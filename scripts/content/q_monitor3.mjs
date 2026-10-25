// 监控第三批
export const Q = [
  { t: 'C', d: 1, q: 'Prometheus TSDB 默认保留时长？', o: ['A. 15天', 'B. 永久', 'C. 90天', 'D. 1天'], a: 'A。长期存储用 Thanos/VM 远程写入方案。', g: ['Prometheus'] },
  { t: 'C', d: 1, q: 'PromQL 中 offset 的用途？', o: ['A. 取历史偏移（对比昨天同时段）', 'B. 延迟告警', 'C. 采样', 'D. 聚合'], a: 'A。sum(rate(x[5m] offset 1d)) 环比分析。', g: ['PromQL'] },
  { t: 'C', d: 2, q: 'Grafana 面板 "No data" 的排查顺序？', o: ['A. 数据源连通→时间范围→查询标签匹配→采集目标up', 'B. 刷新', 'C. 重装', 'D. 换机器'], a: 'A。up{job=...}==0 是第一嫌疑（采集挂了）。', g: ['Grafana', '排障'] },
  { t: 'C', d: 2, q: '告警恢复通知的作用？', o: ['A. 通知值班"问题解除"（闭环认知）', 'B. 无用', 'C. 再告一次', 'D. 升级'], a: 'A。防"恢复了没人知道，其实一直在闪断"的认知割裂。', g: ['告警'] },
  { t: 'C', d: 2, q: '日志 ELK 的 ILM 是？', o: ['A. 索引生命周期管理（热→温→冷→删）', 'B. 权限', 'C. 采集器', 'D. 告警'], a: 'A。控制成本的关键：热SSD 3天/温7天/冷30天/删。', g: ['日志', '进阶'] },
  { t: 'QA', d: 2, q: '写 PromQL：当前 QPS 与昨天同时段对比下降超过 30% 告警。', a: '```promql\n(sum(rate(http_requests_total[10m])) / sum(rate(http_requests_total[10m] offset 1d))) < 0.7\n```\n同比环比是流量异常的第一道网（绝对阈值难定）。', g: ['PromQL', '实战'] },
  { t: 'QA', d: 3, q: '为什么指标要打 label，但又要克制？', a: 'label 用于维度聚合（env/instance/api），让一个指标支撑多维分析、告警可下钻。\n克制：无界基数（userId、完整URL）会让序列爆炸（内存与查询劣化）。\n口径：有限集合→label；高基数明细→日志/trace。这是 Prom 数据建模第一原则。', g: ['Prometheus', '必考'] },
]
