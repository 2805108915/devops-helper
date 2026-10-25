// mw4 快问快答
export const Q = [
  { t: 'C', d: 1, q: 'redis-cli 进入交互后 -n 2 是？', o: ['A. 切换到 2 号数据库（单机逻辑库）', 'B. 2倍速', 'C. 集群模式', 'D. 两个连接'], a: 'A。Cluster 不支持多 db（只有0）。', g: ['Redis'] },
  { t: 'C', d: 1, q: 'EXPIRE 与 PERSIST？', o: ['A. 设过期 / 去掉过期（永生）', 'B. 相反定时', 'C. 都是删除', 'D. 权限命令'], a: 'A。TTL 查剩余秒；-1永生 -2不存在。', g: ['Redis'] },
  { t: 'C', d: 2, q: 'Redis 的 keyspace hits/misses 用在哪？', o: ['A. 命中率（缓存效果）监控', 'B. 容量', 'C. 延迟', 'D. 连接'], a: 'A。命中率突降=穿透/Key被清空的重要信号。', g: ['Redis', '监控'] },
  { t: 'C', d: 2, q: 'Kafka 的 __consumer_group 重平衡期间消费者？', o: ['A. 暂停消费（rebalance 期间整组不可用）', 'B. 更快', 'C. 不影响', 'D. 只影响写'], a: 'A。频繁重平衡=消费暂停抖动，监控 rebalance 次数。', g: ['Kafka', '进阶'] },
  { t: 'C', d: 2, q: 'RocketMQ 的 Tag 过滤发生在？', o: ['A. Broker 侧（减少网络传输）', 'B. 消费者全量拉取后过滤', 'C. 生产者', 'D. 不支持'], a: 'A。但消费者仍按队列拉取——同队列不同Tag混布时仍有浪费（可独立Topic/消息分组优化）。', g: ['RocketMQ', '进阶'] },
  { t: 'QA', d: 2, q: '如何用 Redis 实现分布式环境下的"每日限额"（每用户每天100次）？', a: '```redis\nINCR user:1000:cnt:20261025\n# 首次（返回1）时设置过期：EXPIRE key 86400\n```\nLua 把两步原子化。判断 >100 拒绝。按天 key 天然隔离，过期自清理。', g: ['Redis', '实战'] },
  { t: 'QA', d: 2, q: 'Redis 集群某个 slot 迁移中节点宕机，怎么办？', a: '1. cluster-fail-state 看迁移状态；目标节点补迁（migrating/importing 记录在槽位）\n2. 工具：redis-cli --cluster fix 自动修复槽位分配\n3. 严重时（数据丢失风险）：以从库/备份恢复后重新分配\n运维纪律：迁移分批+低峰+每批验证，避免大范围同时迁移。', g: ['Redis', '进阶'] },
  { t: 'QA', d: 3, q: 'MQ 选型（Kafka/RocketMQ/RabbitMQ）你怎么给建议？', a: '按需求匹配：\n- 日志/流处理/高吞吐：Kafka（生态 flink 等）\n- 业务消息/事务/延迟/顺序丰富语义：RocketMQ\n- 复杂路由/低延迟小流量/多协议：RabbitMQ\n共同追问：团队运维经验与已有生态往往比纸面参数更决定成败。答出"结合团队现状"即成熟。', g: ['架构', '必考'] },
]
