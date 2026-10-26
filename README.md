# DevOpsHelper — 运维学习与面试备战平台

> **DevOpsHelper** — An open-source ops/SRE learning platform: categorized interview questions, **real Linux sandboxes in your browser**, spaced repetition, a personal knowledge base, and optional AI assistance.
>
> 面向运维/DevOps/SRE 学习者与求职者的单用户本地学习工具：**1067 道精选面试题（11 大知识点含云计算）+ 100 个真实容器实操实验 + 102 篇知识库笔记 + SM-2 间隔复习 + 可选 AI 模拟面试**。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## ✨ 亮点 Features

- 🧪 **浏览器里的真实 Linux 沙箱**：每个实操实验启动一个真实 Docker 容器并预埋故障（磁盘写满、502、OOM、SSH 登录失败、Redis 连不上……），你在网页终端里排查修复，系统自动判分，限时自动销毁
- 📝 **1000 道面试题**：10 大知识点 × 问答/选择/场景排障，附参考答案、面试官追问、出题语境，支持筛选/错题本/自建题库
- 🔁 **SM-2 间隔复习**：不会→明天，模糊→3 天，会→间隔倍增；每日复习队列 + 掌握度雷达图
- 📚 **102 篇知识库**：每知识点 10 篇实战速查（命令配方/排障手册/配置模板），Markdown 编辑、与题目互链
- 🧭 **四条岗位路线图**：初级运维 / DevOps / SRE / 云计算
- 🤖 **可选 AI 助手**：OpenAI 兼容接口（GLM/DeepSeek/OpenAI），模拟面试官连环追问、题目深挖、生成新题一键入库
- 🚀 **一键启动**（Windows）+ docker compose 一键部署（Linux 服务器）

## 🚀 快速开始

### 方式 A：标准环境（任何平台）

前置：JDK 17+、Maven 3.8+、Node.js 18+、Docker（实操实验需要）。

```bash
# 1. 启动数据库（数据持久化在 ./docker-data/mysql）
docker compose -f docker-compose.dev.yml up -d

# 2. 一体化构建（前端 dist → 内嵌进 jar）
bash scripts/build-backend.sh

# 3. 启动后端（首次启动自动建表并导入全部内容）
java -jar backend/target/devops-helper-0.1.0-SNAPSHOT.jar

# 4. 打开 http://127.0.0.1:9800
```

### 方式 B：Windows 一键启动

双击桌面快捷方式（或运行 `scripts/start-all.cmd`）：自动 Docker → MySQL → 后端 → 打开浏览器。
停止服务：`scripts/stop-all.cmd`。

### 实验室首次使用

1. 进入「实操实验室」，点击「构建基础镜像」（基于 ubuntu:22.04 预装运维工具全家桶，约 3-10 分钟，仅一次）
2. 任选实验点击「开始实验」→ 右侧出现真实终端
3. 按场景排查修复 → 点击「检测判分」→ 通关后查看参考解法

### AI 助手（可选）

「AI 助手」页展开配置：Base URL / API Key / 模型名。
以智谱 GLM 为例：`https://open.bigmodel.cn/api/paas/v4` + 你的 Key + `glm-4-flash`（免费额度即可）。
不配置完全不影响其他功能。

## 🖥 服务器部署（docker compose）

```bash
bash scripts/build-backend.sh   # 先本地打包
docker compose up -d --build    # MySQL + 后端 + Nginx 前端
# 访问 http://服务器IP（80端口）
```

## 📁 项目结构

```
├── backend/                  Spring Boot 3（JDK17）
│   ├── lab/                  🧪 Docker 沙箱核心：容器管理/Web终端(WS+attach)/判分引擎
│   ├── ai/                   OpenAI 兼容流式客户端（SSE）
│   ├── review/               SM-2 间隔重复算法
│   └── db/migration/         Flyway：建表 + 1000题/102篇种子数据
├── frontend/                 Vue3 + Element Plus + xterm.js + ECharts + md-editor-v3
├── labs/
│   ├── images/base/          实验基础镜像 Dockerfile
│   └── definitions/          100 个实验定义（场景/预埋脚本/检测/提示/解法，YAML）
├── scripts/content/          ✨ 内容生成器：数据文件 → SQL/YAML（可自行增补内容）
└── docker-compose*.yml       开发库 / 生产部署
```

**自己加题/加实验**：编辑 `scripts/content/` 下的数据文件后执行 `node scripts/content/gen.mjs`，重启后端自动导入。

## 🎓 这个项目本身就是学习素材

它覆盖了 DevOps 面试的高频技术点，README 里就有面试答法：

- docker-java 管理容器生命周期、cgroups 资源限额、attach 实现浏览器终端（WebSocket 双向流）
- exec 执行判分脚本、YAML 驱动的实验定义
- Flyway 数据库版本化、SM-2 算法、SSE 流式 AI 对话
- 多阶段构建、Nginx 反代 + WebSocket 升级、docker compose 编排

## ❓ 常见问题

- **3306/3307 被占用**：本项目开发库用 **3316** 端口，与常见本地 MySQL 不冲突
- **后端起不来**：先确认 MySQL 容器在跑（`docker ps | grep devopshelper-mysql`）；日志在 `logs/backend.log`
- **终端连不上**：确认 Docker Desktop 已启动且为 Linux 容器模式；实验页面有「重连终端/重开实验」按钮
- **改代码后**：`bash scripts/build-backend.sh` 再重启（前端会自动内嵌进 jar）
- **重置学习数据**：`docker exec devopshelper-mysql mysql -uroot -pdevops123 -e "DROP DATABASE devops_helper; CREATE DATABASE devops_helper CHARACTER SET utf8mb4"` 后重启后端（种子内容会重新导入，自建题目会丢）

## 🤝 贡献

欢迎 Issue / PR：新增题目与实验（编辑 `scripts/content/` 数据文件即可）、修复 bug、改进文档。

## 📄 License

[MIT](LICENSE) — 实验沙箱环境仅供学习用途，请勿用于未授权的测试目标。
