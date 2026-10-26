@echo off
chcp 936 >nul
title DevOpsHelper OneKey Start
setlocal enabledelayedexpansion
rem 自动定位项目根目录（脚本在 scripts 下，上级即根）
set "ROOT=%~dp0.."
set "JAVAW=%ROOT%\.tools\jdk-17.0.20.1+1\bin\javaw.exe"
if not exist "%JAVAW%" set "JAVAW=javaw.exe"
set "JAR=%ROOT%\backend\target\devops-helper-0.1.0-SNAPSHOT.jar"
set "URL=http://127.0.0.1:9800"
cd /d "%ROOT%"

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
echo [2/4] MySQL 已就绪

REM ---------- 3/4 后端（同时托管前端页面） ----------
netstat -ano | findstr ":9800" | findstr "LISTENING" >nul
if not errorlevel 1 goto backend_ok
if not exist "%JAR%" (
    echo [错误] 未找到后端 jar，请先执行 bash scripts/build-backend.sh
    pause
    exit /b 1
)
echo [3/4] 启动后端 :9800 ...
start "" /B "%JAVAW%" -jar "%JAR%"
set /a BE_TRIES=0
:wait_backend
timeout /t 3 /nobreak >nul
netstat -ano | findstr ":9800" | findstr "LISTENING" >nul
if not errorlevel 1 goto backend_ok
set /a BE_TRIES+=1
if !BE_TRIES! lss 25 goto wait_backend
echo [错误] 后端启动失败，日志: logs/backend.log
pause
exit /b 1
:backend_ok
echo [3/4] 后端已就绪

REM ---------- 4/4 校验页面并打开浏览器 ----------
%SystemRoot%\System32\curl.exe -s -m 8 -o "%ROOT%\logs\page-check.tmp" %URL%/
findstr /i /c:"<html" "%ROOT%\logs\page-check.tmp" >nul 2>&1
if errorlevel 1 (
    echo [错误] 后端在运行但页面未托管！请执行: bash scripts/build-backend.sh 后重新双击本快捷方式
    pause
    exit /b 1
)
echo [4/4] 页面校验通过，打开浏览器...
echo 提示: 若浏览器弹出权限询问（Edge 未响应），点【是】即可正常打开
start "" "%URL%"
echo.
echo ==========================================
echo   启动完成！访问地址: %URL%
echo   如浏览器未自动打开，请手动访问上述地址
echo   停止服务: scripts\stop-all.cmd
echo ==========================================
timeout /t 6 >nul
exit /b 0
