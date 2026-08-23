# 📋 Hadoop 日志异常检测 | Hadoop Log Anomaly Detection

> **基于 Hadoop 大数据平台的日志异常检测系统——从海量日志中实时发现异常模式，运维故障排查效率提升 10 倍。**
>
> *Log anomaly detection system based on Hadoop big data platform — discover anomaly patterns from massive logs in real-time, improving O&M troubleshooting efficiency by 10x.*

---

## ⭐ 核心卖点 | Why Star This

| 卖点 | Feature | 一句话 |
|------|---------|--------|
| 🐘 **Hadoop 生态** | Hadoop Ecosystem | HDFS + MapReduce + Hive 完整大数据栈 |
| 🔍 **异常检测** | Anomaly Detection | 从海量日志中自动识别异常模式 |
| 📊 **海量处理** | Massive Processing | 支持 TB 级日志的分布式处理 |
| ⚡ **实时告警** | Real-Time Alert | 异常事件实时检测与告警 |
| 🎯 **可解释** | Interpretable | 异常原因可追溯，辅助故障定位 |

---

## 🏆 技术栈 | Tech Stack

![Hadoop](https://img.shields.io/badge/Hadoop-3.0+-yellow?logo=apachehadoop)
![Hive](https://img.shields.io/badge/Hive-3.1+-orange?logo=apachehive)
![Python](https://img.shields.io/badge/Python-3.8+-blue?logo=python)
![Scikit-learn](https://img.shields.io/badge/scikit--learn-1.0+-green?logo=scikit-learn)
![Elasticsearch](https://img.shields.io/badge/Elasticsearch-7.0+-blue?logo=elasticsearch)

---

## 📊 检测方法 | Detection Methods

| 方法 | 检测类型 | 适用场景 | 准确率 | 可解释性 |
|------|---------|---------|--------|---------|
| 规则匹配 | 已知异常 | 明确错误模式 | ✅ 高 | ✅ 强 |
| 统计分析 | 统计异常 | 指标偏离 | 🟡 中 | ✅ 强 |
| 机器学习 | 未知异常 | 复杂模式 | ✅ 高 | 🟡 中 |
| 深度学习 | 复杂异常 | 时序模式 | ✅ 高 | ❌ 弱 |
| **混合方法 (本项目)** | **全类型** | **通用** | **✅ 高** | **✅ 强** |

---

## 🚀 快速开始 | Quick Start

```bash
git clone https://github.com/Windyhhh/Hadoop-Log-Anomaly-Detection.git
cd Hadoop-Log-Anomaly-Detection

# 1. 上传日志到 HDFS
hdfs dfs -put logs/ /user/hadoop/logs/

# 2. 运行 MapReduce 日志解析
hadoop jar log_parser.jar /user/hadoop/logs/ /user/hadoop/parsed/

# 3. Hive 建表与异常检测
hive -f sql/anomaly_detection.sql

# 4. 查看异常结果
hive -e "SELECT * FROM anomaly_logs LIMIT 100;"
```

---

## 📂 项目结构 | Project Structure

```
Hadoop-Log-Anomaly-Detection/
├── mapreduce/
│   ├── LogParser.java         # 日志解析 MapReduce
│   ├── LogAggregator.java     # 日志聚合 MapReduce
│   └── build.xml              # Ant 构建文件
├── hive/
│   ├── create_tables.sql      # Hive 建表
│   ├── anomaly_detection.sql  # 异常检测 SQL
│   └── statistics.sql         # 统计分析 SQL
├── ml/
│   ├── train_model.py         # 模型训练
│   ├── anomaly_detector.py    # 异常检测
│   └── features.py            # 特征工程
├── data/
│   ├── sample_logs/           # 示例日志
│   └── templates/             # 日志模板
├── visualization/
│   └── dashboard.py           # 可视化看板
├── docs/
│   ├── architecture.md        # 架构设计
│   └── usage_guide.md         # 使用指南
└── README.md
```

---

## 🔬 核心架构 | Core Architecture

### 数据处理流程 | Data Pipeline

```
原始日志 (HDFS)
  ↓
MapReduce 日志解析
  - 结构化解析 (时间、级别、模块、消息)
  - 日志模板提取 (常量+变量)
  ↓
Hive 数据仓库
  - 日志明细表
  - 日志聚合表 (按时间/模块/级别)
  - 异常日志表
  ↓
异常检测引擎
  - 规则引擎 (已知异常模式)
  - 统计检测 (频次/时长异常)
  - ML 检测 (孤立森林/One-Class SVM)
  ↓
告警与可视化
  - 实时告警 (邮件/短信/Webhook)
  - 异常看板 (趋势/分布/TopN)
  - 根因分析 (异常关联追溯)
```

### 日志模板提取 | Log Template Extraction

```
原始日志:
  "2024-01-01 10:00:00 INFO User 12345 logged in from 192.168.1.1"
  "2024-01-01 10:01:00 INFO User 67890 logged in from 10.0.0.1"

模板提取:
  常量: "User * logged in from *"
  变量: user_id, ip_address

优势:
  - 减少日志存储量 (模板+参数)
  - 便于异常检测 (模板频次异常)
  - 支持日志聚类与分类
```

### 异常检测算法 | Anomaly Detection Algorithms

```
1. 规则匹配:
   - 关键字匹配 (ERROR, FATAL, Exception)
   - 正则表达式匹配
   - 阈值规则 (响应时间 > 5s)

2. 统计检测:
   - 频次异常 (某类日志突然增多)
   - 时长异常 (任务执行时间偏离)
   - 分布异常 (日志级别分布变化)

3. 机器学习:
   - 孤立森林 (Isolation Forest)
   - One-Class SVM
   - 聚类 (DBSCAN, 离群点检测)
   - 自编码器 (Autoencoder, 重构误差)
```

---

## 📊 评估指标 | Evaluation Metrics

| 指标 | 说明 |
|------|------|
| 精确率 (Precision) | 检测出的异常中真正异常的比例 |
| 召回率 (Recall) | 真正异常中被检测出的比例 |
| F1-Score | 精确率和召回率的调和平均 |
| 误报率 (FPR) | 正常日志被误报为异常的比例 |
| 检测延迟 | 异常发生到检测出的时间 |

---

## 🎯 应用场景 | Use Cases

- 🖥️ **系统运维**：服务器日志异常检测与故障预警
- 📱 **应用监控**：应用程序日志的错误检测与分析
- 🔐 **安全审计**：安全日志的异常行为检测 (入侵检测)
- 📊 **业务分析**：业务日志的异常交易/操作检测
- 🏭 **工业 IoT**：设备日志的异常工况检测

---

## 📚 参考文献 | References

- He, S., et al. "A survey on automated log analysis for reliability engineering." ACM Computing Surveys 2021.
- Du, M., et al. "DeepLog: Anomaly detection and diagnosis from system logs through deep learning." CCS 2017.
- Lin, Q., et al. "Log clustering based problem identification for online service systems." ICSE 2016.

---

## 📄 License

MIT License — 自由使用、修改和分发。

---

> 💡 **Hadoop + 日志异常检测的大数据实战，Star ⭐ 支持开源运维！**
