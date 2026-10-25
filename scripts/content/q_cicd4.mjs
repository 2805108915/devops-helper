// cicd4 快问快答
export const Q = [
  { t: 'C', d: 1, q: 'git remote -v 查看？', o: ['A. 远端仓库地址', 'B. 分支', 'C. 日志', 'D. 标签'], a: 'A。push 没权限/推错库先看它。', g: ['Git'] },
  { t: 'C', d: 1, q: 'git branch -d 与 -D？', o: ['A. -d 未合并拒绝；-D 强删', 'B. 相同', 'C. -D安全', 'D. 都强删'], a: 'A。误删分支可 reflog 找回。', g: ['Git'] },
  { t: 'C', d: 1, q: 'git stash drop 与 pop？', o: ['A. 删除暂存 / 恢复并删除', 'B. 相同', 'C. pop不删', 'D. drop恢复'], a: 'A。apply 恢复但保留暂存。', g: ['Git'] },
  { t: 'C', d: 2, q: 'CI 里并发限制同一分支只跑一个的配置？', o: ['A. concurrency 组（actions）/ disableConcurrentBuilds（jenkins）', 'B. 不支持', 'C. 手动等待', 'D. 加锁脚本'], a: 'A。防资源浪费与部署互相踩。', g: ['工具'] },
  { t: 'C', d: 2, q: '预发环境与生产环境配置差异应该怎么管理？', o: ['A. 同一模板+环境覆盖文件（kustomize/helm values）', 'B. 复制粘贴yml', 'C. 生产手改', 'D. 无差别'], a: 'A。手改=漂移之源；GitOps 化管理环境差异。', g: ['配置', '素养'] },
  { t: 'QA', d: 2, q: 'git 提交信息写 "fix bug" 有什么问题？', a: '无法检索、无法追溯动机、changelog 无法生成。规范：type(scope): subject（如 fix(pay): 修复重复扣款），正文写为什么这么改。信息是给半年后的自己与同事看的。', g: ['规范'] },
  { t: 'QA', d: 2, q: '发布后如何确认"真的成功了"（验证清单）？', a: '1. 版本指纹：响应头/health 接口返回的版本号=预期\n2. 指标：错误率/延迟/QPS 无异常波动\n3. 日志：无新增异常栈\n4. 业务抽样：核心链路人工/自动化走一遍\n5. 分批发布：确认比例（kubectl rollout status / 灰度百分比）\n"部署完成≠发布成功"。', g: ['素养', '必考'] },
  { t: 'QA', d: 3, q: 'jenkins agent 与 K8s 动态 agent 的区别与收益？', a: '静态 agent：常驻、占资源、环境固定；K8s 动态（kubernetes plugin）：按 job 起 Pod、用完即焚、环境镜像化一致、并发弹性。配合镜像缓存加速。这是"CI 容器化"的标准演进路径。', g: ['工具', '进阶'] },
]
