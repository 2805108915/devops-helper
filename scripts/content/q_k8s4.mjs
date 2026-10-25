// k8s4 快问快答
export const Q = [
  { t: 'C', d: 1, q: 'kubectl get all 包含什么？', o: ['A. svc/deploy/pod/replicaset 等（不含secret/cm）', 'B. 一切资源', 'C. 只pod', 'D. 节点'], a: 'A。快速总览命名空间工作负载。', g: ['命令'] },
  { t: 'C', d: 1, q: 'Pod 的 restartPolicy 默认？', o: ['A. Always', 'B. Never', 'C. OnFailure', 'D. 随机'], a: 'A。Job 里必须改 Never/OnFailure 否则失败无限重启。', g: ['基础', '坑'] },
  { t: 'C', d: 2, q: 'deployment 的 revisionHistoryLimit？', o: ['A. 保留历史RS数量（回滚余地）', 'B. 镜像版本数', 'C. 副本数', 'D. 无意义'], a: 'A。设0=不能rollout undo——谨慎缩减。', g: ['发布'] },
  { t: 'C', d: 2, q: 'Service 的 targetPort 与 port 区别？', o: ['A. port 对外（svc）；targetPort 容器实际端口', 'B. 相同', 'C. 反的', 'D. 仅LB用'], a: 'A。nodePort 才是节点端口。三端口概念必须分清。', g: ['网络', '必考'] },
  { t: 'C', d: 2, q: 'configmap 挂载后应用没读到新值，原因？', o: ['A. env注入不热更（需重启）或卷刷新延迟~1分钟', 'B. K8s不支持热更', 'C. 必须删pod', 'D. API问题'], a: 'A。可靠做法：checksum 注解触发滚动。', g: ['配置', '高频'] },
  { t: 'C', d: 3, q: 'Pod 处于 Terminating 很久，常见原因？', o: ['A. finalizer未移除/preStop卡住/挂载卸载失败/PDB限制', 'B. 正常', 'C. 网络问题', 'D. API server挂'], a: 'A。describe 看 events；finalizers 字段非空时需手动处理（理解后果后）。', g: ['排障', '进阶'] },
  { t: 'QA', d: 2, q: '如何查询某节点上跑了哪些 pod？', a: '```bash\nkubectl get pods -A --field-selector spec.nodeName=node1\n```\n排障单节点（资源/驱逐）时用。', g: ['命令'] },
  { t: 'QA', d: 2, q: '想让某个 Pod 固定调度到指定节点，有几种方式？', a: '1. nodeName（直接指定，最硬）\n2. nodeSelector（标签匹配）\n3. nodeAffinity requiredDuringScheduling（表达式更灵活）\n4. 污点+容忍（专用节点专用负载，推荐）\n固定调度常用于 GPU/许可证绑定/本地盘场景。', g: ['调度'] },
  { t: 'QA', d: 3, q: '集群里某节点频繁 NotReady 又自愈，怎么排查？', a: '1. 时间轴对齐：kubelet 日志（journalctl -u kubelet）在掉线前报什么（证书/PLEG/内存）\n2. 节点资源：内存压力 OOM 杀 kubelet？磁盘满？\n3. 网络：节点与 apiserver 6443 链路抖动（mtr 长跑）\n4. 容器运行时无响应（containerd 日志）\n5. 联动：cordon 该节点摘流后深入\n"间歇性"问题靠长周期日志与监控留存。', g: ['排障', '实战'] },
]
