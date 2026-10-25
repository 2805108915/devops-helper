-- 题库种子：Shell 脚本（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(3, 'QA', 1, '单引号、双引号、反引号的区别？', NULL,
 '- **单引号 `''`**：原样输出，任何变量和命令都不解析\n- **双引号 `""`**：解析变量 `$var` 和命令替换，保留空格\n- **反引号 `` `` ``**：命令替换（执行命令取输出），等价写法 `$(...)`，推荐后者（可嵌套、易读）\n\n```bash\nname=world\necho "hello $name"     # hello world\necho ''hello $name''     # hello $name\necho "dir: $(pwd)"     # dir: /root\n```\n\n坑：变量含空格不加分引号会拆词：`cp $file /tmp` 应写 `cp "$file" /tmp`。',
 '["$( ) 和 ${ } 一样吗？"]', '["基础"]', 3, '["junior-ops", "devops"]'),

(3, 'QA', 2, '$@ 和 $* 的区别？$? $$ $! $0 分别是什么？', NULL,
 '- `$@`：每个参数独立（加引号时每个都是独立单词），遍历参数用它\n- `$*`：所有参数拼成一个字符串\n- `$?`：上一条命令退出码（0 成功）\n- `$$`：当前脚本 PID\n- `$!`：最近一个后台进程 PID（常用来 kill 掉后台任务）\n- `$0`：脚本名；`$#`：参数个数\n\n```bash\nfor arg in "$@"; do echo "$arg"; done\n```\n\n退出码是脚本被上层（crontab/CI）判断成败的依据，自定义退出：`exit 1`。',
 '["set -e 对退出码有什么影响？"]', '["基础"]', 3, '["junior-ops", "devops"]'),

(3, 'QA', 1, '怎么判断文件、目录是否存在？怎么写 if 条件？', NULL,
 '```bash\nif [ -f /etc/nginx/nginx.conf ]; then echo "文件存在"; fi   # -f 普通文件\nif [ -d /var/log ]; then echo "目录存在"; fi                 # -d 目录\nif [ -z "$input" ]; then echo "变量为空"; fi                 # -z 空 / -n 非空\nif [ -x /root/init.sh ]; then echo "可执行"; fi             # -x 可执行\n```\n\n要点：**方括号两边必须有空格**；变量都加双引号防拆词；数值比较用 `-eq -gt -lt`，字符串比较用 `=` `!=`；`&&`/`||` 短路写法：`[ -f x ] && echo ok`。',
 '["[ ] 和 [[ ]] 的区别？"]', '["基础", "高频"]', 4, '["junior-ops", "devops"]'),

(3, 'SCENARIO', 2, '统计 nginx access.log 中访问量最高的 10 个 IP（awk/sort/uniq 组合）', '日志格式：192.168.1.5 - - [25/Oct/2026:10:00:01 +0800] "GET /api HTTP/1.1" 200 ...',
 '```bash\nawk ''{print $1}'' access.log | sort | uniq -c | sort -rn | head -10\n```\n\n逐步解释：\n1. `awk ''{print $1}''` 取第一列（IP）\n2. `sort` 排序（让相同 IP 相邻，uniq 的前提）\n3. `uniq -c` 去重并计数\n4. `sort -rn` 按数字倒序\n5. `head -10` 取前 10\n\n扩展：\n- 统计 URL：`awk ''{print $7}'' access.log | sort | uniq -c | sort -rn | head`\n- 统计各状态码：`awk ''{print $9}'' access.log | sort | uniq -c`\n- 统计 5xx 占比：`awk ''$9>=500'' access.log | wc -l`\n\n这题几乎是运维/DevOps 面试必考的命令行题，必须熟练。',
 '["怎么统计每分钟的请求量？", "awk 里怎么按任意分隔符取列？"]', '["awk", "必考", "日志分析"]', 5, '["junior-ops", "devops", "sre"]'),

(3, 'QA', 1, 'sed 和 awk 各适合什么场景？举几个常用例子', NULL,
 '**口诀：sed 改行/改串，awk 列处理**。\n\nsed 常用：\n```bash\nsed ''s/foo/bar/g'' file          # 全局替换\nsed -i ''s/foo/bar/g'' file       # 直接改文件（-i）\nsed -n ''10,20p'' file            # 打印 10-20 行\nsed ''/^#/d'' file                # 删除注释行\n```\n\nawk 常用：\n```bash\nawk -F: ''{print $1, $7}'' /etc/passwd    # 指定分隔符取列\nawk ''$3 > 100'' file                     # 条件过滤行\nawk ''{sum += $5} END {print sum}'' file  # 求和\n```\n\n加分：`grep -o pattern file | wc -l` 统计出现次数、`cut -d: -f1` 简单取列。',
 '["sed -i 修改前怎么安全备份？", "awk 关联数组怎么用（如按 IP 计数）？"]', '["文本处理", "高频"]', 4, '["junior-ops", "devops"]'),

(3, 'QA', 2, 'crontab 的格式是什么？常见的坑有哪些？', NULL,
 '格式：**分 时 日 月 周**\n```\n*/5 * * * *   # 每 5 分钟\n0 3 * * *     # 每天凌晨 3 点\n30 2 * * 1    # 每周一 2:30\n```\n\n常见的坑（面试加分重点）：\n1. **`%` 有特殊含义**，命令里要写 `\\%`\n2. **环境变量极简**：PATH 往往只有 /usr/bin:/bin，脚本里用绝对路径，或开头 `source /etc/profile`\n3. **必须重定向输出**：`>> /var/log/xx.log 2>&1`，否则邮件堆积或静默失败\n4. 上次没跑完下次又启动 → 加锁：`flock -n /tmp/xx.lock cmd`\n5. 排查看 cron 日志：`grep CRON /var/log/syslog` 或 journalctl -u crond',
 '["怎么保证 cron 任务不并发执行？", "秒级任务用什么？"]', '["crontab", "高频"]', 5, '["junior-ops", "devops"]'),

(3, 'QA', 2, '脚本里的 set -e、set -u、set -x 分别是什么作用？', NULL,
 '- `set -e`：任何命令失败（非 0 退出码）立即终止脚本。**生产脚本必加**，防止错误雪崩\n- `set -u`：使用未定义变量报错退出，防拼写错误 `$floder`\n- `set -x`：打印每条执行的命令，调试利器\n- `set -o pipefail`：管道中任一环节失败则整体失败（否则只看最后一条）\n\n推荐组合：`set -euo pipefail`（bash 脚本头部常客）。\n\n注意坑：`set -e` 对 `if` 条件、`||`/`&&` 后面的命令不生效；`cmd || true` 可以豁免。',
 '["set -e 和 trap 结合怎么做清理？"]', '["健壮性"]', 3, '["devops", "sre"]'),

(3, 'QA', 1, 'while read 逐行处理文件的正确写法？', NULL,
 '```bash\ncat ips.txt | while read ip; do\n    echo "processing $ip"\ndone\n\n# 或者（避免管道子 shell 变量丢失问题）\nwhile read -r ip; do\n    total=$((total+1))\ndone < ips.txt\n```\n\n要点：\n- `read -r` 防反斜杠转义\n- 管道会开子 shell，循环里的变量改动**带不出来**（常见坑，用重定向 `< file` 或 `done < <(cmd)`）\n- 空行处理：`[ -z "$ip" ] && continue`\n- 并行加速：`xargs -P 10 -I {} sh -c "check {}" < ips.txt`',
 '["for 循环和 while read 各适合什么？", "怎么限制并发数？"]', '["实战"]', 3, '["junior-ops", "devops"]'),

(3, 'SCENARIO', 2, '写一个服务健康检查脚本：接口连续失败 3 次则重启服务并发告警', '要求：用 curl 检测 http://localhost:8080/health，失败 3 次重启 nginx 并输出告警日志。',
 '```bash\n#!/bin/bash\nset -euo pipefail\nURL="http://localhost:8080/health"\nFAIL=0\nfor i in 1 2 3; do\n    if curl -sf --max-time 3 "$URL" > /dev/null; then\n        echo "$(date +%F_%T) ok"\n        exit 0\n    fi\n    FAIL=$((FAIL+1))\n    sleep 2\ndone\necho "$(date +%F_%T) CRITICAL: health check failed $FAIL times, restarting nginx" >> /var/log/health-check.log\nsystemctl restart nginx\necho "$(date +%F_%T) restarted" >> /var/log/health-check.log\n# 告警：curl 钉钉/飞书 webhook 或 mail\n```\n\n考察点：`curl -sf`（-s 静默 -f 失败返回非 0）、`--max-time` 必须设、失败计数与重试、日志带时间戳、重启后告警动作。\n\n可挂在 crontab 每 1 分钟跑一次。',
 '["怎么避免脚本重启风暴？", "curl 的 --retry 参数能替代循环吗？"]', '["实战", "高频"]', 4, '["junior-ops", "devops", "sre"]'),

(3, 'QA', 1, 'Shell 脚本怎么调试？', NULL,
 '1. `bash -x script.sh`：打印每条命令和变量展开（最常用）\n2. 脚本内局部调试：`set -x` 开 / `set +x` 关\n3. `bash -n script.sh`：只做语法检查不执行（CI 里常用）\n4. `shellcheck script.sh`：静态检查工具，能查出引号、空格等隐患（专业加分项）\n5. 关键位置 `echo "$var"` 或 `logger` 输出到 syslog\n\n单元测试可提 shunit2/bats（了解即可，说明有工程化意识）。',
 '["shellcheck 能查出哪些问题？"]', '["调试"]', 2, '["junior-ops", "devops"]');
