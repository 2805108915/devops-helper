-- 题库种子：MySQL 运维（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(9, 'QA', 2, 'MySQL 主从复制的原理？', NULL,
 '三个线程 + 一个日志接力：\n\n1. 主库提交事务写 **binlog**\n2. 从库 **IO 线程**连上主库，主库 **dump 线程**推送 binlog 事件\n3. 从库 IO 线程把事件写入本地**中继日志 relay log**\n4. 从库 **SQL 线程**重放 relay log，数据一致\n\n关键参数：主库 `log_bin=on`、`server_id` 唯一；从库 `CHANGE MASTER TO ...`（8.0.23+ 语法 CHANGE REPLICATION SOURCE TO）。\n\n查看状态：`SHOW SLAVE STATUS\\G`（关注 `Slave_IO_Running / Slave_SQL_Running` 两个 Yes、`Seconds_Behind_Master` 延迟）。\n\n复制模式：异步（默认）、半同步（至少一个从库收到 ack）、GTID 复制（推荐，自动定位位点，搭从库方便）。',
 '["主从复制数据不一致怎么校验？", "GTIP 相比位点复制好在哪？"]', '["复制", "必考"]', 5, '["junior-ops", "sre", "devops"]'),

(9, 'QA', 3, '主从延迟大怎么排查和处理？', NULL,
 '先定位原因再对症：\n1. **从库单线程重放慢**（大事务、DDL）→ 开**并行复制**（`slave_parallel_workers` + LOGICAL_CLOCK）\n2. **大事务**：一个事务百万行，重放慢 → 源头拆小事务\n3. **从库机器差/压力大**：慢查询挤占资源 → 与主库同规格、加读压力隔离\n4. **网络**：跨机房带宽/抖动\n\n监控：`Seconds_Behind_Master`（有坑：NULL 或 0 不代表无延迟，用 GTID 或 pt-heartbeat 更准）。\n\n**业务侧兜底**：\n- **写后立读**走主库（强制路由），其他读走从库\n- 关键查询判断延迟阈值动态切主\n- 半同步复制降低丢数据风险',
 '["半同步退化为异步什么条件？", "读写分离怎么防读到旧数据？"]', '["复制", "进阶"]', 4, '["sre"]'),

(9, 'QA', 2, '慢查询的排查流程？', NULL,
 '1. **开启慢日志**：`slow_query_log=ON`，`long_query_time=1`（秒），定位文件 `slow_query_log_file`\n2. **分析工具**：`mysqldumpslow -s t -t 10 slow.log` 或 **pt-query-digest**（更专业，给出 SQL 指纹+占比）\n3. **EXPLAIN 执行计划**：\n   - `type`：ALL 全表扫（红灯）→ 至少 range/ref\n   - `key`：实际用的索引\n   - `rows`：扫描行数（越小越好）\n   - `Extra`：Using filesort / Using temporary 都要警惕\n4. **优化手段**：加/改索引、改写 SQL（避免函数包列、大分页改游标）、必要时加缓存/读写分离\n5. 验证：重跑 EXPLAIN 对比\n\n线上抓正在执行的慢 SQL：`SELECT * FROM information_schema.processlist WHERE time > 5;` 然后 `KILL <id>`。',
 '["EXPLAIN 里 type 有哪些级别？", "online DDL 加索引会锁表吗？"]', '["慢查询", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(9, 'QA', 3, 'explain 输出里最该关注哪几列？', NULL,
 '- **type**（访问类型，好→差）：`system > const > eq_ref > ref > range > index > ALL`。生产 OLTP 至少 range，出现 ALL（全表扫）基本要优化\n- **key / key_len**：实际命中索引及使用长度（联合索引用了几列）\n- **rows**：预估扫描行数\n- **Extra**：\n  - `Using index` 覆盖索引（好，不回表）\n  - `Using filesort`：额外排序，考虑排序字段入索引\n  - `Using temporary`：临时表（group by 常见）\n  - `Using index condition`：ICP 下推\n- **possible_keys 有但 key 为 NULL**：索引没被用上（隐式转换、函数包列）',
 '["什么是覆盖索引？", "联合索引 (a,b,c) 哪些查询能用上？"]', '["优化", "高频"]', 4, '["devops", "sre"]'),

(9, 'QA', 2, '索引失效的常见场景？', NULL,
 '1. **函数/运算包住列**：`WHERE YEAR(create_time)=2026`、`WHERE id+1=10` → 改范围查询\n2. **隐式类型转换**：字符串列用数字查 `WHERE phone=13800000000`\n3. **左模糊**：`LIKE ''%abc''` 失效（`''abc%''` 可以）\n4. **联合索引不满足最左前缀**：索引(a,b,c)，只查 b 或 c\n5. **OR 两侧有一侧无索引**（改 UNION）\n6. **不等于/NOT IN/IS NOT NULL**：选择性差时优化器放弃\n7. **隐式字符集不一致**（join 两表字符集不同）\n\n诊断：EXPLAIN 看 key 是否为 NULL；`SHOW INDEX FROM t` 看已有索引；避免重复/冗余索引（(a) 被 (a,b) 覆盖）。',
 '["最左前缀举例说明？", "索引越多越好吗？"]', '["索引", "必考"]', 5, '["junior-ops", "devops"]'),

(9, 'QA', 2, 'mysqldump 和 xtrabackup 的区别？备份策略怎么定？', NULL,
 '- **mysqldump**：逻辑备份（SQL 文本）。支持单库单表、跨版本兼容好；但大库恢复慢（重放 SQL），备份时虽不锁表但长事务有风险。适合中小库、迁移导数据\n- **xtrabackup（物理备份）**：拷贝数据文件 + 追增量 redo，**热备不锁表**，恢复=文件拷贝，大库（百G级）首选；8.0 用 xbstream/qpress\n\n策略组合：\n- **全备**：每天凌晨一次（xtrabackup）\n- **增量**：每小时 binlog 备份（binlog 本身就是增量）\n- **恢复目标（RPO）**：全备 + binlog 重放到任意时间点\n- **验证**：备份必须定期**演练恢复**（没恢复过的备份=没有备份）\n- 异地/对象存储归档，保留 7~30 天\n\n延迟从库也算一种"准实时备份"（可应对误删，STOP SLAVE 后抢救）。',
 '["误删表怎么恢复到删前一刻？", "RPO 和 RTO 什么意思？"]', '["备份", "必考"]', 5, '["junior-ops", "sre"]'),

(9, 'QA', 3, 'binlog、redo log、undo log 的区别？', NULL,
 '- **binlog**（Server 层）：逻辑日志，记录所有**已提交**的数据变更，用于**复制和恢复**（时间点恢复）。追加写、所有引擎共用\n- **redo log**（InnoDB）：物理日志，记录页修改，保证**崩溃恢复**（持久性：ACID 的 D）。循环写、先写日志（WAL）再刷数据页\n- **undo log**（InnoDB）：反操作日志（旧值），用于**回滚**和 **MVCC** 读旧版本\n\n两阶段提交（保证 binlog 与 redo 一致）：redo prepare → 写 binlog → redo commit。\n\n崩溃恢复规则：redo 已 prepare 且 binlog 有对应事务 → 提交；否则回滚。',
 '["什么是 WAL？", "MVCC 怎么用 undo 实现快照读？"]', '["原理", "进阶"]', 4, '["sre"]'),

(9, 'SCENARIO', 2, 'MySQL 报 too many connections 连不上，怎么应急和根治？', '应用大量报错：Data source rejected establishment of connection, message from server: Too many connections',
 '**应急（先恢复）**：\n1. 用预留的管理连接进入：`mysql -uroot -p`（80 前用 root 也可能被拒，可用 `--socket` 或调大 `extra_max_connections` 的 admin 端口，若配过）\n2. 看谁占着：`SHOW PROCESSLIST;` —— 大量 Sleep 连接 = **连接池配错/泄漏**\n3. `KILL` 空闲连接临时释放\n4. 动态调大：`SET GLOBAL max_connections=1000;`（立即生效，重启失效）\n\n**根治**：\n- 应用侧连接池上限收缩：maxActive 总和 < max_connections × 0.8，检查未关闭的连接（代码没归还）\n- `wait_timeout` 调小（如 600s）清掉僵尸连接\n- 连接数被业务打爆 → 读写分离/扩容\n- 监控告警：连接使用率 >80% 报警（processlist / Threads_connected 指标）',
 '["Sleep 连接多的常见原因？", "连接池 maxIdle 和 maxActive 怎么配？"]', '["排障", "高频"]', 4, '["junior-ops", "sre"]'),

(9, 'QA', 2, 'MySQL 事务隔离级别有哪几种？默认哪种？', NULL,
 '四种（SQL 标准）：\n- **读未提交 RU**：脏读\n- **读已提交 RC**：解决脏读，有不可重复读。Oracle 默认、互联网公司常改用\n- **可重复读 RR**（**MySQL InnoDB 默认**）：事务内多次读一致；InnoDB 靠 **MVCC + 间隙锁**把幻读也基本解决\n- **串行化**：锁一切，性能差\n\n相关概念：\n- 脏读：读到别人未提交的数据\n- 不可重复读：事务内两次读同一行值不同（别人 update 提交了）\n- 幻读：两次读同一范围行数不同（别人 insert 了）\n\n查看/设置：`SELECT @@transaction_isolation;` `SET SESSION transaction_isolation=''READ-COMMITTED'';`\n\nRR 下 next-key lock（记录锁+间隙锁）锁范围防插入，解决幻读（但范围锁可能引发死锁）。',
 '["MVCC 是怎么实现的？", "RC 和 RR 下 MVCC 快照时机有什么不同？"]', '["原理", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(9, 'QA', 3, '千万级大表怎么安全地加字段/加索引？', NULL,
 '直接 `ALTER TABLE` 的风险：锁表或长事务导致主从延迟、磁盘临时空间暴涨。\n\n1. **8.0 Online DDL**（多数场景已够用）：`ALTER TABLE t ADD COLUMN c INT, ALGORITHM=INSTANT;`（加列秒级）；加索引用 INPLACE，只锁元数据瞬间，不阻塞 DML\n2. **5.7 或超大表**：**gh-ost / pt-online-schema-change**：建影子表 + 增量同步 + 原子切换，可限速、可暂停，主从延迟可控\n3. **配套纪律**：\n   - 低峰期执行\n   - 提前评估磁盘空间\n   - 大变更先在从库/预发验证\n   - 一条 ALTER 合并多个字段（一次表拷贝）\n   - 慢 DDL 期间关注 `SHOW PROCESSLIST` 和主从延迟',
 '["gh-ost 和 pt-osc 原理区别？", "INSTANT 和 INPLACE 区别？"]', '["DDL", "进阶"]', 3, '["sre", "junior-ops"]');
