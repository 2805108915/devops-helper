// Redis/MQ 第三批
export const Q = [
  { t: 'C', d: 1, q: 'Redis GET 返回 nil 与空串 "" 的区别？', o: ['A. nil=不存在；""=存在且值为空（EXISTS 可证）', 'B. 相同', 'C. nil报错', 'D. 空串不存在'], a: 'A。缓存判空要区分（空串可作"已确认不存在"的占位——缓存空值方案）。', g: ['Redis'] },
  { t: 'C', d: 1, q: 'DBSIZE 与 KEYS * 的安全差异？', o: ['A. DBSIZE O(1) 计数；KEYS 遍历阻塞', 'B. 相同', 'C. DBSIZE慢', 'D. KEYS安全'], a: 'A。监控采集用 DBSIZE/INFO。', g: ['Redis'] },
  { t: 'C', d: 2, q: 'Redis INFO 里 instantaneous_ops_per_sec 是？', o: ['A. 每秒命令数（吞吐）', 'B. 内存', 'C. 连接数', 'D. 延迟'], a: 'A。配 connected_clients、used_memory、blocked_clients 组成基础面板。', g: ['Redis', '监控'] },
  { t: 'C', d: 2, q: 'Kafka 分区 Leader 与 Follower 的读写？', o: ['A. 只有 Leader 读写（客户端元数据找Leader）；Follower 仅同步', 'B. 都可读', 'C. 都可写', 'D. 随机'], a: 'A。Follower 提供 HA 与读扩展（fetch follower 可配但少见）。', g: ['Kafka'] },
  { t: 'C', d: 2, q: 'Kafka retention.ms 与 retention.bytes？', o: ['A. 按时间或按大小保留（先到为准）', 'B. 且关系', 'C. 只时间', 'D. 无限存'], a: 'A。磁盘治理参数；重放需足够窗口。', g: ['Kafka'] },
  { t: 'QA', d: 2, q: 'Redis 内存涨到 maxmemory 后应用写报错，缓存场景怎么办？', a: '1. maxmemory-policy 从 noeviction 改 allkeys-lru/lfu（CONFIG SET 立即生效）\n2. 治理 bigkey（真实占用大户）：MEMORY USAGE 扫描\n3. 评估容量：正常水位应 <80% maxmemory（fork/重写需要余量）\n4. 需要更多容量→扩实例/Cluster 分片', g: ['Redis', '实战'] },
  { t: 'QA', d: 2, q: '如何优雅迁移 Redis 实例（不停服）？', a: '1. 新实例搭好，作为旧实例从库全量同步（SYNC）追平\n2. 校验数据量/抽样 key\n3. 低峰切换：应用配置中心改地址（热配置）或 proxy 层切\n4. 双写观察期（可选）+旧实例保留 24h 回退窗口\n5. QPS 迁移监控两边对比\n与 MySQL 主从切换同思想：先同构追平再切流。', g: ['Redis', '架构'] },
  { t: 'QA', d: 3, q: '订单系统消息乱序导致状态机异常（支付先于扣库存到达），怎么设计？', a: '1. 同订单同 key 同分区（Kafka）保证物理有序\n2. 消费端按订单ID串行（内存队列 hash 到单线程）\n3. 状态机 + 版本号：旧消息（version小）直接丢弃\n4. 兜底：定时对账修复状态\n"传输有序 + 消费有序 + 业务幂等"三层防线。', g: ['MQ', '架构', '必考'] },
]
