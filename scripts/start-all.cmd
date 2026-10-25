cd /d "%ROOT%"
@echo off
chcp 936 >nul
title DevOpsHelper OneKey Start
setlocal enabledelayedexpansion
set "ROOT=F:\code-java\devopsHepler"
set "JAVAW=%ROOT%\.tools\jdk-17.0.20.1+1\bin\javaw.exe"
set "JAR=%ROOT%\backend\target\devops-helper-0.1.0-SNAPSHOT.jar"
cd /d "%ROOT%

echo ==========================================
echo        DevOpsHelper 一键启动
echo ==========================================
echo.

REM ---------- 1/4 Docker Desktop ----------
docker info >nul 2>&1
if not errorlevel 1 goto docker_ok
echo [1/4] 正在启动 Docker Desktop（开机后首次可能需要 1-3 分钟）...
if not exist "C:\Program Files\Docker\Docker\Docker Desktop.exe" (
    echo [错误] 找不到 Docker Desktop，请手动启动后重试
    pause
    exit /b 1
)
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
set /a DOCKER_TRIES=0
:wait_docker
timeout /t 5 /nobreak >nul
docker info >nul 2>&1
if not errorlevel 1 goto docker_ok
set /a DOCKER_TRIES+=1
echo       ...等待 Docker 就绪 !DOCKER_TRIES!/60
if !DOCKER_TRIES! lss 60 goto wait_docker
echo [错误] Docker 启动超时，请手动检查 Docker Desktop 后重试
pause
exit /b 1
:docker_ok
echo [1/4] Docker 已就绪

REM ---------- 2/4 MySQL ----------
echo [2/4] 启动 MySQL 容器 devopshelper-mysql ...
docker compose -f "%ROOT%\docker-compose.dev.yml" up -d >nul 2>&1
set /a MYSQL_TRIES=0
:wait_mysql
timeout /t 3 /nobreak >nul
docker exec devopshelper-mysql mysqladmin ping -uroot -pdevops123 >nul 2>&1
if not errorlevel 1 goto mysql_ok
set /a MYSQL_TRIES+=1
if !MYSQL_TRIES! lss 30 goto wait_mysql
echo [错误] MySQL 未就绪，排查: docker logs devopshelper-mysql
pause
exit /b 1
:mysql_ok
echo [2/4] MySQL 已就绪 localhost:3316

REM ---------- 3/4 后端（同时托管前端页面） ----------
netstat -ano | findstr ":9800" | findstr "LISTENING" >nul
if not errorlevel 1 goto backend_ok
if not exist "%JAR%" (
    echo [错误] 未找到后端 jar，请先执行 bash scripts/build-backend.sh
    pause
    exit /b 1
)
if not exist "%ROOT%\frontend\dist\index.html" (
    echo [提示] 前端页面未构建，仅启动 API。可执行: cd frontend 然后 npm run build
)
echo [3/4] 启动后端 :9800 ...
start "" /B "%JAVAW%" -jar "%JAR%" > "%ROOT%\.tools\backend.log" 2>&1
set /a BE_TRIES=0
:wait_backend
timeout /t 3 /nobreak >nul
netstat -ano | findstr ":9800" | findstr "LISTENING" >nul
if not errorlevel 1 goto backend_ok
set /a BE_TRIES+=1
if !BE_TRIES! lss 25 goto wait_backend
echo [错误] 后端启动失败，日志: .tools\backend.log
pause
exit /b 1
:backend_ok
echo [3/4] 服务已就绪 http://localhost:9800

REM ---------- 4/4 打开浏览器 ----------
echo [4/4] 打开浏览器...
start "" "http://localhost:9800"
echo.
echo ==========================================
echo   启动完成！停止服务: scripts\stop-all.cmd
echo ==========================================
timeout /t 5 >nul
exit /b 0
