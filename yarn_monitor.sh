#!/bin/bash

# 配置参数
LOG_FILE="/home/sa_cluster/yarn_monitor.log"
INTERVAL_SECONDS=5
YARN_RM_API="http://ENMSmeta03.spdb.com:8088/ws/v1/cluster/apps"  # 替换为实际RM地址

# 依赖检查
if ! command -v jq &> /dev/null; then
  echo "[ERROR] 'jq' is required. Install it with: sudo apt-get install jq"
  exit 1
fi

# 持续监控
while true; do
  timestamp=$(date "+%Y-%m-%d %H:%M:%S")
  response=$(curl -s "$YARN_RM_API")

  # 提取运行中的应用资源信息
  echo "===== $timestamp =====" >> "$LOG_FILE"
  echo "$response" | jq -r '.apps.app[] | select(.state == "RUNNING") | 
    "AppID: \(.id), Name: \(.name), User: \(.user), Memory: \(.allocatedMB)MB, CPU: \(.allocatedVCores)cores"' >> "$LOG_FILE"
  echo "======================" >> "$LOG_FILE"

  sleep "$INTERVAL_SECONDS"
done