// K8s 第三批
export const Q = [
  { t: 'C', d: 1, q: 'kubeadm init 生成的 join 有效期与重生成？', o: ['A. 默认24h；kubeadm token create --print-join-command', 'B. 永久', 'C. 1h不可重发', 'D. 无法'], a: 'A。过期加入失败的常见处理。', g: ['运维'] },
  { t: 'C', d: 1, q: 'ConfigMap 大小限制？', o: ['A. ~1MB（etcd 单对象限制）', 'B. 无限制', 'C. 10MB', 'D. 100KB'], a: 'A。大配置拆分或改用挂载文件/对象存储。', g: ['配置'] },
  { t: 'C', d: 2, q: 'Pod 重启次数高但当前 Running，先看什么？', o: ['A. RESTARTS 与上次退出原因（describe 的 Last State + logs --previous）', 'B. 直接删', 'C. 看 CPU', 'D. 无需关注'], a: 'A。CrashLoopOff 的前置形态；退出码 137→OOM，1→应用错。', g: ['排障'] },
  { t: 'C', d: 2, q: 'kubectl get 的 -o wide 多给你什么？', o: ['A. IP/节点名（pod）或端口（svc）', 'B. 更多日志', 'C. 事件', 'D. 权限'], a: 'A。快速看调度分布与 IP 的捷径。', g: ['命令'] },
  { t: 'C', d: 2, q: '一个 Service select 不到 Pod 但 Pod Ready，最可能？', o: ['A. labels 与 selector 不匹配（targetPort 也常错）', 'B. 网络错', 'C. DNS', 'D. 节点满'], a: 'A。kubectl get endpoints 一眼看穿（空=选择器问题）。', g: ['排障', '必考'] },
  { t: 'C', d: 2, q: 'kubectl cp 的等价底层实现？', o: ['A. exec tar 流传输', 'B. 挂载', 'C. API 直读', 'D. scp直连'], a: 'A。所以容器没 tar 时会失败（报错特征）。', g: ['命令', '进阶'] },
  { t: 'C', d: 3, q: 'Pod OOMKilled 但 limits 设的 4G 而 JVM Xmx 3G，可能？', o: ['A. 堆外（直接内存/元空间/线程栈）超预算', 'B. 不可能', 'C. K8s记错', 'D. 磁盘问题'], a: 'A。MaxDirectMemorySize、线程数×栈、Native 库都会吃堆外——容器内存账要全算。', g: ['调优', '进阶'] },
  { t: 'QA', d: 2, q: '怎么把运行中 Pod 的完整现场保存下来供离线分析？', a: '```bash\nkubectl describe pod x > x.describe\nkubectl logs x --all-containers --previous > x.log\nkubectl get pod x -o yaml > x.yaml\nkubectl get events --sort-by=.lastTimestamp > events.txt\n# 深度：kubectl debug（ephemeral容器）进现场 jstack/heap dump\n```\n先保现场再重启——排障纪律。', g: ['排障', '素养'] },
  { t: 'QA', d: 3, q: '集群 API 延迟高（kubectl 卡），排查方向？', a: '1. apiserver 负载：etcd 延迟（etcd metrics grpc 与 fsync）、请求 QPS（--max-requests-inflight）\n2. LIST 大对象（大量 CRD/事件未过期）——监控 WATCH/LIST 慢查询\n3. 控制面资源不足（master 规格小）\n4. 客户端侧：大量控制器频繁 full-list（应用自带 informer 配置不当）\n5. 升级/ Velero 等任务集中 LIST\n体现"apiserver 是唯一入口，etcd 是瓶颈底座"的认知。', g: ['性能', '进阶'] },
]
