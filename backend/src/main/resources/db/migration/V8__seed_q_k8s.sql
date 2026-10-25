-- 题库种子：Kubernetes（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(6, 'QA', 2, 'Kubernetes 整体架构：控制面和节点上分别有哪些组件，各干什么？', NULL,
 '**控制面（Control Plane）**：\n- **kube-apiserver**：唯一入口，所有组件都只跟它通信（REST + etcd 读写）\n- **etcd**：分布式 KV 存储，集群全部状态的"数据库"（备份就是备份 etcd）\n- **scheduler**：调度器，决定 Pod 放到哪个节点（资源、亲和性、污点）\n- **controller-manager**：各种控制器的大本营（副本控制器、节点控制器…），核心思想"期望状态 vs 实际状态"的调和循环\n\n**节点（Node）**：\n- **kubelet**：节点代理，确保本节点 Pod 里的容器按规格运行（健康检查、挂载）\n- **kube-proxy**：维护 Service 的网络规则（iptables/ipvs），实现 ClusterIP 负载均衡\n- **容器运行时**：containerd\n\n一句话：apiserver 是大脑入口，etcd 是记忆，scheduler 排座位，controller 盯现状，kubelet 干活。',
 '["apiserver 挂了集群会怎样？", "etcd 为什么要奇数节点？"]', '["架构", "必考"]', 5, '["devops", "sre"]'),

(6, 'QA', 2, 'Pod 是什么？为什么最小调度单位是 Pod 而不是容器？', NULL,
 'Pod = **一组共享网络和存储的容器**的封装，同 Pod 容器：\n- 共享同一 IP 和端口空间（localhost 互访）\n- 共享 volume\n- 总是调度到同一节点\n\n为什么不直接调度容器：很多场景是**多容器协作** —— sidecar（日志收集、Envoy 代理）、init 容器（等依赖就绪/初始化），它们必须同生共死、网络互通，Pod 提供了这个"逻辑主机"。\n\n实现上，同 Pod 容器共享 network namespace（pause 容器/infra 容器持有网络栈）。',
 '["sidecar 模式举两个例子？", "init 容器和普通容器的区别？"]', '["Pod", "必考"]', 5, '["devops", "sre"]'),

(6, 'QA', 2, 'Deployment 的滚动更新是怎么发生的？', NULL,
 '`kubectl set image deploy/api api=newimg:v2` 后：\n1. Deployment 创建新 **ReplicaSet**（v2），副本从 0 开始扩\n2. 按 `maxSurge`（默认 25%，可超频新增）和 `maxUnavailable`（默认 25%，允许下线量）逐步替换 Pod\n3. 新 Pod 就绪（readiness 通过）才继续下一批，旧 RS 副本逐步缩到 0（不删除，保留用于回滚）\n4. 全部就绪后完成\n\n**回滚**：`kubectl rollout undo deploy/api`（回到上一个 RS），`rollout history` 看版本，`--to-revision=3` 指定。\n\n暂停灰度：`kubectl rollout pause/resume`。\n\n查看进度：`kubectl rollout status deploy/api`。',
 '["maxSurge=0 maxUnavailable=1 是什么发布模式？", "滚动更新期间怎么保证不断流？"]', '["发布", "必考"]', 5, '["devops", "sre"]'),

(6, 'QA', 2, 'Service 有哪几种类型？分别什么场景？', NULL,
 'Service = Pod 的稳定访问入口（Pod IP 会变，Service 提供**固定虚拟 IP + 负载均衡 + 服务发现**）。\n\n1. **ClusterIP**（默认）：集群内部虚拟 IP，仅供集群内访问\n2. **NodePort**：每个节点开一个端口（30000-32767），外部可通过 任意节点IP:端口 访问 —— 测试/小规模\n3. **LoadBalancer**：云厂商分配一个外部 LB（SLB/CLB）指向 Service —— 云上暴露服务标准方式\n4. **ExternalName**：DNS CNAME 别名，把外部服务"包装"成集群内服务\n\n另有 **Headless Service**（clusterIP: None）：不做负载均衡，DNS 直接解析到所有 Pod IP —— StatefulSet 配套、客户端自平衡场景。\n\n转发实现：kube-proxy 的 iptables/ipvs 规则（ipvs 性能更好，适合大规模）。',
 '["ClusterIP 能 ping 通吗？", "Headless Service 什么场景用？"]', '["Service", "必考"]', 5, '["devops", "sre"]'),

(6, 'QA', 2, 'Ingress 是干什么的？和 Service 什么关系？', NULL,
 '**Ingress = 七层路由规则**（基于域名/路径把 HTTP 流量路由到不同 Service），**Ingress Controller**（如 Nginx Ingress、Traefik）是真正干活的反向代理。\n\n流量链路：\n```\n外部 → LB/NodePort(ingress-controller的Service) → Ingress Controller(Nginx Pod) → 按规则转发 → 各业务 Service → Pod\n```\n\n典型 YAML：\n```yaml\nkind: Ingress\nspec:\n  rules:\n  - host: api.example.com\n    http:\n      paths:\n      - path: /order\n        backend: { service: order-svc, port: 8080 }\n      - path: /\n        backend: { service: web-svc, port: 80 }\n```\n\n价值：一个入口暴露 N 个服务、统一 HTTPS 证书/TLS 终止、替代一堆 NodePort。',
 '["Ingress 和 LB 类型 Service 怎么选？", "Ingress 怎么做 HTTPS？"]', '["网络", "高频"]', 4, '["devops", "sre"]'),

(6, 'QA', 1, 'ConfigMap 和 Secret 的用法与区别？', NULL,
 '都是给 Pod 注入配置，不把配置写死在镜像里（一份镜像多环境部署的关键）。\n\n- **ConfigMap**：普通配置（明文）\n- **Secret**：敏感数据（密码、token），base64 编码存储（**编码≠加密**，需要 RBAC 限制访问）\n\n三种注入方式：\n1. 环境变量：`env.valueFrom.configMapKeyRef`\n2. 卷挂载：`volumes.configMap` → 挂成文件（`/etc/config/app.yaml`），**更新会自动刷到 Pod**（env 方式不会）\n3. `envFrom` 整体导入\n\n```yaml\nvolumes:\n- name: conf\n  configMap: { name: app-config }\ncontainers:\n- volumeMounts: [{ name: conf, mountPath: /etc/app }]\n```',
 '["Secret 的 base64 安全吗？", "ConfigMap 热更新对 env 变量生效吗？"]', '["配置", "高频"]', 4, '["devops"]'),

(6, 'QA', 3, 'PV、PVC、StorageClass 三者的关系？', NULL,
 '- **PV**（PersistentVolume）：集群里的存储资源（NFS、云盘），由管理员创建或由 StorageClass 动态创建\n- **PVC**（PersistentVolumeClaim）：用户的"存储申请单"（要多大、什么读写模式），绑定到满足条件的 PV\n- **StorageClass**（SC）：动态供给模板 —— 声明"用阿里云 SSD / NFS"，PVC 来了自动创建 PV，免手动管理\n\n关系类比：PV=房源，PVC=租房需求，SC=自动找房的中介。\n\n回收策略：Retain（保留，需手动清理）/ Delete（随 PVC 删除）/ Recycle（已废弃）。\n\nPod 挂载：`volumes.persistentVolumeClaim.claimName`。',
 '["PVC 一直 Pending 怎么排查？", "有状态应用为什么必须用 PVC？"]', '["存储", "进阶"]', 3, '["devops"]'),

(6, 'SCENARIO', 2, 'Pod 状态 CrashLoopBackOff，怎么排查？', 'kubectl get pods 显示某 Pod 不断重启，状态 CrashLoopBackOff。',
 'CrashLoopBackOff = **容器反复启动失败**，kubelet 按指数退避不断重拉。排查四步：\n\n1. **看容器日志**：`kubectl logs <pod> --previous`（--previous 看上一次崩溃的日志，关键参数！）\n2. **看事件**：`kubectl describe pod <pod>`，底部 Events 看镜像拉取失败/OOMKilled/探针失败\n3. **退出码**：describe 里 `Last State: Terminated, Exit Code: 137` → OOM 或被杀；`Error: 1` → 应用异常（看日志栈）\n4. **常见原因**：\n   - 应用启动异常（配置错、依赖连不上、密钥不对）→ logs 里一般有真相\n   - OOMKilled → 调大 resources.limits.memory\n   - liveness 探针太激进（启动慢被误杀）→ 加 startupProbe 或调 initialDelaySeconds\n   - 命令/参数写错 → `command` 覆盖了镜像 ENTRYPOINT',
 '["Pending 和 CrashLoopBackOff 区别？", "ImagePullBackOff 怎么排查？"]', '["排障", "必考"]', 5, '["devops", "sre"]'),

(6, 'QA', 2, '三种探针 liveness、readiness、startup 的区别？', NULL,
 '- **livenessProbe（存活）**：失败就**重启容器**。诊断死锁、假活（进程在但不工作）\n- **readinessProbe（就绪）**：失败就**从 Service 摘除流量**（不重启）。滚动发布不断流的关键、过载时自动摘除\n- **startupProbe（启动）**：慢启动应用专用 —— 启动探针成功前，liveness/readiness 都不生效，避免"启动慢被误杀"\n\n组合拳（Java 应用推荐）：\n```yaml\nstartupProbe:  { httpGet: {path: /actuator/health, port: 8080}, failureThreshold: 30, periodSeconds: 5 }  # 最多等150秒启动\nlivenessProbe: { httpGet: {path: /actuator/health/liveness, port: 8080}, periodSeconds: 10 }\nreadinessProbe:{ httpGet: {path: /actuator/health/readiness, port: 8080}, periodSeconds: 5 }\n```\n\n注意：liveness 检查的接口不要包含依赖检查（DB 挂了就重启所有实例，雪崩）。',
 '["liveness 失败引起雪崩是怎么回事？", "TCP 探针和 HTTP 探针怎么选？"]', '["探针", "高频"]', 4, '["devops", "sre"]'),

(6, 'QA', 1, 'kubectl 日常排障常用命令有哪些？', NULL,
 '```bash\nkubectl get pods -o wide -A          # 全命名空间pod+节点IP\nkubectl describe pod <p>             # 事件详情（排障第一步）\nkubectl logs <p> [-c 容器] [--previous] -f   # 日志（上一次崩溃）\nkubectl exec -it <p> -- sh           # 进入容器\nkubectl top pod/node                # 资源用量（需metrics-server）\nkubectl get events --sort-by=.lastTimestamp   # 最近事件\nkubectl port-forward svc/api 8080:8080  # 本地调试\nkubectl explain pod.spec.containers  # 现场查字段文档\n```\n\n排障路径记忆：**get 看状态 → describe 看原因 → logs 看报错 → exec 进去复现**。',
 '["怎么查一个 Pod 被调度到哪个节点？", "pod 里没有 curl 怎么测内部服务？"]', '["排障", "高频"]', 5, '["devops", "junior-ops", "sre"]');
