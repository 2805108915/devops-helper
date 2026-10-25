// 监控补充题
export const Q = [
  { t: 'C', d: 1, q: 'Prometheus exporter 的本质？', o: ['A. 把现有指标翻译成 /metrics 文本格式的适配器', 'B. 存储引擎', 'C. 告警器', 'D. 面板'], a: 'A。node_exporter=主机、mysqld_exporter=DB。自研暴露 micrometer/官方client。', g: ['Prometheus'] },
  { t: 'C', d: 1, q: 'Prometheus 的 Service Discovery 用于？', o: ['A. 自动发现抓取目标（K8s Pod 变化自动纳入）', 'B. 服务注册', 'C. 熔断', 'D. DNS'], a: 'A。kubernetes_sd_configs 按标签选 Pod；新实例上线免手工配置。', g: ['Prometheus'] },
  { t: 'C', d: 2, q: 'relabel_configs 的用途？', o: ['A. 抓取前改写标签（只留 __address__、打环境标签）', 'B. 告警规则', 'C. 存储', 'D. 面板'], a: 'A。drop/replace/keep——控制采集面与统一维度（env/cluster）。', g: ['Prometheus', '进阶'] },
  { t: 'C', d: 2, q: 'recording rule（预聚合）的价值？', o: ['A. 高频查询预计算，面板更快且减轻即时计算', 'B. 告警专用', 'C. 备份', 'D. 传输'], a: 'A。如提前算好 instance:p99:rate5m；大盘与高频告警标配。', g: ['Prometheus', '进阶'] },
  { t: 'C', d: 2, q: 'avg_over_time / sum(rate()) 的场景区分？', o: ['A. gauge取窗口均值 / counter先rate再聚合', 'B. 相同', 'C. 都用于counter', 'D. 都用于histogram'], a: 'A。类型决定函数：counter必rate、gauge直接over_time、histogram用quantile。', g: ['PromQL'] },
  { t: 'C', d: 2, q: ' Grafana 变量（Variables）用途？', o: ['A. 面板维度下钻（$env/$pod 动态过滤）', 'B. 美化', 'C. 告警', 'D. 权限'], a: 'A。配 label_values() 自动列维度值；模板复用一套大盘全环境。', g: ['Grafana'] },
  { t: 'C', d: 2, q: '告警规则里 "for: 5m" 的含义？', o: ['A. 条件需持续5分钟才触发（防毛刺）', 'B. 每5分钟查一次', 'C. 延迟5分钟发送', 'D. 5分钟后恢复'], a: 'A。与 evaluate interval（评估周期）区分。', g: ['告警'] },
  { t: 'C', d: 2, q: '日志级别调优：排查期临时开 DEBUG 的风险？', o: ['A. 日志量暴增拖垮磁盘/采集器', 'B. 无风险', 'C. 更安全', 'D. 影响权限'], a: 'A。开箱要限时（15分钟后回收）+ 采样；最好是错误请求全量 debug 的按需方案。', g: ['日志'] },
  { t: 'C', d: 2, q: '结构化日志的最大好处？', o: ['A. 字段可索引检索/聚合（JSON）', 'B. 更短', 'C. 更安全', 'D. 压缩高'], a: 'A。traceId/userId/cost 等字段直接 group by；正则解析脆弱。', g: ['日志', '必考'] },
  { t: 'C', d: 3, q: 'Exemplars 是什么？', o: ['A. 指标关联trace的样本（从面板跳到链路）', 'B. 采样器', 'C. 告警样本', 'D. 备份'], a: 'A。指标→链路的桥，可观测融合趋势。', g: ['进阶'] },
  { t: 'C', d: 3, q: '高基数（high cardinality）标签的问题？', o: ['A. 每个值一条时间序列，存储爆炸（如把userId当标签）', 'B. 查询快', 'C. 无影响', 'D. 告警多'], a: 'A。铁律：标签值有限集（env/instance），无界维度（userId/url全量）放日志/trace。', g: ['Prometheus', '必坑'] },
  { t: 'C', d: 3, q: 'VictoriaMetrics 相比 Prometheus 的定位？', o: ['A. 兼容协议的长期存储/更高压缩比与写入性能', 'B. 替代告警', 'C. 只读', 'D. 面板工具'], a: 'A。vmagent+VM 是国内中小团队省资源的常见组合。', g: ['进阶'] },
  { t: 'QA', d: 2, q: '写告警规则：磁盘预计 4 小时内写满（预测告警）。', a: '```promql\npredict_linear(node_filesystem_avail_bytes{mountpoint=\"/data\"}[1h], 4*3600) < 0\n```\n比固定 85% 更提前——水位+速率双保险。说出 predict_linear 即加分。', g: ['PromQL', '进阶'] },
  { t: 'QA', d: 2, q: '你的服务要上线，上线前监控准备清单（最少8项）。', a: '1. /metrics 暴露与自动发现接入\n2. 四黄金指标面板\n3. JVM/连接池/线程池\n4. 业务指标（订单量等）\n5. 告警规则+分级路由+runbook\n6. 日志接采集（结构化+traceId）\n7. trace 接入\n8. 大盘 owner 标注与巡检演练\n"没监控不上线"是底线。', g: ['素养', '必考'] },
  { t: 'QA', d: 3, q: '如何度量监控体系本身的效果？', a: '1. MTTD（平均发现时长）：故障是被监控发现还是用户报障？\n2. 告警信噪比：有效告警占比、每告警均动作数\n3. 覆盖率：核心服务四指标覆盖比例、日志/trace 接入率\n4. 演练结果：注入故障被检测的成功率与耗时\n把 SRE 自身也指标化，持续改进。', g: ['体系', '进阶'] },
]
