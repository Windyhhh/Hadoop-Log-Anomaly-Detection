package com.hadoop;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.IOException;
import java.util.*;

/**
 * MapReduce程序：Hadoop日志异常检测（基于HDFS_v3数据集）
 * 功能：
 * 1. 读取HDFS trace数据（event.csv）
 * 2. 根据文件夹名称判断标签（NM_=Normal, AN_/COM_=Abnormal）
 * 3. 为每个taskID标注Normal/Abnormal
 * 4. 收集同一taskID的所有事件
 * 5. 将eventName映射为eventID
 * 6. 输出格式：label,taskID,eventID1,eventID2,...
 */
public class LogAnomalyDetector {

    /**
     * Mapper类：读取event.csv，提取taskID、OpName、Description
     * 输入格式：TaskID,TID,OpName,StartTime,EndTime,HostAddress,HostName,Agent,Description
     */
    public static class LogMapper extends Mapper<LongWritable, Text, Text, Text> {

        @Override
        protected void map(LongWritable key, Text value, Context context)
                throws IOException, InterruptedException {

            String line = value.toString().trim();

            // 跳过空行和标题行
            if (line.isEmpty() || line.startsWith("TaskID")) {
                return;
            }

            try {
                // 简单CSV解析（不处理引号）
                String[] fields = line.split(",");
                if (fields.length < 3) {
                    return;
                }

                String taskID = fields[0].trim();
                String opName = fields[2].trim();  // OpName在第3列
                String description = fields[8].trim();  // Description在第9列

                if (taskID.isEmpty() || opName.isEmpty()) {
                    return;
                }

                // 生成eventName：OpName+success或OpName+error
                String eventName = opName + (description.toLowerCase().contains("success") ? "+success" : "+error");

                // 输出：taskID -> eventName|description
                String mapValue = eventName + "|" + description;
                context.write(new Text(taskID), new Text(mapValue));

            } catch (Exception e) {
                // 跳过解析错误的行
                return;
            }
        }
    }

    /**
     * Reducer类：聚合同一taskID的所有事件，标注标签，映射eventID
     */
    public static class LogReducer extends Reducer<Text, Text, Text, Text> {

        @Override
        protected void reduce(Text key, Iterable<Text> values, Context context)
                throws IOException, InterruptedException {

            String taskID = key.toString();
            Set<String> eventNames = new LinkedHashSet<>();
            String label = "normal"; // 默认标签
            boolean hasAbnormalEvent = false;

            // 遍历同一taskID的所有事件
            for (Text value : values) {
                String[] parts = value.toString().split("\\|", -1);
                if (parts.length >= 2) {
                    String eventName = parts[0];
                    String description = parts[1];

                    eventNames.add(eventName);

                    // 判断标签逻辑：
                    // Abnormal：description（转小写）不包含"success:"或"a user task"
                    String descLower = description.toLowerCase();
                    if (!descLower.contains("success:") && !descLower.contains("a user task")) {
                        hasAbnormalEvent = true;
                    }
                }
            }

            // 根据是否有异常事件来标注
            label = hasAbnormalEvent ? "abnormal" : "normal";

            // 将eventName映射为eventID
            StringBuilder eventIDList = new StringBuilder();
            int count = 0;
            for (String eventName : eventNames) {
                int eventID = mapEventNameToID(eventName);
                if (count > 0) {
                    eventIDList.append(",");
                }
                eventIDList.append(eventID);
                count++;
            }

            // 输出格式：label,taskID,eventID1,eventID2,...
            String output = label + "," + taskID + "," + eventIDList.toString();
            context.write(new Text(output), new Text(""));
        }

        /**
         * eventName到eventID的映射函数
         * 使用简单的哈希映射，实际应该读取eventId.txt文件
         */
        private int mapEventNameToID(String eventName) {
            // 简单的哈希映射：确保相同的eventName总是映射到相同的ID
            return Math.abs(eventName.hashCode()) % 1000 + 1;
        }
    }

    /**
     * Driver主程序
     */
    public static void main(String[] args) throws Exception {
        if (args.length != 2) {
            System.err.println("Usage: LogAnomalyDetector <input path> <output path>");
            System.exit(-1);
        }

        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "Hadoop Log Anomaly Detection");

        job.setJarByClass(LogAnomalyDetector.class);
        job.setMapperClass(LogMapper.class);
        job.setReducerClass(LogReducer.class);

        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(Text.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        boolean success = job.waitForCompletion(true);
        System.exit(success ? 0 : 1);
    }
}

