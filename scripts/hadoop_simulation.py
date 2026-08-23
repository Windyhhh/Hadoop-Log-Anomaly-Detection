#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Hadoop 日志异常检测系统 - 模拟脚本
用于展示 HDFS、NameNode、DataNode 的相关信息
"""

import os
import sys
import time
from datetime import datetime

class HadoopSimulator:
    def __init__(self):
        self.namenode_host = "127.0.0.1"
        self.namenode_port = 9870
        self.datanodes = [
            {"hostname": "datanode-01", "ip": "192.168.1.101", "port": 50075},
            {"hostname": "datanode-02", "ip": "192.168.1.102", "port": 50075},
            {"hostname": "datanode-03", "ip": "192.168.1.103", "port": 50075},
        ]
        self.project_name = "Hadoop日志异常检测系统"
        self.version = "1.0"
        
    def print_header(self):
        """打印标题"""
        print("\n" + "="*80)
        print(f"  {self.project_name} - Hadoop 模拟运行环境".center(80))
        print(f"  版本: {self.version}".center(80))
        print(f"  时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}".center(80))
        print("="*80 + "\n")
    
    def print_namenode_info(self):
        """打印 NameNode 信息"""
        print("┌" + "─"*78 + "┐")
        print("│ " + "NameNode 信息".ljust(76) + " │")
        print("├" + "─"*78 + "┤")
        print(f"│ NameNode 地址: http://{self.namenode_host}:{self.namenode_port}".ljust(79) + "│")
        print(f"│ NameNode 主机: localhost".ljust(79) + "│")
        print(f"│ 状态: Active".ljust(79) + "│")
        print(f"│ 版本: Hadoop 3.3.1".ljust(79) + "│")
        print(f"│ 启动时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}".ljust(79) + "│")
        print("└" + "─"*78 + "┘\n")
    
    def print_datanode_info(self):
        """打印 DataNode 信息"""
        print("┌" + "─"*78 + "┐")
        print("│ " + "DataNode 信息".ljust(76) + " │")
        print("├" + "─"*78 + "┤")
        for i, dn in enumerate(self.datanodes, 1):
            print(f"│ DataNode {i}:".ljust(79) + "│")
            print(f"│   主机名: {dn['hostname']}".ljust(79) + "│")
            print(f"│   IP地址: {dn['ip']}".ljust(79) + "│")
            print(f"│   端口: {dn['port']}".ljust(79) + "│")
            print(f"│   状态: Live".ljust(79) + "│")
            if i < len(self.datanodes):
                print("│ " + "─"*76 + " │")
        print("└" + "─"*78 + "┘\n")
    
    def print_hdfs_structure(self):
        """打印 HDFS 目录结构"""
        print("┌" + "─"*78 + "┐")
        print("│ " + "HDFS 目录结构 (项目上传后)".ljust(76) + " │")
        print("├" + "─"*78 + "┤")
        
        hdfs_tree = [
            "│ /user/hadoop/                                                              │",
            "│ ├── logs/                                                                  │",
            "│ │   ├── input/                                                             │",
            "│ │   │   ├── processed_logs.csv (194.92 MB)                                 │",
            "│ │   │   └── eventId.txt (2156 events)                                      │",
            "│ │   └── output/                                                            │",
            "│ │       ├── part-r-00000 (结果文件)                                        │",
            "│ │       ├── part-r-00001 (结果文件)                                        │",
            "│ │       └── _SUCCESS                                                       │",
            "│ └── project/                                                               │",
            "│     ├── mapreduce/                                                         │",
            "│     │   ├── pom.xml                                                        │",
            "│     │   ├── src/                                                           │",
            "│     │   │   └── main/java/com/hadoop/                                      │",
            "│     │   │       ├── LogAnomalyDetector.java                                │",
            "│     │   │       └── DatasetProcessor.java                                  │",
            "│     │   └── target/                                                        │",
            "│     │       └── log-anomaly-detector-1.0-SNAPSHOT.jar                      │",
            "│     └── data/                                                              │",
            "│         ├── processed_logs.csv                                             │",
            "│         ├── eventId.txt                                                    │",
            "│         └── output_example.txt                                             │",
        ]
        
        for line in hdfs_tree:
            print(line)
        
        print("└" + "─"*78 + "┘\n")
    
    def print_job_status(self):
        """打印 MapReduce 任务状态"""
        print("┌" + "─"*78 + "┐")
        print("│ " + "MapReduce 任务状态".ljust(76) + " │")
        print("├" + "─"*78 + "┤")
        print("│ 任务ID: job_202512261234_0001".ljust(79) + "│")
        print("│ 任务名: LogAnomalyDetector".ljust(79) + "│")
        print("│ 状态: SUCCEEDED".ljust(79) + "│")
        print("│ 进度: Map 100% | Reduce 100%".ljust(79) + "│")
        print("│ 处理记录数: 2,185,618".ljust(79) + "│")
        print("│ 事件类型数: 2,156".ljust(79) + "│")
        print("│ 运行时间: 12分34秒".ljust(79) + "│")
        print("│ 输出路径: /user/hadoop/logs/output".ljust(79) + "│")
        print("└" + "─"*78 + "┘\n")
    
    def print_output_sample(self):
        """打印输出样本"""
        print("┌" + "─"*78 + "┐")
        print("│ " + "处理结果样本 (前10条)".ljust(76) + " │")
        print("├" + "─"*78 + "┤")
        
        samples = [
            "normal,B076E6516B275ABB,123,456,789,234,567",
            "abnormal,A8DFB1AFB3AF3645,234,567,890,345,678",
            "normal,C1E2F3A4B5C6D7E8,345,678,901,456,789",
            "abnormal,D2F3G4A5B6C7D8E9,456,789,012,567,890",
            "normal,E3G4H5A6B7C8D9E0,567,890,123,678,901",
            "abnormal,F4H5I6A7B8C9D0E1,678,901,234,789,012",
            "normal,G5I6J7A8B9C0D1E2,789,012,345,890,123",
            "abnormal,H6J7K8A9B0C1D2E3,890,123,456,901,234",
            "normal,I7K8L9A0B1C2D3E4,901,234,567,012,345",
            "abnormal,J8L9M0A1B2C3D4E5,012,345,678,123,456",
        ]
        
        for sample in samples:
            print(f"│ {sample}".ljust(79) + "│")
        
        print("│ ...".ljust(79) + "│")
        print("└" + "─"*78 + "┘\n")
    
    def print_summary(self):
        """打印总结信息"""
        print("┌" + "─"*78 + "┐")
        print("│ " + "项目统计信息".ljust(76) + " │")
        print("├" + "─"*78 + "┤")
        print("│ 源代码行数: 244行".ljust(79) + "│")
        print("│ 核心文档数: 9个".ljust(79) + "│")
        print("│ 数据文件大小: 195.31 MB".ljust(79) + "│")
        print("│ 处理日志条数: 2,185,618".ljust(79) + "│")
        print("│ 事件类型数: 2,156".ljust(79) + "│")
        print("│ 处理文件夹数: 50".ljust(79) + "│")
        print("│ 备份文件数: 9个".ljust(79) + "│")
        print("└" + "─"*78 + "┘\n")
    
    def run(self):
        """运行模拟脚本"""
        self.print_header()
        
        print("正在初始化 Hadoop 环境...\n")
        time.sleep(0.5)
        
        self.print_namenode_info()
        time.sleep(0.5)
        
        self.print_datanode_info()
        time.sleep(0.5)
        
        self.print_hdfs_structure()
        time.sleep(0.5)
        
        self.print_job_status()
        time.sleep(0.5)
        
        self.print_output_sample()
        time.sleep(0.5)
        
        self.print_summary()
        
        print("="*80)
        print("  模拟运行完成！".center(80))
        print("="*80 + "\n")

if __name__ == "__main__":
    simulator = HadoopSimulator()
    simulator.run()

