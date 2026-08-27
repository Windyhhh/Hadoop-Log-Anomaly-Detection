<div align="center">

# 📋 Hadoop-Log-Anomaly-Detection

### MapReduce large-scale log anomaly detection.

Java Mapper/Reducer with event-ID mapping and statistical anomaly scoring over massive logs.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Java](https://img.shields.io/badge/Java-8+-007396?logo=openjdk&logoColor=white)](https://openjdk.org/)
[![Hadoop](https://img.shields.io/badge/Hadoop-3-66CCFF?logo=apachehadoop&logoColor=black)](https://hadoop.apache.org/)
[![MapReduce](https://img.shields.io/badge/MapReduce-3-blue)](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html)

</div>

---

**Hadoop-Log-Anomaly-Detection** detects anomalies in large-scale logs using **MapReduce** — a Java Mapper/Reducer pipeline that maps event IDs and computes statistical anomaly scores.

> [!NOTE]
> 中文项目：MapReduce 大规模日志异常检测——Java Mapper/Reducer，事件 ID 映射，统计异常评分。

---

## Quickstart

```bash
git clone https://github.com/Windyhhh/Hadoop-Log-Anomaly-Detection.git
cd Hadoop-Log-Anomaly-Detection

# Build the MapReduce job
cd mapreduce && mvn clean package

# Run on a cluster (Hadoop)
hadoop jar target/...jar com.hadoop.LogAnomalyDetector /input /output

# Or simulate locally without a cluster
python scripts/hadoop_simulation.py
```

---

## Features

- **MapReduce detection** — Java Mapper/Reducer + event-ID mapping.
- **Statistical scoring** — anomaly scores over event frequencies.
- **Cluster-free simulation** — Python/PowerShell/Shell simulators included.

---

## Project Structure

```
Hadoop-Log-Anomaly-Detection/
├── mapreduce/
│   ├── pom.xml
│   └── src/main/java/com/hadoop/
│       ├── DatasetProcessor.java
│       └── LogAnomalyDetector.java
├── scripts/               # hadoop_simulation (.py/.ps1/.sh)
├── data/                  # eventId.txt, output_example.txt
└── docs/                  # reports & guides
```

---

## License

MIT — free to use, modify and distribute.
