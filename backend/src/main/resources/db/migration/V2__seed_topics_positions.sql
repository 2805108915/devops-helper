-- 种子数据：知识点树（10 大类）与 4 个岗位路线图
INSERT INTO `topic` (`id`, `code`, `name`, `description`, `icon`, `sort_order`) VALUES
(1,  'linux',   'Linux 基础',      '文件、权限、进程、systemd、日常命令与文本三剑客', 'Platform', 1),
(2,  'network', '网络排障',        'TCP/IP、DNS、HTTP/HTTPS、抓包与连通性排查',      'Connection', 2),
(3,  'shell',   'Shell 脚本',      'Bash 语法、awk/sed、crontab、日志分析实战',      'DocumentCopy', 3),
(4,  'nginx',   'Nginx',           '反向代理、负载均衡、HTTPS、限流与 502/504 排查', 'Promotion', 4),
(5,  'docker',  'Docker',          '镜像与容器原理、Dockerfile、网络与数据卷',        'Box', 5),
(6,  'k8s',     'Kubernetes',      '核心对象、架构、网络、存储与排障',                'Grid', 6),
(7,  'cicd',    'CI/CD 与 Git',    'Git 工作流、Jenkins/GitHub Actions、发布策略',   'UploadFilled', 7),
(8,  'monitor', '监控与日志',      'Prometheus、Grafana、ELK、告警与可观测性',        'DataAnalysis', 8),
(9,  'mysql',   'MySQL 运维',      '主从复制、备份恢复、慢查询与索引优化',            'Coin', 9),
(10, 'mw',      'Redis/MQ 中间件', 'Redis 持久化与集群、消息堆积、缓存三大问题',      'Files', 10);

INSERT INTO `position` (`id`, `code`, `name`, `description`, `skills`, `sort_order`) VALUES
(1, 'junior-ops', '初级运维工程师', '传统运维入行：把服务稳定跑在 Linux 上',
 '[
   {"stage": "第一阶段 打地基", "items": ["Linux 常用命令与文件权限", "用户与用户组管理", "systemd 服务管理", "软件包管理 yum/apt", "Shell 脚本基础"]},
   {"stage": "第二阶段 管服务", "items": ["Nginx 安装配置与反代", "MySQL 基础运维与备份", "防火墙与安全基线", "日志排查 journalctl/logrotate", "crontab 计划任务"]},
   {"stage": "第三阶段 上台阶", "items": ["Shell 自动化脚本", "Ansible 批量管理", "Docker 容器化", "Zabbix/Prometheus 监控入门"]}
 ]', 1),
(2, 'devops', 'DevOps 工程师', '让代码从提交到上线全自动跑起来',
 '[
   {"stage": "第一阶段 工具链", "items": ["Git 分支模型与协作规范", "Maven/Gradle 构建", "Jenkins 或 GitHub Actions 流水线", "制品库 Nexus/Harbor"]},
   {"stage": "第二阶段 容器化", "items": ["Dockerfile 编写与镜像优化", "docker compose 编排", "Kubernetes 核心对象与部署", "Helm 包管理"]},
   {"stage": "第三阶段 自动化", "items": ["IaC：Terraform 管理云资源", "Ansible 配置管理", "灰度/蓝绿发布策略", "自动化测试与回滚机制"]}
 ]', 2),
(3, 'sre', 'SRE 工程师', '用工程手段保障稳定性：SLO、监控、应急响应',
 '[
   {"stage": "第一阶段 可观测", "items": ["Prometheus 指标与 PromQL", "Grafana 仪表盘", "ELK/Loki 日志体系", "链路追踪 SkyWalking/Jaeger"]},
   {"stage": "第二方法论", "items": ["SLI/SLO 与错误预算", "故障应急响应与复盘", "容量规划", "四个黄金指标"]},
   {"stage": "第三阶段 工程化", "items": ["混沌工程演练", "自动化故障自愈", "oncall 体系", "性能压测与调优"]}
 ]', 3),
(4, 'cloud', '云计算工程师', '云上架构与资源运营',
 '[
   {"stage": "第一阶段 云基础", "items": ["IaaS/PaaS/SaaS 概念", "ECS/虚拟机与镜像", "VPC 网络与安全组", "对象存储 OSS/S3"]},
   {"stage": "第二阶段 云核心", "items": ["负载均衡 SLB/CLB", "云数据库 RDS", "弹性伸缩 ESS", "域名解析与 CDN"]},
   {"stage": "第三阶段 云原生", "items": ["容器服务 ACK/EKS", "云监控与账单治理", "Terraform 资源编排", "多云与混合云架构"]}
 ]', 4);
