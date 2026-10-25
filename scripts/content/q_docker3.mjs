// Docker 第三批
export const Q = [
  { t: 'C', d: 1, q: 'docker pull 的镜像存储位置？', o: ['A. /var/lib/docker/overlay2', 'B. /opt/images', 'C. /var/images', 'D. /usr/docker'], a: 'A。可用 data-root 迁移到数据盘（防止系统盘被镜像吃满）。', g: ['运维'] },
  { t: 'C', d: 1, q: 'docker top 容器 与 docker exec ps 的关系？', o: ['A. 前者从宿主视角看容器进程', 'B. 相同', 'C. 后者更全', 'D. 前者是镜像'], a: 'A。容器内外 PID 不同（namespace），排查时对齐两视角。', g: ['原理'] },
  { t: 'C', d: 2, q: '容器内看不到 ps/curl 等工具，怎么办？', o: ['A. docker cp 拷静态工具进去 / kubectl debug 临时容器 / 宿主 nsenter', 'B. 没办法', 'C. 重打镜像必然', 'D. 重启容器'], a: 'A。distroless 镜像的排障姿势（拷 busybox 静态二进制）。', g: ['排障', '进阶'] },
  { t: 'C', d: 2, q: '容器内存 limit 与 JVM -Xmx 的关系最佳实践？', o: ['A. Xmx ≈ limit 的 70%（留堆外/元空间/线程栈）', 'B. Xmx=limit', 'C. 不设Xmx', 'D. limit越大越好'], a: 'A。或 MaxRAMPercentage=70。Xmx=limit 必 OOMKill。', g: ['调优', '必坑'] },
  { t: 'C', d: 2, q: 'docker run --rm 的语义？', o: ['A. 容器退出即自动删除（临时容器）', 'B. 强制删除运行中', 'C. 清理镜像', 'D. 免重启'], a: 'A。一次性任务容器标配，防堆积。', g: ['命令'] },
  { t: 'C', d: 3, q: '容器访问宿主服务（宿主端口仅127.0.0.1监听）的方式？', o: ['A. host.docker.internal / 网关IP 172.17.0.1（需监听0.0.0.0或用host网络）', 'B. 容器直接127.0.0.1', 'C. 不可能', 'D. 必须公网'], a: 'A。容器里的 localhost 是容器自己——高频认知坑。', g: ['网络', '坑'] },
  { t: 'QA', d: 2, q: '如何让容器随 Docker 开机自启？', o: undefined, a: '1. run 时 --restart unless-stopped（always 也随守护进程拉起）\n2. compose 里 restart: unless-stopped\n3. 依赖顺序靠 depends_on+健康检查\n注意：手动 stop 后 unless-stopped 不再拉起（区别 always），符合运维直觉。', g: ['运维'] },
  { t: 'QA', d: 3, q: '镜像层只读、容器层可写，那容器里 apt install 的东西去哪了？重启还在吗？', a: '写在容器可写层：重启容器（docker restart）还在；**删除容器重建（compose up 重建）就没了**——这就是"不可变基础设施"要义：变更进镜像（Dockerfile），不进容器运行时。临时装包只应急用。', g: ['原理', '素养'] },
]
