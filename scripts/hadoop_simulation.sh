#!/bin/bash
# Hadoop 日志异常检测系统 - 模拟脚本 (Bash)
# 用于展示 HDFS、NameNode、DataNode 的相关信息

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

print_header() {
    echo -e "\n${GRAY}$(printf '=%.0s' {1..80})${NC}"
    echo -e "${CYAN}  Hadoop日志异常检测系统 - Hadoop 模拟运行环境${NC}" | head -c 80
    echo ""
    echo -e "${CYAN}  版本: 1.0${NC}" | head -c 80
    echo ""
    echo -e "${CYAN}  时间: $(date '+%Y-%m-%d %H:%M:%S')${NC}" | head -c 80
    echo ""
    echo -e "${GRAY}$(printf '=%.0s' {1..80})${NC}\n"
}

print_namenode_info() {
    echo -e "${GRAY}┌$(printf '─%.0s' {1..78})┐${NC}"
    echo -e "${GREEN}│ NameNode 信息$(printf ' %.0s' {1..63})│${NC}"
    echo -e "${GRAY}├$(printf '─%.0s' {1..78})┤${NC}"
    echo -e "${YELLOW}│ NameNode 地址: http://127.0.0.1:9870$(printf ' %.0s' {1..39})│${NC}"
    echo -e "${YELLOW}│ NameNode 主机: localhost$(printf ' %.0s' {1..51})│${NC}"
    echo -e "${YELLOW}│ 状态: Active$(printf ' %.0s' {1..64})│${NC}"
    echo -e "${YELLOW}│ 版本: Hadoop 3.3.1$(printf ' %.0s' {1..57})│${NC}"
    echo -e "${YELLOW}│ 启动时间: $(date '+%Y-%m-%d %H:%M:%S')$(printf ' %.0s' {1..44})│${NC}"
    echo -e "${GRAY}└$(printf '─%.0s' {1..78})┘${NC}\n"
}

print_datanode_info() {
    echo -e "${GRAY}┌$(printf '─%.0s' {1..78})┐${NC}"
    echo -e "${GREEN}│ DataNode 信息$(printf ' %.0s' {1..63})│${NC}"
    echo -e "${GRAY}├$(printf '─%.0s' {1..78})┤${NC}"
    
    datanodes=("datanode-01:192.168.1.101" "datanode-02:192.168.1.102" "datanode-03:192.168.1.103")
    
    for i in "${!datanodes[@]}"; do
        IFS=':' read -r hostname ip <<< "${datanodes[$i]}"
        echo -e "${YELLOW}│ DataNode $((i+1)):$(printf ' %.0s' {1..70})│${NC}"
        echo -e "${YELLOW}│   主机名: $hostname$(printf ' %.0s' {1..62})│${NC}"
        echo -e "${YELLOW}│   IP地址: $ip$(printf ' %.0s' {1..62})│${NC}"
        echo -e "${YELLOW}│   端口: 50075$(printf ' %.0s' {1..62})│${NC}"
        echo -e "${YELLOW}│   状态: Live$(printf ' %.0s' {1..64})│${NC}"
        if [ $i -lt $((${#datanodes[@]} - 1)) ]; then
            echo -e "${GRAY}│ $(printf '─%.0s' {1..76}) │${NC}"
        fi
    done
    
    echo -e "${GRAY}└$(printf '─%.0s' {1..78})┘${NC}\n"
}

print_hdfs_structure() {
    echo -e "${GRAY}┌$(printf '─%.0s' {1..78})┐${NC}"
    echo -e "${GREEN}│ HDFS 目录结构 (项目上传后)$(printf ' %.0s' {1..50})│${NC}"
    echo -e "${GRAY}├$(printf '─%.0s' {1..78})┤${NC}"
    
    hdfs_tree=(
        "│ /user/hadoop/                                                              │"
        "│ ├── logs/                                                                  │"
        "│ │   ├── input/                                                             │"
        "│ │   │   ├── processed_logs.csv (194.92 MB)                                 │"
        "│ │   │   └── eventId.txt (2156 events)                                      │"
        "│ │   └── output/                                                            │"
        "│ │       ├── part-r-00000 (结果文件)                                        │"
        "│ │       ├── part-r-00001 (结果文件)                                        │"
        "│ │       └── _SUCCESS                                                       │"
        "│ └── project/                                                               │"
        "│     ├── mapreduce/                                                         │"
        "│     │   ├── pom.xml                                                        │"
        "│     │   ├── src/                                                           │"
        "│     │   │   └── main/java/com/hadoop/                                      │"
        "│     │   │       ├── LogAnomalyDetector.java                                │"
        "│     │   │       └── DatasetProcessor.java                                  │"
        "│     │   └── target/                                                        │"
        "│     │       └── log-anomaly-detector-1.0-SNAPSHOT.jar                      │"
        "│     └── data/                                                              │"
        "│         ├── processed_logs.csv                                             │"
        "│         ├── eventId.txt                                                    │"
        "│         └── output_example.txt                                             │"
    )
    
    for line in "${hdfs_tree[@]}"; do
        echo -e "${YELLOW}$line${NC}"
    done
    
    echo -e "${GRAY}└$(printf '─%.0s' {1..78})┘${NC}\n"
}

print_job_status() {
    echo -e "${GRAY}┌$(printf '─%.0s' {1..78})┐${NC}"
    echo -e "${GREEN}│ MapReduce 任务状态$(printf ' %.0s' {1..59})│${NC}"
    echo -e "${GRAY}├$(printf '─%.0s' {1..78})┤${NC}"
    echo -e "${YELLOW}│ 任务ID: job_202512261234_0001$(printf ' %.0s' {1..47})│${NC}"
    echo -e "${YELLOW}│ 任务名: LogAnomalyDetector$(printf ' %.0s' {1..51})│${NC}"
    echo -e "${YELLOW}│ 状态: SUCCEEDED$(printf ' %.0s' {1..62})│${NC}"
    echo -e "${YELLOW}│ 进度: Map 100% | Reduce 100%$(printf ' %.0s' {1..48})│${NC}"
    echo -e "${YELLOW}│ 处理记录数: 2,185,618$(printf ' %.0s' {1..55})│${NC}"
    echo -e "${YELLOW}│ 事件类型数: 2,156$(printf ' %.0s' {1..59})│${NC}"
    echo -e "${YELLOW}│ 运行时间: 12分34秒$(printf ' %.0s' {1..58})│${NC}"
    echo -e "${YELLOW}│ 输出路径: /user/hadoop/logs/output$(printf ' %.0s' {1..43})│${NC}"
    echo -e "${GRAY}└$(printf '─%.0s' {1..78})┘${NC}\n"
}

print_output_sample() {
    echo -e "${GRAY}┌$(printf '─%.0s' {1..78})┐${NC}"
    echo -e "${GREEN}│ 处理结果样本 (前10条)$(printf ' %.0s' {1..55})│${NC}"
    echo -e "${GRAY}├$(printf '─%.0s' {1..78})┤${NC}"
    
    samples=(
        "normal,B076E6516B275ABB,123,456,789,234,567"
        "abnormal,A8DFB1AFB3AF3645,234,567,890,345,678"
        "normal,C1E2F3A4B5C6D7E8,345,678,901,456,789"
        "abnormal,D2F3G4A5B6C7D8E9,456,789,012,567,890"
        "normal,E3G4H5A6B7C8D9E0,567,890,123,678,901"
        "abnormal,F4H5I6A7B8C9D0E1,678,901,234,789,012"
        "normal,G5I6J7A8B9C0D1E2,789,012,345,890,123"
        "abnormal,H6J7K8A9B0C1D2E3,890,123,456,901,234"
        "normal,I7K8L9A0B1C2D3E4,901,234,567,012,345"
        "abnormal,J8L9M0A1B2C3D4E5,012,345,678,123,456"
    )
    
    for sample in "${samples[@]}"; do
        echo -e "${YELLOW}│ $sample$(printf ' %.0s' {1..$((79-${#sample}-2))})│${NC}"
    done
    
    echo -e "${YELLOW}│ ...$(printf ' %.0s' {1..74})│${NC}"
    echo -e "${GRAY}└$(printf '─%.0s' {1..78})┘${NC}\n"
}

print_summary() {
    echo -e "${GRAY}┌$(printf '─%.0s' {1..78})┐${NC}"
    echo -e "${GREEN}│ 项目统计信息$(printf ' %.0s' {1..64})│${NC}"
    echo -e "${GRAY}├$(printf '─%.0s' {1..78})┤${NC}"
    echo -e "${YELLOW}│ 源代码行数: 244行$(printf ' %.0s' {1..59})│${NC}"
    echo -e "${YELLOW}│ 核心文档数: 9个$(printf ' %.0s' {1..61})│${NC}"
    echo -e "${YELLOW}│ 数据文件大小: 195.31 MB$(printf ' %.0s' {1..51})│${NC}"
    echo -e "${YELLOW}│ 处理日志条数: 2,185,618$(printf ' %.0s' {1..51})│${NC}"
    echo -e "${YELLOW}│ 事件类型数: 2,156$(printf ' %.0s' {1..59})│${NC}"
    echo -e "${YELLOW}│ 处理文件夹数: 50$(printf ' %.0s' {1..61})│${NC}"
    echo -e "${YELLOW}│ 备份文件数: 9个$(printf ' %.0s' {1..61})│${NC}"
    echo -e "${GRAY}└$(printf '─%.0s' {1..78})┘${NC}\n"
}

# 主程序
print_header
echo -e "${GREEN}正在初始化 Hadoop 环境...${NC}\n"
sleep 0.5

print_namenode_info
sleep 0.5

print_datanode_info
sleep 0.5

print_hdfs_structure
sleep 0.5

print_job_status
sleep 0.5

print_output_sample
sleep 0.5

print_summary

echo -e "${GRAY}$(printf '=%.0s' {1..80})${NC}"
echo -e "${CYAN}  模拟运行完成！${NC}" | head -c 80
echo ""
echo -e "${GRAY}$(printf '=%.0s' {1..80})${NC}\n"

