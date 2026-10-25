#!/usr/bin/env bash
# 项目环境变量统一入口：所有脚本 source 本文件，保证 JDK/Maven/npm 全部使用项目内隔离环境
export PROJECT_ROOT="F:/code-java/devopsHepler"
export JAVA_HOME="$PROJECT_ROOT/.tools/jdk-17.0.20.1+1"
export PATH="$JAVA_HOME/bin:$PATH"
export MVN="mvn -s $PROJECT_ROOT/.tools/maven-settings.xml"
