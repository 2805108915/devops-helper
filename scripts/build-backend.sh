#!/usr/bin/env bash
# 编译打包后端 + 构建前端产物（后端托管 frontend/dist，改过任何代码后执行本脚本再重启）
set -e
cd "$(dirname "$0")/.."

echo "==> [1/2] 构建前端 dist ..."
(cd frontend && npm run build)

echo "==> [2/2] 打包后端 jar（项目内隔离 JDK/Maven）..."
cd backend
source ../scripts/env.sh
mvn -s "$PROJECT_ROOT/.tools/maven-settings.xml" package -DskipTests

echo "完成！重启后端: scripts/stop-backend.sh && scripts/run-backend.sh"
