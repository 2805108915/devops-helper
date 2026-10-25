#!/usr/bin/env bash
# 停止后端
PID=$(netstat -ano 2>/dev/null | grep ":9800" | grep LISTEN | awk '{print $NF}' | head -1)
if [ -z "$PID" ]; then
  echo "后端未在运行"
  exit 0
fi
taskkill //F //PID "$PID" && echo "已停止 (PID $PID)"
