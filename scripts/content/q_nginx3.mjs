// Nginx 第三批
export const Q = [
  { t: 'C', d: 1, q: 'try_files $uri $uri/ /index.html 的作用？', o: ['A. 静态优先，回退SPA入口（前端路由）', 'B. 压缩', 'C. 限流', 'D. 反代'], a: 'A。Vue/React history 路由刷新 404 的标准修复。', g: ['配置', '必考'] },
  { t: 'C', d: 1, q: 'access_log off 是？', o: ['A. 该 location 不记访问日志', 'B. 关错误日志', 'C. 停nginx', 'D. 清空日志'], a: 'A。健康检查路径常关日志防刷盘。error_log 不能 off（可 /dev/null）。', g: ['配置'] },
  { t: 'C', d: 2, q: 'proxy_redirect 什么时候需要？', o: ['A. 后端 3xx 的 Location 重写（内网地址暴露时）', 'B. 日常必配', 'C. 限流', 'D. 静态'], a: 'A。后端返回 http://10.0.0.1:8080/xxx 需改写为对外域名。', g: ['配置', '进阶'] },
  { t: 'C', d: 2, q: 'X-Accel-Redirect 是什么？', o: ['A. 后端控制网关内网读文件下载（X-Sendfile）', 'B. 重定向301', 'C. 加速静态', 'D. 熔断'], a: 'A。鉴权后让 Nginx 直接发文件，后端不流经文件流。', g: ['进阶'] },
  { t: 'C', d: 2, q: 'deny/allow 生效顺序？', o: ['A. 顺序匹配第一个命中即止', 'B. allow优先', 'C. deny优先', 'D. 随机'], a: 'A。写反了会全 deny——配完必测。', g: ['安全'] },
  { t: 'C', d: 2, q: 'nginx -T 的用途？', o: ['A. 输出展开后的完整配置（含include）', 'B. 仅测试', 'C. 重启', 'D. 版本'], a: 'A。-t 是测试，-T 测试并打印全量——排查"配置到底加载了啥"。', g: ['排障'] },
  { t: 'QA', d: 2, q: 'Nginx 配置了 HTTPS 但报 "ssl certificate not found"，检查什么？', a: '1. 证书/私钥路径与属主权限（worker 用户可读，私钥建议 600 root）\n2. fullchain 含中间证书\n3. listen 443 ssl 语法（老版本需显式 ssl）\n4. nginx -T 看最终加载\n5. 磁盘/SELinux 拦截读取', g: ['排障'] },
  { t: 'QA', d: 2, q: '为什么 nginx -s reload 后旧 worker 还在（存在几分钟）？', a: '正常现象：旧 worker 优雅退出——处理完存量连接才退出。长连接（WebSocket）会一直挂着：可 worker_shutdown_timeout 或让客户端重连。看 worker 代际：ps 里新旧行并存。', g: ['原理', '进阶'] },
  { t: 'QA', d: 3, q: '给 Nginx 添加第三方模块（如 brotli）的正确姿势？', a: '需编译进二进制：下载源码 ./configure --add-module=... --with原有参数 && make，替换二进制后热升级（USR2）。apt 版无法动态加（部分模块支持 dynamic module --add-dynamic-module+load_module）。体现对二进制交付物的理解。', g: ['进阶'] },
]
