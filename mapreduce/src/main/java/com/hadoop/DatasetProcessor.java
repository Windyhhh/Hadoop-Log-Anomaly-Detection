package com.hadoop;

import java.io.*;
import java.nio.file.*;
import java.util.*;

/**
 * 数据集处理程序：将HDFS_v3数据集转换为MapReduce输入格式
 * 读取event.csv文件，生成CSV格式的输入数据
 */
public class DatasetProcessor {

    public static void main(String[] args) throws Exception {
        String datasetPath = "../../dataset/HDFS_v3_TraceBench/tracebench";
        String outputFile = "../data/processed_logs.csv";
        
        System.out.println("开始处理数据集...");
        
        File outputDir = new File("150/data");
        outputDir.mkdirs();
        
        try (PrintWriter writer = new PrintWriter(new FileWriter(outputFile))) {
            // 写入CSV头
            writer.println("TaskID,OpName,Description");
            
            File datasetDir = new File(datasetPath);
            File[] folders = datasetDir.listFiles(File::isDirectory);
            
            if (folders == null) {
                System.err.println("数据集目录不存在: " + datasetPath);
                return;
            }
            
            Arrays.sort(folders);
            int processedCount = 0;
            
            for (File folder : folders) {
                if (processedCount >= 50) break;  // 处理前50个文件夹
                
                File eventFile = new File(folder, "event.csv");
                if (!eventFile.exists()) continue;
                
                try (BufferedReader reader = new BufferedReader(new FileReader(eventFile))) {
                    String line;
                    boolean isHeader = true;
                    
                    while ((line = reader.readLine()) != null) {
                        if (isHeader) {
                            isHeader = false;
                            continue;
                        }
                        
                        String[] fields = line.split(",");
                        if (fields.length < 9) continue;
                        
                        String taskID = fields[0].trim();
                        String opName = fields[2].trim();
                        String description = fields[8].trim();
                        
                        if (!taskID.isEmpty() && !opName.isEmpty()) {
                            writer.println(taskID + "," + opName + "," + description);
                        }
                    }
                } catch (Exception e) {
                    System.err.println("处理文件失败: " + folder.getName());
                }
                
                processedCount++;
                if (processedCount % 10 == 0) {
                    System.out.println("✓ 已处理 " + processedCount + " 个文件夹");
                }
            }
            
            System.out.println("✓ 处理完成！");
            System.out.println("  输出文件: " + outputFile);
            System.out.println("  处理文件夹数: " + processedCount);
        }
    }
}

