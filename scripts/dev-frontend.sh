#!/usr/bin/env bash
# 启动前端开发服务器（自动代理到本地后端 9800）
set -e
cd "$(dirname "$0")/../frontend"
npm run dev
