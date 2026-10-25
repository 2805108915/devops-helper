-- 题库种子：Nginx（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(4, 'QA', 1, '正向代理和反向代理的区别？', NULL,
 '- **正向代理**：代理**客户端**。服务器不知道真实客户端是谁（科学上网、公司出口代理）。`proxy_pass` 指向外部服务，客户端显式配置代理\n- **反向代理**：代理**服务端**。客户端不知道真实后端是谁（Nginx 的日常用法：负载均衡、隐藏后端、SSL 终止）\n\n记忆：正代理替客户端出头，反代理替服务端挡事。\n\nNginx 反代最小配置：\n```nginx\nserver {\n    listen 80;\n    location /api {\n        proxy_pass http://backend_group;\n    }\n}\n```',
 '["透明代理是什么？"]', '["基础", "高频"]', 5, '["junior-ops", "devops", "sre"]'),

(4, 'QA', 2, 'nginx location 匹配规则和优先级？', NULL,
 '语法与优先级（从高到低）：\n1. `=` 精确匹配：`location = /login`\n2. `^~` 前缀匹配（命中后不再看正则）\n3. `~` / `~*` 正则（区分/不区分大小写），**按配置顺序**第一个命中生效\n4. 普通前缀匹配，取**最长**的那个\n\n示例：请求 `/api/v1`\n- `location = /api/v1` 精确命中 → 最高优先\n- `location ^~ /api/` 与 `location ~ ^/api/.*` 同时存在 → `^~` 赢\n- `location /api/` 与 `location /` → 长前缀 `/api/` 赢\n\n经典坑：静态文件 `location ~ .*\\.(jpg|png)$` 会抢走 `location /images/` 的请求，除非 `/images` 用 `^~`。',
 '["rewrite 和 location 谁先执行？", "proxy_pass 结尾带 / 和不带 / 的区别？"]', '["配置", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(4, 'QA', 2, 'nginx 负载均衡有哪些策略？怎么配？', NULL,
 '```nginx\nupstream backend {\n    # 默认轮询 round-robin\n    server 10.0.0.1:8080 weight=3;      # 加权轮询\n    server 10.0.0.2:8080;\n    server 10.0.0.3:8080 backup;        # 备用机，全挂才上\n    server 10.0.0.4:8080 down;          # 摘除\n    # ip_hash;                          # 源IP哈希→会话保持\n    # least_conn;                       # 最少连接\n}\n```\n\n策略总结：轮询（默认）、weight 加权、ip_hash 会话保持、least_conn 最少连接、一致性哈希（第三方模块或 Nginx Plus）。\n\n会话保持其他方案：后端 session 集中存 Redis（更主流）、cookie 注入（sticky）。',
 '["ip_hash 有什么隐患？", "后端探活怎么做？"]', '["负载均衡", "必考"]', 5, '["junior-ops", "devops"]'),

(4, 'SCENARIO', 2, '502 和 504 的区别与排查思路？', '用户反馈通过网关访问接口，有时返回 502 Bad Gateway，有时长时间等待后 504 Gateway Timeout。',
 '**502**：Nginx 连不上后端或后端返回无效响应。\n排查：\n1. 到 Nginx 机器上直接 `curl` 后端真实地址 → refused 说明后端没起/端口错；空响应说明后端崩了\n2. `ss -tlnp` 确认后端监听\n3. 看 Nginx error.log：`connect() failed (111: Connection refused)` 就是拒连\n4. 常见原因：后端挂了、upstream 端口写错、后端进程 full、防火墙\n\n**504**：连上了但后端在 `proxy_read_timeout`（默认 60s）内没返回。\n排查：\n1. 后端慢查询/死锁/慢 SQL → 看后端日志和线程栈\n2. 合理调大超时：`proxy_read_timeout 120s`（治标）\n3. 是否流量打满后端处理能力 → 扩容 + 限流\n\n一句话：**502 是连不上，504 是等不起**。网关层必考。',
 '["后端偶尔 502 但进程活着，可能什么原因？", "502 时 error.log 里 Connection reset by peer 说明什么？"]', '["排障", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(4, 'QA', 2, 'nginx 怎么配置 HTTPS？证书从哪来？', NULL,
 '```nginx\nserver {\n    listen 443 ssl;\n    server_name example.com;\n    ssl_certificate     /etc/nginx/certs/fullchain.pem;   # 含证书链\n    ssl_certificate_key /etc/nginx/certs/privkey.pem;\n    ssl_protocols TLSv1.2 TLSv1.3;\n    ssl_ciphers HIGH:!aNULL:!MD5;\n}\n# 80 端口跳转 https\nserver {\n    listen 80;\n    return 301 https://$host$request_uri;\n}\n```\n\n证书来源：云厂商免费证书（每年续）、**Let''s Encrypt + certbot 自动续期**（运维标准做法）、商业证书。\n\n验证：`openssl s_client -connect example.com:443`、浏览器锁标、`curl -vI https://...`\n\nreload 生效：`nginx -t && nginx -s reload`（改配置必先 `-t` 检查）。',
 '["证书快过期了怎么批量发现？", "fullchain 和 cert 的区别？"]', '["HTTPS", "高频"]', 4, '["junior-ops", "devops"]'),

(4, 'QA', 2, 'worker_processes 和 worker_connections 怎么设置？nginx 最大连接数怎么算？', NULL,
 '- `worker_processes`：工作进程数，**通常 auto（= CPU 核数）**，每个 worker 单线程 epoll 事件驱动\n- `worker_connections`：单个 worker 的最大连接数，通常 10240+\n- `ulimit -n`（文件描述符）必须相应调大：`worker_rlimit_nofile` 与系统 `nofile` 保持一致\n\n**最大连接数 = worker_processes × worker_connections**\n\n注意：反向代理场景每个客户端连接会占用 2 个（client→nginx、nginx→backend），所以可用客户端连接约为一半。\n\n压测验证：`ab`/`wrk` 打到目标 QPS，同时观察 `ss -ant state established | wc -l`。',
 '["epoll 和 select 的区别？", "reuseport 是干什么的？"]', '["调优"]', 3, '["junior-ops", "sre"]'),

(4, 'QA', 3, 'nginx 限流怎么配？漏桶和令牌桶的区别？', NULL,
 '```nginx\n# 按 IP 限速：每秒 10 个请求，突发桶容量 20，多余请求排队（nodelay 则直接放行突发后限速）\nlimit_req_zone $binary_remote_addr zone=req_limit:10m rate=10r/s;\nserver {\n    location /api {\n        limit_req zone=req_limit burst=20 nodelay;\n        limit_req_status 429;\n    }\n}\n# 连接数限制\nlimit_conn_zone $binary_remote_addr zone=conn_limit:10m;\nlimit_conn conn_limit 50;\n```\n\n- nginx `limit_req` 是**漏桶**：恒定速率流出，平滑突发\n- 令牌桶（如 Google Guava RateLimiter）：按速率发令牌，桶满可积攒，**允许一定突发**\n\n区别一句话：漏桶整流（不许突发），令牌桶限平均速率但容忍突发。',
 '["限流维度还能怎么选？", "429 和 503 返回哪个更合适？"]', '["限流", "进阶"]', 3, '["devops", "sre"]'),

(4, 'QA', 1, '动静分离怎么配置？', NULL,
 '静态资源（js/css/图片）由 Nginx 直接返回，动态请求转后端：\n```nginx\nserver {\n    location ~ .*\\.(js|css|png|jpg|gif|ico|woff2)$ {\n        root /data/static;\n        expires 30d;                    # 强缓存\n        add_header Cache-Control "public";\n    }\n    location / {\n        proxy_pass http://backend;\n    }\n}\n```\n\n好处：后端只处理动态请求，静态走 Nginx 高性能路径 + 浏览器缓存。\n\n进阶：静态资源放对象存储 + CDN，Nginx 只做动态入口。',
 '["expires 和 Cache-Control 的优先级？"]', '["配置"]', 3, '["junior-ops", "devops"]'),

(4, 'QA', 1, 'nginx 日志怎么按天切割？', NULL,
 '两种方案：\n\n1. **logrotate**（系统自带）：`/etc/logrotate.d/nginx`\n```\n/var/log/nginx/*.log {\n    daily\n    rotate 30          # 保留30份\n    compress           # 压缩旧日志\n    missingok\n    notifempty\n    sharedscripts\n    postrotate\n        [ -f /var/run/nginx.pid ] && kill -USR1 $(cat /var/run/nginx.pid)\n    endscript\n}\n```\n2. crontab + `mv access.log access.$(date +%F).log` 后 `nginx -s reopen`（USN1/REOPEN 信号让 nginx 重开文件句柄，不中断服务）\n\n关键点：**不能只 mv 不发信号**，否则 nginx 还写旧句柄（对应"删除文件空间不释放"问题）。',
 '["为什么 mv 后必须 reload/reopen？"]', '["日志", "高频"]', 4, '["junior-ops", "devops"]'),

(4, 'SCENARIO', 1, 'nginx 起不来，报 80 端口被占用或配置错误，怎么排查？', '执行 systemctl start nginx 失败。',
 '1. 看报错：`systemctl status nginx` + `journalctl -u nginx --since "5 min ago"`\n2. 配置检查：`nginx -t` —— 会精确报出哪个文件哪一行错（分号、花括号、变量拼写）\n3. 端口占用：`ss -tlnp | grep :80` → 谁占了就停谁（常见：另一个 nginx、apache、被挖矿程序占）\n4. 权限问题：error log 里 permission denied → 检查目录属主、SELinux（`setenforce 0` 验证是否 SELinux 拦的）\n5. 改完先 `nginx -t` 再 reload/start\n\n习惯：**任何配置变更先 -t 测试再生效**，这是生产纪律。',
 '["SELinux 怎么确认是它拦的？", "怎么查看 nginx 编译了哪些模块？"]', '["排障", "高频"]', 4, '["junior-ops", "devops"]');
