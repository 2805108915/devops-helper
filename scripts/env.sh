#!/usr/bin/env bash
# 项目环境变量统一入口：所有脚本 source 本文件
# PROJECT_ROOT 自动定位到项目根目录（不依赖硬编码路径）
export PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ -d "$PROJECT_ROOT/.tools/jdk-17.0.20.1+1" ]; then
  export JAVA_HOME="$PROJECT_ROOT/.tools/jdk-17.0.20.1+1"
  export PATH="$JAVA_HOME/bin:$PATH"
fi
if [ -f "$PROJECT_ROOT/.tools/maven-settings.xml" ]; then
  export MVN="mvn -s $PROJECT_ROOT/.tools/maven-settings.xml"
else
  export MVN="mvn"
fi
