-- 题库种子：Linux 基础（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(1, 'QA', 1, '你日常常用的 Linux 命令有哪些？分别什么场景用？', NULL,
 '按场景归类回答更有条理：\n\n**文件操作**：`ls / cd / cp / mv / rm / find / mkdir`\n**查看文件**：`cat / less / head / tail`（`tail -f` 追踪日志）\n**文本处理三剑客**：`grep` 过滤、`awk` 按列处理、`sed` 替换\n**进程**：`ps -ef`、`ps aux`、`top / htop`、`kill`\n**网络**：`ss -tlnp`（端口占用）、`curl`、`ping`、`tcpdump`\n**磁盘**：`df -h`（分区使用率）、`du -sh`（目录大小）\n**系统**：`uptime`、`free -h`、`dmesg`（内核日志）\n\n面试技巧：不要只报菜名，每个带一个真实使用场景，比如"排查 CPU 高时我用 top -Hp <pid> 找线程，再 jstack 定位代码行"。',
 '["vmstat 和 top 的区别？", "怎么查看一个端口被哪个进程占用？"]', '["基础", "高频"]', 5, '["junior-ops", "devops", "sre"]'),

(1, 'QA', 1, '软链接和硬链接的区别？', NULL,
 '**硬链接**：`ln a b`。多个文件名指向同一个 inode，删除其中一个不影响其他；不能跨文件系统、不能对目录创建。\n\n**软链接**：`ln -s a b`。类似 Windows 快捷方式，存的是路径；源文件删除后软链接失效（悬空）；可跨文件系统、可链目录。\n\n**判断方法**：`ls -li` 看 inode 号，硬链接 inode 相同；软链接权限位开头是 `l`。',
 '["什么场景下用软链接？"]', '["文件系统"]', 3, '["junior-ops", "devops"]'),

(1, 'QA', 1, '文件权限 rwx 怎么理解？755、644 分别是什么？', NULL,
 '权限分三组：**属主 u / 属组 g / 其他 o**，每组三位：r=4（读）、w=2（写）、x=1（执行）。\n\n- `755` = rwxr-xr-x：属主全权限，其他可读和执行（目录和脚本常用）\n- `644` = rw-r--r--：属主可读写，其他只读（普通文件常用）\n\n常用命令：`chmod 755 file`、`chmod +x file`、`chmod -R` 递归；`chown user:group file` 改归属。\n\n注意：对目录来说，x 权限表示能否进入（cd），r 只表示能 ls。',
 '["chmod 777 为什么危险？", "大写 S/T 权限位是什么？"]', '["基础", "权限"]', 4, '["junior-ops", "devops"]'),

(1, 'QA', 2, 'kill -9 和 kill -15 有什么区别？生产上应该先用哪个？', NULL,
 '`kill` 默认发 **SIGTERM(15)**：通知进程"请退出"，进程可以做清理（关连接、刷盘）后退出，是**优雅停止**。\n\n`kill -9`（SIGKILL）：内核直接终止进程，**进程无法捕获和清理**，可能丢数据、留脏状态（如内存不足时的锁文件）。\n\n生产顺序：先 `kill -15`，等几秒确认没退出再 `-9`。Docker/K8s 停容器的机制同理：先 SIGTERM，宽限期（grace period）后仍存活才 SIGKILL。',
 '["kill -HUP 常用来干什么？", "信号 9 为什么不能被捕获？"]', '["进程", "高频"]', 4, '["junior-ops", "devops", "sre"]'),

(1, 'QA', 2, '什么是僵尸进程和孤儿进程？怎么产生的、怎么处理？', NULL,
 '**僵尸进程**：子进程已退出，但父进程没调用 wait() 回收，子进程的进程表项（含退出状态）残留。危害：占用 PID 资源，多了会无法创建新进程。\n\n**孤儿进程**：父进程先退出，子进程还在运行，被 init/systemd（PID 1）收养，最终能正常回收，**基本无害**。\n\n处理僵尸：\n1. 找出：`ps aux | awk ''$8=="Z"''` 或 `ps -ef | grep defunct`\n2. 根治：杀掉或修复**父进程**（父进程退出后僵尸由 init 回收）\n3. 代码层面：父进程用 wait/waitpid 或注册 SIGCHLD 处理器',
 '["容器里 PID 1 是谁，僵尸进程谁回收？"]', '["进程"]', 3, '["junior-ops", "sre"]'),

(1, 'QA', 2, 'load average 是什么？多高算高？', NULL,
 '`uptime`/`top` 显示的 1/5/15 分钟负载，Linux 下 = **可运行进程数 + 不可中断睡眠（D 状态，多为 IO 等待）进程数**，是 CPU 和 IO 压力的综合体现。\n\n经验值：负载 ≈ CPU 核数是满载临界。如 8 核机器，load 8 表示刚好打满，>8 说明在排队。\n\n排查顺序：\n1. `top` 看是 CPU 高还是 `wa`（iowait）高\n2. CPU 高 → 找进程；iowait 高 → `iostat -x` 看磁盘、`df -h` 看是否写满',
 '["CPU 使用率不高但 load 很高，可能是什么问题？"]', '["性能", "高频"]', 4, '["junior-ops", "sre"]'),

(1, 'SCENARIO', 2, '线上服务器 CPU 飙到 100%，你的排查思路？', '告警显示某台 8 核服务器 CPU 持续 100%，上面的 Java 服务响应变慢。',
 '经典必考题，答题框架：**先定位是谁，再定位是什么，最后决定怎么办**。\n\n1. `top` 找出 CPU 最高的进程，确认是不是业务进程（还是被挖矿木马占了，运维安全意识加分）\n2. 若是 Java：`top -Hp <pid>` 找最耗 CPU 的**线程**，线程号转 16 进制（`printf "%x" TID`），再到 `jstack <pid> | grep -A 20 <hex>` 定位到具体代码行\n3. 若是其他进程：`pidstat -p <pid> 1` 看是用户态（us）还是内核态（sy）高\n4. **应急与根治分开**：先重启/限流恢复服务（止血），再根据定位修代码或扩容（根因）\n\n加分点：提到"先止血再根因"、提到 us/sy/wa 的含义。',
 '["如果是 IO wait 高呢？", "怎么区分是流量暴涨还是代码死循环？"]', '["排障", "必考"]', 5, '["junior-ops", "sre", "devops"]'),

(1, 'SCENARIO', 2, '磁盘空间满了，怎么排查？为什么有时删了文件空间没释放？', '监控告警：根分区使用率 100%，写入全部失败。',
 '1. `df -h` 确认哪个分区满了\n2. 逐层定位大文件：`du -sh /* 2>/dev/null | sort -rh | head`，逐层往下找，常用命令：`du -sh /var/* | sort -rh`\n3. 常见元凶：日志没切割（/var/log）、core dump、大临时文件、yum/apt 缓存\n4. 清理后 `df -h` 确认\n\n**删了文件空间不释放**：文件被进程持有（比如服务还在往已删除的日志写）。inode 没释放，空间就不会回收。定位：`lsof | grep deleted`。解决：重启/重载对应进程，或用 `> /proc/<pid>/fd/<n>` 清空该文件描述符。\n\n加分：提到 `df -i` 看 inode 是否耗尽（小文件过多场景）。',
 '["inode 用满了但磁盘没满，怎么回事？"]', '["排障", "必考"]', 5, '["junior-ops", "devops", "sre"]'),

(1, 'QA', 1, '怎么找出 7 天前的日志文件并删除？', NULL,
 '```\nfind /var/log/app -name "*.log" -mtime +7 -delete\n```\n\n或先预览再删（生产建议）：\n```\nfind /var/log/app -name "*.log" -mtime +7 -exec ls -lh {} \\;\nfind /var/log/app -name "*.log" -mtime +7 | xargs rm -f\n```\n\n要点：`-mtime +7` 表示修改时间在 7 天前；`-exec ... {} \\;` 与 xargs 的区别（exec 逐个执行，xargs 批量拼参数，文件名有空格时 xargs 要加 `-d ''\\n''`）。',
 '["-mtime +7 和 -mtime 7 的区别？", "文件名带空格时 xargs 会出什么问题？"]', '["find", "实战"]', 4, '["junior-ops", "devops"]'),

(1, 'QA', 1, 'systemd 管理服务的常用命令？怎么让服务开机自启？', NULL,
 '以 nginx 为例：\n\n- 启动/停止/重启：`systemctl start|stop|restart nginx`\n- 优雅重载配置：`systemctl reload nginx`\n- 开机自启：`systemctl enable nginx`（disable 取消）\n- 查看状态：`systemctl status nginx`\n- 查看日志：`journalctl -u nginx -f`（`-f` 跟随，`--since "10 min ago"` 看最近）\n\n加粗考点：restart 会断连接，reload 不中断（发 SIGHUP 重读配置）。',
 '["写一个自定义 systemd 服务单元需要哪些字段？", "journalctl 怎么看上一次启动的日志？"]', '["systemd", "高频"]', 4, '["junior-ops", "devops"]');
