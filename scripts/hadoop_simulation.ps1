# Hadoop 日志异常检测系统 - 模拟脚本 (PowerShell)
# 用于展示 HDFS、NameNode、DataNode 的相关信息

$ErrorActionPreference = "SilentlyContinue"

# 颜色定义
$colors = @{
    "Header" = "Cyan"
    "Info" = "Green"
    "Data" = "Yellow"
    "Border" = "Gray"
}

function Print-Header {
    Write-Host "`n" -ForegroundColor $colors["Border"]
    Write-Host ("=" * 80) -ForegroundColor $colors["Border"]
    Write-Host ("  Hadoop日志异常检测系统 - Hadoop 模拟运行环境".PadRight(80).Substring(0, 80)) -ForegroundColor $colors["Header"]
    Write-Host ("  版本: 1.0".PadRight(80).Substring(0, 80)) -ForegroundColor $colors["Header"]
    Write-Host ("  时间: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')".PadRight(80).Substring(0, 80)) -ForegroundColor $colors["Header"]
    Write-Host ("=" * 80) -ForegroundColor $colors["Border"]
    Write-Host "`n"
}

function Print-NameNodeInfo {
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| " + "NameNode 信息".PadRight(77) + "|") -ForegroundColor $colors["Info"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| NameNode 地址: http://127.0.0.1:9870".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| NameNode 主机: localhost".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 状态: Active".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 版本: Hadoop 3.3.1".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 启动时间: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host "`n"
}

function Print-DataNodeInfo {
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| " + "DataNode 信息".PadRight(77) + "|") -ForegroundColor $colors["Info"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]

    $datanodes = @(
        @{hostname="datanode-01"; ip="192.168.1.101"; port=50075},
        @{hostname="datanode-02"; ip="192.168.1.102"; port=50075},
        @{hostname="datanode-03"; ip="192.168.1.103"; port=50075}
    )

    for ($i = 0; $i -lt $datanodes.Count; $i++) {
        $dn = $datanodes[$i]
        Write-Host ("| DataNode $($i+1):".PadRight(79) + "|") -ForegroundColor $colors["Data"]
        Write-Host ("|   主机名: $($dn.hostname)".PadRight(79) + "|") -ForegroundColor $colors["Data"]
        Write-Host ("|   IP地址: $($dn.ip)".PadRight(79) + "|") -ForegroundColor $colors["Data"]
        Write-Host ("|   端口: $($dn.port)".PadRight(79) + "|") -ForegroundColor $colors["Data"]
        Write-Host ("|   状态: Live".PadRight(79) + "|") -ForegroundColor $colors["Data"]
        if ($i -lt $datanodes.Count - 1) {
            Write-Host ("| " + ("-" * 76) + " |") -ForegroundColor $colors["Border"]
        }
    }

    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host "`n"
}

function Print-HDFSStructure {
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| " + "HDFS 目录结构 (项目上传后)".PadRight(77) + "|") -ForegroundColor $colors["Info"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]

    $hdfs_tree = @(
        "| /user/hadoop/                                                              |",
        "| +-- logs/                                                                  |",
        "|     +-- input/                                                             |",
        "|     |   +-- processed_logs.csv (194.92 MB)                                 |",
        "|     |   +-- eventId.txt (2156 events)                                      |",
        "|     +-- output/                                                            |",
        "|         +-- part-r-00000 (结果文件)                                        |",
        "|         +-- part-r-00001 (结果文件)                                        |",
        "|         +-- _SUCCESS                                                       |",
        "| +-- project/                                                               |",
        "|     +-- mapreduce/                                                         |",
        "|     |   +-- pom.xml                                                        |",
        "|     |   +-- src/                                                           |",
        "|     |   |   +-- main/java/com/hadoop/                                      |",
        "|     |   |       +-- LogAnomalyDetector.java                                |",
        "|     |   |       +-- DatasetProcessor.java                                  |",
        "|     |   +-- target/                                                        |",
        "|     |       +-- log-anomaly-detector-1.0-SNAPSHOT.jar                      |",
        "|     +-- data/                                                              |",
        "|         +-- processed_logs.csv                                             |",
        "|         +-- eventId.txt                                                    |",
        "|         +-- output_example.txt                                             |"
    )

    foreach ($line in $hdfs_tree) {
        Write-Host $line -ForegroundColor $colors["Data"]
    }

    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host "`n"
}

function Print-JobStatus {
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| " + "MapReduce 任务状态".PadRight(77) + "|") -ForegroundColor $colors["Info"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| 任务ID: job_202512261234_0001".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 任务名: LogAnomalyDetector".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 状态: SUCCEEDED".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 进度: Map 100% | Reduce 100%".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 处理记录数: 2,185,618".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 事件类型数: 2,156".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 运行时间: 12分34秒".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 输出路径: /user/hadoop/logs/output".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host "`n"
}

function Print-OutputSample {
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| " + "处理结果样本 (前10条)".PadRight(77) + "|") -ForegroundColor $colors["Info"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]

    $samples = @(
        "normal,B076E6516B275ABB,123,456,789,234,567",
        "abnormal,A8DFB1AFB3AF3645,234,567,890,345,678",
        "normal,C1E2F3A4B5C6D7E8,345,678,901,456,789",
        "abnormal,D2F3G4A5B6C7D8E9,456,789,012,567,890",
        "normal,E3G4H5A6B7C8D9E0,567,890,123,678,901",
        "abnormal,F4H5I6A7B8C9D0E1,678,901,234,789,012",
        "normal,G5I6J7A8B9C0D1E2,789,012,345,890,123",
        "abnormal,H6J7K8A9B0C1D2E3,890,123,456,901,234",
        "normal,I7K8L9A0B1C2D3E4,901,234,567,012,345",
        "abnormal,J8L9M0A1B2C3D4E5,012,345,678,123,456"
    )

    foreach ($sample in $samples) {
        Write-Host ("| " + $sample.PadRight(77) + "|") -ForegroundColor $colors["Data"]
    }

    Write-Host ("| ...".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host "`n"
}

function Print-Summary {
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| " + "项目统计信息".PadRight(77) + "|") -ForegroundColor $colors["Info"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host ("| 源代码行数: 244行".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 核心文档数: 9个".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 数据文件大小: 195.31 MB".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 处理日志条数: 2,185,618".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 事件类型数: 2,156".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 处理文件夹数: 50".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("| 备份文件数: 9个".PadRight(79) + "|") -ForegroundColor $colors["Data"]
    Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor $colors["Border"]
    Write-Host "`n"
}

# 主程序
Print-Header
Write-Host "正在初始化 Hadoop 环境...`n" -ForegroundColor $colors["Info"]
Start-Sleep -Milliseconds 500

Print-NameNodeInfo
Start-Sleep -Milliseconds 500

Print-DataNodeInfo
Start-Sleep -Milliseconds 500

Print-HDFSStructure
Start-Sleep -Milliseconds 500

Print-JobStatus
Start-Sleep -Milliseconds 500

Print-OutputSample
Start-Sleep -Milliseconds 500

Print-Summary

Write-Host ("=" * 80) -ForegroundColor $colors["Border"]
Write-Host ("  模拟运行完成！".PadRight(80).Substring(0, 80)) -ForegroundColor $colors["Header"]
Write-Host ("=" * 80) -ForegroundColor $colors["Border"]
Write-Host "`n"

