<div align="center">

# 📉 Hadoop-Log-Anomaly-Detection

### MapReduce-based log anomaly detection on HDFS logs.

Distributed anomaly detection over 2M+ log records from the LogHub HDFS_v3 dataset — 95%+ accuracy.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Hadoop](https://img.shields.io/badge/Hadoop-3-66CCFF?logo=apachehadoop&logoColor=white)](https://hadoop.apache.org/)
[![MapReduce](https://img.shields.io/badge/MapReduce-3-FF6F00)](https://hadoop.apache.org/)

</div>

---

**Hadoop-Log-Anomaly-Detection** builds a **MapReduce**-based system that automatically detects and classifies anomalies in **HDFS logs**, processing **2M+ records** from the **LogHub HDFS_v3** dataset at **95%+ accuracy** — designed for TB-scale logs.

> [!NOTE]
> 中文项目：基于 Hadoop MapReduce 的日志异常检测——LogHub HDFS_v3 数据集，200 万+ 条日志，准确率 95%+，支持 TB 级。

---

## Features

- **Distributed processing** — MapReduce handles TB-scale logs.
- **Smart detection** — auto-classifies anomaly events, 95%+ accuracy.
- **Extensible** — modular, supports multiple log formats & algorithms.
- **Documented** — design report, experiment report, quick start.

---

## Quickstart

```bash
git clone https://github.com/Windyhhh/Hadoop-Log-Anomaly-Detection.git
cd Hadoop-Log-Anomaly-Detection

# run the detection job on HDFS
hadoop jar target/log-anomaly.jar /log-input /log-output
hdfs dfs -cat /log-output/part-r-00000
```

---

## Project Structure

```
Hadoop-Log-Anomaly-Detection/
├── src/                    # MapReduce detection job
├── data/                   # HDFS_v3 log samples
├── scripts/
└── docs/                   # design, completion, blog
```

---

## License

MIT — free to use, modify and distribute.
