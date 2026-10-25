// mysql4 快问快答
export const Q = [
  { t: 'C', d: 1, q: 'USE 与 SHOW DATABASES 的权限关系？', o: ['A. 只能看到有权限的库', 'B. 全部可见', 'C. 无关', 'D. 只看第一个'], a: 'A。"为什么少了一个库"——先查账号权限（SHOW GRANTS）。', g: ['基础'] },
  { t: 'C', d: 1, q: 'DESC table 的作用？', o: ['A. 查看表结构', 'B. 降序排序', 'C. 删表', 'D. 描述引擎'], a: 'A。= SHOW COLUMNS。写SQL前先 DESC 是好习惯。', g: ['基础'] },
  { t: 'C', d: 2, q: 'EXPLAIN 的 rows 是精确值吗？', o: ['A. 基于统计信息的估算', 'B. 精确', 'C. 上限', 'D. 无意义'], a: 'A。统计过期会偏差（可 ANALYZE TABLE 校正）。', g: ['优化'] },
  { t: 'C', d: 2, q: '在线 DDL 期间看到 "waiting for metadata lock" 排队，直接后果？', o: ['A. 后续该表所有查询被阻塞（雪崩）', 'B. 只DDL等', 'C. 无影响', 'D. 从库only'], a: 'A。先 kill DDL 解围，再查长事务。', g: ['排障', '必坑'] },
  { t: 'C', d: 2, q: 'SHOW STATUS LIKE \'Threads_connected\' 与 max_connections 对比是看？', o: ['A. 连接水位（容量）', 'B. 慢查询', 'C. 复制', 'D. 锁'], a: 'A。>80% 告警扩容或查泄漏。', g: ['监控'] },
  { t: 'C', d: 3, q: 'XA/分布式事务与本地事务的运维差异？', o: ['A. XA有悬挂/悬挂恢复问题，排障复杂（xa recover）', 'B. 无差异', 'C. XA更快', 'D. 本地事务更复杂'], a: 'A。能业务幂等+最终一致就别强XA。', g: ['进阶'] },
  { t: 'QA', d: 2, q: '为什么 SELECT * 是坏习惯？', a: '1. 破坏覆盖索引（回表+网络放大）\n2. 表结构变更（加列）隐式影响依赖方\n3. 传输/内存浪费（大字段 text）\n4. 语义不明确，review 困难\n指定列名是基线素质。', g: ['规范', '必考'] },
  { t: 'QA', d: 2, q: '数据库 CPU 100%，允许你执行三条命令，你怎么用？', a: '1. SHOW PROCESSLIST —— 看在跑什么（抓到耗CPU的SQL）\n2. KILL <可疑查询pid> —— 止血\n3. SHOW GLOBAL STATUS LIKE \'Threads_running\' —— 确认并发回落\n然后保留现场：慢日志+processlist 快照落盘分析根因。体现"先止血后取证"。', g: ['应急', '必考'] },
  { t: 'QA', d: 3, q: '如何评估一套 MySQL 参数调优是否真的有效？', a: '1. 基线压测（相同流量回放）前指标：QPS/P99/慢查数\n2. 变更一次一项（控制变量）\n3. 观察窗口内对比（同负载模型）\n4. 看业务指标而非单参数：buffer 命中率提升≠P99 改善\n5. 归档记录（变更单+数据）供回溯\n没有压测对比的调优是玄学。', g: ['调优', '素养'] },
]
