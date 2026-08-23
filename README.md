# 📊 Hadoop Log Anomaly Detection | Hadoop 日志异常检测系统

> **Large-scale log anomaly detection using Hadoop MapReduce. Java-based Mapper/Reducer pipeline for processing massive log datasets, with event ID mapping, statistical anomaly scoring, and complete simulation scripts.**
>
> 基于 Hadoop MapReduce 的大规模日志异常检测。Java Mapper/Reducer 流水线处理海量日志数据集，包含事件 ID 映射、统计异常评分和完整模拟脚本。

---

## 🌟 Why This Project? | 项目亮点

Modern distributed systems generate **terabytes of logs daily**. Manually inspecting logs for anomalies is infeasible. This project implements a **Hadoop MapReduce-based log anomaly detection system** that scales to massive log datasets. The Java-based Mapper/Reducer pipeline processes logs in parallel, maps raw log lines to event IDs, computes statistical anomaly scores, and identifies anomalous patterns — all with complete Hadoop simulation scripts for local testing without a full cluster.

现代分布式系统每天生成 **TB 级日志**。人工检查日志中的异常是不可行的。本项目实现了一个**基于 Hadoop MapReduce 的日志异常检测系统**，可扩展到海量日志数据集。基于 Java 的 Mapper/Reducer 流水线并行处理日志，将原始日志行映射到事件 ID，计算统计异常分数，识别异常模式——所有这些都配有完整的 Hadoop 模拟脚本，无需完整集群即可本地测试。

| Feature | Details |
|---------|---------|
| **Framework** | Apache Hadoop MapReduce (Java) |
| **Pipeline** | Mapper → Reducer (statistical anomaly scoring) |
| **Event Mapping** | Raw log lines → Event IDs (404K event dictionary) |
| **Anomaly Score** | Statistical deviation from normal patterns |
| **Build Tool** | Maven (pom.xml) |
| **Simulation** | PowerShell / Python / Shell Hadoop simulation scripts |
| **Local Testing** | Run without full Hadoop cluster |
| **Documentation** | Complete design report, experiment report, quick start guide |

---

## 🏗️ Architecture | 架构设计

```
┌─────────────────────────────────────────────────────────────┐
│                   Raw Log Files (Massive)                     │
│         Format: timestamp | event_type | message | ...        │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                   Dataset Processor                            │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │  • Parse raw log lines                                   │  │
│  │  • Map to event IDs (eventId.txt dictionary)             │  │
│  │  • Extract features (timestamp, event type, frequency)   │  │
│  │  • Output structured CSV for MapReduce input             │  │
│  └─────────────────────────────────────────────────────────┘  │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                   Hadoop MapReduce Job                        │
│                                                                 │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │   InputSplit  │ →  │   LogMapper  │ →  │  Shuffle &   │  │
│  │   (HDFS)      │    │  (Map phase) │    │    Sort      │  │
│  └──────────────┘    └──────────────┘    └──────┬───────┘  │
│                                                    │           │
│                                                    ▼           │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │   Output      │ ←  │  LogReducer  │ ←  │  Reducer     │  │
│  │  (HDFS)       │    │ (Reduce phase)│    │  input       │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│                                                                 │
│  LogMapper:                                                     │
│    • Input: (line_offset, log_line)                            │
│    • Parse event ID, timestamp, features                        │
│    • Output: (event_id, (timestamp, features, count=1))       │
│                                                                 │
│  LogReducer:                                                    │
│    • Input: (event_id, [(timestamp, features, count), ...])   │
│    • Compute: frequency, temporal patterns, statistical score   │
│    • Anomaly detection: deviation from baseline statistics      │
│    • Output: (event_id, anomaly_score, details)                │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│              Anomaly Detection Results                         │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │  • Event ID with anomaly score                           │  │
│  │  • Anomalous event ranking                               │  │
│  │  • Temporal anomaly patterns                             │  │
│  │  • Statistical deviation details                         │  │
│  └─────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Project Structure | 项目结构

```
Hadoop-Log-Anomaly-Detection/
├── mapreduce/                          # Hadoop MapReduce Java project
│   ├── pom.xml                         # Maven build configuration
│   └── src/main/java/com/hadoop/
│       ├── LogAnomalyDetector.java     # Main MapReduce job (Mapper + Reducer)
│       └── DatasetProcessor.java       # Log dataset preprocessing
├── data/
│   ├── eventId.txt                     # Event ID mapping dictionary (404KB)
│   └── output_example.txt              # Example MapReduce output
├── scripts/
│   ├── hadoop_simulation.py            # Python Hadoop simulation
│   ├── hadoop_simulation.sh            # Shell Hadoop simulation
│   ├── hadoop_simulation.ps1           # PowerShell Hadoop simulation
│   ├── hadoop_simulation_simple.ps1    # Simplified PowerShell simulation
│   ├── hadoop_upload_simulation.ps1    # Upload simulation
│   └── run_log_anomaly_detection.sh    # Cluster run script
├── docs/
│   ├── 设计报告.md                      # Design report
│   ├── 实验报告完整版.md                # Complete experiment report
│   ├── 快速开始指南.md                  # Quick start guide
│   ├── 数据处理说明.md                  # Data processing说明
│   ├── 最终项目总结.md                  # Final project summary
│   ├── 交付清单.md                      # Deliverable checklist
│   ├── 需求完成检查清单.md              # Requirements checklist
│   ├── 文档索引.md                      # Document index
│   └── 项目清单.txt                     # Project inventory
├── hadoop-log-anomaly-detection-blog.md # Technical blog (37KB)
├── README.md
├── .gitignore
└── 博客要求
```

---

## 🚀 Quick Start | 快速开始

### Prerequisites | 前置条件

- Java 8+ (JDK)
- Maven 3.6+
- Python 3.7+ (for simulation)
- (Optional) Apache Hadoop 2.7+ / 3.x cluster

### Build the Project | 构建项目

```bash
cd mapreduce
mvn clean package
```

This produces `target/log-anomaly-detector-1.0-SNAPSHOT.jar`.

### Run on Hadoop Cluster | 在 Hadoop 集群上运行

```bash
# Upload data to HDFS
hdfs dfs -put data/eventId.txt /input/
hdfs dfs -put data/processed_logs.csv /input/

# Run MapReduce job
hadoop jar target/log-anomaly-detector-1.0-SNAPSHOT.jar \
    com.hadoop.LogAnomalyDetector \
    /input/processed_logs.csv \
    /output/

# View results
hdfs dfs -cat /output/part-r-00000
```

### Run Local Simulation (No Cluster Needed) | 本地模拟（无需集群）

```bash
# Python simulation
python scripts/hadoop_simulation.py

# PowerShell simulation (Windows)
powershell -ExecutionPolicy Bypass -File scripts/hadoop_simulation.ps1

# Shell simulation (Linux/Mac)
bash scripts/hadoop_simulation.sh
```

The simulation scripts emulate the MapReduce pipeline locally, allowing you to test the anomaly detection logic without a full Hadoop cluster.

---

## 🔬 MapReduce Implementation | MapReduce 实现

### LogMapper | 映射器

```java
public static class LogMapper extends Mapper<LongWritable, Text, Text, Text> {
    @Override
    protected void map(LongWritable key, Text value, Context context) {
        // Parse log line
        // Extract: event_id, timestamp, features
        // Output: (event_id, timestamp|features|1)
    }
}
```

### LogReducer | 归约器

```java
public static class LogReducer extends Reducer<Text, Text, Text, Text> {
    @Override
    protected void reduce(Text key, Iterable<Text> values, Context context) {
        // Aggregate all values for this event_id
        // Compute: frequency, temporal patterns, statistics
        // Calculate: anomaly score (deviation from baseline)
        // Output: (event_id, anomaly_score|details)
    }
}
```

### Anomaly Scoring | 异常评分

The reducer computes statistical anomaly scores based on:
1. **Frequency deviation** — Is this event occurring more/less often than normal?
2. **Temporal pattern** — Is the event timing anomalous?
3. **Feature distribution** — Do the log features deviate from baseline?
4. **Rarity score** — How rare is this event compared to normal operation?

---

## 📊 Event ID Mapping | 事件 ID 映射

The `data/eventId.txt` file contains a dictionary mapping raw log event types to numeric event IDs. This is essential for:
- Efficient MapReduce key-based grouping
- Statistical analysis per event type
- Anomaly baseline computation per event

The dictionary covers 404K event types, making it suitable for enterprise-scale log analysis.

---

## 📚 References | 参考文献

1. **White, T.** (2015). *Hadoop: The Definitive Guide.* O'Reilly Media.
2. **Dean, J., & Ghemawat, S.** (2008). *MapReduce: simplified data processing on large clusters.* Communications of the ACM, 51(1), 107-113.
3. **He, S., Zhu, J., He, P., & Lyu, M. R.** (2017). *Experience report: System log analysis for anomaly detection.* ISSRE.
4. **Du, M., Li, F., Zheng, G., & Srikumar, V.** (2017). *DeepLog: Anomaly detection and diagnosis from system logs through deep learning.* CCS.
5. **Lin, Q., et al.** (2016). *Log clustering based problem identification for online service systems.* ICSE.

---

## 📄 License | 许可证

MIT License — free to use, modify, and distribute.

---

<div align="center">

**Built with 📊 for large-scale log analytics**

[Report Bug](https://github.com/Windyhhh/Hadoop-Log-Anomaly-Detection/issues) · [Request Feature](https://github.com/Windyhhh/Hadoop-Log-Anomaly-Detection/issues)

</div>
