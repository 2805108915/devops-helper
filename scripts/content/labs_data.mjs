// Lab 定义数据（第一批 45 个：Linux 文件/权限/进程/磁盘 家族）
// 环境：devopshelper-base 镜像（ubuntu22.04, root, 含 nginx/ssh/redis/cron/常用工具）
export const LABS = [
  // ========== 文件查找与清理家族 ==========
  {
    code: 'find-large-files', name: '找出并清理超大日志', topic: 'linux', d: 1, sort: 11, g: ['find', 'du'], mins: 30,
    scenario: '告警：磁盘 92%。已知 /var/log/app 下日志暴涨。\n任务：删除超过 50MB 的日志文件（保留 app.log），使目录小于 5MB。',
    setup: 'mkdir -p /var/log/app\ndd if=/dev/zero of=/var/log/app/app.log.1 bs=1M count=120 status=none\ndd if=/dev/zero of=/var/log/app/old-debug.log bs=1M count=90 status=none\ndd if=/dev/zero of=/var/log/app/trace.bin bs=1M count=60 status=none\necho running > /var/log/app/app.log',
    check: 'sz=$(du -sm /var/log/app | awk \'{print $1}\')\nif [ "$sz" -lt 5 ] && [ -f /var/log/app/app.log ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！垃圾清理干净且保留在用日志"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"目录还有 \'$sz\'MB 或 app.log 被删了"}\'\nfi',
    hints: ['定位：du -sh /var/log/app/*', '按大小找：find /var/log/app -size +50M', '确认后删除，别动 app.log'],
    solution: 'du -sh /var/log/app/*\nfind /var/log/app -size +50M -ls\nrm /var/log/app/app.log.1 /var/log/app/old-debug.log /var/log/app/trace.bin\ndu -sm /var/log/app'
  },
  {
    code: 'find-by-name', name: '按名称清理指定文件', topic: 'linux', d: 1, sort: 12, g: ['find'], mins: 30,
    scenario: '磁盘告急。/data 下有大量 .tmp 和 .bak 临时文件需要清理。\n任务：删除 /data 下所有 .tmp 与 .bak 文件（含子目录），保留其他文件。',
    setup: 'mkdir -p /data/a/b/c\necho x > /data/a/1.tmp; echo x > /data/a/2.bak\necho x > /data/a/b/3.tmp\necho x > /data/a/b/c/4.bak\necho keep > /data/a/b/keep.txt\necho keep > /data/keep.conf',
    check: 'n=$(find /data -name "*.tmp" -o -name "*.bak" | wc -l)\nk=$(find /data -name "keep*" | wc -l)\nif [ "$n" -eq 0 ] && [ "$k" -eq 2 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！临时文件清理干净，正式文件保留"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还剩 \'$n\' 个临时文件，保留文件数 \'$k\'/2"}\'\nfi',
    hints: ['find /data -name "*.tmp"', '两种后缀用 -o 组合：-name "*.tmp" -o -name "*.bak"', '删除加 -delete 或 xargs rm'],
    solution: 'find /data \\( -name "*.tmp" -o -name "*.bak" \\) -print\nfind /data \\( -name "*.tmp" -o -name "*.bak" \\) -delete\nfind /data -type f | wc -l'
  },
  {
    code: 'find-old-logs', name: '清理 7 天前的归档日志', topic: 'linux', d: 1, sort: 13, g: ['find', 'mtime'], mins: 30,
    scenario: '归档目录 /archive 只需保留 7 天内的文件。\n任务：删除修改时间在 7 天前的 .log.gz 文件，保留 7 天内的。',
    setup: 'mkdir -p /archive\necho a > /archive/d1.log.gz; touch -d "10 days ago" /archive/d1.log.gz\necho b > /archive/d2.log.gz; touch -d "15 days ago" /archive/d2.log.gz\necho c > /archive/new.log.gz; touch -d "2 days ago" /archive/new.log.gz\necho d > /archive/today.log.gz',
    check: 'if [ -f /archive/new.log.gz ] && [ -f /archive/today.log.gz ] && [ ! -f /archive/d1.log.gz ] && [ ! -f /archive/d2.log.gz ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！旧的清了新的保留"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"检查 -mtime +7 与保留文件"}\'\nfi',
    hints: ['7天前 = -mtime +7', '先 -ls 预览再 -delete', '验证 ls -la /archive'],
    solution: 'find /archive -name "*.log.gz" -mtime +7 -ls\nfind /archive -name "*.log.gz" -mtime +7 -delete\nls -la /archive'
  },
  {
    code: 'locate-empty-dirs', name: '清理空目录', topic: 'linux', d: 1, sort: 14, g: ['find'], mins: 30,
    scenario: '/data/share 下有大量空目录占 inode。\n任务：删除 /data/share 下所有空目录（含嵌套），保留非空目录。',
    setup: 'mkdir -p /data/share/x1 /data/share/x2/y2 /data/share/x3\necho f > /data/share/x3/file.txt\nmkdir -p /data/share/x4/z1',
    check: 'e=$(find /data/share -type d -empty | wc -l)\nf=$(find /data/share -type f | wc -l)\nif [ "$e" -eq 0 ] && [ "$f" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！空目录已清理"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还有 \'$e\' 个空目录"}\'\nfi',
    hints: ['空目录：find -type d -empty', '删除：-delete', '注意嵌套空目录可能要跑两遍'],
    solution: 'find /data/share -type d -empty -print\nfind /data/share -type d -empty -delete\nfind /data/share -type d -empty -delete   # 嵌套的第二遍\nfind /data/share -type d'
  },
  {
    code: 'inode-exhaust-find', name: 'inode 耗尽排查', topic: 'linux', d: 2, sort: 15, g: ['inode', 'df -i'], mins: 40,
    scenario: 'df -h 显示磁盘很空，但创建文件报 No space left on device！\n提示：df -i 看看 inode。\n任务：找出文件数量最多的目录并清理 /tmp/cache 下的小文件，使可创建新文件。',
    setup: 'mkdir -p /tmp/cache/s1 /tmp/cache/s2\nfor i in $(seq 1 60); do echo x > /tmp/cache/s1/f$i; echo x > /tmp/cache/s2/f$i; done\nmkdir -p /tmp/work',
    check: 'touch /tmp/work/newfile 2>/dev/null && rc=0 || rc=1\nn=$(find /tmp/cache -type f | wc -l)\nif [ "$rc" = "0" ] && [ "$n" -lt 5 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！inode 压力解除"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"清理 /tmp/cache 全部小文件后重试"}\'\nfi',
    hints: ['df -i 对比 IUse%', '统计各目录文件数：for d in /tmp/*; do echo $d $(find $d | wc -l); done', 'rm -rf /tmp/cache/s1 /tmp/cache/s2'],
    solution: 'df -i\nfor d in /tmp/*; do echo "$d $(find $d 2>/dev/null | wc -l)"; done\nrm -rf /tmp/cache/s1 /tmp/cache/s2\ntouch /tmp/work/newfile && echo OK'
  },
  {
    code: 'dangling-symlink', name: '悬空软链接清理', topic: 'linux', d: 2, sort: 16, g: ['find', '软链接'], mins: 30,
    scenario: '/opt/versions 使用软链接 current 指向当前版本，升级后遗留了大量失效链接。\n任务：找出 /opt/versions 下所有失效（悬空）软链接并删除，保留有效链接。',
    setup: 'mkdir -p /opt/versions/v1 /opt/versions/v2\necho app > /opt/versions/v1/run.sh\nln -sf /opt/versions/v1 /opt/versions/current\nln -sf /opt/versions/v3 /opt/versions/old\nln -sf /opt/versions/v4 /opt/versions/backup\nln -sf /etc/hostname /opt/versions/host',
    check: 'b=$(find /opt/versions -xtype l | wc -l)\ng=$(find /opt/versions -type l ! -xtype l | wc -l)\nif [ "$b" -eq 0 ] && [ "$g" -ge 2 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！失效链接清理，有效链接保留"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还剩 \'$b\' 个失效链接（find -xtype l 定位）"}\'\nfi',
    hints: ['悬空链接：find /opt/versions -xtype l', '删除可以 xargs rm', '验证：ls -la /opt/versions'],
    solution: 'find /opt/versions -xtype l -ls\nfind /opt/versions -xtype l -delete\nls -la /opt/versions'
  },
  {
    code: 'file-type-audit', name: '可疑文件类型审计', topic: 'linux', d: 2, sort: 17, g: ['file', '安全'], mins: 30,
    scenario: '安全巡检：/tmp 发现可疑文件，需要识别类型并清理可执行体。\n任务：用 file 命令识别 /tmp/suspect 下文件；删除其中的 ELF 可执行文件，保留文本。',
    setup: 'mkdir -p /tmp/suspect\ncp /bin/true /tmp/suspect/svc1\ncp /bin/cat /tmp/suspect/svc2\nprintf "#!/bin/bash\\necho hi\\n" > /tmp/suspect/run.sh\necho "plain text" > /tmp/suspect/note.txt',
    check: 'elf=$(find /tmp/suspect -type f -exec file {} \\; | grep -c ELF || true)\nn=$(find /tmp/suspect -type f | wc -l)\nif [ "$elf" = "0" ] && [ "$n" -ge 2 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！可执行体清除，文本保留"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还有 \'$elf\' 个 ELF 文件"}\'\nfi',
    hints: ['file 命令看类型', '批量识别：find ... -exec file {} \\;', '按结果过滤删除'],
    solution: 'find /tmp/suspect -type f -exec file {} \\;\nfind /tmp/suspect -type f -exec file {} \\; | grep ELF | cut -d: -f1 | xargs rm -f\nls -la /tmp/suspect'
  },
  {
    code: 'grep-deep-search', name: '全目录内容搜索', topic: 'linux', d: 1, sort: 18, g: ['grep'], mins: 30,
    scenario: '要在 /opt/app 的所有文件里找到含数据库密码的配置。\n任务：找出 /opt/app 下内容含 "DB_PASSWORD" 的文件，把文件路径写入 /root/found.txt。',
    setup: 'mkdir -p /opt/app/conf /opt/app/src\necho "DB_PASSWORD=s3cret" > /opt/app/conf/app.properties\necho "port=8080" > /opt/app/conf/net.properties\necho "spring.datasource... DB_PASSWORD=abc123" > /opt/app/src/main.conf\necho "hello" > /opt/app/src/readme',
    check: 'if [ -f /root/found.txt ] && [ "$(grep -c app.properties /root/found.txt)" -ge 1 ] && [ "$(grep -c main.conf /root/found.txt)" -ge 1 ] && [ "$(grep -c net.properties /root/found.txt)" -eq 0 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！精准命中两个文件"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"检查 grep -rl 的输出与重定向"}\'\nfi',
    hints: ['递归搜内容：grep -r "DB_PASSWORD" /opt/app', '-l 只列文件名', '重定向 > /root/found.txt'],
    solution: 'grep -rl "DB_PASSWORD" /opt/app\ngrep -rl "DB_PASSWORD" /opt/app > /root/found.txt\ncat /root/found.txt'
  },
  {
    code: 'archive-extract', name: '备份归档与校验', topic: 'linux', d: 1, sort: 19, g: ['tar'], mins: 30,
    scenario: '需要打包 /data/app 发布到备份机。\n任务：把 /data/app 打包为 /backup/app-2026.tar.gz，并解压到 /restore/app 验证内容一致。',
    setup: 'mkdir -p /data/app/conf /backup\necho "name=demo" > /data/app/conf/app.conf\necho "v1" > /data/app/version\necho "log line" > /data/app/run.log',
    check: 'if [ -f /backup/app-2026.tar.gz ] && [ -f /restore/app/conf/app.conf ] && [ "$(cat /restore/app/version 2>/dev/null)" = "v1" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！归档与恢复校验通过"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"检查 tar -czf 打包与 -xzf 解压路径"}\'\nfi',
    hints: ['打包：tar -czf /backup/app-2026.tar.gz -C /data app', '解压：mkdir -p /restore/app && tar -xzf ... -C /restore/app', '校验 diff -r /data/app /restore/app'],
    solution: 'tar -czf /backup/app-2026.tar.gz -C /data app\nmkdir -p /restore/app\ntar -xzf /backup/app-2026.tar.gz -C /restore/app\ndiff -r /data/app /restore/app && echo SAME'
  },
  {
    code: 'batch-rename', name: '批量重命名（脚本实战）', topic: 'linux', d: 2, sort: 20, g: ['脚本'], mins: 30,
    scenario: '上传目录 /data/up 的 66 张图片文件名是 IMG_xxx.jpg，要改成 小写 img_xxx.jpg。\n任务：把 /data/up 下所有 IMG_*.jpg 重命名为 img_*.jpg。',
    setup: 'mkdir -p /data/up\nfor i in 1 2 3 4 5; do echo pic > /data/up/IMG_00$i.jpg; done\necho pic > /data/up/photo.txt',
    check: 'u=$(ls /data/up | grep -c "^IMG_" || true)\nl=$(ls /data/up | grep -c "^img_" || true)\nif [ "$u" -eq 0 ] && [ "$l" -ge 5 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！批量重命名成功"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还剩 \'$u\' 个大写开头文件"}\'\nfi',
    hints: ['for f in /data/up/IMG_*.jpg; do ...; done', '新名字符串替换：${f/IMG_/img_}', 'mv "$f" "$new"'],
    solution: 'for f in /data/up/IMG_*.jpg; do\n  mv "$f" "${f/IMG_/img_}"\ndone\nls /data/up'
  },

  // ========== 权限家族 ==========
  {
    code: 'perm-fix-exec', name: '脚本没有执行权限', topic: 'linux', d: 1, sort: 21, g: ['chmod'], mins: 20,
    scenario: '/opt/app/start.sh 无法执行（Permission denied）。\n任务：给所有者加执行权限，使 ./start.sh 能跑起来。',
    setup: 'mkdir -p /opt/app\nprintf "#!/bin/bash\\necho APP_STARTED_OK\\n" > /opt/app/start.sh\nchmod 644 /opt/app/start.sh',
    check: 'out=$(/opt/app/start.sh 2>/dev/null)\nif [ "$out" = "APP_STARTED_OK" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！脚本可执行"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还没执行权限（chmod u+x）"}\'\nfi',
    hints: ['ls -l 看权限', 'chmod u+x 或 755', '验证：./start.sh'],
    solution: 'ls -l /opt/app/start.sh\nchmod u+x /opt/app/start.sh\n/opt/app/start.sh'
  },
  {
    code: 'perm-service-user', name: '应用用户读不到配置', topic: 'linux', d: 2, sort: 22, g: ['chmod', 'chown'], mins: 30,
    scenario: '应用以 appuser 运行，但 /opt/app/config 权限是 root:root 600。\n任务：让 appuser 能读取 /opt/app/config（推荐最小权限做法），并让 start.sh 可执行。',
    setup: 'id -u appuser >/dev/null 2>&1 || useradd -m -s /bin/bash appuser\nmkdir -p /opt/app\necho "DB=local" > /opt/app/config\nchown root:root /opt/app/config; chmod 600 /opt/app/config\nprintf "#!/bin/bash\\necho ok\\n" > /opt/app/start.sh; chmod 644 /opt/app/start.sh',
    check: 'ok=1\nsu appuser -c \'cat /opt/app/config >/dev/null 2>&1\' || ok=0\n[ -x /opt/app/start.sh ] || ok=0\nif [ "$ok" = "1" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！appuser 可读且脚本可执行"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"验证：su appuser -c cat config；chmod +x start.sh"}\'\nfi',
    hints: ['测试读：su appuser -c "cat /opt/app/config"', '最小权限：chgrp appuser config && chmod 640', '执行位：chmod +x start.sh'],
    solution: 'chgrp appuser /opt/app/config\nchmod 640 /opt/app/config\nchmod +x /opt/app/start.sh\nsu appuser -c \'cat /opt/app/config && /opt/app/start.sh\''
  },
  {
    code: 'perm-web-dir', name: 'Web 目录权限修复', topic: 'linux', d: 2, sort: 23, g: ['权限'], mins: 30,
    scenario: 'Nginx 以 www-data 跑，站点目录 /var/www/shop 属 root 且无读权限，访问 403。\n任务：修正目录权限使 www-data 可读文件并可进入目录（保持 index.html 内容不变），并启动 nginx 使 curl 返回 200。',
    setup: 'mkdir -p /var/www/shop\necho "SHOP_OK" > /var/www/shop/index.html\nchown -R root:root /var/www/shop\nchmod -R 700 /var/www/shop\ncat > /etc/nginx/sites-available/shop <<EOF\nserver { listen 8090; root /var/www/shop; index index.html; }\nEOF\nln -sf /etc/nginx/sites-available/shop /etc/nginx/sites-enabled/shop',
    check: 'code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 3 http://127.0.0.1:8090/ 2>/dev/null)\nif [ "$code" = "200" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！站点 200"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"当前 http://127.0.0.1:8090/ 返回 \'$code\'（403=目录读/执行权限，其他=nginx未启动）"}\'\nfi',
    hints: ['403 是权限：目录需要 r+x（755），文件 r（644）', 'chmod -R 或分别处理', '启动：nginx（配置已就绪）'],
    solution: 'chmod 755 /var/www/shop\nchmod 644 /var/www/shop/index.html\nnginx\ncurl -s http://127.0.0.1:8090/'
  },
  {
    code: 'perm-shared-dir', name: '团队共享目录（SGID）', topic: 'linux', d: 3, sort: 24, g: ['SGID'], mins: 40,
    scenario: '两个用户 alice/bob 共用 /data/team，要求互相能读写对方新文件。\n任务：建立 team 组并加入两用户；给 /data/team 设置 SGID 和组权限，使 bob 创建的文件 alice 可写。',
    setup: 'id -u alice >/dev/null 2>&1 || useradd -m alice\nid -u bob >/dev/null 2>&1 || useradd -m bob\nmkdir -p /data/team\nchown root:root /data/team\nchmod 755 /data/team',
    check: 'su bob -c \'echo hello > /data/team/bob.txt\' 2>/dev/null\nw=$(su alice -c \'test -w /data/team/bob.txt && echo y || echo n\' 2>/dev/null)\nif [ "$w" = "y" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！SGID 共享目录生效"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"alice 仍不可写 bob 的文件（SGID 2775 + 同组）"}\'\nfi',
    hints: ['建组加人：groupadd team; usermod -aG team alice bob', 'SGID：chmod 2775 /data/team（目录新文件继承组）', 'bob 的默认 umask 可能 022——需要 umask 002 或 g+rw 补齐'],
    solution: 'groupadd team\nusermod -aG team alice; usermod -aG team bob\nchgrp team /data/team\nchmod 2775 /data/team\nsu bob -c \'umask 002; echo hello > /data/team/bob.txt\'\nsu alice -c \'echo edited >> /data/team/bob.txt && cat /data/team/bob.txt\''
  },
  {
    code: 'perm-suid-audit', name: 'SUID 文件安全审计', topic: 'linux', d: 2, sort: 25, g: ['SUID', '安全'], mins: 30,
    scenario: '安全基线：SUID 程序可能被提权利用。\n任务：找出 /opt/tools 下被设置了 SUID 的可疑脚本并去掉 SUID 位（保留普通权限）。',
    setup: 'mkdir -p /opt/tools\nprintf "#!/bin/bash\\nid\\n" > /opt/tools/check.sh\ncp /bin/ls /opt/tools/myls\nprintf "#!/bin/bash\\nwhoami\\n" > /opt/tools/info.sh\nchmod 4755 /opt/tools/check.sh /opt/tools/myls /opt/tools/info.sh\nchmod 755 /opt/tools/info.sh',
    check: 's=$(find /opt/tools -perm -4000 | wc -l)\nx=$(find /opt/tools -perm -1000 -type f | wc -l)\nif [ "$s" -eq 0 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！SUID 全部清除"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还剩 \'$s\' 个 SUID 文件（find -perm -4000）"}\'\nfi',
    hints: ['找 SUID：find /opt/tools -perm -4000', '去掉：chmod u-s 或 chmod 755', '验证再查一遍'],
    solution: 'find /opt/tools -perm -4000 -ls\nfind /opt/tools -perm -4000 -exec chmod u-s {} \\;\nfind /opt/tools -perm -4000 | wc -l'
  },
  {
    code: 'perm-umask', name: '修复默认权限（umask）', topic: 'linux', d: 2, sort: 26, g: ['umask'], mins: 30,
    scenario: '某用户 umask 被设成 077，新文件对同组完全不可读，导致协作故障。\n任务：使当前 shell 的 umask 为 022，并创建 /data/public/readme.txt 验证其权限为 644。',
    setup: 'mkdir -p /data/public\n# 无需预埋，任务在用户操作',
    check: 'p=$(stat -c %a /data/public/readme.txt 2>/dev/null)\nif [ "$p" = "644" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！默认权限恢复 644"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"readme.txt 当前权限 \'$p\'（要求 644）"}\'\nfi',
    hints: ['查看：umask', '设置：umask 022', '新建文件验证：stat -c %a'],
    solution: 'umask\numask 022\necho hi > /data/public/readme.txt\nstat -c %a /data/public/readme.txt'
  },
  {
    code: 'perm-ssh-keys', name: 'SSH 密钥权限修复', topic: 'linux', d: 2, sort: 27, g: ['ssh', '权限'], mins: 30,
    scenario: 'appuser 配了公钥登录但一直失败（sshd 严格校验权限）。\n任务：修正 /home/appuser/.ssh 与 authorized_keys 的权限属主，并启动 sshd，使密钥登录放行（sshd -t 校验通过即可判分）。',
    setup: 'id -u appuser >/dev/null 2>&1 || useradd -m -s /bin/bash appuser\nmkdir -p /home/appuser/.ssh\necho "ssh-ed25519 AAAAtest" > /home/appuser/.ssh/authorized_keys\nchown -R root:root /home/appuser/.ssh\nchmod 777 /home/appuser/.ssh\nchmod 666 /home/appuser/.ssh/authorized_keys\nmkdir -p /run/sshd',
    check: 'ok=1\n[ "$(stat -c %a /home/appuser/.ssh)" = "700" ] || ok=0\n[ "$(stat -c %a /home/appuser/.ssh/authorized_keys)" = "600" ] || ok=0\n[ "$(stat -c %U /home/appuser/.ssh/authorized_keys)" = "appuser" ] || ok=0\nif [ "$ok" = "1" ]; then echo \'{"pass":true,"score":100,"message":"完成！密钥权限规范"}\'\nelse echo \'{"pass":false,"score":0,"message":"要求 .ssh=700 authorized_keys=600 属主 appuser"}\'\nfi',
    hints: ['sshd 要求 .ssh 700、authorized_keys 600', '属主必须是本人：chown -R appuser:appuser', 'chmod 700 / 600'],
    solution: 'chown -R appuser:appuser /home/appuser/.ssh\nchmod 700 /home/appuser/.ssh\nchmod 600 /home/appuser/.ssh/authorized_keys\nls -la /home/appuser/.ssh'
  },

  // ========== 进程家族 ==========
  {
    code: 'proc-kill-loop', name: '清理失控循环进程', topic: 'linux', d: 1, sort: 28, g: ['ps', 'kill'], mins: 30,
    scenario: '机器卡顿：3 个失控 busy loop 吃满 CPU。\n任务：找出并终止全部失控进程，使高 CPU（>80%）进程数为 0。',
    setup: 'for i in 1 2 3; do setsid sh -c \'while :; do :; done\' >/dev/null 2>&1 < /dev/null & done\nsleep 2',
    check: 'sleep 3\nbusy=$(ps aux | awk \'$3 > 80 {c++} END{print c+0}\')\nif [ "$busy" -eq 0 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！CPU 恢复正常"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还有 \'$busy\' 个高CPU进程"}\'\nfi',
    hints: ['定位：top -bn1 或 ps aux --sort=-%cpu', '匹配命令行杀：pkill -9 -f "while"', '验证再查'],
    solution: 'ps aux --sort=-%cpu | head -5\npkill -9 -f "while :; do :; done"\nps aux | awk \'$3 > 80\' | wc -l'
  },
  {
    code: 'proc-zombie-parent', name: '僵尸进程清理', topic: 'linux', d: 2, sort: 29, g: ['僵尸'], mins: 30,
    scenario: '系统出现多个 Z 状态进程，PID 资源被占。\n任务：找出僵尸进程及其父进程，终止父进程让僵尸被回收（系统 Z 状态进程数 = 0）。',
    setup: 'printf "#!/bin/bash\\n/bin/sleep 300 &\\nsleep 1\\nkill -9 %s\\nwait\\n" "$!" > /tmp/badparent.sh 2>/dev/null || true\ncat > /tmp/badparent.sh <<EOF\n#!/bin/bash\n/bin/sleep 300 &\nsleep 1\nkill -9 \$!\nwhile :; do sleep 10; done\nEOF\nchmod +x /tmp/badparent.sh\nsetsid /tmp/badparent.sh >/dev/null 2>&1 < /dev/null &\nsleep 3',
    check: 'z=$(ps aux | awk \'$8 ~ /^Z/\' | wc -l)\nif [ "$z" -eq 0 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！僵尸已回收"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"还有 \'$z\' 个僵尸——杀它们的父进程"}\'\nfi',
    hints: ['找僵尸：ps aux | awk \'$8 ~ /^Z/\'', '看父进程：ps -o ppid= -p <zpid>', '杀父进程僵尸即被 init 回收'],
    solution: 'ps aux | awk \'$8 ~ /^Z/ {print $2}\' | head -1 | xargs -I{} ps -o pid,ppid,cmd -p {}\npkill -9 -f badparent.sh\nps aux | awk \'$8 ~ /^Z/\' | wc -l'
  },
  {
    code: 'proc-oom-trace', name: 'OOM 现场取证与修复', topic: 'linux', d: 2, sort: 30, g: ['OOM', 'dmesg'], mins: 30,
    scenario: '服务进程莫名消失，疑似被 OOM Kill。\n任务：1) 在 dmesg 里找到 OOM 记录确认被杀进程名 2) 把含该进程名的 OOM 行写入 /root/oom-evidence.txt 3) 用提供的启动脚本重启服务并确保进程存活。',
    setup: 'dmesg -c >/dev/null 2>&1 || true\necho "[ 1234.567 ] Out of memory: Killed process 666 (javabiz) total-vm:2048000kB\n[ 1234.568 ] oom_reaper: reaped process 666 (javabiz)" >> /dev/kmsg 2>/dev/null || echo "[ 1234.567 ] Out of memory: Killed process 666 (javabiz) total-vm:2048000kB" > /var/log/kern.log\ncat > /opt/app/start.sh <<EOF\n#!/bin/bash\nnohup sh -c \'while :; do sleep 5; done\' >/var/log/app.log 2>&1 &\necho \$! > /var/run/app.pid\nEOF\nchmod +x /opt/app/start.sh 2>/dev/null || { mkdir -p /opt/app && chmod +x /opt/app/start.sh; }',
    check: 'ok=1\ngrep -q javabiz /root/oom-evidence.txt 2>/dev/null || ok=0\nkill -0 "$(cat /var/run/app.pid 2>/dev/null)" 2>/dev/null || ok=0\nif [ "$ok" = "1" ]; then echo \'{"pass":true,"score":100,"message":"完成！证据留存且服务已恢复"}\'\nelse echo \'{"pass":false,"score":0,"message":"需要 oom 证据文件 + 存活的应用进程（/opt/app/start.sh）"}\'\nfi',
    hints: ['dmesg | grep -i "out of memory"（容器里也看 /var/log/kern.log）', '证据落盘：dmesg | grep javabiz > /root/oom-evidence.txt', '启动：/opt/app/start.sh'],
    solution: 'dmesg | grep -i oom || grep -i "out of memory" /var/log/kern.log\ndmesg 2>/dev/null | grep javabiz > /root/oom-evidence.txt || grep javabiz /var/log/kern.log > /root/oom-evidence.txt\n/opt/app/start.sh\ncat /root/oom-evidence.txt; kill -0 $(cat /var/run/app.pid) && echo ALIVE'
  },
  {
    code: 'proc-priority', name: '降低批任务优先级（nice）', topic: 'linux', d: 2, sort: 31, g: ['nice'], mins: 30,
    scenario: '凌晨批处理和在线服务抢 CPU。现有进程 batchjob 需要让路。\n任务：把已运行的 batchjob 进程 nice 值调到 19（最低优先级），不影响其运行。',
    setup: 'setsid sh -c \'exec -a batchjob sh -c "while :; do :; done"\' >/dev/null 2>&1 < /dev/null &\nsleep 2',
    check: 'pid=$(pgrep -f \'exec -a batchjob\' | head -1); [ -z "$pid" ] && pid=$(ps aux | grep [b]atchjob | awk \'{print $2}\' | head -1)\nn=$(ps -o ni= -p "$pid" 2>/dev/null | tr -d \' \')\nif [ -n "$pid" ] && [ "$n" = "19" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！已让路在线服务"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"当前 nice=\'$n\'（renice 19 -p PID）"}\'\nfi',
    hints: ['找 PID：ps aux | grep batchjob', '改优先级：renice 19 -p <pid>', '验证：ps -o ni,cmd -p <pid>'],
    solution: 'ps aux | grep [b]atchjob\nPID=$(ps aux | grep [b]atchjob | awk \'{print $2}\' | head -1)\nrenice 19 -p $PID\nps -o pid,ni,cmd -p $PID'
  },
  {
    code: 'proc-env-audit', name: '进程环境变量取证', topic: 'linux', d: 2, sort: 32, g: ['proc'], mins: 30,
    scenario: '怀疑某个进程的环境变量配置错了（连错数据库）。\n任务：找到运行中的 envapp 进程，查看其环境变量，把其中的 DB_HOST 值写入 /root/dbhost.txt。',
    setup: 'setsid env DB_HOST=10.0.0.99 DB_PORT=3306 APP_MODE=prod sh -c \'exec -a envapp sleep 600\' >/dev/null 2>&1 < /dev/null &\nsleep 1',
    check: 'if grep -q "10.0.0.99" /root/dbhost.txt 2>/dev/null; then\n  echo \'{"pass":true,"score":100,"message":"完成！取证正确"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"提示：/proc/<pid>/environ，tr \'\\\\0\' \'\\\\n\' 后 grep"}\'\nfi',
    hints: ['找 pid：pgrep -f envapp', '环境变量在 /proc/<pid>/environ（NUL分隔）', "tr '\\0' '\\n' < /proc/PID/environ | grep DB_HOST"],
    solution: "PID=$(pgrep -f envapp | head -1)\ntr '\\0' '\\n' < /proc/$PID/environ\ngrep DB_HOST= /proc/$PID/environ | tr '\\0' '\\n' | grep -o '10.0.0.99' > /root/dbhost.txt\ncat /root/dbhost.txt"
  },
  {
    code: 'proc-fd-leak', name: '文件句柄泄漏排查', topic: 'linux', d: 3, sort: 33, g: ['lsof', 'ulimit'], mins: 40,
    scenario: '应用报 Too many open files。\n任务：1) 查看 fdapp 进程打开了多少 fd（写入 /root/fdcount.txt） 2) 提高该进程用户的文件句柄限制说明文件位置（本题判分看 /root/fdcount.txt 内容为数字且 >100）。',
    setup: 'setsid sh -c \'exec -a fdapp bash -c "for i in \\$(seq 1 200); do eval \"exec \$i>/dev/null\"; done; sleep 600"\' >/dev/null 2>&1 < /dev/null &\nsleep 1',
    check: 'c=$(cat /root/fdcount.txt 2>/dev/null | grep -oE "^[0-9]+$" | head -1)\nif [ -n "$c" ] && [ "$c" -ge 100 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！fd 数量取证到位"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"统计该进程 fd 数（ls /proc/PID/fd | wc -l）写入 /root/fdcount.txt"}\'\nfi',
    hints: ['找 pid：pgrep -f fdapp', '统计：ls /proc/PID/fd | wc -l（或 lsof -p PID）', '永久调限：/etc/security/limits.conf 的 nofile'],
    solution: "PID=$(pgrep -f fdapp | head -1)\nls /proc/$PID/fd | wc -l\nls /proc/$PID/fd | wc -l > /root/fdcount.txt\ncat /root/fdcount.txt"
  },
  {
    code: 'proc-find-by-port', name: '谁占用了我的端口', topic: 'linux', d: 1, sort: 34, g: ['ss', '端口'], mins: 20,
    scenario: '要启动的服务绑不上 8081 端口（被占）。\n任务：找出占用 8081 的进程并终止它。',
    setup: 'setsid python3 -m http.server 8081 --directory /tmp >/dev/null 2>&1 < /dev/null &\nsleep 1',
    check: 'if ! ss -tln | grep -q ":8081 "; then\n  echo \'{"pass":true,"score":100,"message":"完成！端口已释放"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"8081 仍被占用（ss -tlnp | grep 8081）"}\'\nfi',
    hints: ['ss -tlnp | grep 8081 拿 PID', 'kill <pid>', '验证端口空出'],
    solution: 'ss -tlnp | grep 8081\nkill $(ss -tlnp | grep :8081 | grep -oP "pid=\\K[0-9]+" | head -1)\nss -tln | grep 8081 || echo FREE'
  },
  {
    code: 'proc-background-job', name: '后台任务与脱离会话', topic: 'linux', d: 2, sort: 35, g: ['nohup'], mins: 30,
    scenario: '需要一个长期任务在后台持续输出心跳。\n任务：以后台方式启动 /opt/task/beat.sh（脱离终端），并确保进程存活（判分时检查进程与日志文件持续增长）。',
    setup: 'mkdir -p /opt/task\ncat > /opt/task/beat.sh <<EOF\n#!/bin/bash\nwhile :; do\n  echo "beat \$(date +%T)" >> /var/log/beat.log\n  sleep 1\ndone\nEOF\nchmod +x /opt/task/beat.sh',
    check: 'sleep 3\np=$(pgrep -f beat.sh | head -1)\nl=$(wc -l < /var/log/beat.log 2>/dev/null || echo 0)\nif [ -n "$p" ] && [ "$l" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！心跳任务后台存活"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"nohup /opt/task/beat.sh & 方式启动"}\'\nfi',
    hints: ['直接运行会占终端且退出即死', 'nohup /opt/task/beat.sh >/dev/null 2>&1 &', '验证：pgrep -f beat.sh；tail /var/log/beat.log'],
    solution: 'nohup /opt/task/beat.sh >/dev/null 2>&1 &\npgrep -f beat.sh\ntail -3 /var/log/beat.log'
  },

  // ========== 磁盘与文件系统家族 ==========
  {
    code: 'disk-dir-size-map', name: '目录容量地图', topic: 'linux', d: 1, sort: 36, g: ['du'], mins: 30,
    scenario: '盘要满了，需要容量画像给老板看。\n任务：统计 /data 一级子目录大小，按从大到小写入 /root/size-report.txt（每行："大小MB 目录名"）。',
    setup: 'mkdir -p /data/logs /data/media /data/db\ndd if=/dev/zero of=/data/logs/a.log bs=1M count=30 status=none\ndd if=/dev/zero of=/data/media/v.mp4 bs=1M count=60 status=none\ndd if=/dev/zero of=/data/db/d.dat bs=1M count=15 status=none',
    check: 'if [ -f /root/size-report.txt ] && head -1 /root/size-report.txt | grep -q "media" && [ "$(wc -l < /root/size-report.txt)" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！容量画像生成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"首行应为最大的 media，共至少3行（du -sm /data/* | sort -rn）"}\'\nfi',
    hints: ['du -sm /data/* 单位MB', 'sort -rn 降序', '重定向到报告文件'],
    solution: 'du -sm /data/* | sort -rn\ndu -sm /data/* | sort -rn > /root/size-report.txt\ncat /root/size-report.txt'
  },
  {
    code: 'disk-log-rotate-manual', name: '手工日志轮转（truncate）', topic: 'linux', d: 2, sort: 37, g: ['日志'], mins: 30,
    scenario: '/var/log/app/server.log 8GB，进程持有句柄不能停。\n任务：不重启进程的前提下把日志清空（保留文件与句柄），使文件大小 < 1MB；并将内容归档到 /backup/server.log.old（先拷贝再清空）。',
    setup: 'mkdir -p /var/log/app /backup\nsetsid sh -c \'exec 3>/var/log/app/server.log; while :; do echo "line" >&3; sleep 1; done\' >/dev/null 2>&1 < /dev/null &\ndd if=/dev/zero of=/var/log/app/server.log bs=1M count=8 status=none',
    check: 'sz=$(du -sm /var/log/app/server.log | awk \'{print $1}\')\nb=$(du -sm /backup/server.log.old 2>/dev/null | awk \'{print $1}\')\nif [ "$sz" -lt 1 ] && [ "$b" -ge 7 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！句柄保留且已归档"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"日志 \'$sz\'MB、归档 \'$b\'MB（cp 后用 > file 截断，不能 rm）"}\'\nfi',
    hints: ['先归档：cp server.log /backup/server.log.old', '清空但保句柄：> /var/log/app/server.log', 'rm 会导致空间不释放——为什么？'],
    solution: 'cp /var/log/app/server.log /backup/server.log.old\n> /var/log/app/server.log\nls -lh /var/log/app/server.log /backup/server.log.old\nlsof /var/log/app/server.log | head -3'
  },
  {
    code: 'disk-file-held', name: '删除了文件但空间没释放', topic: 'linux', d: 2, sort: 38, g: ['lsof', '经典'], mins: 30,
    scenario: '同事 rm 了一个 5GB 日志但 df 没变化（进程还握着句柄）。\n任务：用 lsof 找到被删除仍被占用的文件，通过 /proc/<pid>/fd/N 清空它使空间释放（不允许杀进程，进程是关键服务）。',
    setup: 'mkdir -p /var/log/big\nsetsid sh -c \'exec 3>/var/log/big/held.log; sleep 600\' >/dev/null 2>&1 < /dev/null &\nsleep 1\nPID=$(pgrep -f "sleep 600" | head -1)\ndd if=/dev/zero of=/proc/$PID/fd/3 bs=1M count=5 status=none 2>/dev/null || true\nrm -f /var/log/big/held.log',
    check: 'h=$(df -m / | awk \'NR==2{print $3}\')\nleaked=$(lsof +L1 2>/dev/null | grep -c held.log || true)\nif [ "$leaked" = "0" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！句柄内文件已清空"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"仍被持有：lsof | grep deleted 找 fd，然后 > /proc/PID/fd/N"}\'\nfi',
    hints: ['定位：lsof +L1 或 lsof | grep deleted', '找到 PID 和 fd 号', '清空该 fd：> /proc/<pid>/fd/<n>'],
    solution: 'lsof +L1 | grep held\nPID=$(lsof +L1 | grep held.log | awk \'{print $2}\' | head -1)\nFD=$(lsof +L1 | grep held.log | awk \'{print $4}\' | head -1 | grep -oE "^[0-9]+")\n> /proc/$PID/fd/$FD\nlsof +L1 | grep held || echo released'
  },
  {
    code: 'disk-mount-info', name: '分区与挂载信息审计', topic: 'linux', d: 1, sort: 39, g: ['df', 'mount'], mins: 20,
    scenario: '写巡检报告需要分区信息。\n任务：把当前系统所有文件系统的"挂载点 使用率%"按 df 输出写入 /root/fs-report.txt（至少包含 / 一行）。',
    setup: 'echo ok',
    check: 'if [ -f /root/fs-report.txt ] && grep -qE "^/\\s|/" /root/fs-report.txt && [ "$(wc -l < /root/fs-report.txt)" -ge 1 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！分区报告生成"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"df -h > /root/fs-report.txt"}\'\nfi',
    hints: ['df -h', '含挂载点与百分比', '写入报告'],
    solution: 'df -h\ndf -h > /root/fs-report.txt\ncat /root/fs-report.txt'
  },
  {
    code: 'disk-tmp-clean-policy', name: '临时目录清理策略落地', topic: 'linux', d: 2, sort: 40, g: ['find', 'tmp'], mins: 30,
    scenario: '/tmp 塞满了 48 小时前的旧会话文件。\n任务：删除 /tmp 下修改时间超过 2 天的 sess_* 文件，保留新文件与无关文件。',
    setup: 'mkdir -p /tmp\necho a > /tmp/sess_001; touch -d "3 days ago" /tmp/sess_001\necho b > /tmp/sess_002; touch -d "5 days ago" /tmp/sess_002\necho c > /tmp/sess_003\necho keep > /tmp/build.cache',
    check: 'old=$(find /tmp -name "sess_*" -mtime +2 | wc -l)\nnew=$(ls /tmp/sess_003 2>/dev/null | wc -l)\nc=$(ls /tmp/build.cache 2>/dev/null | wc -l)\nif [ "$old" = "0" ] && [ "$new" = "1" ] && [ "$c" = "1" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！策略精准执行"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"旧 sess 没清干净或误删了新文件"}\'\nfi',
    hints: ['2天前：-mtime +2', '只匹配 sess_*', '先预览再删'],
    solution: 'find /tmp -name "sess_*" -mtime +2 -ls\nfind /tmp -name "sess_*" -mtime +2 -delete\nls -la /tmp'
  },
  {
    code: 'user-create-service', name: '创建服务账号（最小权限）', topic: 'linux', d: 1, sort: 41, g: ['useradd'], mins: 20,
    scenario: '要部署新服务，按规范建专用账号。\n任务：创建系统账号 deploy（不可登录 shell /sbin/nologin，无家目录或默认均可），并验证 id deploy 存在。',
    setup: 'id -u deploy >/dev/null 2>&1 && userdel -r deploy 2>/dev/null; echo ok',
    check: 'if id deploy >/dev/null 2>&1 && [ "$(getent passwd deploy | cut -d: -f7)" = "/sbin/nologin" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！最小权限账号就绪"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"useradd -r -s /sbin/nologin deploy"}\'\nfi',
    hints: ['系统账号：useradd -r', '禁止登录：-s /sbin/nologin', '验证：id deploy; getent passwd deploy'],
    solution: 'useradd -r -s /sbin/nologin deploy\nid deploy\ngetent passwd deploy'
  },
  {
    code: 'user-sudo-grant', name: '受限 sudo 授权', topic: 'linux', d: 3, sort: 42, g: ['sudo'], mins: 40,
    scenario: '运维组新人 ops1 需要能免密重启 nginx，但不能做别的 root 操作。\n任务：给 ops1 配置仅允许免密执行 systemctl restart nginx 的 sudo 规则（写入 /etc/sudoers.d/ops1，权限 440）。',
    setup: 'id -u ops1 >/dev/null 2>&1 || useradd -m -s /bin/bash ops1\nrm -f /etc/sudoers.d/ops1',
    check: 'if [ -f /etc/sudoers.d/ops1 ] && [ "$(stat -c %a /etc/sudoers.d/ops1)" = "440" ] && grep -q "systemctl restart nginx" /etc/sudoers.d/ops1 && grep -q "NOPASSWD" /etc/sudoers.d/ops1; then\n  echo \'{"pass":true,"score":100,"message":"完成！最小授权配置正确"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"/etc/sudoers.d/ops1 需 440 且含 NOPASSWD: systemctl restart nginx"}\'\nfi',
    hints: ['格式：ops1 ALL=(root) NOPASSWD: /usr/bin/systemctl restart nginx（容器无systemd也按路径写）', '权限必须 440', '语法校验：visudo -c'],
    solution: 'echo \'ops1 ALL=(root) NOPASSWD: /usr/bin/systemctl restart nginx\' > /etc/sudoers.d/ops1\nchmod 440 /etc/sudoers.d/ops1\nvisudo -c\nsu ops1 -c \'sudo -l\''
  },
  {
    code: 'text-csv-report', name: 'CSV 报表统计', topic: 'shell', d: 2, sort: 43, g: ['awk'], mins: 30,
    scenario: '/data/sales.csv 格式：日期,城市,金额。\n任务：统计总金额写入 /root/total.txt（纯数字）。',
    setup: 'mkdir -p /data\ncat > /data/sales.csv <<EOF\n2026-10-01,bj,1200\n2026-10-02,sh,3400\n2026-10-03,bj,800\n2026-10-04,gz,2600\nEOF',
    check: 't=$(grep -oE "[0-9]+" /root/total.txt 2>/dev/null | head -1)\nif [ "$t" = "8000" ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！合计正确"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"总金额应为 8000（awk -F, 求和第3列）"}\'\nfi',
    hints: ['分隔符：awk -F, ', '求和：awk -F, \'{s+=$3} END{print s}\'', '写入文件'],
    solution: 'awk -F, \'{s+=$3} END{print s}\' /data/sales.csv\nawk -F, \'{s+=$3} END{print s}\' /data/sales.csv > /root/total.txt\ncat /root/total.txt'
  },
  {
    code: 'text-top-url', name: '访问日志 TOP10 URL', topic: 'shell', d: 2, sort: 44, g: ['awk', '必考'], mins: 30,
    scenario: '性能分析需要热点接口。\n任务：统计 /var/log/app/access.log 第 7 列 URL 的 TOP10（次数降序）写入 /root/top-url.txt。',
    setup: 'mkdir -p /var/log/app\nfor i in $(seq 1 50); do echo "10.0.0.1 - - [x] \\"GET /api/a HTTP/1.1\\" 200"; done > /var/log/app/access.log\nfor i in $(seq 1 30); do echo "10.0.0.2 - - [x] \\"GET /api/b HTTP/1.1\\" 200"; done >> /var/log/app/access.log\nfor i in $(seq 1 12); do echo "10.0.0.3 - - [x] \\"GET / HTTP/1.1\\" 200"; done >> /var/log/app/access.log',
    check: 'if [ -f /root/top-url.txt ] && head -1 /root/top-url.txt | grep -q "/api/a" && [ "$(wc -l < /root/top-url.txt)" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！TOP URL 统计正确"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"四件套：awk取列 | sort | uniq -c | sort -rn | head"}\'\nfi',
    hints: ['第7列：awk \'{print $7}\'', 'sort | uniq -c | sort -rn', 'head -10 落盘'],
    solution: "awk '{print $7}' /var/log/app/access.log | sort | uniq -c | sort -rn | head -10 > /root/top-url.txt\ncat /root/top-url.txt"
  },
  {
    code: 'text-error-extract', name: '错误日志聚类', topic: 'shell', d: 2, sort: 45, g: ['grep', 'awk'], mins: 30,
    scenario: '上千行日志要快速知道有哪些异常类。\n任务：提取 /var/log/app/app.log 中所有 ERROR 行的错误码（如 ERR-xxx）并去重计数，写入 /root/errors.txt（按次数降序）。',
    setup: 'mkdir -p /var/log/app\nfor i in $(seq 1 20); do echo "INFO ok"; echo "ERROR ERR-1001 db timeout"; done > /var/log/app/app.log\nfor i in $(seq 1 8); do echo "ERROR ERR-2002 cache miss"; done >> /var/log/app/app.log\nfor i in $(seq 1 3); do echo "WARN slow"; echo "ERROR ERR-3003 null"; done >> /var/log/app/app.log',
    check: 'if [ -f /root/errors.txt ] && head -1 /root/errors.txt | grep -q "ERR-1001" && [ "$(wc -l < /root/errors.txt)" -ge 3 ]; then\n  echo \'{"pass":true,"score":100,"message":"完成！错误聚类正确"}\'\nelse\n  echo \'{"pass":false,"score":0,"message":"grep ERROR 取错误码 | sort | uniq -c | sort -rn"}\'\nfi',
    hints: ['过滤：grep ERROR', '提取错误码：awk \'{for(i=1;i<=NF;i++) if($i ~ /^ERR-/) print $i}\' 或 grep -o', 'uniq -c 计数排序'],
    solution: "grep ERROR /var/log/app/app.log | grep -oE 'ERR-[0-9]+' | sort | uniq -c | sort -rn > /root/errors.txt\ncat /root/errors.txt"
  },
]
