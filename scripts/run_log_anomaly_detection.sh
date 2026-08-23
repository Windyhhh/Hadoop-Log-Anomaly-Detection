#!/bin/bash

# Hadoop日志异常检测 MapReduce 运行脚本
# 功能：检测HDFS日志中的异常任务

set -e

# 配置变量
HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}
JAR_PATH="../mapreduce/target/log-anomaly-detector-1.0-SNAPSHOT.jar"
INPUT_PATH="/user/hadoop/logs/input"
OUTPUT_PATH="/user/hadoop/logs/output"
LOCAL_DATA_PATH="../data/sample_logs.csv"
LOCAL_EVENT_ID_PATH="../data/eventId.txt"

echo "=========================================="
echo "Hadoop日志异常检测 MapReduce 程序"
echo "=========================================="

# 检查JAR文件是否存在
if [ ! -f "$JAR_PATH" ]; then
    echo "错误：JAR文件不存在：$JAR_PATH"
    echo "请先运行：cd ../mapreduce && mvn clean package"
    exit 1
fi

# 检查Hadoop是否运行
echo "检查Hadoop服务..."
if ! $HADOOP_HOME/bin/hdfs dfs -ls / > /dev/null 2>&1; then
    echo "错误：Hadoop HDFS 服务未运行"
    echo "请先启动Hadoop服务"
    exit 1
fi

echo "✓ Hadoop HDFS 服务正常"

# 清理旧的输入/输出路径
echo ""
echo "清理旧数据..."
$HADOOP_HOME/bin/hdfs dfs -rm -r -f $INPUT_PATH 2>/dev/null || true
$HADOOP_HOME/bin/hdfs dfs -rm -r -f $OUTPUT_PATH 2>/dev/null || true

# 创建输入目录
echo "创建输入目录..."
$HADOOP_HOME/bin/hdfs dfs -mkdir -p $INPUT_PATH

# 上传本地数据到HDFS
echo "上传日志数据到HDFS..."
$HADOOP_HOME/bin/hdfs dfs -put $LOCAL_DATA_PATH $INPUT_PATH/

echo "上传eventId映射文件到HDFS..."
$HADOOP_HOME/bin/hdfs dfs -put $LOCAL_EVENT_ID_PATH $INPUT_PATH/

# 显示上传的文件
echo ""
echo "HDFS输入目录内容："
$HADOOP_HOME/bin/hdfs dfs -ls -R $INPUT_PATH

# 运行MapReduce任务
echo ""
echo "=========================================="
echo "运行MapReduce任务..."
echo "=========================================="
echo "输入路径：$INPUT_PATH"
echo "输出路径：$OUTPUT_PATH"
echo ""

$HADOOP_HOME/bin/hadoop jar $JAR_PATH com.hadoop.LogAnomalyDetector $INPUT_PATH $OUTPUT_PATH

# 检查任务是否成功
if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✓ MapReduce任务执行成功！"
    echo "=========================================="
    
    # 显示输出结果
    echo ""
    echo "输出结果："
    echo "=========================================="
    $HADOOP_HOME/bin/hdfs dfs -cat $OUTPUT_PATH/part-r-00000
    
    # 保存结果到本地
    echo ""
    echo "保存结果到本地文件..."
    $HADOOP_HOME/bin/hdfs dfs -get $OUTPUT_PATH/part-r-00000 ./anomaly_detection_result.txt
    echo "✓ 结果已保存到：./anomaly_detection_result.txt"
else
    echo ""
    echo "=========================================="
    echo "✗ MapReduce任务执行失败！"
    echo "=========================================="
    exit 1
fi

echo ""
echo "完成！"

