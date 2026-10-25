// Lab 定义数据（第二批 45 个：网络/Nginx/Redis/SSH/Cron/Shell 综合 家族）
export const LABS2 = [
  // ========== 网络家族 ==========
  {
    code: 'net-hosts-wrong', name: 'hosts 劫持排查', topic: 'network', d: 2, sort: 46, g: ['hosts'], mins: 30,
    scenario: '应用访问 api.internal 总是返回错误页面。\n任务：排查 hosts 劫持，修正 /etc/hosts 中 api.internal 的解析（正确 IP 见 /opt/hint-ip 文件），使 curl api.internal 返回 200。',
    setup: 'echo "10.9.9.9" > /opt/hint-ip\nmkdir -p /var/www/real\necho "RIGHT_SITE" > /var/www/real/index.html\ncat > /etc/nginx/sites-available/real <<EOF\nserver { listen 80; server_name api.internal; root /var/www/real; }\nEOF\nln -sf /etc/nginx/sites-available/real /etc/nginx/sites-enabled/real\necho "127.0.0.1 localhost\n10.1.1.1 api.internal" > /etc/hosts\nnginx 2>/dev/null || true',
    check: 'out=$(curl -s --max-time 3 http://api.internal/ 2>/dev/null)\nif echo "$out" | grep -q RIGHT_SITE; then\n  echo \'{"pass":true,"score":100,"message":"完成！解析已纠正"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"改 /etc/hosts 把 api.internal 指向正确IP后重试"}\'\nfi',
    hints: ['看现状：curl -v http://api.internal 和 cat /etc/hosts', '正确 IP 在 /opt/hint-ip', '改完 hosts 直接 curl 验证'],
    solution: 'cat /opt/hint-ip\ncat /etc/hosts\nsed -i "s/^10.1.1.1 api.internal/$(cat /opt/hint-ip) api.internal/" /etc/hosts\ncurl -s http://api.internal/'
  },
  {
    code: 'net-resolv-broken', name: 'DNS 配置损坏', topic: 'network', d: 1, sort: 47, g: ['DNS'], mins: 30,
    scenario: '域名解析全部失败（ping IP 正常）。\n任务：修复 /etc/resolv.conf 使 nameserver 为 223.5.5.5（容器场景 DNS 走宿主转发，判分看配置文件内容正确）。',
    setup: 'echo "nameserver 300.300.300.300" > /etc/resolv.conf',
    check: 'if grep -q "nameserver 223.5.5.5" /etc/resolv.conf && ! grep -q "300.300" /etc/resolv.conf; then\n  echo \'{"pass":true,"score":100,"message":"完成！DNS 配置修复"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"/etc/resolv.conf 需要 nameserver 223.5.5.5"}\'\nfi',
    hints: ['看配置：cat /etc/resolv.conf', '写法：nameserver 223.5.5.5', 'echo 或 vi 修改'],
    solution: 'cat /etc/resolv.conf\necho "nameserver 223.5.5.5" > /etc/resolv.conf\ncat /etc/resolv.conf'
  },
  {
    code: 'net-listen-all', name: '服务只监听了 127.0.0.1', topic: 'network', d: 2, sort: 48, g: ['监听'], mins: 30,
    scenario: '容器内 web 服务只有本机能访问。\n任务：发现 python 服务只绑了 127.0.0.1:9000。终止它并用绑 0.0.0.0 的方式重启（python3 -m http.server 9000 --directory /tmp --bind 0.0.0.0），使 ss 显示 0.0.0.0:9000 监听。',
    setup: 'setsid python3 -m http.server 9000 --directory /tmp --bind 127.0.0.1 >/dev/null 2>&1 < /dev/null &\nsleep 1',
    check: 'if ss -tln | grep ":9000" | grep -q "0.0.0.0:9000"; then\n  echo \'{"pass":true,"score":100,"message":"完成！全网卡监听"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"当前仍非 0.0.0.0 监听（ss -tln | grep 9000）"}\'\nfi',
    hints: ['诊断：ss -tln | grep 9000 看绑定地址', '杀旧：kill PID', '重启加 --bind 0.0.0.0 并后台化'],
    solution: 'ss -tlnp | grep 9000\nkill $(ss -tlnp | grep :9000 | grep -oP "pid=\\K[0-9]+" | head -1)\nnohup python3 -m http.server 9000 --directory /tmp --bind 0.0.0.0 >/dev/null 2>&1 &\nss -tln | grep 9000'
  },
  {
    code: 'net-curl-diagnose', name: 'HTTP 分层诊断', topic: 'network', d: 1, sort: 49, g: ['curl'], mins: 30,
    scenario: '用 curl 完成一次诊断报告：访问 http://127.0.0.1:80 并把状态码写入 /root/code.txt，把总耗时写入 /root/time.txt。',
    setup: 'mkdir -p /var/www/html\necho "diag ok" > /var/www/html/index.html\nnginx 2>/dev/null || nginx -s reload 2>/dev/null || true',
    check: 'c=$(cat /root/code.txt 2>/dev/null | grep -oE "^[0-9]{3}$")\nt=$(cat /root/time.txt 2>/dev/null | grep -oE "^[0-9]+\\.[0-9]+$")\nif [ "$c" = "200" ] && [ -n "$t" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！诊断数据采集到位"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"code.txt=200；time.txt=耗时秒数（curl -w）"}\'\nfi',
    hints: ['状态码：curl -o /dev/null -s -w "%{http_code}" http://127.0.0.1:80/', '耗时：同上 -w 加 %{time_total}', '分别写入两个文件'],
    solution: 'curl -o /dev/null -s -w "%{http_code}" http://127.0.0.1:80/ > /root/code.txt\ncurl -o /dev/null -s -w "%{time_total}" http://127.0.0.1:80/ > /root/time.txt\ncat /root/code.txt /root/time.txt'
  },
  {
    code: 'net-conn-stats', name: '连接状态统计', topic: 'network', d: 2, sort: 50, g: ['ss'], mins: 30,
    scenario: '要评估连接健康度。\n任务：统计系统当前各 TCP 状态连接数（按状态计数，含 LISTEN），以 "数量 状态" 每行格式写入 /root/connstat.txt。',
    setup: 'for i in 1 2 3; do (exec 3<>/dev/tcp/127.0.0.1/80 && sleep 60) & done 2>/dev/null; sleep 1',
    check: 'if [ -f /root/connstat.txt ] && grep -qE "LISTEN" /root/connstat.txt && [ "$(wc -l < /root/connstat.txt)" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！连接画像完成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"ss -ant 状态列 | sort | uniq -c"}\'\nfi',
    hints: ['拿状态：ss -ant 第一列', '计数：sort | uniq -c', '至少应有 LISTEN/ESTAB 等多行'],
    solution: "ss -ant | awk 'NR>1{print $1}' | sort | uniq -c > /root/connstat.txt\ncat /root/connstat.txt"
  },
  {
    code: 'net-two-ports-conflict', name: '双服务端口冲突', topic: 'network', d: 2, sort: 51, g: ['端口'], mins: 30,
    scenario: '新服务起不来：8082 被一个废弃的 python 服务占着，而正确的新服务应为 python 监听 8082 且目录在 /opt/newweb。\n任务：杀掉旧服务，以 nohup 启动新服务（python3 -m http.server 8082 --directory /opt/newweb --bind 0.0.0.0），curl 返回 NEW_OK。',
    setup: 'mkdir -p /opt/newweb\necho "NEW_OK" > /opt/newweb/index.html\nsetsid python3 -m http.server 8082 --directory /tmp --bind 0.0.0.0 >/dev/null 2>&1 < /dev/null &\nsleep 1',
    check: 'out=$(curl -s --max-time 3 http://127.0.0.1:8082/ 2>/dev/null)\nif echo "$out" | grep -q NEW_OK; then\n  echo \'{"pass":true,"score":100,"message":"完成！新服务接管端口"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"先杀旧进程，再以正确目录后台启动"}\'\nfi',
    hints: ['找占用：ss -tlnp | grep 8082', '杀掉后确认端口空闲', 'nohup python3 -m http.server 8082 --directory /opt/newweb --bind 0.0.0.0 &'],
    solution: 'ss -tlnp | grep 8082\nkill $(ss -tlnp | grep :8082 | grep -oP "pid=\\K[0-9]+" | head -1); sleep 1\nnohup python3 -m http.server 8082 --directory /opt/newweb --bind 0.0.0.0 >/dev/null 2>&1 &\nsleep 1; curl -s http://127.0.0.1:8082/'
  },
  {
    code: 'net-ping-diag', name: 'ICMP 连通性诊断', topic: 'network', d: 1, sort: 52, g: ['ping'], mins: 20,
    scenario: '验证本机网络栈：对 127.0.0.1 做 3 次 ping，把丢包率那一行写入 /root/ping.txt。',
    setup: 'echo ok',
    check: 'if [ -f /root/ping.txt ] && grep -qiE "packet loss|丢包" /root/ping.txt; then\n  echo \'{"pass":true,"score":100,"message":"完成！连通性数据留存"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"ping -c 3 127.0.0.1 结果中的丢包行落盘"}\'\nfi',
    hints: ['ping -c 3 127.0.0.1', '丢包行含 "packet loss"', 'grep 过滤后写入'],
    solution: 'ping -c 3 127.0.0.1\nping -c 3 127.0.0.1 | grep "packet loss" > /root/ping.txt\ncat /root/ping.txt'
  },
  {
    code: 'net-http-status-check', name: '批量 URL 探活', topic: 'shell', d: 2, sort: 53, g: ['脚本', 'curl'], mins: 40,
    scenario: '写一个探活脚本：读取 /opt/urls.txt（每行一个URL），逐个 curl 取状态码，输出 "状态码 URL" 到 /root/probe.txt。',
    setup: 'mkdir -p /var/www/html; echo ok > /var/www/html/index.html; nginx 2>/dev/null || true\ncat > /opt/urls.txt <<EOF\nhttp://127.0.0.1/\nhttp://127.0.0.1/none\nhttp://127.0.0.1/ok2\nEOF',
    check: 'if [ -f /root/probe.txt ] && grep -q "^200.*127.0.0.1/" /root/probe.txt && [ "$(wc -l < /root/probe.txt)" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！批量探活报告"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"while read 循环 + curl -o /dev/null -w"}\'\nfi',
    hints: ['while read -r url; do ...; done < /opt/urls.txt', '取码：curl -s -o /dev/null -w "%{http_code}" "$url"', 'echo "$code $url" >> /root/probe.txt'],
    solution: '#!/bin/bash\nwhile read -r url; do\n  code=$(curl -s -o /dev/null -m 3 -w "%{http_code}" "$url")\n  echo "$code $url" >> /root/probe.txt\ndone < /opt/urls.txt\ncat /root/probe.txt'
  },
  {
    code: 'net-route-table', name: '路由表与本地路由', topic: 'network', d: 1, sort: 54, g: ['路由'], mins: 20,
    scenario: '网络组要路由信息。\n任务：把默认路由那一行写入 /root/default-route.txt。',
    setup: 'echo ok',
    check: 'if [ -f /root/default-route.txt ] && grep -q "default" /root/default-route.txt; then\n  echo \'{"pass":true,"score":100,"message":"完成！默认路由留存"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"ip route | grep default > /root/default-route.txt"}\'\nfi',
    hints: ['ip route 看路由表', '默认路由以 default 开头', '落盘'],
    solution: 'ip route\nip route | grep default > /root/default-route.txt\ncat /root/default-route.txt'
  },
  {
    code: 'net-interface-info', name: '网卡信息采集', topic: 'network', d: 1, sort: 55, g: ['ip'], mins: 20,
    scenario: '资产登记需要网卡信息。\n任务：列出所有网卡名与对应 IPv4 地址（"网卡 IP"每行）写入 /root/nics.txt，至少包含 eth0。',
    setup: 'echo ok',
    check: 'if [ -f /root/nics.txt ] && grep -q "eth0" /root/nics.txt && grep -qE "[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+" /root/nics.txt; then\n  echo \'{"pass":true,"score":100,"message":"完成！网卡清单生成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"ip -4 -o addr 可拿 网卡+IP"}\'\nfi',
    hints: ['ip -4 -o addr show', '第二列网卡第四列IP', 'awk 处理成"网卡 IP"'],
    solution: "ip -4 -o addr | awk '{print $2, $4}' | cut -d/ -f1 > /root/nics.txt\ncat /root/nics.txt"
  },

  // ========== Nginx 家族 ==========
  {
    code: 'nginx-bad-semi', name: 'Nginx 缺分号起不来', topic: 'nginx', d: 1, sort: 56, g: ['语法'], mins: 30,
    scenario: '改配置手滑删了个分号，nginx 起不来了。\n任务：用 nginx -t 定位行号修复，启动 nginx，使 curl 127.0.0.1 返回 200。',
    setup: 'cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak\nsed -i "s/worker_processes auto;/worker_processes auto/" /etc/nginx/nginx.conf\nsed -i "/worker_processes auto/a \\ \\ bad_without_semi on" /etc/nginx/nginx.conf\npkill -x nginx 2>/dev/null || true',
    check: 'code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 3 http://127.0.0.1/ 2>/dev/null)\nif pgrep -x nginx >/dev/null && [ "$code" = "200" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！语法修复服务恢复"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"nginx -t 看报错行，删掉坏行后启动"}\'\nfi',
    hints: ['nginx -t 会给出坏行号', 'sed -i "Nd" 删行（N=行号）或 vi 修改', '修好 nginx -t 通过后直接 nginx 启动'],
    solution: 'nginx -t\n# 删除提示的坏行（例如第7行）：sed -i "7d" /etc/nginx/nginx.conf\nnginx -t && nginx\ncurl -s -o /dev/null -w "%{http_code}\\n" http://127.0.0.1/'
  },
  {
    code: 'nginx-default-site', name: '默认站点抢占', topic: 'nginx', d: 2, sort: 57, g: ['server_name'], mins: 30,
    scenario: '配置了新站点 shop (listen 80, server_name shop.test)，但访问一直返回默认欢迎页。\n任务：让 shop.test 的请求返回 SHOP_OK（本机 hosts 已把 shop.test 指到 127.0.0.1；配置文件在 /etc/nginx/sites-available/shop）。',
    setup: 'mkdir -p /var/www/shop; echo "SHOP_OK" > /var/www/shop/index.html\ncat > /etc/nginx/sites-available/shop <<EOF\nserver {\n    listen 80;\n    root /var/www/shop;\n    index index.html;\n}\nEOF\necho "127.0.0.1 shop.test" >> /etc/hosts\nnginx 2>/dev/null || true',
    check: 'out=$(curl -s --max-time 3 -H "Host: shop.test" http://127.0.0.1/ 2>/dev/null)\nif echo "$out" | grep -q SHOP_OK; then\n  echo \'{"pass":true,"score":100,"message":"完成！虚拟主机生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"配置 server_name shop.test 并 reload（软链确认在 sites-enabled）"}\'\nfi',
    hints: ['问题：没写 server_name，请求落在 default server', '加 server_name shop.test; 并启用站点软链', 'nginx -t && nginx -s reload'],
    solution: "sed -i 's/listen 80;/listen 80;\\n    server_name shop.test;/' /etc/nginx/sites-available/shop\nln -sf /etc/nginx/sites-available/shop /etc/nginx/sites-enabled/shop\nnginx -t && nginx -s reload\ncurl -s -H 'Host: shop.test' http://127.0.0.1/"
  },
  {
    code: 'nginx-gzip-on', name: '开启 Gzip 压缩', topic: 'nginx', d: 2, sort: 58, g: ['优化'], mins: 30,
    scenario: '页面传输太大要开压缩。\n任务：在 nginx http 块开启 gzip（含 text/css application/json），reload 后用 curl -H "Accept-Encoding: gzip" 验证响应头含 Content-Encoding: gzip（判分直接检查配置与响应）。',
    setup: 'dd if=/dev/zero of=/var/www/html/big.js bs=1K count=256 status=none\nnginx 2>/dev/null || true',
    check: 'h=$(curl -s -o /dev/null -D - -H "Accept-Encoding: gzip" --max-time 3 http://127.0.0.1/big.js 2>/dev/null | grep -i "content-encoding: gzip" | wc -l)\nc=$(grep -c "gzip on" /etc/nginx/nginx.conf)\nif [ "$h" -ge 1 ] && [ "$c" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！压缩已生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"http{} 里 gzip on; gzip_types ...; 然后 reload"}\'\nfi',
    hints: ['在 nginx.conf 的 http{} 里加 gzip on; gzip_types text/css application/json;', 'nginx -t && nginx -s reload', '验证：curl -H "Accept-Encoding: gzip" -I'],
    solution: 'vi /etc/nginx/nginx.conf   # http{} 内加两行\ngzip on;\ngzip_types text/css application/json;\n# 保存后：\nnginx -t && nginx -s reload\ncurl -s -D - -o /dev/null -H "Accept-Encoding: gzip" http://127.0.0.1/big.js | grep -i encoding'
  },
  {
    code: 'nginx-proxy-prefix', name: '反代路径拼接 404', topic: 'nginx', d: 2, sort: 59, g: ['proxy_pass', '坑'], mins: 30,
    scenario: '/api/ 反代到后端 9000，但后端收到的路径带 /api 前缀导致 404。\n任务：修正 proxy_pass 使 curl http://127.0.0.1/api/ 返回 API_OK。',
    setup: 'mkdir -p /opt/bk\necho "API_OK" > /opt/bk/index.html\nnohup python3 -m http.server 9000 --directory /opt/bk --bind 127.0.0.1 >/dev/null 2>&1 &\ncat > /etc/nginx/sites-available/api <<EOF\nserver {\n    listen 80;\n    location /api/ {\n        proxy_pass http://127.0.0.1:9000;\n    }\n}\nEOF\nln -sf /etc/nginx/sites-available/api /etc/nginx/sites-enabled/api\nrm -f /etc/nginx/sites-enabled/default\nnginx 2>/dev/null || nginx -s reload 2>/dev/null || true',
    check: 'out=$(curl -s --max-time 3 http://127.0.0.1/api/ 2>/dev/null)\nif echo "$out" | grep -q API_OK; then\n  echo \'{"pass":true,"score":100,"message":"完成！路径语义修正"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"proxy_pass 末尾加 / 即可剥离 /api 前缀，改后 reload"}\'\nfi',
    hints: ['现象：后端收到 /api/ 而不是 /', 'proxy_pass http://127.0.0.1:9000/;（注意尾部斜杠）', 'reload 后验证'],
    solution: "sed -i 's|proxy_pass http://127.0.0.1:9000;|proxy_pass http://127.0.0.1:9000/;|' /etc/nginx/sites-available/api\nnginx -t && nginx -s reload\ncurl -s http://127.0.0.1/api/"
  },
  {
    code: 'nginx-upstream-lb', name: '配置双后端负载均衡', topic: 'nginx', d: 2, sort: 60, g: ['负载均衡'], mins: 40,
    scenario: '两台后端 9001/9002 已运行（页面分别输出 BK1/BK2）。Nginx 还没配置。\n任务：配置 nginx 在 80 端口负载均衡转发到两台后端（轮询），多次 curl 应能出现两种输出。',
    setup: 'mkdir -p /opt/bk1 /opt/bk2; echo "BK1" > /opt/bk1/index.html; echo "BK2" > /opt/bk2/index.html\nnohup python3 -m http.server 9001 --directory /opt/bk1 --bind 127.0.0.1 >/dev/null 2>&1 &\nnohup python3 -m http.server 9002 --directory /opt/bk2 --bind 127.0.0.1 >/dev/null 2>&1 &\nrm -f /etc/nginx/sites-enabled/*\nsleep 1',
    check: 'r=$(for i in 1 2 3 4; do curl -s --max-time 3 http://127.0.0.1/ 2>/dev/null; done | sort -u | wc -l)\nif [ "$r" -ge 2 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！轮询负载均衡生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"upstream 两台 + location / 转发 + reload"}\'\nfi',
    hints: ['http{} 加 upstream bks { server 127.0.0.1:9001; server 127.0.0.1:9002; }', 'server{} 的 location / { proxy_pass http://bks; }', 'nginx -t && nginx -s reload'],
    solution: 'cat >> /etc/nginx/nginx.conf.bak /dev/null 2>&1 || true\n# 在 nginx.conf http{} 内追加：\n# upstream bks { server 127.0.0.1:9001; server 127.0.0.1:9002; }\n# server { listen 80; location / { proxy_pass http://bks; } }\nvi /etc/nginx/nginx.conf\nnginx -t && nginx -s reload\nfor i in 1 2 3 4; do curl -s http://127.0.0.1/; done'
  },
  {
    code: 'nginx-https-selfsigned', name: '自签 HTTPS 上线', topic: 'nginx', d: 3, sort: 61, g: ['HTTPS', 'openssl'], mins: 45,
    scenario: '测试环境需要 HTTPS：用 openssl 生成自签证书并配置 nginx 443，使 curl -k https://127.0.0.1/ 返回 200。',
    setup: 'nginx 2>/dev/null || true',
    check: 'code=$(curl -sk -o /dev/null -w "%{http_code}" --max-time 3 https://127.0.0.1/ 2>/dev/null)\nif [ "$code" = "200" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！HTTPS 服务上线"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"生成证书+443 ssl 配置+reload（curl -k 自签）"}\'\nfi',
    hints: ['生成：openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl.key -out /etc/nginx/ssl.crt -subj "/CN=test"', 'server { listen 443 ssl; ssl_certificate ...; ssl_certificate_key ...; root html; }', 'reload 后 curl -k 验证'],
    solution: 'openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl.key -out /etc/nginx/ssl.crt -subj "/CN=test" >/dev/null 2>&1\ncat > /etc/nginx/sites-available/ssl <<EOF\nserver {\n    listen 443 ssl;\n    ssl_certificate /etc/nginx/ssl.crt;\n    ssl_certificate_key /etc/nginx/ssl.key;\n    root /var/www/html;\n}\nEOF\nln -sf /etc/nginx/sites-available/ssl /etc/nginx/sites-enabled/ssl\nnginx -t && nginx -s reload\ncurl -sk -o /dev/null -w "%{http_code}\\n" https://127.0.0.1/'
  },
  {
    code: 'nginx-rate-limit', name: '接口限流', topic: 'nginx', d: 3, sort: 62, g: ['限流'], mins: 40,
    scenario: '登录接口被脚本刷，要限速：对 /login 限 1 r/s。\n任务：配置 limit_req（zone 在 http 块定义），reload 后连发 10 次请求应出现非 200 状态（429/503）。',
    setup: 'mkdir -p /var/www/html; echo login > /var/www/html/login\nnginx 2>/dev/null || true',
    check: 'codes=$(for i in $(seq 1 10); do curl -s -o /dev/null -w "%{http_code} " --max-time 2 http://127.0.0.1/login 2>/dev/null; done)\nlimited=$(echo "$codes" | grep -oE "429|503" | wc -l)\nif [ "$limited" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！限流生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"limit_req_zone 定义在 http{}，location /login 应用 limit_req"}\'\nfi',
    hints: ['http{}：limit_req_zone $binary_remote_addr zone=lg:1m rate=1r/s;', 'location /login { limit_req zone=lg burst=2 nodelay; }', 'reload 后 for 循环 curl 观察'],
    solution: '# http{} 内： limit_req_zone $binary_remote_addr zone=lg:1m rate=1r/s;\n# server 的 location /login { limit_req zone=lg; root /var/www/html; }\nvi /etc/nginx/nginx.conf\nnginx -t && nginx -s reload\nfor i in $(seq 1 10); do curl -s -o /dev/null -w "%{http_code} " http://127.0.0.1/login; done; echo'
  },
  {
    code: 'nginx-log-cut', name: '手工日志轮转信号', topic: 'nginx', d: 2, sort: 63, g: ['日志'], mins: 30,
    scenario: '按天切割 access.log：把当前日志 mv 成 access.20261025.log，再让 nginx 重开句柄（不重启服务）。\n任务：完成后 /var/log/nginx/ 存在 access.20261025.log 且 access.log 重新可写（判分：两个文件都存在且新请求追加进 access.log）。',
    setup: 'nginx 2>/dev/null || true\necho "init" > /var/log/nginx/access.log',
    check: 'sleep 1\ncurl -s -o /dev/null --max-time 3 http://127.0.0.1/ 2>/dev/null\nif [ -f /var/log/nginx/access.20261025.log ] && [ -f /var/log/nginx/access.log ] && [ "$(wc -l < /var/log/nginx/access.log)" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！切割与重开句柄成功"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"mv 后给 master 发 USR1 信号"}\'\nfi',
    hints: ['mv access.log access.20261025.log', 'nginx -s reopen（等价 kill -USR1 master pid）', 'curl 一次验证新文件在写'],
    solution: 'cd /var/log/nginx\nmv access.log access.20261025.log\nnginx -s reopen\ncurl -s -o /dev/null http://127.0.0.1/\nls -la /var/log/nginx | head'
  },
  {
    code: 'nginx-custom-error', name: '自定义 502 页面', topic: 'nginx', d: 2, sort: 64, g: ['运维体验'], mins: 30,
    scenario: '后端维护时网关 502 太丑，要换成友好提示页。\n任务：配置自定义 502 页面（/var/www/err/502.html，内容含 MAINTENANCE），使访问 /api/（反代到不存在的 9000 端口）返回页面含 MAINTENANCE。',
    setup: 'mkdir -p /var/www/err; echo "<h1>MAINTENANCE</h1>" > /var/www/err/502.html\ncat > /etc/nginx/sites-available/err <<EOF\nserver {\n    listen 80;\n    location /api/ {\n        proxy_pass http://127.0.0.1:9000/;\n    }\n}\nEOF\nln -sf /etc/nginx/sites-available/err /etc/nginx/sites-enabled/err\nrm -f /etc/nginx/sites-enabled/default\nnginx 2>/dev/null || nginx -s reload 2>/dev/null || true',
    check: 'out=$(curl -s --max-time 3 http://127.0.0.1/api/x 2>/dev/null)\nif echo "$out" | grep -q MAINTENANCE; then\n  echo \'{"pass":true,"score":100,"message":"完成！友好降级页生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"error_page 502 /502.html; + location = /502.html 指向页面"}\'\nfi',
    hints: ['server{} 里 error_page 502 /502.html;', 'location = /502.html { root /var/www/err; internal; }', 'reload 验证'],
    solution: "cat >> /etc/nginx/sites-available/err <<EOF\nEOF\n# 在 server{} 中加入：\n# error_page 502 /502.html;\n# location = /502.html { root /var/www/err; internal; }\nvi /etc/nginx/sites-available/err\nnginx -t && nginx -s reload\ncurl -s http://127.0.0.1/api/x"
  },
  {
    code: 'nginx-rewrite-rule', name: '旧路径重定向', topic: 'nginx', d: 2, sort: 65, g: ['rewrite'], mins: 30,
    scenario: '站点改版：/old/* 需 301 到 /new/*。\n任务：配置后 curl -I http://127.0.0.1/old/page 应返回 301 且 Location 含 /new/page。',
    setup: 'mkdir -p /var/www/html/new; echo NEW > /var/www/html/new/page\nnginx 2>/dev/null || true',
    check: 'loc=$(curl -s -o /dev/null -D - --max-time 3 http://127.0.0.1/old/page 2>/dev/null | grep -i "^location" | grep -c "/new/page")\ncode=$(curl -s -o /dev/null -w "%{http_code}" --max-time 3 http://127.0.0.1/old/page 2>/dev/null)\nif [ "$loc" -ge 1 ] && [ "$code" = "301" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！旧路径迁移完成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"location /old/ { rewrite ^/old/(.*)$ /new/$1 permanent; }"}\'\nfi',
    hints: ['location /old/ { rewrite ^/old/(.*)$ /new/$1 permanent; }', 'permanent = 301（redirect=302）', 'reload 后 curl -I 验证'],
    solution: '# 在默认 server 配置中加入 location\nvi /etc/nginx/sites-available/default 2>/dev/null || vi /etc/nginx/nginx.conf\n# location /old/ { rewrite ^/old/(.*)$ /new/$1 permanent; }\nnginx -t && nginx -s reload\ncurl -I http://127.0.0.1/old/page'
  },

  // ========== Redis/服务家族 ==========
  {
    code: 'redis-wrong-port', name: 'Redis 端口配错', topic: 'mw', d: 2, sort: 66, g: ['redis'], mins: 40,
    scenario: '应用连 6379 报拒绝。发现配置文件端口写错。\n任务：修正 /etc/redis/redis.conf 的 port 为 6379 并启动 redis-server，使 redis-cli ping 返回 PONG。',
    setup: 'cat > /etc/redis/redis.conf <<EOF\nbind 127.0.0.1\nport 6390\ndaemonize yes\nlogfile /var/log/redis/redis.log\ndir /var/lib/redis\nEOF\nmkdir -p /var/log/redis /var/lib/redis',
    check: 'pong=$(redis-cli -p 6379 ping 2>/dev/null)\nif [ "$pong" = "PONG" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！Redis 恢复"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"改 port 6379 后 redis-server /etc/redis/redis.conf"}\'\nfi',
    hints: ['看配置：grep ^port /etc/redis/redis.conf', '改成 6379', 'redis-server /etc/redis/redis.conf 启动'],
    solution: 'sed -i "s/^port .*/port 6379/" /etc/redis/redis.conf\nredis-server /etc/redis/redis.conf\nsleep 1\nredis-cli ping'
  },
  {
    code: 'redis-auth-set', name: '给 Redis 设置密码', topic: 'mw', d: 2, sort: 67, g: ['redis', '安全'], mins: 40,
    scenario: '安全基线：Redis 必须密码访问。\n任务：启动带 requirepass lab2026 的 redis，验证无密码 ping 报错、带密码 ping 返回 PONG。',
    setup: 'pkill -x redis-server 2>/dev/null; sleep 1\ncat > /etc/redis/redis.conf <<EOF\nbind 127.0.0.1\nport 6379\ndaemonize yes\nrequirepass lab2026\nlogfile /var/log/redis/redis.log\ndir /var/lib/redis\nEOF\nmkdir -p /var/log/redis /var/lib/redis',
    check: 'noauth=$(redis-cli ping 2>&1 | grep -ci "NOAUTH\\|authentication" || true)\nok=$(redis-cli -a lab2026 --no-auth-warning ping 2>/dev/null)\nif [ "$ok" = "PONG" ] && [ "$noauth" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！密码认证生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"启动后：redis-cli -a lab2026 ping 应 PONG，无密码应报 NOAUTH"}\'\nfi',
    hints: ['配置文件已含 requirepass，直接启动', 'redis-server /etc/redis/redis.conf', '验证两种访问'],
    solution: 'redis-server /etc/redis/redis.conf\nsleep 1\nredis-cli ping\nredis-cli -a lab2026 --no-auth-warning ping'
  },
  {
    code: 'redis-maxmemory-policy', name: '配置内存淘汰策略', topic: 'mw', d: 2, sort: 68, g: ['redis'], mins: 40,
    scenario: 'Redis 当缓存用，内存满了会写报错。\n任务：启动 redis（配置已给 maxmemory 64mb），设置淘汰策略为 allkeys-lru（CONFIG SET），并把 CONFIG GET maxmemory-policy 的结果写入 /root/policy.txt。',
    setup: 'pkill -x redis-server 2>/dev/null; sleep 1\ncat > /etc/redis/redis.conf <<EOF\nbind 127.0.0.1\nport 6379\ndaemonize yes\nmaxmemory 64mb\nmaxmemory-policy noeviction\nlogfile /var/log/redis/redis.log\ndir /var/lib/redis\nEOF\nmkdir -p /var/log/redis /var/lib/redis',
    check: 'p=$(grep -c allkeys-lru /root/policy.txt 2>/dev/null || echo 0)\nif [ "$p" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！LRU 淘汰已生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"CONFIG SET maxmemory-policy allkeys-lru 后 GET 结果落盘"}\'\nfi',
    hints: ['启动：redis-server /etc/redis/redis.conf', 'CONFIG SET maxmemory-policy allkeys-lru', 'CONFIG GET maxmemory-policy > /root/policy.txt'],
    solution: 'redis-server /etc/redis/redis.conf\nsleep 1\nredis-cli CONFIG SET maxmemory-policy allkeys-lru\nredis-cli CONFIG GET maxmemory-policy | tee /root/policy.txt'
  },
  {
    code: 'redis-data-op', name: 'Redis 数据操作实战', topic: 'mw', d: 1, sort: 69, g: ['redis'], mins: 30,
    scenario: '熟悉数据结构：向本地 Redis 写入 key name=ops-2026（string）、向 set tags 加入 a 和 b，把 LLEN/LRANGE 之外的两个 key 数量（DBSIZE）写入 /root/dbsize.txt。',
    setup: 'pkill -x redis-server 2>/dev/null; sleep 1\ncat > /etc/redis/redis.conf <<EOF\nbind 127.0.0.1\nport 6379\ndaemonize yes\nlogfile /var/log/redis/redis.log\ndir /var/lib/redis\nEOF\nmkdir -p /var/log/redis /var/lib/redis',
    check: 'n=$(redis-cli dbsize 2>/dev/null)\nf=$(grep -oE "^2$" /root/dbsize.txt 2>/dev/null | head -1)\nif [ "$n" -ge 2 ] && [ "$f" = "2" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！数据操作到位"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"SET name ops-2026；SADD tags a b；DBSIZE 写入文件"}\'\nfi',
    hints: ['启动 redis', 'SET name ops-2026；SADD tags a b', 'redis-cli dbsize > /root/dbsize.txt'],
    solution: 'redis-server /etc/redis/redis.conf; sleep 1\nredis-cli SET name ops-2026\nredis-cli SADD tags a b\nredis-cli dbsize | tee /root/dbsize.txt'
  },
  {
    code: 'redis-slowlog', name: '慢查询定位', topic: 'mw', d: 3, sort: 70, g: ['redis'], mins: 40,
    scenario: 'Redis 偶发卡顿，怀疑慢命令。\n任务：启动 redis 后执行一条故意慢的命令（KEYS *），然后查看 SLOWLOG GET 把结果写入 /root/slow.txt（文件应包含 KEYS）。',
    setup: 'pkill -x redis-server 2>/dev/null; sleep 1\ncat > /etc/redis/redis.conf <<EOF\nbind 127.0.0.1\nport 6379\ndaemonize yes\nslowlog-log-slower-than 0\nlogfile /var/log/redis/redis.log\ndir /var/lib/redis\nEOF\nmkdir -p /var/log/redis /var/lib/redis\nfor i in $(seq 1 200); do echo "k$i v" ; done | while read k v; do :; done\ntrue',
    check: 'if grep -q "KEYS" /root/slow.txt 2>/dev/null; then\n  echo \'{"pass":true,"score":100,"message":"完成！慢命令证据留存"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"先造点数据再 KEYS *，SLOWLOG GET 落盘"}\'\nfi',
    hints: ['启动 redis（slowlog 阈值已设 0 全记录）', '写入几十个 key 再执行 KEYS *', 'redis-cli SLOWLOG GET > /root/slow.txt'],
    solution: 'redis-server /etc/redis/redis.conf; sleep 1\nfor i in $(seq 1 50); do redis-cli set k$i v >/dev/null; done\nredis-cli KEYS "*" >/dev/null\nredis-cli SLOWLOG GET > /root/slow.txt\nhead -5 /root/slow.txt'
  },

  // ========== SSH 家族 ==========
  {
    code: 'ssh-enable-password', name: '启用 SSH 密码登录', topic: 'linux', d: 2, sort: 71, g: ['ssh'], mins: 40,
    scenario: '新机器 sshd 配置禁了密码登录，且 appuser 没密码。\n任务：设 appuser 密码为 lab123、开启 PasswordAuthentication、启动 sshd，使 sshpass 免密自测通过。',
    setup: 'id -u appuser >/dev/null 2>&1 || useradd -m -s /bin/bash appuser\nmkdir -p /run/sshd\nsed -i "s/^#\\?PasswordAuthentication.*/PasswordAuthentication no/" /etc/ssh/sshd_config\ngrep -q "^PasswordAuthentication" /etc/ssh/sshd_config || echo "PasswordAuthentication no" >> /etc/ssh/sshd_config\npkill -x sshd 2>/dev/null; sleep 1; /usr/sbin/sshd',
    check: 'out=$(sshpass -p lab123 ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 appuser@127.0.0.1 \'echo SSH_OK\' 2>/dev/null)\nif [ "$out" = "SSH_OK" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！密码登录打通"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"chpasswd + 改配置 + 重启 sshd（pkill 后 /usr/sbin/sshd）"}\'\nfi',
    hints: ['设密码：echo "appuser:lab123" | chpasswd', 'sed 改 PasswordAuthentication yes', '重启：pkill -x sshd; /usr/sbin/sshd'],
    solution: 'echo "appuser:lab123" | chpasswd\nsed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config\npkill -x sshd; sleep 1; /usr/sbin/sshd\nsshpass -p lab123 ssh -o StrictHostKeyChecking=no appuser@127.0.0.1 whoami'
  },
  {
    code: 'ssh-port-change', name: '修改 SSH 端口', topic: 'linux', d: 2, sort: 72, g: ['ssh'], mins: 40,
    scenario: '安全加固：SSH 改用 2222 端口。\n任务：把 sshd 监听端口改为 2222 并重启 sshd，使 sshpass -p lab123 ssh -p 2222 appuser@127.0.0.1 通过（appuser 密码 lab123 已配好）。',
    setup: 'id -u appuser >/dev/null 2>&1 || useradd -m -s /bin/bash appuser\necho "appuser:lab123" | chpasswd\nmkdir -p /run/sshd\npkill -x sshd 2>/dev/null; sleep 1; /usr/sbin/sshd',
    check: 'out=$(sshpass -p lab123 ssh -p 2222 -o StrictHostKeyChecking=no -o ConnectTimeout=5 appuser@127.0.0.1 \'echo SSH2222_OK\' 2>/dev/null)\nif [ "$out" = "SSH2222_OK" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！非默认端口加固"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"sshd_config 加/改 Port 2222 后重启 sshd"}\'\nfi',
    hints: ['sshd_config：Port 2222（加一行即可）', 'pkill -x sshd 后 /usr/sbin/sshd', 'ssh -p 2222 验证'],
    solution: 'echo "Port 2222" >> /etc/ssh/sshd_config\npkill -x sshd; sleep 1; /usr/sbin/sshd\nss -tlnp | grep 2222\nsshpass -p lab123 ssh -p 2222 -o StrictHostKeyChecking=no appuser@127.0.0.1 whoami'
  },
  {
    code: 'ssh-deny-root', name: '禁止 root 直接登录', topic: 'linux', d: 2, sort: 73, g: ['ssh', '安全'], mins: 40,
    scenario: '基线：root 不许直连 SSH，只能普通用户跳转。\n任务：设置 PermitRootLogin no 并重启 sshd（判分：sshd_config 含该行且进程在跑，且 appuser 密码登录仍正常，密码 lab123）。',
    setup: 'id -u appuser >/dev/null 2>&1 || useradd -m -s /bin/bash appuser\necho "appuser:lab123" | chpasswd\nmkdir -p /run/sshd\nsed -i "/^#\\?PermitRootLogin/d" /etc/ssh/sshd_config\npkill -x sshd 2>/dev/null; sleep 1; /usr/sbin/sshd',
    check: 'cfg=$(grep -c "^PermitRootLogin no" /etc/ssh/sshd_config)\nrun=$(pgrep -x sshd | wc -l)\nok=$(sshpass -p lab123 ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 appuser@127.0.0.1 \'echo OK\' 2>/dev/null)\nif [ "$cfg" -ge 1 ] && [ "$run" -ge 1 ] && [ "$ok" = "OK" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！基线加固完成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"PermitRootLogin no + sshd 存活 + appuser 可登录"}\'\nfi',
    hints: ['加行：PermitRootLogin no', '重启 sshd', '用 appuser 验证没把自己锁外面（运维素养！）'],
    solution: 'echo "PermitRootLogin no" >> /etc/ssh/sshd_config\npkill -x sshd; sleep 1; /usr/sbin/sshd\nsshpass -p lab123 ssh -o StrictHostKeyChecking=no appuser@127.0.0.1 whoami'
  },
  {
    code: 'ssh-keygen-deploy', name: '密钥对生成与部署', topic: 'linux', d: 2, sort: 74, g: ['ssh'], mins: 40,
    scenario: '给 root 生成 ed25519 密钥并把公钥追加到 appuser 的 authorized_keys（权限规范），验证 ssh 免密登录 appuser 成功。',
    setup: 'id -u appuser >/dev/null 2>&1 || useradd -m -s /bin/bash appuser\nmkdir -p /run/sshd /home/appuser/.ssh\nrm -f /root/.ssh/id_ed25519*\npkill -x sshd 2>/dev/null; sleep 1; /usr/sbin/sshd',
    check: 'k=$(ls /root/.ssh/id_ed25519.pub 2>/dev/null | wc -l)\na=$(grep -c "ssh-ed25519" /home/appuser/.ssh/authorized_keys 2>/dev/null || echo 0)\np=$(stat -c %a /home/appuser/.ssh/authorized_keys 2>/dev/null)\nif [ "$k" = "1" ] && [ "$a" -ge 1 ] && [ "$p" = "600" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！密钥部署规范"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"ssh-keygen -t ed25519；公钥入authorized_keys(600)"}\'\nfi',
    hints: ['生成：ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519', '部署：cat 公钥 >> /home/appuser/.ssh/authorized_keys', 'chown appuser + chmod 600'],
    solution: 'ssh-keygen -t ed25519 -N "" -f /root/.ssh/id_ed25519\ncat /root/.ssh/id_ed25519.pub >> /home/appuser/.ssh/authorized_keys\nchown -R appuser:appuser /home/appuser/.ssh\nchmod 700 /home/appuser/.ssh; chmod 600 /home/appuser/.ssh/authorized_keys\nssh -o StrictHostKeyChecking=no appuser@127.0.0.1 whoami'
  },
  {
    code: 'ssh-config-syntax', name: 'sshd 配置语法错', topic: 'linux', d: 2, sort: 75, g: ['ssh', '排障'], mins: 40,
    scenario: '改完 sshd 配置服务起不来了。\n任务：用 sshd -t 找到坏行修复，重启 sshd 并确保 appuser（密码 lab123）能登录。',
    setup: 'id -u appuser >/dev/null 2>&1 || useradd -m -s /bin/bash appuser\necho "appuser:lab123" | chpasswd\nmkdir -p /run/sshd\necho "PermitRootLocks yes" >> /etc/ssh/sshd_config   # 坏指令\npkill -x sshd 2>/dev/null; echo ok',
    check: 't=$(sshd -t 2>&1 | wc -l)\nrun=$(pgrep -x sshd | wc -l)\nok=$(sshpass -p lab123 ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 appuser@127.0.0.1 \'echo OK\' 2>/dev/null)\nif [ "$t" -eq 0 ] && [ "$run" -ge 1 ] && [ "$ok" = "OK" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！语法修复服务恢复"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"sshd -t 定位坏行删除，再启动 /usr/sbin/sshd"}\'\nfi',
    hints: ['sshd -t 输出坏行行号', '删掉那一行（sed 或 vi）', '再次 sshd -t 通过后 /usr/sbin/sshd'],
    solution: 'sshd -t\nsed -i "/PermitRootLocks/d" /etc/ssh/sshd_config\nsshd -t && /usr/sbin/sshd\nsshpass -p lab123 ssh -o StrictHostKeyChecking=no appuser@127.0.0.1 whoami'
  },

  // ========== Cron 家族 ==========
  {
    code: 'cron-not-running', name: 'cron 守护进程没启动', topic: 'shell', d: 1, sort: 76, g: ['cron'], mins: 30,
    scenario: 'crontab 有任务但从不执行。\n任务：启动 cron 守护进程，手动执行一次 /opt/backup.sh，确保 /backup/backup.log 出现新行且 crontab 里有该任务（每小时）。',
    setup: 'mkdir -p /backup /opt\ncat > /opt/backup.sh <<EOF\n#!/bin/bash\necho "backup \$(date +%T)" >> /backup/backup.log\nEOF\nchmod +x /opt/backup.sh\necho "0 * * * * /opt/backup.sh" | crontab -\npkill -x cron 2>/dev/null; echo ok',
    check: '/opt/backup.sh\nif pgrep -x cron >/dev/null && [ -f /backup/backup.log ] && crontab -l 2>/dev/null | grep -q backup.sh; then\n  echo \'{"pass":true,"score":100,"message":"完成！定时任务恢复"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"启动 cron（直接运行 cron 命令）；手动跑一次脚本"}\'\nfi',
    hints: ['容器里启动：cron（或 service cron start）', '手动验证：/opt/backup.sh 后看日志', '确认任务：crontab -l'],
    solution: 'cron\npgrep -x cron\n/opt/backup.sh\ntail /backup/backup.log\ncrontab -l'
  },
  {
    code: 'cron-wrong-path', name: 'crontab 路径写错', topic: 'shell', d: 2, sort: 77, g: ['cron'], mins: 30,
    scenario: '任务日志三天没更新。脚本在 /opt/backup.sh，但 crontab 写成了 /opt/scripts/backup.sh。\n任务：修正 crontab 路径（保持每小时执行），启动 cron，手动执行验证日志新增。',
    setup: 'mkdir -p /backup\ncat > /opt/backup.sh <<EOF\n#!/bin/bash\necho "backup \$(date +%T)" >> /backup/backup.log\nEOF\nchmod +x /opt/backup.sh\necho "0 * * * * /opt/scripts/backup.sh" | crontab -\necho old > /backup/backup.log\npkill -x cron 2>/dev/null; echo ok',
    check: 'if crontab -l | grep -q " /opt/backup.sh" && pgrep -x cron >/dev/null && [ "$(wc -l < /backup/backup.log)" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！路径修正任务恢复"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"crontab -e 改路径；启动 cron；手动跑一次"}\'\nfi',
    hints: ['找真实路径：ls /opt/backup.sh', 'crontab -e 修正', 'cron 启动 + 手动验证'],
    solution: 'crontab -l\necho "0 * * * * /opt/backup.sh" | crontab -\ncron\n/opt/backup.sh\ncrontab -l; tail -1 /backup/backup.log'
  },
  {
    code: 'cron-percent-escape', name: 'cron 里的 % 坑', topic: 'shell', d: 3, sort: 78, g: ['cron', '坑'], mins: 40,
    scenario: '任务要每小时打时间戳快照，但用 date +%F 一直失败（% 在 crontab 有特殊含义）。\n任务：修正 crontab（可转义 \\% 或改用脚本），使 /opt/snap.sh 每分钟执行且 /tmp/snap.log 出现新内容，且 snap.log 内含完整日期。',
    setup: 'cat > /opt/snap.sh <<EOF\n#!/bin/bash\necho "snap \$(date +%F)" >> /tmp/snap.log\nEOF\nchmod +x /opt/snap.sh\necho "* * * * * /opt/snap.sh" | crontab -\npkill -x cron 2>/dev/null; echo ok',
    check: 'if [ -f /tmp/snap.log ] && grep -qE "202[0-9]-[0-9]{2}-[0-9]{2}" /tmp/snap.log; then\n  echo \'{"pass":true,"score":100,"message":"完成！快照任务正常"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"启动 cron；等一分钟或手动执行脚本生成规范日期日志"}\'\nfi',
    hints: ['cron 已配好调用脚本（脚本内部 % 无需转义）', '启动 cron 后等 1 分钟', ' impatient 可以先手动 /opt/snap.sh'],
    solution: 'cron\nsleep 65 || /opt/snap.sh\ncat /tmp/snap.log\ncrontab -l'
  },
  {
    code: 'cron-env-path', name: 'cron 环境 PATH 坑', topic: 'shell', d: 3, sort: 79, g: ['cron', '坑'], mins: 40,
    scenario: '脚本里调用了 python3，手动能跑 cron 不跑（cron 的 PATH 极简且无 venv）。\n任务：给 /opt/job.sh 补上环境（脚本开头写绝对路径或加载 profile），启动 cron，等 1 分钟（或手动）验证 /tmp/job.out 有内容。',
    setup: 'cat > /opt/job.sh <<EOF\n#!/bin/bash\necho "job ran at \$(date +%T)" > /tmp/job.out\nEOF\nchmod 644 /opt/job.sh\necho "* * * * * /opt/job.sh" | crontab -\npkill -x cron 2>/dev/null; echo ok',
    check: 'if [ -f /tmp/job.out ] && pgrep -x cron >/dev/null && [ -x /opt/job.sh ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！脚本具备执行权限且任务可运行"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"chmod +x /opt/job.sh；启动 cron；验证输出"}\'\nfi',
    hints: ['先跑一下 /opt/job.sh 看报错：没有执行权限！', 'chmod +x', 'cron 启动后等 1 分钟或手动跑'],
    solution: 'chmod +x /opt/job.sh\n/opt/job.sh && cat /tmp/job.out\ncron\ncrontab -l'
  },
  {
    code: 'cron-freq-fix', name: '执行频率改错', topic: 'shell', d: 1, sort: 80, g: ['cron'], mins: 30,
    scenario: '要求每天 2:30 执行备份，但 crontab 被写成每月 30 号才跑。\n任务：修正为每天 02:30（分 时 日 月 周），启动 cron。',
    setup: 'echo "30 2 30 * * /bin/true" | crontab -\npkill -x cron 2>/dev/null; echo ok',
    check: 'if crontab -l | grep -qE "^30 2 \\* \\* \\*" && pgrep -x cron >/dev/null; then\n  echo \'{"pass":true,"score":100,"message":"完成！频率修正"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"每天02:30 = 30 2 * * *；并启动 cron"}\'\nfi',
    hints: ['五个字段：分 时 日 月 周', '每天 = 日/月/周 都 *', 'echo 新条目 | crontab -'],
    solution: 'echo "30 2 * * * /bin/true" | crontab -\ncron\ncrontab -l'
  },

  // ========== Shell 综合家族 ==========
  {
    code: 'shell-script-syntax-fix', name: '脚本语法错修复', topic: 'shell', d: 1, sort: 81, g: ['bash'], mins: 30,
    scenario: '/opt/run.sh 跑不起来（语法错）。\n任务：用 bash -n 定位修复，使脚本输出 SCRIPT_OK 并把结果写入 /tmp/run.out。',
    setup: 'cat > /opt/run.sh <<EOF\n#!/bin/bash\nif [ -f /etc/hostname ]\nthen\necho "SCRIPT_OK"\nfi\nEOF\nchmod +x /opt/run.sh',
    check: 'if /opt/run.sh > /tmp/run.out 2>/dev/null && grep -q SCRIPT_OK /tmp/run.out; then\n  echo \'{"pass":true,"score":100,"message":"完成！脚本可运行"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"bash -n /opt/run.sh 看缺什么（then 后的 fi?）"}\'\nfi',
    hints: ['诊断：bash -n /opt/run.sh', '缺 fi（if 块没闭合）', '补上后运行'],
    solution: 'bash -n /opt/run.sh\necho "fi" >> /opt/run.sh\nbash -n /opt/run.sh && /opt/run.sh | tee /tmp/run.out'
  },
  {
    code: 'shell-script-sete', name: '给脚本加健壮性', topic: 'shell', d: 2, sort: 82, g: ['健壮性'], mins: 30,
    scenario: '/opt/deploy.sh 某步失败仍继续执行（危险）。\n任务：给脚本加 set -euo pipefail（放在 shebang 后），使它第一步就安全退出；验证脚本退出码非 0。',
    setup: 'cat > /opt/deploy.sh <<EOF\n#!/bin/bash\ncd /not-exist-dir 2>/dev/null\necho "still running" >> /tmp/deploy.log\nEOF\nchmod +x /opt/deploy.sh',
    check: '/opt/deploy.sh >/dev/null 2>&1; rc=$?\nif [ "$rc" -ne 0 ] && [ ! -f /tmp/deploy.log ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！失败即停生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"加 set -euo pipefail；注意 cd 失败会退出且后续不执行"}\'\nfi',
    hints: ['第2行加 set -euo pipefail', 'cd 失败（无-e时被 2>/dev/null 吞掉继续跑）', '运行后看退出码 $?'],
    solution: 'sed -i "1a set -euo pipefail" /opt/deploy.sh\n/opt/deploy.sh; echo "exit=$?"\nls /tmp/deploy.log 2>/dev/null || echo "未执行后续步骤=正确"'
  },
  {
    code: 'shell-lock-flock', name: '任务防并发（flock）', topic: 'shell', d: 3, sort: 83, g: ['并发'], mins: 40,
    scenario: '任务每分钟跑一次但耗时不定，会重叠执行。\n任务：给 /opt/job.sh 加 flock 单实例锁（在脚本内 exec 9>lock; flock -n 9 || exit 0），验证脚本可正常运行且产生输出 /tmp/job.log。',
    setup: 'cat > /opt/job.sh <<EOF\n#!/bin/bash\necho "job \$(date +%T)" >> /tmp/job.log\nsleep 2\nEOF\nchmod +x /opt/job.sh',
    check: '/opt/job.sh >/dev/null 2>&1 & /opt/job.sh >/dev/null 2>&1; sleep 3\nif grep -q "exec 9>" /opt/job.sh && grep -q "flock -n 9" /opt/job.sh && [ -f /tmp/job.log ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！单实例锁就位"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"脚本内加：exec 9>/tmp/job.lock; flock -n 9 || exit 0"}\'\nfi',
    hints: ['脚本开头：exec 9>/tmp/job.lock', 'flock -n 9 || exit 0', '并发跑两次验证只执行一个'],
    solution: 'sed -i "1a exec 9>/tmp/job.lock\\nflock -n 9 || exit 0" /opt/job.sh\n/opt/job.sh & /opt/job.sh; wait\nwc -l /tmp/job.log'
  },
  {
    code: 'shell-merge-lines', name: '两文件按行合并', topic: 'shell', d: 2, sort: 84, g: ['paste', 'join'], mins: 30,
    scenario: '/data/ips.txt 与 /data/names.txt 行对行对应（第i行名字属于第i行IP）。\n任务：合并为 "名字 IP" 每行写入 /root/merge.txt。',
    setup: 'mkdir -p /data\nprintf "10.0.0.1\\n10.0.0.2\\n10.0.0.3\\n" > /data/ips.txt\nprintf "web1\\ndb1\\ncache1\\n" > /data/names.txt',
    check: 'if [ -f /root/merge.txt ] && grep -q "web1 10.0.0.1" /root/merge.txt && [ "$(wc -l < /root/merge.txt)" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！合并成功"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"paste names.txt ips.txt 处理列序"}\'\nfi',
    hints: ['paste -d" " file1 file2', '注意名字在前IP在后', '落盘验证'],
    solution: 'paste -d" " /data/names.txt /data/ips.txt > /root/merge.txt\ncat /root/merge.txt'
  },
  {
    code: 'shell-diff-config', name: '配置差异对比', topic: 'shell', d: 1, sort: 85, g: ['diff'], mins: 30,
    scenario: '发布前后配置对比：找出 /opt/conf/old.cnf 与 new.cnf 的差异。\n任务：把 diff 结果写入 /root/conf-diff.txt（文件应含 < 或 > 行）。',
    setup: 'mkdir -p /opt/conf\nprintf "a=1\\nb=2\\nc=3\\n" > /opt/conf/old.cnf\nprintf "a=1\\nb=20\\nd=4\\n" > /opt/conf/new.cnf',
    check: 'if [ -f /root/conf-diff.txt ] && grep -qE "^<|^>" /root/conf-diff.txt; then\n  echo \'{"pass":true,"score":100,"message":"完成！差异留档"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"diff -u old new > /root/conf-diff.txt"}\'\nfi',
    hints: ['diff -u 更易读', '重定向', '看懂 < 与 > 含义（旧/新）'],
    solution: 'diff -u /opt/conf/old.cnf /opt/conf/new.cnf > /root/conf-diff.txt\ncat /root/conf-diff.txt'
  },
  {
    code: 'shell-sed-replace', name: '批量替换配置项', topic: 'shell', d: 1, sort: 86, g: ['sed'], mins: 30,
    scenario: '迁移环境：/opt/conf/app.conf 的 db_host 要从 10.0.0.1 换成 10.0.0.99。\n任务：用 sed 修改文件（保留其他行），验证新值生效。',
    setup: 'mkdir -p /opt/conf\nprintf "port=8080\\ndb_host=10.0.0.1\\ndb_user=root\\n" > /opt/conf/app.conf',
    check: 'v=$(grep "^db_host=" /opt/conf/app.conf | cut -d= -f2)\np=$(grep -c "^port=8080" /opt/conf/app.conf)\nif [ "$v" = "10.0.0.99" ] && [ "$p" = "1" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！精准替换"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"sed -i s/旧/新/ 定向替换 db_host 行"}\'\nfi',
    hints: ['sed -i "s/^db_host=.*/db_host=10.0.0.99/" 文件', '验证 grep', '别动其他行'],
    solution: 'sed -i "s/^db_host=.*/db_host=10.0.0.99/" /opt/conf/app.conf\ncat /opt/conf/app.conf'
  },
  {
    code: 'shell-time-calc', name: '时间戳处理', topic: 'shell', d: 1, sort: 87, g: ['date'], mins: 30,
    scenario: '日志排查要把时间戳转可读时间。\n任务：把时间戳 1761379200 转成 "年-月-日 时:分:秒" 格式写入 /root/ts.txt。',
    setup: 'echo 1761379200 > /opt/ts.in',
    check: 'if grep -qE "202[0-9]-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}" /root/ts.txt 2>/dev/null; then\n  echo \'{"pass":true,"score":100,"message":"完成！时间转换成功"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"date -d @1761379200 +%F\\\\ %T"}\'\nfi',
    hints: ['date -d @时间戳', '格式 +%F\\ %T 或 +"%Y-%m-%d %H:%M:%S"', '落盘'],
    solution: 'date -d @1761379200 +"%Y-%m-%d %H:%M:%S" | tee /root/ts.txt\ncat /root/ts.txt'
  },
  {
    code: 'shell-parallel-xargs', name: '并行批量探活（xargs -P）', topic: 'shell', d: 3, sort: 88, g: ['并发'], mins: 40,
    scenario: '要对 /opt/hosts.txt 的每行地址做连通测试（ping -c1 -W1），并行 10 路。\n任务：运行批量探测，把每行结果 "IP OK/FAIL" 写入 /root/pingall.txt。',
    setup: 'printf "127.0.0.1\\n127.0.0.2\\n127.0.0.3\\n" > /opt/hosts.txt',
    check: 'if [ -f /root/pingall.txt ] && grep -q "127.0.0.1" /root/pingall.txt && [ "$(wc -l < /root/pingall.txt)" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！并行探测完成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"xargs -P 10 -I {} sh -c "ping..." 或 for 循环"}\'\nfi',
    hints: ['xargs -P 10 -I{} sh -c \'...{}...\' < 文件', '结果 echo 追加文件', 'wc -l 验证'],
    solution: "cat /opt/hosts.txt | xargs -P 10 -I{} sh -c 'ping -c1 -W1 {} >/dev/null 2>&1 && echo \"{} OK\" || echo \"{} FAIL\"' > /root/pingall.txt\ncat /root/pingall.txt"
  },
  {
    code: 'shell-service-watchdog', name: '进程守护脚本', topic: 'shell', d: 3, sort: 89, g: ['实战'], mins: 40,
    scenario: '写一个简单守护：每 10 秒检查 myweb（python 9000）是否存活，不在则拉起，日志写 /tmp/watchdog.log。\n任务：启动守护脚本后台运行；判分时杀掉 myweb 后 30 秒内它应被自动拉活。',
    setup: 'mkdir -p /opt/web; echo MYWEB > /opt/web/index.html\nnohup python3 -m http.server 9000 --directory /opt/web --bind 127.0.0.1 >/dev/null 2>&1 &\nsleep 1',
    check: 'pkill -f "http.server 9000" 2>/dev/null; sleep 25\nif curl -s --max-time 3 http://127.0.0.1:9000/ 2>/dev/null | grep -q MYWEB && [ -f /tmp/watchdog.log ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！守护拉活成功"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"后台守护脚本：pgrep检查+拉起+日志；保持运行等检测"}\'\nfi',
    hints: ['脚本：while :; do pgrep -f "http.server 9000" >/dev/null || nohup python3 ... &; sleep 10; done', '日志追加 /tmp/watchdog.log', 'nohup 后台运行守护脚本本身'],
    solution: 'cat > /opt/watch.sh <<EOF\n#!/bin/bash\nwhile :; do\n  pgrep -f "http.server 9000" >/dev/null || { nohup python3 -m http.server 9000 --directory /opt/web --bind 127.0.0.1 >/dev/null 2>&1 & echo "\$(date +%T) restarted" >> /tmp/watchdog.log; }\n  sleep 10\ndone\nEOF\nchmod +x /opt/watch.sh\nnohup /opt/watch.sh >/dev/null 2>&1 &\npgrep -f watch.sh'
  },
  {
    code: 'shell-ip-top-cities', name: '多维日志统计（IP+状态码）', topic: 'shell', d: 2, sort: 90, g: ['awk', '必考'], mins: 40,
    scenario: '两份报告：1) TOP5 IP 2) 各状态码计数。\n任务：分别写入 /root/r1.txt（"次数 IP"）与 /root/r2.txt（"次数 状态码"）。',
    setup: 'mkdir -p /var/log/app\nfor i in $(seq 1 40); do echo "10.0.0.5 - - [x] \\"GET /a\\" 200"; done > /var/log/app/access.log\nfor i in $(seq 1 25); do echo "10.0.0.6 - - [x] \\"GET /b\\" 500"; done >> /var/log/app/access.log\nfor i in $(seq 1 10); do echo "10.0.0.7 - - [x] \\"GET /c\\" 404"; done >> /var/log/app/access.log',
    check: 'r1=$(head -1 /root/r1.txt 2>/dev/null | grep -c "10.0.0.5")\nr2=$(grep -c "404" /root/r2.txt 2>/dev/null)\nif [ "$r1" -ge 1 ] && [ "$r2" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！双维统计正确"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"两份报告都要：awk列1/列9 分别统计"}\'\nfi',
    hints: ['IP：awk \'{print $1}\' | sort | uniq -c | sort -rn | head -5', '状态码：$9 列', '分别落盘两个文件'],
    solution: "awk '{print $1}' /var/log/app/access.log | sort | uniq -c | sort -rn | head -5 > /root/r1.txt\nawk '{print $9}' /var/log/app/access.log | sort | uniq -c | sort -rn > /root/r2.txt\ncat /root/r1.txt /root/r2.txt"
  },
  {
    code: 'nginx-502-recover', name: '综合排障：502 恢复', topic: 'nginx', d: 3, sort: 91, g: ['综合', '必考'], mins: 45,
    scenario: '完整故障：用户访问 http://127.0.0.1/api/ 返回 502。\n架构：nginx 反代 9000 后端。后端进程挂了。\n任务：定位并恢复，使 /api/ 返回 API_OK；把排查过程三行说明写入 /root/postmortem.txt（含"后端未运行"字样）。',
    setup: 'mkdir -p /opt/bk; echo "API_OK" > /opt/bk/index.html\ncat > /etc/nginx/sites-available/api502 <<EOF\nserver {\n    listen 80;\n    location /api/ { proxy_pass http://127.0.0.1:9000/; }\n}\nEOF\nln -sf /etc/nginx/sites-available/api502 /etc/nginx/sites-enabled/api502\nrm -f /etc/nginx/sites-enabled/default\nnginx 2>/dev/null || nginx -s reload 2>/dev/null || true',
    check: 'out=$(curl -s --max-time 3 http://127.0.0.1/api/ 2>/dev/null)\nif echo "$out" | grep -q API_OK && grep -q "后端未运行" /root/postmortem.txt 2>/dev/null; then\n  echo \'{"pass":true,"score":100,"message":"完成！故障恢复并复盘"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"拉起后端9000；postmortem写清根因（后端未运行）"}\'\nfi',
    hints: ['复现：curl -I /api/ 得 502', '区分：后端死(502) vs 后端慢(504)', '修复：nohup python3 -m http.server 9000 --directory /opt/bk &；写复盘'],
    solution: 'curl -I http://127.0.0.1/api/\nss -tlnp | grep 9000 || echo 后端未运行\nnohup python3 -m http.server 9000 --directory /opt/bk --bind 127.0.0.1 >/dev/null 2>&1 &\ncurl -s http://127.0.0.1/api/\nprintf "1. 现象:/api/ 502\\n2. 根因:后端未运行(9000无监听)\\n3. 恢复:拉起后端并加守护\\n" > /root/postmortem.txt'
  },
  {
    code: 'linux-system-report', name: '巡检报告一键生成', topic: 'shell', d: 2, sort: 92, g: ['综合', '实战'], mins: 40,
    scenario: '写巡检脚本 /opt/check.sh 生成 /root/report.txt，包含：当前负载、内存可用、磁盘 / 使用率（三段都要有）。',
    setup: 'echo ok',
    check: 'r=$(grep -cE "load|内存|磁盘|Mem|Filesystem|/" /root/report.txt 2>/dev/null)\nx=$(ls /opt/check.sh 2>/dev/null | wc -l)\nif [ "$r" -ge 3 ] && [ "$x" = "1" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！巡检脚本就绪"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"/opt/check.sh 输出 uptime/free -h/df -h 到 /root/report.txt"}\'\nfi',
    hints: ['脚本三段：uptime; free -h; df -h /', '重定向 /root/report.txt', 'chmod +x 并执行'],
    solution: 'cat > /opt/check.sh <<EOF\n#!/bin/bash\n{ echo "== load =="; uptime; echo "== mem =="; free -h; echo "== disk =="; df -h /; } > /root/report.txt\nEOF\nchmod +x /opt/check.sh && /opt/check.sh\ncat /root/report.txt'
  },
  {
    code: 'net-http-bench', name: '简易压测与容量感知', topic: 'shell', d: 2, sort: 93, g: ['性能'], mins: 40,
    scenario: '用 ab 或 curl 循环对本地 nginx 发 100 个请求，统计完成总耗时写入 /root/bench.txt（含 "100" 与秒数）。',
    setup: 'nginx 2>/dev/null || true; echo bench > /var/www/html/index.html',
    check: 'if [ -f /root/bench.txt ] && grep -qE "100" /root/bench.txt && grep -qE "[0-9]+\\.[0-9]+" /root/bench.txt; then\n  echo \'{"pass":true,"score":100,"message":"完成！基线数据到手"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"time + for循环100次curl 结果落盘"}\'\nfi',
    hints: ['ab -n 100 -c 10 http://127.0.0.1/（ab 若无则用 for+curl）', '或：time (for i in $(seq 100); do curl -s -o /dev/null URL; done)', '结果（含请求数与时间）写入文件'],
    solution: '{ echo "requests=100"; time (for i in $(seq 1 100); do curl -s -o /dev/null http://127.0.0.1/; done); } > /root/bench.txt 2>&1\ncat /root/bench.txt'
  },
  {
    code: 'mw-memcpy-hotkey', name: '热点key模拟与本地缓存', topic: 'mw', d: 3, sort: 94, g: ['综合'], mins: 45,
    scenario: 'Redis 中 hot:key 被高频读取。任务：1) 启动 redis 并 set hot:key v1 2) 用循环读 1000 次 3) 把 QPS（次/秒）计算写入 /root/qps.txt。',
    setup: 'pkill -x redis-server 2>/dev/null; sleep 1\ncat > /etc/redis/redis.conf <<EOF\nbind 127.0.0.1\nport 6379\ndaemonize yes\nlogfile /var/log/redis/redis.log\ndir /var/lib/redis\nEOF\nmkdir -p /var/log/redis /var/lib/redis',
    check: 'if [ -f /root/qps.txt ] && grep -qE "[0-9]+" /root/qps.txt && redis-cli exists hot:key 2>/dev/null | grep -q 1; then\n  echo \'{"pass":true,"score":100,"message":"完成！压测数据生成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"启动redis；写hot:key；循环1000次计时算QPS"}\'\nfi',
    hints: ['启动 redis；set hot:key v1', 'start=$(date +%s%N) ... 循环 get ... end', 'QPS = 1000/耗时秒'],
    solution: 'redis-server /etc/redis/redis.conf; sleep 1\nredis-cli set hot:key v1\nS=$(date +%s%N); for i in $(seq 1 1000); do redis-cli get hot:key >/dev/null; done; E=$(date +%s%N)\necho "QPS = 1000 / $(( (E-S)/1000000000 )).$(( ((E-S)/100000000)%10 ))s" | tee /root/qps.txt'
  },
  {
    code: 'linux-forensics-user', name: '安全取证：谁动过系统', topic: 'linux', d: 3, sort: 95, g: ['安全', '综合'], mins: 45,
    scenario: '疑似有人动过机器。任务：1) 查看成功登录记录（last）与失败记录（lastb）2) 找出 /etc/passwd 中 shell 为 /bin/bash 的可登录用户数写入 /root/users.txt。',
    setup: 'echo ok',
    check: 'n=$(cat /root/users.txt 2>/dev/null | grep -oE "^[0-9]+$")\nreal=$(getent passwd | grep -c "/bin/bash")\nif [ -n "$n" ] && [ "$n" = "$real" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！基础取证完成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"统计可登录用户（getent passwd | grep -c /bin/bash）"}\'\nfi',
    hints: ['last / lastb 看登录', 'getent passwd 列用户', 'grep -c 统计计数写入文件'],
    solution: 'last | head; lastb 2>/dev/null | head\ngetent passwd | grep "/bin/bash" | wc -l | tee /root/users.txt'
  },
  {
    code: 'net-multi-check', name: '机房连通性巡检', topic: 'network', d: 2, sort: 96, g: ['综合'], mins: 40,
    scenario: '巡检清单 /opt/targets：每行 "名称 端口"，全是本机服务。\n任务：逐项检查 127.0.0.1 的端口连通（nc/curl），输出 "名称 OK/FAIL" 到 /root/netcheck.txt。',
    setup: 'nginx 2>/dev/null || true\nprintf "web 80\\nredis 6379\\nnone 9999\\n" > /opt/targets\npkill -x redis-server 2>/dev/null; sleep 1\ncat > /etc/redis/redis.conf <<EOF\nbind 127.0.0.1\nport 6379\ndaemonize yes\nlogfile /tmp/redis.log\ndir /tmp\nEOF\nredis-server /etc/redis/redis.conf 2>/dev/null; sleep 1',
    check: 'ok=$(grep -cE "web OK" /root/netcheck.txt 2>/dev/null)\nfail=$(grep -cE "none FAIL" /root/netcheck.txt 2>/dev/null)\nif [ "${ok:-0}" -ge 1 ] && [ "${fail:-0}" -ge 1 ] && [ "$(wc -l < /root/netcheck.txt)" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！巡检报告正确"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"web应OK、none应FAIL（9999没人听）"}\'\nfi',
    hints: ['while read name port：nc -z -w1 127.0.0.1 $port', '结果追加 /root/netcheck.txt', '三行都要有'],
    solution: '#!/bin/bash\nwhile read -r name port; do\n  nc -z -w1 127.0.0.1 "$port" >/dev/null 2>&1 && echo "$name OK" || echo "$name FAIL"\ndone < /opt/targets > /root/netcheck.txt\ncat /root/netcheck.txt'
  },
  {
    code: 'linux-service-recover', name: '综合排障：Web 服务恢复', topic: 'nginx', d: 3, sort: 97, g: ['综合'], mins: 45,
    scenario: '站点 http://127.0.0.1:8085 挂了（曾经正常）。目录 /var/www/it 与配置 /etc/nginx/sites-available/it 都在。\n任务：找出原因（nginx 没起）恢复服务，curl 8085 返回 IT_OK。',
    setup: 'mkdir -p /var/www/it; echo "IT_OK" > /var/www/it/index.html\ncat > /etc/nginx/sites-available/it <<EOF\nserver { listen 8085; root /var/www/it; index index.html; }\nEOF\nln -sf /etc/nginx/sites-available/it /etc/nginx/sites-enabled/it\npkill -x nginx 2>/dev/null; echo ok',
    check: 'out=$(curl -s --max-time 3 http://127.0.0.1:8085/ 2>/dev/null)\nif echo "$out" | grep -q IT_OK; then\n  echo \'{"pass":true,"score":100,"message":"完成！服务恢复"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"查端口监听→发现nginx未运行→启动→验证"}\'\nfi',
    hints: ['ss -tlnp | grep 8085：没人听', 'pgrep nginx：进程不在', 'nginx -t && nginx 启动'],
    solution: 'ss -tlnp | grep 8085 || echo "8085 无监听"\npgrep -x nginx || echo "nginx 未运行"\nnginx -t && nginx\ncurl -s http://127.0.0.1:8085/'
  },
  {
    code: 'shell-file-watch', name: '文件变更监控（简单版）', topic: 'shell', d: 3, sort: 98, g: ['进阶'], mins: 40,
    scenario: '监控 /opt/conf/app.conf 是否被改动（轮询 md5）。\n任务：写 /opt/watch-conf.sh：后台死循环每 5 秒比较 md5，变化时追加一行到 /tmp/conf.alert 并更新基准；启动它后台运行（判分：修改 app.conf 后 30 秒内 /tmp/conf.alert 出现记录）。',
    setup: 'mkdir -p /opt/conf; echo "a=1" > /opt/conf/app.conf',
    check: 'md5sum /opt/conf/app.conf | awk \'{print $1}\' > /tmp/base.md5\necho "a=2" > /opt/conf/app.conf\nsleep 25\nif [ -f /tmp/conf.alert ] && grep -q "changed" /tmp/conf.alert; then\n  echo \'{"pass":true,"score":100,"message":"完成！变更被捕获"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"守护脚本需在后台持续运行并检测差异"}\'\nfi',
    hints: ['md5sum 取哈希与基准比较', '变化则 echo "$(date) changed" >> /tmp/conf.alert 并更新基准', 'nohup 后台运行'],
    solution: 'cat > /opt/watch-conf.sh <<EOF\n#!/bin/bash\nbase=\\$(md5sum /opt/conf/app.conf | awk "{print \\$1}")\nwhile :; do\n  cur=\\$(md5sum /opt/conf/app.conf | awk "{print \\$1}")\n  [ "\\$cur" != "\\$base" ] && { echo "\\$(date +%T) changed" >> /tmp/conf.alert; base=\\$cur; }\n  sleep 5\ndone\nEOF\nchmod +x /opt/watch-conf.sh\nnohup /opt/watch-conf.sh >/dev/null 2>&1 &\npgrep -f watch-conf'
  },
  {
    code: 'linux-capacity-alert', name: '磁盘水位告警脚本', topic: 'shell', d: 2, sort: 99, g: ['实战'], mins: 40,
    scenario: '写 /opt/diskalert.sh：当根分区使用率超过阈值（设 5%，便于实验）时向 /tmp/disk.alert 写入告警行（含 USE% 与时间）；立即执行一次验证。',
    setup: 'echo ok',
    check: 'if [ -x /opt/diskalert.sh ] && grep -qE "USE|%" /tmp/disk.alert 2>/dev/null; then\n  echo \'{"pass":true,"score":100,"message":"完成！水位告警可用"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"df -P / 取百分比与5比较，超阈值写 /tmp/disk.alert"}\'\nfi',
    hints: ['df -P / 输出稳定格式（第5列 xx%）', '取百分比：df -P / 后取第5列并去掉百分号（awk 的 gsub）', '比较大于5则追加一行到 /tmp/disk.alert'],
    solution: 'cat > /opt/diskalert.sh <<EOF\n#!/bin/bash\np=\\$(df -P / | awk "NR==2{gsub(\\\\"%\\",\\\"\\");print \\\$5}")\n[ "\\$p" -gt 5 ] && echo "\\$(date +%F\\ %T) disk USE \\${p}% over threshold" >> /tmp/disk.alert\nEOF\nchmod +x /opt/diskalert.sh && /opt/diskalert.sh\ncat /tmp/disk.alert'
  },
  {
    code: 'mw-http-cache-check', name: 'HTTP 缓存头验证', topic: 'network', d: 2, sort: 100, g: ['HTTP'], mins: 40,
    scenario: '静态资源要配长缓存。\n任务：给 nginx 的 .txt/.js 加 expires 30d，reload 后 curl -I 验证响应头含 Cache-Control/max-age（把该头写入 /root/cachehdr.txt）。',
    setup: 'echo "cache test" > /var/www/html/f.js\nnginx 2>/dev/null || true',
    check: 'if grep -qiE "cache-control|max-age" /root/cachehdr.txt 2>/dev/null; then\n  echo \'{"pass":true,"score":100,"message":"完成！强缓存生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"location ~ .*\\\\.(js|txt)$ { expires 30d; } 后 curl -I 落盘"}\'\nfi',
    hints: ['server{} 加 location ~ .*\\.(js|txt)$ { root /var/www/html; expires 30d; }', 'nginx -t && nginx -s reload', 'curl -I http://127.0.0.1/f.js | grep -i cache'],
    solution: '# 在 server 配置中加 location\nvi /etc/nginx/sites-available/default 2>/dev/null || vi /etc/nginx/nginx.conf\n# location ~ .*\\.(js|txt)$ { root /var/www/html; expires 30d; }\nnginx -t && nginx -s reload\ncurl -sI http://127.0.0.1/f.js | grep -iE "cache-control|max-age|expires" | tee /root/cachehdr.txt'
  },
]
