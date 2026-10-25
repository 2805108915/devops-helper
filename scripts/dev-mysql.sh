#!/usr/bin/env bash
# 启动开发用 MySQL（数据保存在项目内 ./docker-data/mysql）
set -e
cd "$(dirname "$0")/.."
docker compose -f docker-compose.dev.yml up -d
echo "MySQL: localhost:3316  root/devops123  库: devops_helper"
