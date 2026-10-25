// docker4 快问快答
export const Q = [
  { t: 'C', d: 1, q: 'docker version 与 docker info 的区别？', o: ['A. 客户端/服务端版本 vs 引擎全局状态（存储驱动/容器数）', 'B. 相同', 'C. 后者只看版本', 'D. 前者看容器'], a: 'A。排 Docker 环境问题先 info。', g: ['命令'] },
  { t: 'C', d: 1, q: 'docker images 的 <none> 镜像是？', o: ['A. 悬空镜像（旧层/构建残留）', 'B. 病毒', 'C. 系统镜像', 'D. 运行中'], a: 'A。docker image prune 清理。', g: ['运维'] },
  { t: 'C', d: 1, q: 'docker run -v /data 的效果？', o: ['A. 匿名卷（Docker随机命名管理）', 'B. 挂载宿主/data', 'C. 只读', 'D. 报错'], a: 'A。与 -v name:/data（命名卷）、-v /host:/c（bind）三态区分。', g: ['存储'] },
  { t: 'C', d: 2, q: 'docker logs -f 与 docker events 的区别？', o: ['A. 单容器日志 vs 引擎事件流（启停/挂载等动作）', 'B. 相同', 'C. 前者引擎级', 'D. 后者是日志'], a: 'A。"容器为什么重启了"查 events。', g: ['排障'] },
  { t: 'C', d: 2, q: '容器退出后 docker start 回来，数据在吗？', o: ['A. 在（可写层保留）；rm 后才丢', 'B. 丢失', 'C. 部分丢', 'D. 卷才保留'], a: 'A。重建（run 新容器/up --force-recreate）=新可写层，数据只在 volume 里持久。', g: ['原理', '必考'] },
  { t: 'C', d: 2, q: 'compose 里 env_file 与 environment 的优先级？', o: ['A. environment 覆盖 env_file', 'B. 反', 'C. 相同', 'D. 报错'], a: 'A。分层配置：公共 env_file + 环境差异化 environment。', g: ['compose'] },
  { t: 'C', d: 3, q: '容器内时间是 UTC，应用要 CST，最快修法？', o: ['A. -e TZ=Asia/Shanghai（镜像含tzdata）或 Dockerfile ENV TZ', 'B. 改宿主机即可', 'C. 每次手动date', 'D. 无法'], a: 'A。日志时间差 8 小时的根治；镜像缺 tzdata 则需装或用带时区的镜像。', g: ['坑', '高频'] },
  { t: 'QA', d: 2, q: '为什么 docker exec 修改容器文件不持久到镜像？如何持久？', a: '可写层属于容器实例：commit 可固化但不推荐；正规是改 Dockerfile 重建（可审计可复现）。"运行时改"只应急。', g: ['素养'] },
  { t: 'QA', d: 3, q: '如何限制容器日志与磁盘写入（防写满宿主盘）？', a: '1. 日志：daemon.json log-driver json-file + max-size/max-file\n2. 容器写大量数据：--mount readonly 或挂专用 volume 到数据盘\n3. 构建残留：定期 prune + buildkit 缓存上限\n4. 监控：docker system df 采集告警\n原则：容器是"易耗品"，大文件流不放可写层。', g: ['运维', '实战'] },
]
