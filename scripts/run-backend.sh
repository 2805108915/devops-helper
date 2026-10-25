#!/usr/bin/env bash
# 后台启动后端（日志: .tools/backend.log）
set -e
cd "$(dirname "$0")/.."
source scripts/env.sh
if netstat -ano 2>/dev/null | grep ":9800" | grep -q LISTEN; then
  echo "后端已在运行 (端口 9800)，如需重启先执行 scripts/stop-backend.sh"
  exit 0
fi
(nohup "$JAVA_HOME/bin/java" -jar backend/target/devops-helper-0.1.0-SNAPSHOT.jar > .tools/backend.log 2>&1 &)
echo "后端启动中... http://localhost:9800  日志: .tools/backend.log"
