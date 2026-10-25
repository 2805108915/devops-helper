// MySQL 第三批
export const Q = [
  { t: 'C', d: 1, q: 'datetime 与 timestamp 的选择？', o: ['A. timestamp 带时区转换且2038上限；datetime 存字面', 'B. 相同', 'C. timestamp更大', 'D. 必用datetime'], a: 'A。国际化/时区敏感用 timestamp（或存UTC）；范围超2038用 datetime。', g: ['基础'] },
  { t: 'C', d: 1, q: 'NULL 的坑：count(col) 与 count(*) ？', o: ['A. count(col) 不数NULL行；count(*) 全数', 'B. 相同', 'C. count(col)更快', 'D. 都不数NULL'], a: 'A。索引与比较 NULL<>NULL 三值逻辑是 SQL 面试常客。', g: ['基础'] },
  { t: 'C', d: 2, q: 'update 没 where 全表改了且已提交，第一反应？', o: ['A. 停应用止血→binlog 生成反向SQL/备份恢复演练', 'B. 直接改回', 'C. 没救', 'D. 重启DB'], a: 'A。binlog2sql/my2sql 生成反向语句；备份+binlog PITR。', g: ['应急', '高频'] },
  { t: 'C', d: 2, q: 'error log 里 "Too many connections" 出现时机？', o: ['A. 连接数达 max_connections 上限（新连接被拒）', 'B. 慢SQL', 'C. 主从断', 'D. 磁盘'], a: 'A。应急：预留管理连接+KILL；根治看连接池/泄漏。', g: ['排障'] },
  { t: 'C', d: 3, q: '分库分表后跨片查询与全局ID怎么解决（答要点）？', o: ['A. 冗余/宽表/ES二次索引；ID用号段或雪花', 'B. 无法解决', 'C. 只能JOIN跨片', 'D. 随机ID'], a: 'A。架构取舍题：代理或客户端分片（ShardingSphere）+异构索引。', g: ['架构', '进阶'] },
  { t: 'QA', d: 2, q: '如何在线给 5000 万行表加索引（8.0）？', a: '1. 确认无长事务（innodb_trx）防 MDL 卡死\n2. ALGORITHM=INLOCK 不存在——用 INPLACE：ALTER TABLE t ADD INDEX idx_x(x), ALGORITHM=INPLACE, LOCK=NONE\n3. 低峰执行，观察磁盘空间与主从延迟\n4. 更稳：gh-ost 可限速可暂停\n5. 完成后 EXPLAIN 验证命中', g: ['DDL', '实战'] },
  { t: 'QA', d: 3, q: '主库磁盘写满，binlog 在数据盘，怎么紧急腾空间？', a: '1. 立即评估：PURGE BINARY LOGS（确认从库位点已消费）保留 1-2 天\n2. 临时迁移新 binlog 到其它盘（软链，风险动作，需停写窗口）\n3. 治理大事务与 DDL 产生的巨型 binlog\n4. 长期：binlog 独立盘/更大盘+expire 策略+水位告警 70%\n顺序：先确认位点再 PURGE，别把从库需要的删了。', g: ['应急', '实战'] },
]
