-- 题库种子：网络排障（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(2, 'QA', 2, 'TCP 三次握手和四次挥手的过程？为什么握手是三次、挥手是四次？', NULL,
 '**三次握手**（建立连接）：\n1. 客户端 → SYN, seq=x\n2. 服务端 → SYN+ACK, seq=y, ack=x+1\n3. 客户端 → ACK, ack=y+1\n\n为什么三次：双方都要确认"我发的对方能收到、对方发的我能收到"。两次无法防止历史失效连接请求（旧的 SYN 迟到）造成的资源浪费。\n\n**四次挥手**（断开）：FIN → ACK → FIN → ACK。为什么四次：TCP 全双工，每个方向要单独关闭；收到 FIN 只代表对方不再发数据，我可能还有数据要发，所以 ACK 和 FIN 分开发。\n\n加分：说出 CLOSE_WAIT 堆积 = 本方代码没调用 close；TIME_WAIT 是主动关闭方等待 2MSL。',
 '["大量 CLOSE_WAIT 说明什么问题？", "TIME_WAIT 为什么等 2MSL？"]', '["TCP", "必考"]', 5, '["junior-ops", "sre", "devops"]'),

(2, 'QA', 3, 'TIME_WAIT 是什么？服务器上大量 TIME_WAIT 正常吗，怎么处理？', NULL,
 'TIME_WAIT 出现在**主动关闭方**，持续 2*MSL（Linux 默认 60 秒），作用：让旧报文自然消亡 + 保证最后一个 ACK 能重达。\n\n大量 TIME_WAIT 的常见场景：本机作为客户端高频短连接访问别人（如压测机、爬虫、频繁连 DB 用短连接）。\n\n处理思路（按顺序）：\n1. **治本**：改长连接/连接池（HTTP keepalive、DB 连接池）\n2. 复用：`net.ipv4.tcp_tw_reuse=1`（仅客户端方向，需时间戳）\n3. 调小 `tcp_fin_timeout`、扩大端口范围 `ip_local_port_range`\n4. `tcp_tw_recycle` 已在内核 4.12 后移除，答它反而扣分（NAT 环境丢连接）',
 '["tw_recycle 为什么被移除？", "怎么统计各状态连接数？"]', '["TCP", "性能"]', 4, '["sre", "junior-ops"]'),

(2, 'QA', 2, 'ping 的原理是什么？ping 不通但服务能正常访问，可能是什么原因？', NULL,
 'ping 用 **ICMP** 协议（Echo Request/Reply），不经过 TCP/UDP 端口。\n\nping 不通但服务正常，常见原因：\n1. 对方/中间防火墙**禁 ICMP**（云服务器安全组常见默认策略）\n2. ping 的目标 IP 和服务实际 IP 不一致（域名解析问题）\n3. ICMP 被限速\n\n结论：**ping 不通 ≠ 网络不通**，判断服务可达要用 `curl -v telnet IP 端口` / `nc -zv IP 端口` 直接测传输层。',
 '["traceroute 为什么能显示每一跳？", "ping 通但 telnet 端口不通，说明什么？"]', '["ICMP", "排障"]', 4, '["junior-ops", "sre"]'),

(2, 'QA', 2, 'traceroute 的实现原理？', NULL,
 '利用 **IP 包 TTL 字段**：\n\n1. 发 TTL=1 的包 → 第一跳路由器把 TTL 减到 0，丢弃并回送 ICMP Time Exceeded\n2. 发 TTL=2 的包 → 第二跳回应……以此递增，直到到达目标（回 Echo Reply 或端口不可达）\n3. 每一跳发 3 个探测包，显示往返时间\n\nLinux 默认用 UDP 高位端口，`traceroute -I` 改用 ICMP（常用来绕过防火墙对 UDP 的拦截），`-T` 用 TCP。\n\n排障应用：`traceroute IP` 看在哪一跳断/变慢——判断是本端、运营商还是对端的问题。',
 '["为什么有些跳显示 * * *？"]', '["排障"]', 3, '["junior-ops", "sre"]'),

(2, 'QA', 2, '浏览器输入网址到页面展示，中间发生了什么？（重点讲 DNS）', NULL,
 '完整链路：**DNS 解析 → TCP 三次握手 →（HTTPS 则 TLS 握手）→ 发 HTTP 请求 → 服务端处理 → 返回渲染**。\n\nDNS 解析过程：\n1. 查本机缓存（浏览器缓存 → hosts 文件 → 本地 DNS 缓存）\n2. 问配置的**递归 DNS**（本地运营商/公共 DNS 如 223.5.5.5）\n3. 递归 DNS 代为**迭代**查询：根 → 顶级域(.com) → 权威 DNS，拿到 A 记录\n4. 结果按 TTL 缓存\n\n排查命令：`nslookup` / `dig domain`、`dig @8.8.8.8 domain` 指定服务器、`dig +trace` 看完整迭代过程。',
 '["dig 返回的 A 记录和 CNAME 区别？", "怎么排查域名解析不生效？"]', '["DNS", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(2, 'SCENARIO', 2, 'curl 报 Connection refused、Timeout、502 分别说明什么问题？', '你用 curl 测试接口，分别遇到三种报错，各自意味着什么？',
 '三种报错定位层次完全不同，这是排障基本功：\n\n**Connection refused**：包到了目标机器，但**没有进程监听该端口**（或被 REJECT 规则拒）。→ 查服务是否启动、监听端口对不对：`ss -tlnp | grep 端口`\n\n**Timeout**：包在路上丢了或被**静默丢弃（DROP）**。→ 分段定位：本机通不通 → 目标机防火墙/安全组 → 服务是否挂起。中间链路用 traceroute\n\n**502 Bad Gateway**：TCP 通了、请求到达了**反向代理**（Nginx），但**代理连不上后端**。→ 到 Nginx 机器上 curl 后端真实地址，查后端进程/端口/健康状态\n\n加分：refused 是"明确拒绝"，timeout 是"石沉大海"，先区分这两类再往下查。',
 '["504 和 502 的区别？", "telnet 通但 curl 返回空，可能什么问题？"]', '["排障", "必考"]', 5, '["junior-ops", "sre", "devops"]'),

(2, 'QA', 2, '四层负载均衡和七层负载均衡的区别？各有什么代表？', NULL,
 '**四层（L4）**：工作在传输层，只看 IP+端口，转发 TCP/UDP 包，不改内容。\n- 优点：性能高、开销小；缺点：无法按内容路由\n- 代表：LVS、云厂商的 NLB/四层 SLB、F5\n\n**七层（L7）**：工作在应用层，能解析 HTTP，可按 path/header/cookie 路由、改写、限流、压缩。\n- 代表：Nginx、HAProxy(mode http)、Envoy、云厂商七层 ALB\n\n实践组合：**LVS/NLB 扛流量 → Nginx 按内容分发**（电商大站经典架构）。\n\nK8s 里对应：kube-proxy(ipvs/iptables) 是四层，Ingress Controller（Nginx Ingress）是七层。',
 '["为什么四层比七层快？", "session 保持怎么做？"]', '["负载均衡", "高频"]', 5, '["junior-ops", "devops", "sre"]'),

(2, 'QA', 3, 'HTTPS 的握手过程简述？证书校验的是什么时候发生的？', NULL,
 '以 TLS1.2 RSA 交换为例：\n1. Client Hello：带上支持的 TLS 版本、加密套件、随机数 C\n2. Server Hello + 证书：选定套件、随机数 S、服务器证书\n3. 客户端**验证证书**：CA 链信任、域名匹配、未过期、未吊销\n4. 客户端生成预主密钥，用证书公钥加密发给服务端\n5. 双方用 (C, S, 预主密钥) 生成会话密钥，后续对称加密通信\n\n要点：**非对称加密只用于交换密钥，业务数据用对称加密**（性能考虑）；证书校验发生在客户端收到证书后。\n\n运维相关：Nginx 配 `ssl_certificate`；排查工具 `openssl s_client -connect host:443` 看证书链；`openssl x509 -in cert.pem -noout -dates` 看有效期。',
 '["证书过期了会怎样，怎么提前发现？", "TLS1.3 为什么只要 1-RTT？"]', '["HTTPS", "安全"]', 4, '["devops", "sre"]'),

(2, 'QA', 1, 'ss/netstat 怎么看端口占用和连接状态统计？', NULL,
 '查看端口监听：\n```\nss -tlnp          # TCP 监听端口 + 进程\nss -tlnp | grep 8080\n```\n连接状态统计（排障高频）：\n```\nss -ant | awk ''{print $1}'' | sort | uniq -c\n```\n看某端口连接数（判断连接是否打满）：`ss -ant state established ''( sport = :8080 )'' | wc -l`\n\nnetstat 老工具同样语法（`netstat -tlnp`），新系统推荐 ss（更快，netstat 已被淘汰趋势）。`-t` TCP、`-u` UDP、`-l` 监听、`-n` 数字显示、`-p` 进程。',
 '["TIME_WAIT 很多怎么看？", "怎么看某个远程 IP 的连接数？"]', '["排障", "高频"]', 5, '["junior-ops", "devops", "sre"]'),

(2, 'QA', 2, 'tcpdump 常用的抓包姿势有哪些？', NULL,
 '过滤组合：\n```\ntcpdump -i eth0 port 8080 -nn -c 1000 -w dump.pcap\ntcpdump -i any host 10.0.0.5 and port 443 -nn\ntcpdump -i eth0 tcp[tcpflags] & tcp-syn != 0 -nn   # 只看 SYN 包\ntcpdump -i eth0 icmp -nn                          # 排查 ping\n```\n参数：`-i` 网卡（any 全部）、`-nn` 不解析域名和端口名、`-c` 数量、`-w` 存文件（用 Wireshark 图形分析）、`-A`/`-X` 看内容。\n\n典型应用：确认请求到底有没有到机器、握手到哪一步断了、端口是否被 RST。',
 '["生产上抓包要注意什么？", "怎么只抓 POST 请求？"]', '["抓包", "排障"]', 4, '["sre", "junior-ops"]');
