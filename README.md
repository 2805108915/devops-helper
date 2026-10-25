# DevOpsHelper 运维学习与面试备战平台

一个**单用户本地学习工具**：分类面试题库 + Docker 真实沙箱实操 + 个人知识库 + 间隔复习 + 可选 AI 辅助。
技术栈：Spring Boot 3 + Vue 3 + MySQL 8 + Docker。项目本身附带了完整的容器化部署方案——它就是你第一个可以写进简历的 DevOps 实战项目。

## 功能总览

| 模块 | 说明 |
|------|------|
| 📝 题库刷题 | 内置 100 道精选高频题（问答/场景排障），按 10 大知识点 × 难度 × 岗位筛选，支持自评、错题本、自建题目录入 |
| 🔁 间隔复习 | SM-2 算法（同 Anki）：不会→明天，模糊→3 天，会→间隔倍增；每日复习队列 |
| 🧪 实操实验室 | **核心亮点**：每道实操题启动一个真实 Linux 容器并预埋故障（磁盘写满、CPU 打满、502、SSH 登不上、Redis 连不上...），在浏览器 Web 终端里排查修复，系统自动判分，限时自动销毁 |
| 📚 知识库 | Markdown 笔记按知识点组织，与题目双向关联 |
| 🧭 岗位路线 | 初级运维 / DevOps / SRE / 云计算四条学习路线图 + 对应题集进度 |
| 🤖 AI 助手 | 可选接入 OpenAI 兼容 API（GLM/DeepSeek/OpenAI）：模拟面试官、题目追问、生成新题一键入库 |

## 快速开始

### 日常使用：桌面一键启动（推荐）

桌面上已有 **「DevOpsHelper 一键启动」** 快捷方式（指向 `scripts/start-all.cmd`）。开机后双击它，脚本会自动：

1. 启动 Docker Desktop（若未运行，首次约 1-3 分钟）
2. 启动 MySQL 容器（数据在 `./docker-data/mysql`，可重复执行）
3. 启动后端服务（同时托管前端页面）
4. 自动打开浏览器 **http://localhost:9800**

停止全部服务：双击 `scripts/stop-all.cmd`。

> 注：后端已托管前端构建产物，日常使用只有「一个 Java 进程 + 一个 MySQL 容器」，无需 Node。

### 开发模式（改代码时）

**前置要求**：本机已装 Docker Desktop、Node.js 18+。JDK 17 与 Maven 仓库已包含在 `.tools/`（无需自己安装 JDK），所有工具与缓存隔离在项目内。

```bash
bash scripts/build-backend.sh        # 编译打包后端 + 重新构建前端 dist
bash scripts/run-backend.sh          # 启动后端 http://localhost:9800（日志 .tools/backend.log）

# 前端改动后的热更新开发（可选，仅前端开发时需要）
bash scripts/dev-frontend.sh         # Vite dev server http://localhost:5173
```

### 实验室首次使用

1. 打开「实操实验室」页面，Docker 正常时会提示构建基础镜像
2. 点击「构建基础镜像」（约 3-10 分钟，只需一次）
3. 任选实验点击「开始实验」→ 右侧出现真实终端，左侧看场景和提示
4. 排查修复后点「检测判分」，通过后可查看参考解法

### AI 助手配置（可选）

「AI 助手」页展开配置：填 Base URL / API Key / 模型名并启用。
以智谱 GLM 为例：`https://open.bigmodel.cn/api/paas/v4` + 你的 Key + `glm-4-flash`（免费额度即可用）。
不配置完全不影响其他功能。

## 服务器部署（docker compose 一键）

```bash
# 前提：服务器已装 docker + docker compose，先本地执行过 build-backend.sh
bash scripts/build-backend.sh
docker compose up -d --build
# 访问 http://服务器IP  （80 端口）
```

包含三个服务：MySQL（数据持久化在 ./docker-data）、后端（挂载 Docker socket 管理实验沙箱）、前端（Nginx 托管 + 反代）。
云服务器安全组放行 80 端口即可；建议再套一层域名 + HTTPS（可用 certbot 或云厂商免费证书）。

## 项目结构

```
devopsHepler/
├── backend/                  Spring Boot 3 后端
│   ├── src/main/java/com/devops/helper/
│   │   ├── lab/              Lab 沙箱核心（docker-java 容器管理/Web终端桥接/判分）
│   │   ├── ai/               OpenAI 兼容流式客户端
│   │   └── ...               题库/复习(SM-2)/知识库/笔记/岗位
│   └── src/main/resources/db/migration/   Flyway 建表+100题种子
├── frontend/                 Vue3 + Element Plus + xterm.js + ECharts
├── labs/
│   ├── images/base/          实验基础镜像（ubuntu:22.04 + 运维工具全家桶）
│   └── definitions/*.yml     10 个实验定义（场景/预埋脚本/检测脚本/提示/解法）
├── scripts/                  开发脚本（全部使用项目内隔离环境）
├── .tools/                   隔离环境：JDK17、Maven仓库、npm缓存、运行日志（gitignore）
├── docker-compose.dev.yml    开发用 MySQL
└── docker-compose.yml        生产部署
```

## 新增一个实操实验

在 `labs/definitions/` 新建 YAML：

```yaml
code: my-lab            # 唯一编码
name: 实验名称
topic: nginx            # 关联知识点（见 topic 表 code）
difficulty: 2           # 1-3
timeLimitMinutes: 45
scenario: |             # 给用户看的故事背景与任务
  ...
setup: |                # 容器启动后执行的预埋故障脚本（sh）
  ...
check: |                # 判分脚本：最后一行输出 JSON {"pass":bool,"message":"..."}
  ...
hints: [提示1, 提示2, 提示3]
solution: |
  ...
```

重启后端自动导入。

## 面试可以怎么讲这个项目

- **全栈**：Spring Boot 3 + MyBatis-Plus + Flyway + Vue3 前后端分离
- **Docker 深度应用**：docker-java 管理容器生命周期、资源限额（cgroups 参数）、attach 实现浏览器 Web 终端（WebSocket 双向流）、exec 执行判分脚本
- **工程化**：Flyway 数据库版本化、YAML 驱动的实验定义、SM-2 间隔重复算法、SSE 流式 AI 对话
- **部署**：多阶段构建、Nginx 反代 + WebSocket 升级、docker compose 编排、Docker socket 挂载的容器管理架构

## 常见问题

- **3306/3307 端口被占用**：本机已有其他 MySQL。本项目开发库固定用 **3316** 端口。
- **后端起不来报连接失败**：先 `bash scripts/dev-mysql.sh` 确认 MySQL 容器在跑。
- **实验容器连不上**：确认 Docker Desktop 已启动且处于 Linux 容器模式。
- **终端中文乱码**：容器已配置 `LANG=C.UTF-8`，若仍有问题刷新页面重连。
- **重置所有学习数据**：`docker exec devopshelper-mysql mysql -uroot -pdevops123 -e "DROP DATABASE devops_helper; CREATE DATABASE devops_helper CHARACTER SET utf8mb4"` 后重启后端（题库种子会重新导入，自建题目会丢失）。
