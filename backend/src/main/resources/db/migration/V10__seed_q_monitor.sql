-- 题库种子：监控与日志（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(8, 'QA', 2, '一个系统的监控体系应该分哪几层？', NULL,
 '由下往上四层：\n1. **基础设施**：IDC/云主机存活、网络质量（丢包、延迟）\n2. **系统层**：CPU、内存、磁盘、IO、网络流量、load —— node_exporter\n3. **应用层**：JVM（GC、堆内存、线程）、接口 QPS/RT/错误率、中间件（MySQL/Redis/MQ）—— 各种 exporter + micrometer\n4. **业务层**：订单量、支付成功率、登录数 —— 业务指标往往最**先**反映问题\n\n原则：**告警从上层触发**（用户先受损才报警，最关键）、**下层数据用于定位**。只有系统层监控会在 CPU 90% 时报警，但用户早就受影响了。',
 '["为什么业务监控很重要？", "黑盒监控和白盒监控区别？"]', '["监控", "高频"]', 4, '["junior-ops", "sre", "devops"]'),

(8, 'QA', 2, 'Prometheus 的架构？为什么用拉取（Pull）模式？', NULL,
 '核心组件：\n- **Prometheus Server**：定时从 exporter / 应用 /metrics 端点**拉取**指标，存本地时序数据库（TSDB）\n- **Exporter**：把现有系统翻译成 metrics 格式（node_exporter=主机，mysqld_exporter=MySQL）\n- **Pushgateway**：短生命周期任务主动推指标的中转站（批处理任务）\n- **Alertmanager**：接收告警规则触发，去重、分组、路由、静默，发钉钉/飞书/邮件\n- **Grafana**：查询展示（PromQL）\n\n**Pull 的好处**：\n1. 目标健康状态天然可知（拉不到=挂了）\n2. 被监控方实现简单（暴露 /metrics HTTP 端点即可）\n3. 无被监控端堆积问题，抓取节奏由监控方统一控制\n4. 手动 curl /metrics 就能调试\n\n服务发现：static_configs 静态配置或对接 Consul/K8s（Pod 变化自动纳入）。',
 '["Pushgateway 什么场景必须用？", "Prometheus 数据存多久，怎么扩容？"]', '["Prometheus", "必考"]', 5, '["sre", "devops"]'),

(8, 'QA', 3, 'PromQL：怎么写 QPS 和 P99 延迟？', NULL,
 '假设指标（micrometer 标准命名）：\n- `http_server_requests_seconds_count{uri="/api/order"}` 累计请求次数\n- `http_server_requests_seconds_bucket{le="..."}` 直方图桶\n\n**QPS**（counter 要先 rate）：\n```promql\nsum(rate(http_server_requests_seconds_count[5m]))\n```\n\n**P99 延迟**：\n```promql\nhistogram_quantile(0.99,\n  sum(rate(http_server_requests_seconds_bucket[5m])) by (le)\n)\n```\n\n**错误率**：\n```promql\nsum(rate(http_server_requests_seconds_count{status=~"5.."}[5m]))\n/\nsum(rate(http_server_requests_seconds_count[5m]))\n```\n\n要点：counter 必须 rate/increase；histogram 才能算分位数（summary 不支持聚合）；[5m] 是回看窗口。',
 '["rate 和 irate 的区别？", "为什么 P99 比 P999 常用？"]', '["PromQL", "进阶"]', 3, '["sre"]'),

(8, 'QA', 2, 'SRE 说的四个黄金指标是什么？', NULL,
 'Google SRE 书定义，衡量服务健康的最小集：\n1. **延迟（Latency）**：请求耗时（区分成功/失败请求的延迟，失败请求往往更快返回）\n2. **流量（Traffic）**：QPS / 并发数 / 带宽\n3. **错误（Errors）**：5xx 比例、业务错误码率\n4. **饱和度（Saturation）**：资源"满"的程度 —— CPU、内存、IO、队列长度、线程池\n\n用法：任何服务先配齐这四个的告警，再逐步丰富。\n\n配套概念：**USE 方法**（Utilization/Saturation/Errors 查资源）、**RED 方法**（Rate/Errors/Duration 查服务）—— 面试提这两个方法论很加分。',
 '["RED 和 USE 分别适合监控什么？", "延迟上升但错误率正常，说明什么？"]', '["SRE", "必考"]', 5, '["sre"]'),

(8, 'QA', 2, '告警怎么设计？怎么避免告警风暴（告警疲劳）？', NULL,
 '原则：**每条告警都必须"值得被叫醒"，否则就是噪音**。\n\n1. **分级**：P0 电话/短信（服务不可用）、P1 IM 群（错误率/延迟异常）、P2 邮件（容量趋势）\n2. **基于症状而非原因**：报"下单失败率 >1%"（用户受损），而不是"某台机器 CPU 高"（可能无影响）\n3. **去重聚合**：Alertmanager `group_by` 按服务聚合，一次故障一条富信息告警，而不是 200 条\n4. **静默与抑制**：机房级故障时抑制下游服务告警；变更窗口静默\n5. **合理阈值 + 持续时长**：CPU>90% **持续 5 分钟**才报，避免毛刺\n6. **告警要带上下文**：当前值、影响面、runbook 链接\n7. 定期复盘：从未 actionable 的告警删掉或调阈值',
 '["告警发出来没人看怎么办？", "怎么写告警的 runbook？"]', '["告警", "高频"]', 4, '["sre"]'),

(8, 'QA', 2, 'ELK 日志体系的架构和各组件作用？', NULL,
 '经典链路：\n```\n应用/主机 → Filebeat(采集) → Logstash(解析/过滤) → Elasticsearch(存储索引) → Kibana(查询展示)\n```\n- **Filebeat**：轻量采集器，盯日志文件尾部（类似 tail -f），断点续传，资源占用小 —— **不直接做解析**\n- **Logstash**：重型处理器，grok 正则解析多行文本成结构化字段（时间、级别、traceId）、过滤、路由\n- **Elasticsearch**：全文检索引擎，存索引日志\n- **Kibana**：查询、聚合分析、仪表盘\n\n轻量替代（现代趋势）：**Loki + Promtail + Grafana** —— 只索引标签不索引全文，存储成本低 10 倍+，配合日志告警，中小团队很流行。\n\n实践要点：日志要结构化（JSON 格式）、带 traceId、按天建索引 + ILM 生命周期管理（7 天删热节点转冷）。',
 '["Loki 和 ELK 怎么选？", "多行日志（异常栈）怎么合并？"]', '["日志", "必考"]', 5, '["sre", "junior-ops", "devops"]'),

(8, 'QA', 2, 'Metrics、Logging、Tracing 三者的区别？怎么配合？', NULL,
 '- **Metrics（指标）**：数值时间序列，回答"**有没有问题**"—— 聚合快、存储省、适合告警。如 QPS、错误率、内存\n- **Logging（日志）**：离散事件文本，回答"**发生了什么**"—— 细节最全但量大。如一次请求的报错栈\n- **Tracing（链路）**：请求跨服务的完整路径，回答"**问题在哪一环**"—— 服务依赖可视化、定位慢在哪个服务哪一段\n\n经典配合（排障三板斧）：\n1. **告警触发**：错误率 P99 指标异常（Metrics）\n2. **定位服务**：traceId 串联的调用链看到卡在 OrderService→DB（Tracing）\n3. **看清细节**：拿 traceId 查日志，发现具体 SQL 超时（Logging）\n\n三者通过 **traceId 打通**是关键工程实践（日志里打 traceId）。',
 '["OpenTelemetry 是什么？", "采样率怎么定？"]', '["可观测性", "必考"]', 5, '["sre"]'),

(8, 'QA', 1, 'Grafana 是干什么的？怎么做一块应用监控大盘？', NULL,
 'Grafana = **可视化 + 告警**平台，可接 Prometheus/Loki/MySQL 等几十种数据源， dashboard 即 JSON 可导入导出（社区有海量现成模板，如 JVM 盘、主机盘）。\n\n一块应用大盘（自上而下）：\n1. **概览行**：QPS、错误率、P99/P95 延迟（黄金指标）—— 折线图\n2. **JVM 行**：堆内存使用/上限、GC 次数与耗时、线程数\n3. **资源行**：CPU、内存、磁盘 IO、网络\n4. **业务行**：核心业务量（下单量）\n5. 每个图配 **threshold 变色** + 关键图挂告警规则\n\n变量（$pod、$env）做多维下钻；大盘能一键导入导出共享。',
 '["怎么做告警规则的 dashboard 化管理？"]', '["Grafana", "高频"]', 4, '["sre", "junior-ops"]'),

(8, 'SCENARIO', 2, '收到"接口 5xx 突增"告警，你的排查思路？', '凌晨告警：下单接口 5xx 比例从 0.1% 涨到 8%。',
 '框架：**先定影响面 → 找变更 → 分层定位 → 止血**。\n\n1. **影响面**：哪个服务？全部接口还是单接口？全部实例还是部分？（Grafana 下钻）\n2. **最近变更**（最常见原因）：刚发过版？改过配置/DB/网关？→ 是则直接**回滚**，十分钟内止血\n3. **不是变更则分层看**：\n   - 依赖：DB 连接池耗尽？Redis 超时？下游服务挂？（Metrics/链路）\n   - 资源：OOM？CPU 打满？磁盘满？\n   - 流量：是否被刷（QPS 异常、来源 IP 集中）→ 限流/封禁\n4. **日志取证**：ELK 搜 5xx 的 traceId，看异常栈（如 `Connection is not available` = 连接池）\n5. **止血优先**：回滚 / 扩容 / 重启 / 降级非核心功能 / 限流，恢复后再找根因\n6. **事后复盘**：时间线、根因、为什么没更早发现、改进项\n\n加分：说"先看是否有变更，80% 故障是变更引起"。',
 '["回滚也没恢复怎么办？", "怎么区分是自己的问题还是依赖方问题？"]', '["排障", "必考"]', 5, '["sre", "devops"]'),

(8, 'QA', 3, '容量规划怎么做？', NULL,
 '目标：**在流量来之前备好资源**，既不浪费也不被打挂。\n\n1. **摸现状**：当前 QPS/峰值 QPS、单实例容量上限（压测得出：单 Pod 500 QPS 时 P99 200ms）\n2. **算需求**：业务预测（大促 10 倍流量）→ 需要实例数 = 目标 QPS / 单机容量 × 冗余系数(1.5)\n3. **留余量**：N+1 容错（挂一台还能扛）、资源利用率红线（CPU 长期 >60% 就该扩）\n4. **弹性**：K8s HPA 按 CPU/QPS 自动扩缩容、云厂商弹性伸缩组 —— 定时扩（大促前）+ 动态扩（指标触发）\n5. **验证**：全链路压测（影子库/流量打标），验证容量假设\n6. **非计算资源**：连接数、证书配额、带宽、云限额（如 SLB 连接数上限）也要提前申请\n\n指标化：容量水位 = 当前峰值 / 容量上限，>70% 告警。',
 '["HPA 扩容过慢怎么办？", "压测怎么不影响生产数据？"]', '["SRE", "进阶"]', 3, '["sre"]');
