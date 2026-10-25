-- 题库种子：Redis/MQ 中间件运维（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(10, 'QA', 2, 'Redis 持久化 RDB 和 AOF 的区别？生产怎么选？', NULL,
 '- **RDB**：定时全量快照（fork 子进程 + 写时复制）。文件小、恢复快；**会丢最后一次快照后的数据**（分钟级丢失）。参数 `save 900 1` 等，命令 `BGSAVE`\n- **AOF**：追加写每条写命令。`appendfsync everysec`（每秒刷盘，最多丢 1 秒）；文件大、恢复慢；重写机制（AOF Rewrite 压缩体积）\n- **混合持久化**（4.0+，推荐）：重写时 RDB 打头 + 增量 AOF，兼顾恢复速度和数据安全\n\n生产选择：\n- 纯缓存可丢 → RDB 甚至不持久化\n- 重要数据 → AOF everysec + 混合持久化\n- 主从 + Sentinel 负责高可用，持久化负责单机数据落地，两者互补\n\n监控点：fork 耗时（`latest_fork_usec`）、AOF 重写期间写延迟抖动',
 '["fork 卡顿怎么回事？", "AOF 重写期间丢数据吗？"]', '["Redis", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(10, 'QA', 2, '缓存穿透、击穿、雪崩的区别和对策？', NULL,
 '- **穿透**：查**不存在**的 key（如恶意传 -1），缓存永远不命中全打到 DB。→ **布隆过滤器**挡住不存在的 key；缓存空值（短 TTL）；参数校验\n- **击穿**：某个**热点 key 过期瞬间**，海量请求同时打 DB。→ 热点 key **逻辑过期/不过期**；互斥锁（只放一个请求去重建缓存，其他等待）；热点提前刷新\n- **雪崩**：**大批 key 同时过期**或 Redis 整体宕机，DB 被冲垮。→ TTL 加随机值打散；多级缓存（本地+Redis）；集群高可用；DB 侧限流熔断兜底\n\n记忆：穿透=查不存在的；击穿=一个热 key 失效；雪崩=一大片失效/挂了。',
 '["布隆过滤器误判怎么办？", "怎么发现热点 key？"]', '["缓存", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(10, 'QA', 2, 'Redis 内存淘汰策略有哪些？默认哪个？', NULL,
 '内存达到 `maxmemory` 后按 `maxmemory-policy` 淘汰：\n\n**不淘汰**：\n- `noeviction`（**默认**）：内存满后**写报错**，读正常 —— 缓存场景通常要改掉\n\n**在设置了过期时间的 key 里淘汰**：\n- `volatile-lru` / `volatile-lfu` / `volatile-random` / `volatile-ttl`（先淘汰快到期的）\n\n**在全部 key 里淘汰**：\n- `allkeys-lru`（纯缓存**最常用**）/ `allkeys-lfu` / `allkeys-random`\n\nLFU（4.0+）按访问频率，抗偶发扫描更合理；LRU 是近似实现（采样）。\n\n配套监控：`used_memory` 接近 maxmemory 报警、`evicted_keys` 淘汰计数突增说明容量不足。',
 '["LRU 和 LFU 的区别？", "evicted_keys 突增说明什么？"]', '["Redis", "高频"]', 4, '["junior-ops", "sre"]'),

(10, 'QA', 3, 'Redis 哨兵（Sentinel）机制：主挂了怎么完成故障转移？', NULL,
 'Sentinel 集群（建议 ≥3 个，奇数）持续监控：\n\n1. **主观下线 SDOWN**：单个哨兵 ping 主库超时\n2. **客观下线 ODOWN**：达到 `quorum` 个哨兵都认为挂了 → 确认故障\n3. **选举哨兵 leader**（Raft 思想）执行转移\n4. **选新主**：按优先级 → 复制偏移量最大（数据最全）→ runid 小\n5. **执行切换**：从库 REPLICAOF 指向新主；旧主恢复后自动降级为从\n6. 客户端通过**订阅 +switch-master** 事件或 Sentinel 代理发现新主地址\n\n注意：哨兵只保证**可用性**，异步复制可能丢最后一段写入（一致性权衡）。',
 '["脑裂是怎么回事怎么防？", "min-slaves-to-write 什么用？"]', '["Redis", "进阶"]', 4, '["sre"]'),

(10, 'QA', 3, 'Redis Cluster 分片原理？', NULL,
 '- 数据分片：16384 个 **hash slot**，`slot = CRC16(key) % 16384`，每个主节点负责一段槽\n- **客户端直连**：smart client 缓存 slot 分布表；key 不在自己节点返回 MOVED（重定向更新缓存）\n- **多 key 操作限制**：不同 slot 的 key 不能直接 MGET/事务 —— hash tag `{user1}...` 让相关 key 落同一 slot\n- **高可用**：每主带从节点，主挂由剩余主节点**投票选从提升**（过半同意）\n- **扩缩容**：`redis-cli --cluster reshard` 迁移槽（ASK 重定向）\n\n规模：官方建议 ≤1000 主节点；至少 3 主 3 从起。',
 '["为什么是 16384 个槽？", "ASK 和 MOVED 的区别？"]', '["Redis", "进阶"]', 3, '["sre"]'),

(10, 'QA', 2, 'bigkey 有什么危害？怎么发现和处理？', NULL,
 '危害：\n- 单 key 过大（如百万元素的 hash / 几十 MB 的 string）操作**阻塞单线程**（DEL 大 key 卡主库）\n- 网络打满、主从同步变慢、集群数据倾斜\n\n发现：\n- `redis-cli --bigkeys`（采样）\n- `MEMORY USAGE key`（精确）\n- RDB 离线分析工具（rdb-tools）\n\n处理：\n- **拆分**：大 hash 按 key 前缀拆成 N 个小 key\n- 删除用 `UNLINK`（异步删除，替代 DEL）或 `SCAN` 分批删\n- 设计阶段杜绝：list/hash 限长、过期清理任务',
 '["hotkey 怎么发现和处理？", "SCAN 和 KEYS 的区别？"]', '["Redis", "高频"]', 4, '["junior-ops", "sre"]'),

(10, 'SCENARIO', 2, 'MQ 消息堆积了几百万条，怎么处理？', 'Kafka 消费者 lag 告警：某 topic 堆积 500 万条。',
 '先定位原因，再分类处置：\n\n**定位**：\n1. 消费者挂了/重启循环？看 consumer 状态\n2. 消费能力不足：单条消息处理耗时 × QPS > 生产速率（如慢 SQL、下游接口慢）\n3. rebalance 风暴频繁导致消费暂停\n\n**处置**：\n1. **扩容消费者**（注意 ≤ 分区数，Kafka 一个分区只能被组内一个消费者消费；分区不够先扩分区）\n2. **降级消费**：如果消息有时效性（如推送），跳过过期消息直接清理\n3. **批量消费**：拉一批处理一批（调 fetch.min.bytes/max.poll.records）\n4. **异步化/并行化**：消费逻辑里把重活丢线程池（注意提交位移的语义）\n5. 临时**转储**：换个新 topic 让线上恢复，堆积的离线慢慢消费\n\n预防：lag 告警 + 容量评估 + 消费端限流保护下游',
 '["Kafka 分区数怎么定？", "重复消费和丢失怎么权衡？"]', '["MQ", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(10, 'QA', 3, 'MQ 怎么保证消息不丢失？（生产/存储/消费三段）', NULL,
 '消息链路三段，每段都可能丢，逐段保证：\n\n**1. 生产端**：\n- 发送确认：Kafka `acks=all`（所有 ISR 副本确认）；RocketMQ 同步发送 + 重试\n- 失败兜底：本地消息表 / 发送失败落库重发\n\n**2. Broker 存储**：\n- 多副本：`replication.factor >= 3`，`min.insync.replicas >= 2`\n- 刷盘：RocketMQ 同步刷盘（性能换可靠）；Kafka 依赖副本而非单机刷盘\n\n**3. 消费端**：\n- **先处理完业务再提交位移**（手动 ack）；处理失败重试 + 死信队列（DLQ）兜底\n- 幂等消费防重复（见下一题）\n\n一句话：**生产确认、存储冗余、消费手动提交**。',
 '["死信队列怎么设计？", "acks=all 性能差怎么办？"]', '["MQ", "高频"]', 4, '["devops", "sre"]'),

(10, 'QA', 2, 'MQ 消息重复消费怎么处理？', NULL,
 '分布式场景**重复投递不可避免**（生产重试、消费者 rebalance 后位移回退、网络超时重发），所以思路不是消灭重复，而是**消费幂等**：\n\n1. **唯一业务 ID + 去重表**：消息带唯一键（订单号），消费前插入去重表，唯一索引冲突则跳过\n2. **数据库乐观锁/状态机**：`UPDATE orders SET status=PAID WHERE id=? AND status=UNPAID` —— 状态已流转自然失败\n3. **Redis SETNX**：`SET msg:{id} 1 EX 86400 NX` 短期去重（注意与业务操作的事务一致性）\n4. 天然幂等操作优先：set 覆盖、增量改绝对值\n\n选型：**强一致用去重表（同库事务）；高并发用 Redis+DB 双层**。',
 '["去重表和业务表怎么保证原子性？", "Redis 去重宕机怎么办？"]', '["MQ", "高频"]', 4, '["devops", "sre"]'),

(10, 'QA', 3, 'Redis 分布式锁怎么实现？有哪些坑？', NULL,
 '基础实现：\n```\nSET lock:key <uniqueValue> NX EX 10\n# 业务...\n# 释放：Lua 脚本（判断是自己的锁才删）\n```\n\n必答的三个坑：\n1. **误删别人的锁**：业务超时锁过期后，A 的删除命令删掉了 B 的锁 → value 存唯一标识（UUID+线程ID），**Lua 原子判断+删除**\n2. **业务没执行完锁过期**：**看门狗续期**（Redisson watchdog 默认 30s 每 10s 续）\n3. **主从切换锁丢失**：异步复制下主写锁成功未同步就挂，新主没有锁 → **RedLock**（多主多数派）争议较大，实践更常用：接受小概率 + 业务幂等兜底；或用 ZooKeeper/etcd 强一致锁\n\n推荐直接用 **Redisson**（封装了续期、可重入、Lua）。',
 '["Redisson 看门狗原理？", "什么场景必须用 zk 锁？"]', '["Redis", "高频"]', 4, '["devops", "sre"]');
