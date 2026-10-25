@echo off
chcp 936 >nul
title DevOpsHelper 停止服务
echo 正在停止后端(9800)/前端(5173)...
for /f "tokens=5" %%p in ('netstat -ano ^| findstr ":5173 :9800" ^| findstr "LISTENING"') do taskkill /F /PID %%p >nul 2>&1
echo 正在停止 MySQL...
docker compose -f "F:\code-java\devopsHepler\docker-compose.dev.yml" stop >nul 2>&1
echo.
echo 已停止全部服务（Docker Desktop 保持运行）。
timeout /t 3 >nul
exit /b 0
