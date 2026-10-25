-- 题库种子：Docker（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(5, 'QA', 1, '镜像（Image）和容器（Container）是什么关系？', NULL,
 '类比**类和实例**：镜像是只读模板（分层文件系统 + 配置），容器是镜像的一个运行实例（镜像层 + 可写层）。\n\n- 一个镜像可以启动多个容器，互不影响\n- 容器删除后可写层丢失，数据要么落 volume，要么提交成新镜像（`docker commit`，不推荐作为常规做法）\n- 查看分层：`docker image inspect`、`docker history nginx:latest`\n\n镜像统一存储与分发格式叫 **OCI 镜像**，可推送到 registry（Docker Hub / Harbor）。',
 '["容器可写层满了会怎样？", "docker commit 一般什么场景用？"]', '["基础", "高频"]', 5, '["junior-ops", "devops", "sre"]'),

(5, 'QA', 2, '容器的核心底层技术是什么？和虚拟机的区别？', NULL,
 '两大支柱：\n1. **Namespace**：隔离视图 —— PID、NET、MNT、UTS、IPC、USER 六大空间，容器内只看到自己的进程、网卡、文件系统挂载\n2. **Cgroups**：限制资源 —— CPU 配额、内存上限、IO 带宽（`docker run --memory 512m --cpus 1`）\n\n加上 **UnionFS（overlay2）** 实现分层镜像。\n\n**与虚拟机区别**：\n- VM 虚拟化硬件，每个 VM 一个完整内核，GB 级、分钟级启动\n- 容器共享宿主内核，只隔离进程环境，MB 级、秒级启动、密度高\n- 代价：隔离性弱于 VM（内核共享、逃逸风险），所以安全要求高的场景容器跑在 VM 里',
 '["docker run --pid host 是什么效果？", "容器逃逸是怎么回事？"]', '["原理", "必考"]', 5, '["devops", "sre"]'),

(5, 'QA', 2, 'CMD 和 ENTRYPOINT 的区别？', NULL,
 '- **ENTRYPOINT**：容器固定的入口命令，`docker run` 的参数会**追加**给它\n- **CMD**：默认命令/默认参数，`docker run` 后面的参数会**整体覆盖**它\n\n经典组合（推荐写法）：\n```dockerfile\nENTRYPOINT ["java", "-jar", "app.jar"]\nCMD ["--spring.profiles.active=prod"]\n```\n- `docker run img` → 执行 `java -jar app.jar --spring.profiles.active=prod`\n- `docker run img --debug` → CMD 被覆盖，执行 `java -jar app.jar --debug`\n\nexec 数组格式 vs shell 格式：shell 格式（`CMD java -jar app.jar`）会包一层 `/bin/sh -c`，**收不到 SIGTERM 信号**，容器停不干净，生产用 exec 格式。',
 '["为什么 shell 格式收不到 SIGTERM？", "docker stop 卡 10 秒才停，怎么优化？"]', '["Dockerfile", "高频"]', 5, '["devops"]'),

(5, 'QA', 1, 'COPY 和 ADD 的区别？', NULL,
 '- `COPY src dst`：单纯复制本地文件进镜像 —— **默认用它**\n- `ADD` 额外功能：自动解压本地 tar 包、支持 URL 下载\n\n最佳实践：**需要解压 tar 才用 ADD，其他一律 COPY**（语义清晰、行为可预期）。下载文件用 `RUN curl/wget`（可在同一层清理，减小体积）。\n\n都支持多阶段构建里 `COPY --from=builder /app/target/app.jar /`。',
 '["COPY 多个文件时目标目录规则？"]', '["Dockerfile"]', 3, '["devops"]'),

(5, 'QA', 2, '容器的网络模式有哪些？bridge 模式下容器怎么被外部访问到？', NULL,
 '四种（`docker run --network`）：\n1. **bridge**（默认）：容器接 docker0 网桥，NAT 上网。容器间用 docker 内嵌 DNS（容器名当域名，同自定义网络才行）互访\n2. **host**：直接用宿主网络栈，无隔离无 NAT，性能最好\n3. **none**：只有 lo，完全无网\n4. **container:<name>**：共享另一容器的网络（K8s Pod 内就是这原理）\n\nbridge 下外部访问：\n- 端口映射 `docker run -p 8080:80`（iptables DNAT）\n- 或自建网络 + 容器间互联\n\n排查：`docker network inspect bridge`、容器内 `ip a`、`docker exec` 里 curl。',
 '["为什么默认 bridge 里容器名不通 DNS？", "-p 和 -P 的区别？"]', '["网络", "高频"]', 4, '["devops", "junior-ops"]'),

(5, 'QA', 1, '容器数据怎么持久化？volume 和 bind mount 的区别？', NULL,
 '1. **volume**（推荐）：`docker volume create appdata` → `-v appdata:/data`。由 Docker 管理（/var/lib/docker/volumes/），生命周期独立于容器，方便备份迁移，不依赖宿主目录结构\n2. **bind mount**：`-v /host/path:/container/path`。直接挂宿主目录，开发时挂代码热更新方便，但依赖宿主路径\n3. **tmpfs**：内存挂载，临时敏感数据\n\n```\ndocker run -v mysql-data:/var/lib/mysql mysql:8.0   # 数据库必须挂volume\n```\n\n备份 volume：`docker run --rm -v mysql-data:/src -v $PWD:/bak alpine tar czf /bak/mysql.tgz -C /src .`',
 '["容器删了 volume 还在吗？", "docker volume prune 干什么的？"]', '["存储", "高频"]', 4, '["junior-ops", "devops"]'),

(5, 'SCENARIO', 2, '容器一启动就退出（Exited），怎么排查？', 'docker run 之后 docker ps -a 显示容器几秒内 Exited (1) 或 Exited (137)。',
 '排查三板斧：\n1. **看退出码和日志**：`docker ps -a` 看退出码，`docker logs --tail 100 <c>` 看报错\n2. **退出码含义**：\n   - `Exited (1)`：应用启动报错（配置错、连不上依赖、路径不存在）\n   - `Exited (137)`：**被 SIGKILL** —— 多半 OOM（`docker inspect` 看 OOMKilled: true）或手动 kill -9\n   - `Exited (0)`：主进程正常结束了 —— 常见原因是前台命令写成后台/命令本身是瞬时的（如 `service nginx start` 立即返回）\n3. **替换入口调试**：`docker run -it --entrypoint /bin/sh img` 进去手动跑启动命令看真实报错\n\n经典原因清单：应用抛异常退出、前台进程退化为后台、OOM、依赖的服务没就绪。',
 '["OOMKilled 怎么确认和解决？", "为什么 CMD service nginx start 会秒退？"]', '["排障", "必考"]', 5, '["devops", "junior-ops", "sre"]'),

(5, 'QA', 2, '怎么做镜像瘦身？多阶段构建是什么？', NULL,
 '目标：更小的镜像 = 更快的拉取/部署 + 更小的攻击面。\n\n1. **小基础镜像**：alpine / distroless / Temurin JRE（Java 应用没必要用完整 JDK 镜像跑）\n2. **多阶段构建**：编译阶段用大镜像（Maven/JDK），运行阶段只 COPY 产物到小镜像：\n```dockerfile\nFROM maven:3.9-eclipse-temurin-17 AS build\nCOPY src /app/src; COPY pom.xml /app\nRUN mvn -f /app/pom.xml package -DskipTests\nFROM eclipse-temurin:17-jre-alpine\nCOPY --from=build /app/target/app.jar /app.jar\nENTRYPOINT ["java", "-jar", "/app.jar"]\n```\n3. **层清理**：`RUN apt-get update && apt-get install -y xxx && rm -rf /var/lib/apt/lists/*` 同一层装完就清\n4. `.dockerignore` 排除无关文件\n5. 合并 RUN 层或最后 `docker export|import` 压扁（了解）\n\n验证：`docker images` 对比大小。',
 '["Java 应用镜像一般多大？怎么继续压？", "alpine 镜像有什么坑？"]', '["优化", "高频"]', 4, '["devops"]'),

(5, 'QA', 1, 'docker compose 常用命令？编排一个 web+redis 怎么写？', NULL,
 '```yaml\nservices:\n  web:\n    build: ./web\n    ports: ["8080:8080"]\n    environment:\n      REDIS_HOST: redis\n    depends_on: [redis]\n  redis:\n    image: redis:7-alpine\n    volumes: [redis-data:/data]\nvolumes:\n  redis-data:\n```\n\n命令：`docker compose up -d`（后台起）、`ps`、`logs -f web`、`exec web sh`、`down`（加 `-v` 连卷删除）、`restart`。\n\n要点：服务名即 DNS 域名互访；`depends_on` 只控制启动顺序不等健康（加 `condition: service_healthy` 才等）。',
 '["depends_on 能保证 redis 就绪吗？", "compose 文件怎么分环境？"]', '["compose", "高频"]', 4, '["devops", "junior-ops"]'),

(5, 'QA', 1, 'docker exec 和 docker attach 的区别？进容器常用哪个？', NULL,
 '- `docker exec -it <c> bash`：**在容器里新开一个进程**（bash），退出不影响主进程 —— **99% 场景用它**\n- `docker attach <c>`：直接附加到**容器主进程**的终端，exit 会导致主进程退出（容器停止）—— 很少用，调试 PID 1 输出时偶尔用\n\n-i 保持 stdin、-t 分配 tty。容器没有 bash 时用 `sh`。\n\n注意：exec 进去只是"旁路"，看到的就是容器内真实环境（`ps` 只见容器内进程、`ip a` 是容器网卡）。',
 '["容器里没有 ps 命令怎么办？", "怎么不进容器看环境变量？"]', '["基础"]', 3, '["junior-ops", "devops"]');
