# Hadoop Log Anomaly Detection System - Simulation Script (PowerShell)

Write-Host "`n" -ForegroundColor Cyan
Write-Host ("=" * 80) -ForegroundColor Cyan
Write-Host "  Hadoop Log Anomaly Detection System - Hadoop Simulation Environment" -ForegroundColor Cyan
Write-Host "  Version: 1.0" -ForegroundColor Cyan
Write-Host ("  Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')") -ForegroundColor Cyan
Write-Host ("=" * 80) -ForegroundColor Cyan
Write-Host "`n"

Write-Host "Initializing Hadoop environment...`n" -ForegroundColor Green
Start-Sleep -Milliseconds 500

# NameNode Info
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| NameNode Information" -ForegroundColor Green
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| NameNode Address: http://127.0.0.1:9870" -ForegroundColor Yellow
Write-Host "| NameNode Host: localhost" -ForegroundColor Yellow
Write-Host "| Status: Active" -ForegroundColor Yellow
Write-Host "| Version: Hadoop 3.3.1" -ForegroundColor Yellow
Write-Host ("| Startup Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')") -ForegroundColor Yellow
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "`n"
Start-Sleep -Milliseconds 500

# DataNode Info
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| DataNode Information" -ForegroundColor Green
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| DataNode 1:" -ForegroundColor Yellow
Write-Host "|   Hostname: datanode-01" -ForegroundColor Yellow
Write-Host "|   IP Address: 192.168.1.101" -ForegroundColor Yellow
Write-Host "|   Port: 50075" -ForegroundColor Yellow
Write-Host "|   Status: Live" -ForegroundColor Yellow
Write-Host "| " + ("-" * 76) + " |" -ForegroundColor Gray
Write-Host "| DataNode 2:" -ForegroundColor Yellow
Write-Host "|   Hostname: datanode-02" -ForegroundColor Yellow
Write-Host "|   IP Address: 192.168.1.102" -ForegroundColor Yellow
Write-Host "|   Port: 50075" -ForegroundColor Yellow
Write-Host "|   Status: Live" -ForegroundColor Yellow
Write-Host "| " + ("-" * 76) + " |" -ForegroundColor Gray
Write-Host "| DataNode 3:" -ForegroundColor Yellow
Write-Host "|   Hostname: datanode-03" -ForegroundColor Yellow
Write-Host "|   IP Address: 192.168.1.103" -ForegroundColor Yellow
Write-Host "|   Port: 50075" -ForegroundColor Yellow
Write-Host "|   Status: Live" -ForegroundColor Yellow
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "`n"
Start-Sleep -Milliseconds 500

# HDFS Structure
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| HDFS Directory Structure (After Project Upload)" -ForegroundColor Green
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| /user/hadoop/" -ForegroundColor Yellow
Write-Host "| +-- logs/" -ForegroundColor Yellow
Write-Host "|     +-- input/" -ForegroundColor Yellow
Write-Host "|     |   +-- processed_logs.csv (194.92 MB)" -ForegroundColor Yellow
Write-Host "|     |   +-- eventId.txt (2156 events)" -ForegroundColor Yellow
Write-Host "|     +-- output/" -ForegroundColor Yellow
Write-Host "|         +-- part-r-00000 (result file)" -ForegroundColor Yellow
Write-Host "|         +-- part-r-00001 (result file)" -ForegroundColor Yellow
Write-Host "|         +-- _SUCCESS" -ForegroundColor Yellow
Write-Host "| +-- project/" -ForegroundColor Yellow
Write-Host "|     +-- mapreduce/" -ForegroundColor Yellow
Write-Host "|     |   +-- pom.xml" -ForegroundColor Yellow
Write-Host "|     |   +-- src/" -ForegroundColor Yellow
Write-Host "|     |   |   +-- main/java/com/hadoop/" -ForegroundColor Yellow
Write-Host "|     |   |       +-- LogAnomalyDetector.java" -ForegroundColor Yellow
Write-Host "|     |   |       +-- DatasetProcessor.java" -ForegroundColor Yellow
Write-Host "|     |   +-- target/" -ForegroundColor Yellow
Write-Host "|     |       +-- log-anomaly-detector-1.0-SNAPSHOT.jar" -ForegroundColor Yellow
Write-Host "|     +-- data/" -ForegroundColor Yellow
Write-Host "|         +-- processed_logs.csv" -ForegroundColor Yellow
Write-Host "|         +-- eventId.txt" -ForegroundColor Yellow
Write-Host "|         +-- output_example.txt" -ForegroundColor Yellow
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "`n"
Start-Sleep -Milliseconds 500

# MapReduce Job Status
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| MapReduce Job Status" -ForegroundColor Green
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| Job ID: job_202512261234_0001" -ForegroundColor Yellow
Write-Host "| Job Name: LogAnomalyDetector" -ForegroundColor Yellow
Write-Host "| Status: SUCCEEDED" -ForegroundColor Yellow
Write-Host "| Progress: Map 100% | Reduce 100%" -ForegroundColor Yellow
Write-Host "| Records Processed: 2,185,618" -ForegroundColor Yellow
Write-Host "| Event Types: 2,156" -ForegroundColor Yellow
Write-Host "| Execution Time: 12m 34s" -ForegroundColor Yellow
Write-Host "| Output Path: /user/hadoop/logs/output" -ForegroundColor Yellow
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "`n"
Start-Sleep -Milliseconds 500

# Output Sample
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| Processing Results Sample (First 10 Records)" -ForegroundColor Green
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| normal,B076E6516B275ABB,123,456,789,234,567" -ForegroundColor Yellow
Write-Host "| abnormal,A8DFB1AFB3AF3645,234,567,890,345,678" -ForegroundColor Yellow
Write-Host "| normal,C1E2F3A4B5C6D7E8,345,678,901,456,789" -ForegroundColor Yellow
Write-Host "| abnormal,D2F3G4A5B6C7D8E9,456,789,012,567,890" -ForegroundColor Yellow
Write-Host "| normal,E3G4H5A6B7C8D9E0,567,890,123,678,901" -ForegroundColor Yellow
Write-Host "| abnormal,F4H5I6A7B8C9D0E1,678,901,234,789,012" -ForegroundColor Yellow
Write-Host "| normal,G5I6J7A8B9C0D1E2,789,012,345,890,123" -ForegroundColor Yellow
Write-Host "| abnormal,H6J7K8A9B0C1D2E3,890,123,456,901,234" -ForegroundColor Yellow
Write-Host "| normal,I7K8L9A0B1C2D3E4,901,234,567,012,345" -ForegroundColor Yellow
Write-Host "| abnormal,J8L9M0A1B2C3D4E5,012,345,678,123,456" -ForegroundColor Yellow
Write-Host "| ..." -ForegroundColor Yellow
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "`n"
Start-Sleep -Milliseconds 500

# Project Statistics
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| Project Statistics" -ForegroundColor Green
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "| Source Code Lines: 244" -ForegroundColor Yellow
Write-Host "| Core Documents: 9" -ForegroundColor Yellow
Write-Host "| Data File Size: 195.31 MB" -ForegroundColor Yellow
Write-Host "| Log Records Processed: 2,185,618" -ForegroundColor Yellow
Write-Host "| Event Types: 2,156" -ForegroundColor Yellow
Write-Host "| Processed Folders: 50" -ForegroundColor Yellow
Write-Host "| Backup Files: 9" -ForegroundColor Yellow
Write-Host ("+--" + ("-" * 76) + "--+") -ForegroundColor Gray
Write-Host "`n"

Write-Host ("=" * 80) -ForegroundColor Cyan
Write-Host "  Simulation Completed Successfully!" -ForegroundColor Cyan
Write-Host ("=" * 80) -ForegroundColor Cyan
Write-Host "`n"

