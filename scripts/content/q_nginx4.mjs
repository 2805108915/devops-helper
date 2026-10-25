// nginx4 快问快答
export const Q = [
  { t: 'C', d: 1, q: 'Nginx 安装后默认站点目录（Ubuntu）？', o: ['A. /var/www/html', 'B. /usr/share/nginx/html', 'C. /opt/nginx', 'D. /www'], a: 'A。Ubuntu 系默认；CentOS 系常是 B。改 root 即换站。', g: ['基础'] },
  { t: 'C', d: 1, q: '错误日志级别 debug|warn|error 谁最详细？', o: ['A. debug', 'B. warn', 'C. error', 'D. crit'], a: 'A。debug 最详细（性能损耗，临时排障用）；error_log 级别递增：debug<info<notice<warn<error<crit。', g: ['日志'] },
  { t: 'C', d: 2, q: 'location 里 root 与 index 的关系？', o: ['A. index 指定默认尝试文件（拼在root后）', 'B. 无关', 'C. index是目录', 'D. root是文件'], a: 'A。index index.html index.htm; 依次尝试。SPA 场景常再加 try_files。', g: ['配置'] },
  { t: 'C', d: 2, q: 'Nginx 访问日志 "$request_time 5s" 但后端日志 50ms，问题在？', o: ['A. 网络传输/客户端慢（后端无辜）', 'B. 后端慢', 'C. Nginx bug', 'D. 一定是DDoS'], a: 'A。两时间字段对比定位法——网关与后端时间轴对齐。', g: ['排障', '必考'] },
  { t: 'C', d: 2, q: '同一 server 想对不同来源返回不同缓存时长？', o: ['A. map $http_user_agent 等 + if/expires 变量化', 'B. 不支持', 'C. 只能多server', 'D. 重写模块才行'], a: 'A。移动端/爬虫差异化策略的思路（if 谨慎用，location 拆分更稳）。', g: ['进阶'] },
  { t: 'C', d: 2, q: 'proxy_pass 到变量（如 http://$backend）时必须配什么？', o: ['A. resolver（运行时DNS）', 'B. 无需', 'C. upstream必须', 'D. 不支持变量'], a: 'A。否则报 no resolver defined——K8s 动态服务名场景必踩。', g: ['配置', '坑'] },
  { t: 'C', d: 3, q: 'Nginx worker 进程数设为 CPU 核数的 2 倍会更好吗？', o: ['A. 不会，推荐 auto（=核数）', 'B. 会更快', 'C. 必须双倍', 'D. 无影响'], a: 'A。worker 单线程事件驱动，超核数徒增切换。', g: ['调优'] },
  { t: 'QA', d: 2, q: '如何临时给某接口加维护页（10分钟）？', a: '```nginx\nlocation /api/pay/ {\n    return 503;\n    error_page 503 /maint.html;\n}\nlocation = /maint.html { root /var/www/maint; internal; }\n```\nreload 秒级生效；应急止血不改代码。体现"网关层兜底"意识。', g: ['实战'] },
  { t: 'QA', d: 2, q: 'Nginx 报 "414 Request-URI Too Large"？', o: undefined, a: '超大 URL（常是误用 GET 传大数据/攻击）。处理：large_client_header_buffers 8 32k 调大；治本是让调用方改 POST body 传参。', g: ['排障'] },
  { t: 'QA', d: 3, q: 'Nginx 层如何做 A/B 测试（按 cookie 分组）？', a: '```nginx\nmap $cookie_abgroup $pool {\n    default main;\n    "B"      exp;\n}\nupstream main { server ...; }\nupstream exp { server ...; }\nlocation / { proxy_pass http://$pool; }\n```\n配后端埋点对比转化率。讲 map+upstream 组合即达标。', g: ['架构', '进阶'] },
]
