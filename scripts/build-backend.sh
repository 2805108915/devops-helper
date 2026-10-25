#!/usr/bin/env bash
# 编译打包后端 + 构建前端并内嵌进 jar（改过任何代码后执行本脚本再重启）
set -e
cd "$(dirname "$0")/.."

echo "==> [1/3] 构建前端 dist ..."
(cd frontend && npm run build)

echo "==> [2/3] 拷贝前端到 jar 静态资源目录 ..."
rm -rf backend/src/main/resources/static
mkdir -p backend/src/main/resources/static
cp -r frontend/dist/. backend/src/main/resources/static/

echo "==> [3/3] 打包后端 jar（项目内隔离 JDK/Maven）..."
cd backend
source ../scripts/env.sh
mvn -s "$PROJECT_ROOT/.tools/maven-settings.xml" clean package -DskipTests

echo "完成！重启后端: scripts/stop-backend.sh && scripts/run-backend.sh"
