# Hadoop Project Upload Simulation Script
# Demonstrates uploading project to HDFS with realistic output

Write-Host "`n" -ForegroundColor Cyan
Write-Host ("=" * 90) -ForegroundColor Cyan
Write-Host "  Hadoop Log Anomaly Detection System - Project Upload Simulation" -ForegroundColor Cyan
Write-Host ("=" * 90) -ForegroundColor Cyan
Write-Host "`n"

# Step 1: Create HDFS directories
Write-Host "[STEP 1] Creating HDFS directories..." -ForegroundColor Green
Write-Host "Command: hdfs dfs -mkdir -p /user/hadoop/logs/input" -ForegroundColor Yellow
Write-Host "Command: hdfs dfs -mkdir -p /user/hadoop/logs/output" -ForegroundColor Yellow
Start-Sleep -Milliseconds 800
Write-Host "Status: Directories created successfully" -ForegroundColor Green
Write-Host "`n"

# Step 2: Upload data files
Write-Host "[STEP 2] Uploading data files to HDFS..." -ForegroundColor Green
Write-Host "Command: hdfs dfs -put 150/data/processed_logs.csv /user/hadoop/logs/input/" -ForegroundColor Yellow
Start-Sleep -Milliseconds 1000
Write-Host "Uploading: processed_logs.csv (194.92 MB)" -ForegroundColor Cyan
Write-Host "Progress: [##################################################] 100%" -ForegroundColor Cyan
Write-Host "Status: File uploaded successfully" -ForegroundColor Green
Write-Host "`n"

Write-Host "Command: hdfs dfs -put 150/data/eventId.txt /user/hadoop/logs/input/" -ForegroundColor Yellow
Start-Sleep -Milliseconds 500
Write-Host "Uploading: eventId.txt (2156 events)" -ForegroundColor Cyan
Write-Host "Progress: [##################################################] 100%" -ForegroundColor Cyan
Write-Host "Status: File uploaded successfully" -ForegroundColor Green
Write-Host "`n"

# Step 3: Upload JAR file
Write-Host "[STEP 3] Uploading compiled JAR file..." -ForegroundColor Green
Write-Host "Command: hdfs dfs -put 150/mapreduce/target/log-anomaly-detector-1.0-SNAPSHOT.jar /user/hadoop/logs/" -ForegroundColor Yellow
Start-Sleep -Milliseconds 800
Write-Host "Uploading: log-anomaly-detector-1.0-SNAPSHOT.jar (5.2 MB)" -ForegroundColor Cyan
Write-Host "Progress: [##################################################] 100%" -ForegroundColor Cyan
Write-Host "Status: JAR file uploaded successfully" -ForegroundColor Green
Write-Host "`n"

# Step 4: Verify uploaded files
Write-Host "[STEP 4] Verifying uploaded files..." -ForegroundColor Green
Write-Host "Command: hdfs dfs -ls -R /user/hadoop/logs/" -ForegroundColor Yellow
Start-Sleep -Milliseconds 800
Write-Host "`n"
Write-Host "Output:" -ForegroundColor Cyan
Write-Host "drwxr-xr-x   - hadoop hadoop          0 2025-12-26 12:30 /user/hadoop/logs" -ForegroundColor White
Write-Host "drwxr-xr-x   - hadoop hadoop          0 2025-12-26 12:30 /user/hadoop/logs/input" -ForegroundColor White
Write-Host "-rw-r--r--   1 hadoop hadoop  204405632 2025-12-26 12:30 /user/hadoop/logs/input/processed_logs.csv" -ForegroundColor White
Write-Host "-rw-r--r--   1 hadoop hadoop      89456 2025-12-26 12:30 /user/hadoop/logs/input/eventId.txt" -ForegroundColor White
Write-Host "drwxr-xr-x   - hadoop hadoop          0 2025-12-26 12:30 /user/hadoop/logs/output" -ForegroundColor White
Write-Host "-rw-r--r--   1 hadoop hadoop    5242880 2025-12-26 12:30 /user/hadoop/logs/log-anomaly-detector-1.0-SNAPSHOT.jar" -ForegroundColor White
Write-Host "`n"

# Step 5: Block Information Query
Write-Host "[STEP 5] Querying block information..." -ForegroundColor Green
Write-Host "Command: hdfs fsck /user/hadoop/logs/input/processed_logs.csv -files -blocks" -ForegroundColor Yellow
Start-Sleep -Milliseconds 1000
Write-Host "`n"
Write-Host "Output:" -ForegroundColor Cyan
Write-Host "/user/hadoop/logs/input/processed_logs.csv 204405632 bytes, 2 block(s):" -ForegroundColor White
Write-Host "Block ID: blk_1234567890123456 len=134217728 repl=1 [DatanodeInfoWithStorage[192.168.1.101:50010,DISK]]" -ForegroundColor White
Write-Host "Block ID: blk_0987654321098765 len=70187904 repl=1 [DatanodeInfoWithStorage[192.168.1.102:50010,DISK]]" -ForegroundColor White
Write-Host "`n"
Write-Host "Status: Healthy. 2 blocks and 2 racks" -ForegroundColor Green
Write-Host "`n"

# Step 6: Replication Information
Write-Host "[STEP 6] Checking replication information..." -ForegroundColor Green
Write-Host "Command: hdfs dfs -stat '%r %b %n' /user/hadoop/logs/input/*" -ForegroundColor Yellow
Start-Sleep -Milliseconds 800
Write-Host "`n"
Write-Host "Output:" -ForegroundColor Cyan
Write-Host "Replication Factor: 1" -ForegroundColor White
Write-Host "File: processed_logs.csv" -ForegroundColor White
Write-Host "  Size: 204405632 bytes (194.92 MB)" -ForegroundColor White
Write-Host "  Blocks: 2" -ForegroundColor White
Write-Host "  Replication: 1" -ForegroundColor White
Write-Host "`n"
Write-Host "File: eventId.txt" -ForegroundColor White
Write-Host "  Size: 89456 bytes (87.36 KB)" -ForegroundColor White
Write-Host "  Blocks: 1" -ForegroundColor White
Write-Host "  Replication: 1" -ForegroundColor White
Write-Host "`n"

# Step 7: DataNode Block Distribution
Write-Host "[STEP 7] DataNode block distribution..." -ForegroundColor Green
Write-Host "Command: hdfs dfsadmin -report" -ForegroundColor Yellow
Start-Sleep -Milliseconds 1000
Write-Host "`n"
Write-Host "Output:" -ForegroundColor Cyan
Write-Host "Configured Capacity: 1099511627776 (1 TB)" -ForegroundColor White
Write-Host "Present Capacity: 1099511627776 (1 TB)" -ForegroundColor White
Write-Host "DFS Remaining: 894784929792 (834 GB)" -ForegroundColor White
Write-Host "DFS Used: 204726697984 (190.6 GB)" -ForegroundColor White
Write-Host "`n"
Write-Host "Live datanodes (3):" -ForegroundColor White
Write-Host "`n"
Write-Host "Name: 192.168.1.101:50010 (datanode-01)" -ForegroundColor White
Write-Host "Hostname: datanode-01" -ForegroundColor White
Write-Host "Decommission Status: Normal" -ForegroundColor White
Write-Host "Configured Capacity: 366503875584 (341 GB)" -ForegroundColor White
Write-Host "DFS Used: 68157440000 (63.5 GB)" -ForegroundColor White
Write-Host "Non DFS Used: 0 (0 B)" -ForegroundColor White
Write-Host "DFS Remaining: 298346435584 (277.5 GB)" -ForegroundColor White
Write-Host "Blocks: 45" -ForegroundColor White
Write-Host "`n"
Write-Host "Name: 192.168.1.102:50010 (datanode-02)" -ForegroundColor White
Write-Host "Hostname: datanode-02" -ForegroundColor White
Write-Host "Decommission Status: Normal" -ForegroundColor White
Write-Host "Configured Capacity: 366503875584 (341 GB)" -ForegroundColor White
Write-Host "DFS Used: 68284928000 (63.6 GB)" -ForegroundColor White
Write-Host "Non DFS Used: 0 (0 B)" -ForegroundColor White
Write-Host "DFS Remaining: 298218947584 (277.4 GB)" -ForegroundColor White
Write-Host "Blocks: 46" -ForegroundColor White
Write-Host "`n"
Write-Host "Name: 192.168.1.103:50010 (datanode-03)" -ForegroundColor White
Write-Host "Hostname: datanode-03" -ForegroundColor White
Write-Host "Decommission Status: Normal" -ForegroundColor White
Write-Host "Configured Capacity: 366503875584 (341 GB)" -ForegroundColor White
Write-Host "DFS Used: 68284329984 (63.6 GB)" -ForegroundColor White
Write-Host "Non DFS Used: 0 (0 B)" -ForegroundColor White
Write-Host "DFS Remaining: 298219545600 (277.4 GB)" -ForegroundColor White
Write-Host "Blocks: 44" -ForegroundColor White
Write-Host "`n"

Write-Host ("=" * 90) -ForegroundColor Cyan
Write-Host "  Project Upload Simulation Completed Successfully!" -ForegroundColor Cyan
Write-Host ("=" * 90) -ForegroundColor Cyan
Write-Host "`n"

