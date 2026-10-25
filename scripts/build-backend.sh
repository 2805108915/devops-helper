#!/usr/bin/env bash
# 编译打包后端（使用项目内隔离的 JDK 与 Maven 仓库）
set -e
cd "$(dirname "$0")/../backend"
source ../scripts/env.sh
mvn -s "$PROJECT_ROOT/.tools/maven-settings.xml" package -DskipTests
echo "打包完成: backend/target/devops-helper-0.1.0-SNAPSHOT.jar"
