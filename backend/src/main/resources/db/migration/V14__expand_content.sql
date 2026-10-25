-- 自动生成（scripts/content/gen.mjs），请勿手改

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(7, 'CHOICE', 1, 'git 中 HEAD 指向？', NULL, '[\"A. 最新tag\",\"B. 当前分支的最新提交（检出位置）\",\"C. 远端main\",\"D. 第一个提交\"]', 'B。detached HEAD 时指向具体提交。reflog 记录 HEAD 移动历史（救命的命令）。', NULL, '[\"Git\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'git merge --no-ff 的效果？', NULL, '[\"A. 快进合并\",\"B. 强制生成merge commit（保留分支历史形状）\",\"C. 压缩提交\",\"D. 不产生提交\"]', 'B。squash 是把分支所有提交压成一个。三者区别是流水的必考题。', NULL, '[\"Git\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '撤销已 push 的公共分支提交，安全的命令？', NULL, '[\"A. git reset --hard + push -f\",\"B. git revert <commit>\",\"C. git checkout .\",\"D. rm .git\"]', 'B。revert 生成反向提交不改写历史；公共分支 force push 是事故之源（必须时用 --force-with-lease）。', NULL, '[\"Git\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, '.gitignore 已跟踪的文件删除后仍被跟踪？', NULL, '[\"A. 正常，ignore只对未跟踪文件生效，需 git rm --cached\",\"B. bug\",\"C. 重启\",\"D. 改文件名\"]', 'A。```
git rm --cached config.properties   # 从版本库移除保留本地
```典型场景：误提交了密钥（历史里还在需 filter-repo 清理+轮换密钥！）。', NULL, '[\"Git\",\"坑\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'git pull --rebase 与 git pull 的区别？', NULL, '[\"A. 无区别\",\"B. rebase把本地提交重放到远端之上，历史线性\",\"C. pull更快\",\"D. rebase保留merge点\"]', 'B。团队规范常见"pull 永远带 --rebase"避免无意义 merge commit。黄金法则：**公共分支不 rebase**。', NULL, '[\"Git\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, 'CI 的核心价值？', NULL, '[\"A. 编译更快\",\"B. 频繁集成+自动化验证，尽早暴露问题\",\"C. 省服务器\",\"D. 代码更漂亮\"]', 'B。每次提交自动构建+测试，把"上线前大爆炸"变成"提交即反馈"。', NULL, '[\"概念\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '持续交付与持续部署的区别？', NULL, '[\"A. 一样\",\"B. 交付=随时可一键上生产；部署=通过即自动上生产\",\"C. 交付更高级\",\"D. 部署手动\"]', 'B。区别就在"最后一步是否需要人点按钮"。', NULL, '[\"概念\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '蓝绿发布最大的代价？', NULL, '[\"A. 慢\",\"B. 双倍资源占用\",\"C. 回滚慢\",\"D. 无法测试\"]', 'B。两套全量环境换流量（换来的是秒级切换/回滚）。', NULL, '[\"发布\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '金丝雀发布判断"继续放量"的依据？', NULL, '[\"A. 感觉\",\"B. 核心指标（错误率/延迟/业务量）对比基线无劣化\",\"C. 时间到\",\"D. 老板说\"]', 'B。灰度的本质是小流量真实实验，指标护航（自动分析=渐进式交付 Argo Rollouts/Flagger）。', NULL, '[\"发布\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'GitHub Actions 中 workflow 的触发定义在？', NULL, '[\"A. .github/workflows/*.yml 的 on:\",\"B. package.json\",\"C. Jenkinsfile\",\"D. Dockerfile\"]', 'A。on: push/pull_request/schedule/cron；job→step→action/命令；runner 执行。', NULL, '[\"工具\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'Jenkins 主从架构中 agent 的作用？', NULL, '[\"A. 备份\",\"B. 分布执行构建任务（标签调度）\",\"C. 界面\",\"D. 存储\"]', 'B。master 管调度UI，agent 跑活（不同环境打标签：jdk17/docker）。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '制品库（如 Harbor）解决的核心问题？', NULL, '[\"A. 代码托管\",\"B. 制品不可变+版本可追溯+权限审计\",\"C. 加速编译\",\"D. 文档\"]', 'B。"一次构建多环境部署同一制品"+回滚有据。latest 禁令的载体。', NULL, '[\"制品\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '部署清单里记录镜像 digest（sha256）比记录 tag 好在哪？', NULL, '[\"A. 短\",\"B. digest不可变，tag可被覆盖——精确锁定内容\",\"C. 好看\",\"D. 没区别\"]', 'B。安全与审计进一步：可复现+防篡改（cosign 签名验 digest）。', NULL, '[\"制品\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'git stash 的适用场景？', NULL, '[\"A. 永久保存\",\"B. 临时存现场切分支处理紧急事务后 pop 恢复\",\"C. 删除改动\",\"D. 合并\"]', 'B。stash list / stash pop / stash drop。热修场景标配。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '合并冲突的标记 <<<<<<< ======= >>>>>>> 中间部分是？', NULL, '[\"A. 你的改动\",\"B. 两者共同祖先之后的双方内容分隔（上=当前分支，下=合入分支）\",\"C. 远端\",\"D. 注释\"]', 'B。解决=编辑成想要的最终内容后 git add。abort 放弃：merge --abort / rebase --abort。', NULL, '[\"Git\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '语义化提交信息 feat/fix/chore 属于？', NULL, '[\"A. 装饰\",\"B. Conventional Commits 规范（可自动生成changelog与版本号）\",\"C. 公司规定\",\"D. git钩子\"]', 'B。机器可读的历史 → 自动化 changelog/semantic-release。', NULL, '[\"规范\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 3, '数据库变更能随应用一起"回滚镜像"吗？', NULL, '[\"A. 能\",\"B. 不能直接回：须向后兼容设计（先加后删、分两次发布）\",\"C. 从不涉及\",\"D. 手工总是可以\"]', 'B。破坏性 DDL 拆开发布是发布工程铁律；Flyway/Liquibase 管理迁移版本。', NULL, '[\"发布\",\"进阶\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '设计一条生产级 CI 流水线（阶段+失败策略）。', NULL, NULL, '```yaml
stages: [lint, test, build, scan, deploy-dev, smoke]
```
1. lint 静态检查（5min内快速失败）
2. 单测+覆盖率卡点
3. 构建镜像 tag=git短hash-构建号（禁latest）
4. 安全扫描：依赖漏洞(trivy/dependency-check)+镜像CVE，严重级别阻断
5. 推 Harbor → 部署 dev → 冒烟
6. 产物：通知(IM)、测试报告、镜像SBOM
原则：快者优先、失败即停、一切产物带溯源信息。', NULL, '[\"流水线\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '怎么保证流水线的 secrets 不泄漏？', NULL, NULL, '1. 用平台原生 secrets（GitHub Encrypted Secrets / Jenkins credentials），不进代码与日志
2. 最小权限：部署 token 按仓库/环境隔离，只写特定 helm/ns
3. 日志脱敏（echo 时自动掩码）
4. 定期轮换；泄露立即吊销（vault 动态凭证更佳）
5. PR 来自 fork 不给 secrets（防白嫖算力+窃取）', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, 'git submodule 与 monorepo 的取舍？', NULL, NULL, '- submodule：多仓但共享组件，更新繁琐（忘了 update 就构建错版本）
- monorepo（单仓）：原子跨服务变更、统一CI缓存按路径触发；规模大需构建工具（bazel/nx/turbo）
趋势：中小团队 monorepo 省心；大厂多仓+CI 编排
面试给结论+理由即可。', NULL, '[\"工程化\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '说出 5 个你会在 CI 里做的"卡点"。', NULL, NULL, '1. 单测覆盖率 <80% 阻断（阈值渐进提高）
2. 镜像高危漏洞（trivy --severity CRITICAL）阻断
3. 镜像 tag 非 latest 且符合规范
4. 提交信息符合 Conventional Commits
5. 部署清单变更必须附带变更单号（幂等审计）

卡点=把review里的机械部分自动化。', NULL, '[\"质量\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, 'git hooks 在团队工程里能做什么？给两个实用例子。', NULL, NULL, '1. pre-commit：格式化（gofmt/prettier）、大文件拦截、密钥扫描（gitleaks）
2. commit-msg：校验 Conventional Commits 格式
3. pre-push：跑快速单测
工程实践：husky+lint-staged（前端）、pre-commit 框架统一分发（避免各自配置漂移）。', NULL, '[\"工程化\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 3, 'ArgoCD/GitOps 的核心思想与好处？', NULL, NULL, '声明式：Git 仓库是期望状态（yaml/helm），控制器持续对比集群实际状态并收敛（拉模式）。
好处：
1. Git 即审计（谁改了什么，PR 审批流）
2. 灾难恢复=apply git
3. 防漂移（有人手改集群会被纠正/告警）
4. 凭证不出集群（CI 只提交不动集群）

"pull vs push" 的区别是加分考点。', NULL, '[\"GitOps\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '流水线变慢（15分钟），优化思路？', NULL, NULL, '1. 分解耗时：各 stage 时间打点找 top
2. 缓存：依赖缓存（maven/npm cache action）、docker layer cache（cache-from/to、buildkit）
3. 并行：单测拆片并行、lint/test/build 并行
4. 增量：变更影响分析（monorepo 路径触发）
5. 资源：大 runner/自建 runner 就近内网仓库
目标：PR 反馈 <5min，主干全量流水 <15min。', NULL, '[\"优化\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '发布清单（runbook）里应该有什么？', NULL, NULL, '1. 变更内容与影响面（服务/依赖/DB）
2. 前置检查（备份、容量、依赖方确认）
3. 分步操作（可复制命令）+ 每步验证点
4. 回滚步骤与触发条件（谁有权拍板）
5. 观察窗口与指标基线、值班联系人

发布无 runbook = 裸奔。SRE 面试常考"你如何发布一个服务"。', NULL, '[\"素养\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 3, 'trunk-based 与 git flow 如何选？', NULL, NULL, '- git flow：多环境长周期版本（客户端/外包），分支多合并痛
- trunk-based：小步提交主干+feature flag+主干随时可发布，CI 快速反馈，配合灰度最顺
云原生团队主流 trunk-based；能否回答"feature flag 解决未完成功能"是理解深度信号。', NULL, '[\"工程化\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '如何做数据库变更的自动化与安全？', NULL, NULL, '1. 迁移脚本版本化（Flyway/Liquibase）进仓库，随代码 review
2. CI 里对临时库执行迁移验证可重入（幂等）
3. 大表变更用 online DDL/gh-ost 并在预发演练时长
4. 铁律：向后兼容（先加列后用列、删列隔两版）；变更前备份点
5. 生产执行窗口与双写/回滚脚本准备', NULL, '[\"数据库\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'SCENARIO', 2, '发布进行到一半（已更新 50% 实例）发现严重 bug，怎么办？', '滚动发布 K8s 环境。', NULL, '1. **立即停止**继续发布：kubectl rollout pause deploy/api（保住未更新的50%）
2. 评估快速修复：小fix直接继续（修好镜像继续 rollout resume）
3. 不能快速修复：kubectl rollout undo（回滚会同时回滚已更新部分——此时新旧混合，undo 即整体回旧）
4. 验证：错误率回落、功能回归
5. 复盘：灰度阶段指标卡点为什么没拦住

考"pause"这个中间态命令，很多人只知道 undo。', NULL, '[\"应急\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'SCENARIO', 3, 'CI 一切绿灯但生产启动失败，问题可能出在哪些环节？', NULL, NULL, '1. 环境差异：配置（ConfigMap/环境变量）不同、依赖版本（本地/生产 DB schema 漂移）
2. 镜像不同：CI 测的 commit 与部署 tag 不一致（流程缺陷）
3. 资源差异：生产 limits 小于开发导致 OOM；JVM 参数差异
4. 依赖服务：生产 DB 未迁移、下游未就绪
5. 网络策略：生产 NetworkPolicy 拦截
改进：环境一致性（同一制品）、配置即代码、部署后 smoke 作为 CD 最后一环', NULL, '[\"质量\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'SCENARIO', 2, '团队 20 人，分支满天飞+经常丢提交，你如何治理？', NULL, NULL, '1. 定分支模型：主干+短命 feature（2天内合）+ release/hotfix
2. 保护主干：PR 必审（CODEOWNERS）+CI绿+至少1 approve
3. 规范：Conventional Commits + PR 模板（变更说明/影响面/回滚）
4. 自动化兜底：merge 前自动 rebase 检查、过期分支机器人提醒
5. 制度落地靠工具（branch protection 一开，谁都改不了）

考察工程治理思维而非背流程。', NULL, '[\"治理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, 'git clone --depth 1 的用途？', NULL, '[\"A. 浅克隆（CI提速）\",\"B. 只读\",\"C. 单分支全历史\",\"D. 轻量跟踪\"]', 'A。大仓 CI 拉代码提速明显；缺点无历史（不能对比、blame）。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, 'git fetch 与 pull 的关系？', NULL, '[\"A. pull = fetch + merge/rebase\",\"B. 相同\",\"C. fetch覆盖本地\",\"D. pull只下载\"]', 'A。先 fetch 看 log 再决定合入更稳；pull 默认行为可配（pull.rebase）。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'git cherry-pick 的适用场景？', NULL, '[\"A. 把某提交摘到另一分支（hotfix 回合）\",\"B. 合并全分支\",\"C. 撤销\",\"D. 重命名\"]', 'A。hotfix 分支修复后合回 main 与 release 分支。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'git tag -a v1.2 -m "..." 的意义？', NULL, '[\"A. 附注标签（发布版本锚点，CI按tag出包）\",\"B. 书签\",\"C. 分支\",\"D. 注释\"]', 'A。语义化版本 v主.次.修订；里程碑管理与回溯发布基线。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'Git LFS 解决什么？', NULL, '[\"A. 大文件存储（仓库存指针）\",\"B. 大仓库克隆\",\"C. 二进制diff\",\"D. 加密\"]', 'A。设计文件/模型等。滥用 LFS 藏日志/构建产物是反模式。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'PR review 的最低工程标准？', NULL, '[\"A. 1人审+CI绿+变更说明完整\",\"B. 自己合\",\"C. 人数越多越好\",\"D. 只看CI\"]', 'A。CODEOWNERS 关键路径强制指定审者；PR 小而聚焦（<400行改动更易审出问题）。', NULL, '[\"协作\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'CI 与 CD 的分界线是？', NULL, '[\"A. 制品产出之后（部署编排属于CD）\",\"B. 无分界\",\"C. 测试之后\",\"D. 编译之后\"]', 'A。CI 产出可验证制品；CD（deliver/deploy）把它安全送达环境。', NULL, '[\"概念\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'feature flag（功能开关）解决什么？', NULL, '[\"A. 代码合入但功能可按开关灰度/关闭（解耦部署与发布）\",\"B. 编译开关\",\"C. 权限\",\"D. 环境\"]', 'A。trunk-based 的伴生技术；注意开关治理（过期清理）。', NULL, '[\"发布\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '回滚优先（rollback-first）原则指？', NULL, '[\"A. 生产异常先回滚止血，再定位根因\",\"B. 先查root cause\",\"C. 重启优先\",\"D. 扩容优先\"]', 'A。MTTR 优先于"完美解释"；保留现场另行复盘。', NULL, '[\"应急\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'Nexus 与 Harbor 的分工？', NULL, '[\"A. Nexus偏jar/通用制品；Harbor专注容器镜像\",\"B. 相同\",\"C. 都只能镜像\",\"D. 都只能jar\"]', 'A。混编团队两个都有；统一治理用制品清单关联。', NULL, '[\"制品\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 3, 'Supply Chain 安全的最低配置集？', NULL, '[\"A. 锁定依赖+SCA扫描+镜像扫描+签名验证\",\"B. 代码扫描 only\",\"C. WAF\",\"D. 不需要\"]', 'A。lockfile（锁定版本）、dependency-check/trivy、cosign 部署验签、SBOM 归档。', NULL, '[\"安全\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 3, 'Squash merge 的缺点？', NULL, '[\"A. 丢失分支内提交细节（难 bisect）\",\"B. 慢\",\"C. 冲突多\",\"D. 无缺点\"]', 'A。取舍：主线整洁 vs 可追溯；团队约定一致即可。', NULL, '[\"Git\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '写一个 GitHub Actions 触发：仅当 backend/ 目录变化才跑后端CI。', NULL, NULL, '```yaml
on:
  push:
    paths: [''backend/**'']
```
monorepo 增量CI 的基础；复杂规则用 dorny/paths-filter。', NULL, '[\"工具\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '发布窗口选择与检查清单（口述）。', NULL, NULL, '避开：业务高峰、整点（任务扎堆）、周五下午（值守弱）。
清单：变更单/回滚脚本/依赖方通告、监控面板打开、值班就位、灰度比例与观察指标明确、abort 条件（错误率>1%即停）。', NULL, '[\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 3, '如何设计"一键回滚"并保证它真的可用？', NULL, NULL, '1. 制品与配置版本化（回滚=部署旧版本组合）
2. 脚本化：deploy.sh --to v1.2.3（含前置检查）
3. DB 兼容：代码回滚不破坏新 schema（向后兼容DDL）
4. 缓存兼容：旧代码能读新缓存结构（或回滚时清缓存）
5. **每月演练**：预发执行一次全链路回滚计时
没演练的回滚按钮是装饰品。', NULL, '[\"发布\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, 'git init --bare 的用途？', NULL, '[\"A. 建中央裸仓（无工作区，做远端）\",\"B. 空仓库\",\"C. 删除\",\"D. 浅克隆\"]', 'A。自建 git 服务的仓库形态。日常用托管平台则少接触。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, '.git 目录里有什么？', NULL, '[\"A. 全部历史/配置/钩子/索引\",\"B. 只代码\",\"C. 只日志\",\"D. 构建产物\"]', 'A。.git 丢了历史就没了；hooks 目录可放团队钩子。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'git diff HEAD 与 git diff --staged？', NULL, '[\"A. 工作区+暂存 vs HEAD / 暂存 vs HEAD\",\"B. 相同\",\"C. 反的\",\"D. 无HEAD用法\"]', 'A。提交前自检两连。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'CI 缓存（cache）与制品（artifacts）的区别？', NULL, '[\"A. cache 加速下次（依赖包）；artifacts 是本次产出传递\",\"B. 相同\",\"C. artifacts可删\",\"D. cache永久\"]', 'A。m2/npm 缓存 vs jar/镜像 tar。', NULL, '[\"工具\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '矩阵构建（matrix）适合？', NULL, '[\"A. 多版本/多平台组合批量测试\",\"B. 加速单测\",\"C. 发布\",\"D. 备份\"]', 'A。JDK17/21 × linux/arm 组合验证。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '如何防止把密钥提交进 Git 仓库？', NULL, NULL, '1. pre-commit 钩子扫描（gitleaks）
2. .gitignore 模板化（.env*）
3. 配置中心/Vault 注入而非文件
4. 已泄漏处置：**立即轮换密钥**（删文件没用，历史还在），需要时 git filter-repo 清史
5. 平台侧开 push 保护（GitHub secret scanning）', NULL, '[\"安全\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 3, '描述一次"回滚比修复快"的决策过程。', NULL, NULL, '凌晨故障：新版本缓存结构不兼容导致 5%。
1. 评估：修复需30分钟+回归；回滚5分钟
2. 决策：错误率持续>阈值→回滚（止损优先）
3. 回滚后验证指标恢复
4. 白天修复+兼容性测试+补集成测试用例
5. 复盘：发布检查表加"缓存结构变更"项
讲出决策依据（时间与风险量化）比结论更重要。', NULL, '[\"应急\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, 'git remote -v 查看？', NULL, '[\"A. 远端仓库地址\",\"B. 分支\",\"C. 日志\",\"D. 标签\"]', 'A。push 没权限/推错库先看它。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, 'git branch -d 与 -D？', NULL, '[\"A. -d 未合并拒绝；-D 强删\",\"B. 相同\",\"C. -D安全\",\"D. 都强删\"]', 'A。误删分支可 reflog 找回。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, 'git stash drop 与 pop？', NULL, '[\"A. 删除暂存 / 恢复并删除\",\"B. 相同\",\"C. pop不删\",\"D. drop恢复\"]', 'A。apply 恢复但保留暂存。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, 'CI 里并发限制同一分支只跑一个的配置？', NULL, '[\"A. concurrency 组（actions）/ disableConcurrentBuilds（jenkins）\",\"B. 不支持\",\"C. 手动等待\",\"D. 加锁脚本\"]', 'A。防资源浪费与部署互相踩。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '预发环境与生产环境配置差异应该怎么管理？', NULL, '[\"A. 同一模板+环境覆盖文件（kustomize/helm values）\",\"B. 复制粘贴yml\",\"C. 生产手改\",\"D. 无差别\"]', 'A。手改=漂移之源；GitOps 化管理环境差异。', NULL, '[\"配置\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, 'git 提交信息写 "fix bug" 有什么问题？', NULL, NULL, '无法检索、无法追溯动机、changelog 无法生成。规范：type(scope): subject（如 fix(pay): 修复重复扣款），正文写为什么这么改。信息是给半年后的自己与同事看的。', NULL, '[\"规范\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, '发布后如何确认"真的成功了"（验证清单）？', NULL, NULL, '1. 版本指纹：响应头/health 接口返回的版本号=预期
2. 指标：错误率/延迟/QPS 无异常波动
3. 日志：无新增异常栈
4. 业务抽样：核心链路人工/自动化走一遍
5. 分批发布：确认比例（kubectl rollout status / 灰度百分比）
"部署完成≠发布成功"。', NULL, '[\"素养\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 3, 'jenkins agent 与 K8s 动态 agent 的区别与收益？', NULL, NULL, '静态 agent：常驻、占资源、环境固定；K8s 动态（kubernetes plugin）：按 job 起 Pod、用完即焚、环境镜像化一致、并发弹性。配合镜像缓存加速。这是"CI 容器化"的标准演进路径。', NULL, '[\"工具\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 1, 'git log --oneline -5 的 -5？', NULL, '[\"A. 最近5条\",\"B. 前5个文件\",\"C. 5分钟内\",\"D. 5个分支\"]', 'A。--graph --all 加拓扑。', NULL, '[\"Git\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'CHOICE', 2, '代码扫描(SAST)应放在流水线哪个阶段？', NULL, '[\"A. 尽早（PR/commit 阶段快速反馈）\",\"B. 部署后\",\"C. 上线后\",\"D. 任意\"]', 'A。左移原则：越早发现成本越低。', NULL, '[\"质量\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 2, 'git 合并产生大量冲突的根因是什么？怎么改善？', NULL, NULL, '根因：分支生命周期长+同文件高频改动+缺乏模块边界。
改善：1) 小步合入（trunk-based/短分支）2) 常常 rebase 主干 3) 拆模块/接口层减少同文件碰撞 4) 团队约定文件 owner。
流程服务于协作，而不是反过来。', NULL, '[\"治理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(7, 'QA', 3, '如何度量研发交付效率（DevOps 指标）？', NULL, NULL, '四大关键指标（DORA）：
1. 部署频率（越勤越好）
2. 变更前置时间（提交→上线）
3. 变更失败率
4. MTTR（恢复时长）
数据从流水线+工单系统出，季度复盘改进。有指标才能管理。', NULL, '[\"体系\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(5, 'CHOICE', 1, '查看容器日志最后 50 行并跟随？', NULL, '[\"A. docker logs -f --tail 50 name\",\"B. docker log name\",\"C. docker exec logs\",\"D. docker inspect logs\"]', 'A。--since "10m" 按时间；仅对主进程 stdout/stderr 有效（应用必须输出到标准输出）。', NULL, '[\"命令\",\"必背\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, '进入运行中容器开个 shell？', NULL, '[\"A. docker exec -it name sh\",\"B. docker attach name\",\"C. docker enter\",\"D. ssh container\"]', 'A。exec 新开进程退出不影响容器；attach 挂主进程，exit 会停容器。', NULL, '[\"命令\",\"必背\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, '容器退出码 137 通常意味着？', NULL, '[\"A. 语法错\",\"B. 被 SIGKILL：常见 OOM 或手动 kill -9\",\"C. 正常退出\",\"D. 镜像错\"]', 'B。128+9=137。docker inspect 看 OOMKilled: true 确认；治法：降内存用量或调大 limits。', NULL, '[\"排障\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'Dockerfile 中 EXPOSE 的作用？', NULL, '[\"A. 声明端口（文档性质）\",\"B. 自动映射端口\",\"C. 打开防火墙\",\"D. 必须\"]', 'A。真正映射靠 docker run -p。EXPOSE 只是元数据声明，方便 -P 随机映射与阅读。', NULL, '[\"Dockerfile\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'CMD ["a"] 与 CMD a b（shell 格式）关键区别？', NULL, '[\"A. 无区别\",\"B. shell格式经 /bin/sh -c 包装，收不到 SIGTERM\",\"C. exec更快\",\"D. shell更安全\"]', 'B。PID1 是 sh，docker stop 的 TERM 被 sh 忽略 → 等 10s 被 KILL（数据风险）。生产一律 exec 数组格式。', NULL, '[\"Dockerfile\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器网络默认模式是？', NULL, '[\"A. host\",\"B. bridge（docker0 NAT）\",\"C. none\",\"D. macvlan\"]', 'B。-p 端口映射即 iptables DNAT；容器间用自定义网络+容器名 DNS 互访。', NULL, '[\"网络\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, '数据持久化的推荐方式？', NULL, '[\"A. 容器可写层\",\"B. volume 或 bind mount\",\"C. 镜像里\",\"D. 环境变量\"]', 'B。volume 由 Docker 管理（-v name:/path），bind mount 直挂宿主目录（开发热更）。容器删除可写层即丢。', NULL, '[\"存储\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '以下哪个不是镜像瘦身手段？', NULL, '[\"A. 多阶段构建\",\"B. alpine 基础镜像\",\"C. 同层清理 apt 缓存\",\"D. 增加 RUN 层数\"]', 'D。层越多通常越大；合并 RUN 并同层清理才减体积。', NULL, '[\"优化\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'docker stats 看到容器内存接近 limit 但应用没报错，可能？', NULL, '[\"A. 缓存页占用（可回收），不一定异常\",\"B. 一定OOM\",\"C. stats坏了\",\"D. CPU问题\"]', 'A。cgroup memory.stat 区分 cache 与 rss；关注 oom_counter/events 里的 OOM 事件而非仅总量。', NULL, '[\"资源\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器重启策略 --restart=on-failure 与 always 区别？', NULL, '[\"A. 一样\",\"B. on-failure 仅异常退出才重启；always 无条件（含手动stop前）\",\"C. always只在开机\",\"D. on-failure不重启\"]', 'B。always 还随 Docker 守护进程启动而拉起（开机自启场景）。unless-stopped 手动停后不再拉起。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'docker compose up -d 与 docker compose restart 区别？', NULL, '[\"A. 一样\",\"B. up -d 会重建配置变化的容器；restart 只重启进程（不加载新配置/镜像）\",\"C. restart 更新镜像\",\"D. up 更慢无别\"]', 'B。改了 compose 文件/镜像后必须 up -d（会 recreate）。restart 对"更新配置"无效是高频误区。', NULL, '[\"compose\",\"坑\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '镜像 tag 用 latest 的生产风险？', NULL, '[\"A. 无风险\",\"B. 拉取结果不可复现、回滚无凭据、缓存误用\",\"C. 更安全\",\"D. 只影响名字\"]', 'B。规范：git短hash/版本号 tag；部署记录当前 tag；回滚=切回旧 tag。', NULL, '[\"规范\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 3, '容器内 top 看到的 PID 与宿主机的关系？', NULL, '[\"A. 相同\",\"B. PID namespace 隔离：容器内从1编号，宿主机是另一套真实号\",\"C. 容器无PID\",\"D. 随机\"]', 'B。容器 PID1 映射宿主机某真实 PID（docker inspect -f {{.State.Pid}}）。jmap/jstack 需注意目标号是宿主侧还是容器侧。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '为什么容器里 PID1 程序要处理 SIGTERM？', NULL, '[\"A. 礼貌\",\"B. docker stop 先发TERM给PID1，忽略则10秒后被KILL，失去优雅退出机会\",\"C. 不需要\",\"D. 只有Java需要\"]', 'B。优雅停机链路：TERM → 应用释放连接/落盘 → 超时 grace period 才 KILL。K8s terminationGracePeriodSeconds 同理。', NULL, '[\"原理\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'docker system prune 会清理什么？', NULL, '[\"A. 一切\",\"B. 停止的容器、悬空镜像、未用网络、构建缓存（默认不动卷）\",\"C. 只删镜像\",\"D. 数据库\"]', 'B。危险点：-a 会删所有未使用镜像（别的项目共用会误删）；卷需 --volumes 才删。生产慎用，先 df 看。', NULL, '[\"运维\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '构建镜像时 COPY 与 ADD 的选择？', NULL, '[\"A. 一律ADD\",\"B. 默认COPY，仅本地tar自动解压需求用ADD\",\"C. 一样\",\"D. URL下载用COPY\"]', 'B。URL下载用 RUN curl+清理（可控可缓存），语义更清晰。', NULL, '[\"Dockerfile\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 3, 'overlay2 的容器可写层与镜像层关系？', NULL, '[\"A. 每容器完整拷贝镜像\",\"B. 镜像层只读共享，容器顶部加可写层（写时复制）\",\"C. 无层\",\"D. 每次commit新卷\"]', 'B。copy-on-write：改文件时从镜像层复制到可写层修改——所以大文件在容器内修改会膨胀，且容器删除可写层即丢。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 1, '容器与虚拟机的本质区别（2点以上）？', NULL, NULL, '1. 隔离级别：容器共享宿主内核（namespace 视图隔离+cgroups 限额）；VM 虚拟化硬件各带内核
2. 资源：容器 MB 级秒起，VM GB 级分钟起
3. 安全：容器隔离弱（内核漏洞=逃逸风险），生产常"VM 里跑容器"取折中
4. 镜像：OCI 标准分层分发 vs 磁盘镜像', NULL, '[\"原理\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '写一个生产级 Java 应用 Dockerfile（要点注释）。', NULL, NULL, '```dockerfile
FROM eclipse-temurin:17-jre-alpine          # 运行期只要JRE，小
WORKDIR /app
COPY target/app.jar app.jar
ENV JAVA_OPTS="-Xms512m -Xmx512m" TZ=Asia/Shanghai
# exec格式：PID1是java，能收到SIGTERM优雅停
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar app.jar"]
```
进阶：多阶段构建（build阶段mvn打包）、非root用户（USER app）、HEALTHCHECK。', NULL, '[\"Dockerfile\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, 'docker stop 卡 10 秒才停的原因与优化？', NULL, NULL, '原因：PID1 收不到/不处理 SIGTERM（shell 包装、应用未注册 shutdown hook），10s 宽限后被 KILL。
优化：
1. ENTRYPOINT exec 格式
2. 应用注册优雅停机（Spring Boot actuator shutdown/k8s preStop）
3. docker stop -t 30 调宽限
4. Java 注意 JVM 转发：用 exec 乔装（tini -- / java）', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '容器一启动就 Exited，完整排查步骤？', NULL, NULL, '1. docker ps -a 看退出码（1=应用报错，137=OOM/被杀，0=主进程正常结束=命令瞬时）
2. docker logs --tail 100（90%答案在这）
3. docker inspect 看 OOMKilled、Error
4. 替换入口调试：docker run -it --entrypoint sh img 手动跑启动命令
5. 依赖检查：DB/Redis 未就绪即退出（加重试）
6. 资源：limits 太小启动即 OOM', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '如何给运行中的容器改端口映射/挂载？', NULL, NULL, '改不了（run 时固定）。方案：
1. 删掉重建（docker run 新参数；数据在 volume 不丢）
2. compose 场景改 yml 后 up -d（自动重建该服务）
3. 硬核 hack（改 hostconfig.json+重启docker）不推荐

由此引出正确认知：**容器是无状态的、可重建的**，配置变更走声明式重建。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '镜像构建很慢，如何利用缓存加速？', NULL, NULL, '1. **层顺序**：先 COPY pom.xml 依赖清单再装依赖，最后 COPY 源码——源码变了不重下依赖
2. 减少会变的层放后面（配置/代码最后）
3. 构建缓存挂载：RUN --mount=type=cache（BuildKit）
4. .dockerignore 排除 node_modules/target
5. CI 开 BuildKit + 远程缓存（--cache-from/to）', NULL, '[\"优化\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, 'docker compose 中 depends_on 能保证 MySQL 就绪吗？', NULL, NULL, '不能——只保证**启动顺序**不保证就绪。正确：
```yaml
depends_on:
  mysql:
    condition: service_healthy
```
配合镜像的 healthcheck（mysqladmin ping）。应用侧仍建议连接重试。', NULL, '[\"compose\",\"坑\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 3, '如何查看容器占用磁盘过大的原因？', NULL, NULL, '1. docker system df -v 看镜像/容器可写层/卷/缓存分布
2. 可写层大：容器内写了大文件（应移 volume）—— docker diff name 看
3. 日志大：/var/lib/docker/containers/*/*-json.log —— 配 log-driver max-size
4. 悬空镜像/停止容器堆积：prune（先 -v 预览）
5. 根因治理：不可变容器理念——数据出容器、日志走驱动', NULL, '[\"运维\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, 'docker network 的自定义 bridge 与默认 bridge 区别？', NULL, NULL, '自定义网络：
1. 内嵌 DNS：容器名互访（默认 bridge 不行，只能已废弃的 --link）
2. 隔离性：不同网络互不可见
3. 动态接入断开（docker network connect）

compose up 自动建项目网络，服务名即域名。', NULL, '[\"网络\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 3, '什么是 Docker in Docker（DinD）？CI 里为什么不推荐？替代？', NULL, NULL, 'DinD：容器内再跑 docker daemon（privileged 特权），风险高（逃逸面大）且卷/缓存复杂。
替代：
1. **挂载宿主 socket**（-v /var/run/docker.sock:/var/run/docker.sock）—— sibling 模式，CI（含本项目 Lab 沙箱）标准做法
2. Kaniko/buildkit 无守护进程构建

面试亮点：能说清 socket 挂载等于给了宿主 root 级权限，需要信任边界。', NULL, '[\"进阶\",\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '如何导出容器内文件到宿主（无 exec 场景，如容器已退出）？', NULL, NULL, '```
docker cp name:/path/file ./        # 运行/停止均可
docker cp name:/var/log .
```
反方向同样可用。排障已退出容器：docker cp 取日志/heapdump 后再删。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '健康检查在 Docker 层怎么配？', NULL, NULL, 'Dockerfile: HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD curl -sf http://localhost:8080/health || exit 1
compose 同义。状态在 docker ps 的 STATUS 显示 (healthy)。注意：健康检查失败的容器不会被自动替换——自动摘除/重建需编排层（K8s/compose --wait）。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 3, '一个镜像在 A 机器能跑 B 机器报 standard_init_linux.go: exec format error，为什么？', NULL, NULL, 'CPU 架构不匹配：A 是 x86(amd64) 构建，B 是 ARM（如 Apple M/树莓派/国产ARM服务器）。
解决：docker buildx 多架构构建（--platform linux/amd64,linux/arm64）并推 manifest。也提示规范：镜像仓库 tag 带架构信息。', NULL, '[\"排障\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'SCENARIO', 2, '发布后服务反复重启（Restarting→Exited 循环），怎么排查？', 'docker ps 显示 Restart (1) / Restart (137) 交替。', NULL, '1. 看退出码类型：1=启动异常（logs 看栈：配置/依赖）；137=OOM（inspect OOMKilled；调内存或查泄漏）
2. logs 时间线：启动多久挂（启动即挂=配置错；跑几分钟挂=OOM/依赖断连退出）
3. 依赖就绪时机：DB 慢导致连接失败 System.exit —— 加重试
4. 临时处置：docker update --restart=no 停止重启风暴防止打爆下游，再排查
5. 若 OOM：-Xmx 与容器 limit 的关系（JVM 感知 cgroup 内存需 UseContainerSupport，8+默认开）', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'SCENARIO', 3, '宿主机磁盘被 Docker 占满，线上在跑，如何安全清理？', NULL, NULL, '1. 确认占大头：docker system df（镜像/容器/卷/日志/build缓存）
2. **日志文件**（最常见且安全）：truncate -s 0 /var/lib/docker/containers/*/*-json.log，并给 daemon.json 配 max-size 防复发
3. 悬空镜像/已停止容器：docker image prune / container prune（不碰运行中）
4. 构建缓存：builder prune
5. **不要动**：运行中容器的可写层、在用 volume、在用镜像
6. 卷里的大文件逐卷 docker system df -v 定位后进容器处理或迁移

要点：先 df 分类，永远不动在线资源。', NULL, '[\"运维\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'SCENARIO', 2, '同一 compose 里的服务互相访问报 "connection refused/name not resolved"，排查？', NULL, NULL, '1. 服务名写对了吗（compose 服务名即 DNS 名，不是容器名/镜像名）
2. 目标服务在哪个网络（默认同 default 网络互通；自定义 networks 需声明共同网络）
3. 目标服务监听地址：容器内应用须听 0.0.0.0（不是127.0.0.1）
4. 端口用的是**容器端口**（服务间通信用 3306，不是宿主映射的 3307）
5. 目标容器起来了吗（depends_on/健康状态）

第3、4点是90%的原因。', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker run -d --name x img 中 -d 的含义？', NULL, '[\"A. 后台运行\",\"B. 删除\",\"C. 调试\",\"D. 挂载\"]', 'A。detached；前台 -it 调试看日志。注意 -d + 应用秒退要 ps -a 查退出码。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker inspect 主要看什么？', NULL, '[\"A. 全部元数据（IP/挂载/环境变量/退出原因/OOM）\",\"B. 只看日志\",\"C. 只看大小\",\"D. 网络 only\"]', 'A。排障三件：State（OOMKilled/ExitCode）、NetworkSettings.IPAddress、Mounts。用 -f "template" 提取。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker ps -a 与 --format 的用法？', NULL, '[\"A. 含已退出容器 / 自定义输出列\",\"B. 排序\",\"C. 过滤 only\",\"D. 统计\"]', 'A。--format "{{.Names}}\t{{.Status}}" 做清单脚本。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, '镜像与容器的类比最贴切的是？', NULL, '[\"A. 类与实例\",\"B. 文件与文件夹\",\"C. 硬件与软件\",\"D. 进程与线程\"]', 'A。镜像只读模板，容器=镜像+可写层运行态。', NULL, '[\"基础\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'docker build 的缓存失效规则？', NULL, '[\"A. 某层指令/RUN内容或所COPY文件变化起全部失效\",\"B. 随机\",\"C. 只最后一层\",\"D. 永不失效\"]', 'A。所以变动频繁的内容（源码）放最后；依赖清单先 COPY。', NULL, '[\"优化\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'docker run -p 8080:80 端口不通，容器内服务正常，最可能？', NULL, '[\"A. 容器内服务监听127.0.0.1\",\"B. 端口映射错方向\",\"C. 都可能\",\"D. 不可能\"]', 'C。两都常见：容器内须听 0.0.0.0；-p 宿主:容器 方向别写反。', NULL, '[\"排障\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'ENV 与 ARG 的区别？', NULL, '[\"A. ENV 运行时也在；ARG 仅构建期\",\"B. 相同\",\"C. ARG更安全\",\"D. ENV只构建期\"]', 'A。敏感信息放 ARG 也不安全（history 可见）——用 BuildKit secret。', NULL, '[\"Dockerfile\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'HEALTHCHECK 状态在哪看、谁消费？', NULL, '[\"A. docker ps 的 (healthy)；compose --wait/orchestrator 消费\",\"B. 自动重启\",\"C. 日志 only\",\"D. 无人用\"]', 'A。注意 unhealthy 不会自动替换容器——那是 K8s 的事。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器内 DNS 解析顺序（自定义网络）？', NULL, '[\"A. 内嵌DNS(容器/服务名) → 外部DNS\",\"B. 直接公网\",\"C. hosts only\",\"D. 无DNS\"]', 'A。compose 服务名互通的原理。默认 bridge 没有内嵌 DNS（所以要用自定义网络）。', NULL, '[\"网络\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器 root 用户与宿主 root 的关系？', NULL, '[\"A. 容器root≈宿主root能力（危险，挂载后可改宿主文件）\",\"B. 完全隔离安全\",\"C. 普通用户\",\"D. 无用户概念\"]', 'A。USER 指令降权是镜像安全基线；配合 --user 运行时覆盖。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'docker compose 中 volumes 短语法的等价？', NULL, '[\"A. ./data:/app/data = bind mount\",\"B. named volume\",\"C. tmpfs\",\"D. 无挂载\"]', 'A。裸名字（data:/x）才是 volume；顶层需声明 volumes:。', NULL, '[\"compose\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器日志 json-file 的限制配置在哪？', NULL, '[\"A. daemon.json（max-size/max-file）\",\"B. Dockerfile\",\"C. run 参数 only\",\"D. 不可限\"]', 'A。/etc/docker/daemon.json 配置后 restart 生效；run 时 -log-opt 也能单容器限。磁盘被日志吃满的标准预防。', NULL, '[\"运维\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 3, 'overlayfs 写时复制（COW）对性能的影响？', NULL, '[\"A. 首次修改大文件需复制整文件到可写层（慢且占空间）\",\"B. 无影响\",\"C. 更快\",\"D. 只读更快\"]', 'A。数据库类容器别把数据放镜像层文件上——挂 volume 绕开 COW。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 3, 'docker stats 显示 CPU 300% 说明？', NULL, '[\"A. 多核累计（3核满载，除以核数得真实占比）\",\"B. 报错\",\"C. 超卖\",\"D. 300%就绪\"]', 'A。与 top 单核百分比口径不同，面试坑点。', NULL, '[\"监控\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 3, '容器内 PID1 是 sh（shell 包装）时优雅停机失效的补救？', NULL, '[\"A. exec 替换：CMD [\\"sh\\",\\"-c\\",\\"exec java -jar app.jar\\"]\",\"B. 无解\",\"C. 加 -t 即可\",\"D. 重启容器\"]', 'A。exec 让 java 顶替 sh 成为 PID1。或用 tini 作 init。', NULL, '[\"原理\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '如何把一个运行中容器的当前改动保存下来调试？正规做法是什么？', NULL, NULL, '调试可用 docker commit 临时固化（不推荐作分发流程）；正规做法：改 Dockerfile 重新构建（可追溯可复现）。commit 的镜像像"黑盒快照"，违反基础设施即代码原则。', NULL, '[\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, 'docker logs 看不到应用日志，为什么？', NULL, NULL, 'docker logs 只收集 PID1 的 stdout/stderr。应用把日志写文件（如 log4j 写盘）就看不到。方案：1) 应用改为输出标准输出（十二要素，推荐）2) 或挂载日志目录到宿主采集。', NULL, '[\"日志\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 3, '描述 CI 中用 Docker 构建镜像的完整质量环节。', NULL, NULL, '1. 多阶段构建（build→runtime）
2. .dockerignore（防泄密+缓存失效）
3. tag 用 git hash，禁 latest
4. trivy 扫描（CRITICAL 阻断）
5. 镜像签名（cosign 可选）
6. 推 Harbor（保留策略+漏洞基线）
7. 构建 SBOM 归档
8. 缓存加速（buildkit cache-from/to）', NULL, '[\"CI\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker pull 的镜像存储位置？', NULL, '[\"A. /var/lib/docker/overlay2\",\"B. /opt/images\",\"C. /var/images\",\"D. /usr/docker\"]', 'A。可用 data-root 迁移到数据盘（防止系统盘被镜像吃满）。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker top 容器 与 docker exec ps 的关系？', NULL, '[\"A. 前者从宿主视角看容器进程\",\"B. 相同\",\"C. 后者更全\",\"D. 前者是镜像\"]', 'A。容器内外 PID 不同（namespace），排查时对齐两视角。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器内看不到 ps/curl 等工具，怎么办？', NULL, '[\"A. docker cp 拷静态工具进去 / kubectl debug 临时容器 / 宿主 nsenter\",\"B. 没办法\",\"C. 重打镜像必然\",\"D. 重启容器\"]', 'A。distroless 镜像的排障姿势（拷 busybox 静态二进制）。', NULL, '[\"排障\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器内存 limit 与 JVM -Xmx 的关系最佳实践？', NULL, '[\"A. Xmx ≈ limit 的 70%（留堆外/元空间/线程栈）\",\"B. Xmx=limit\",\"C. 不设Xmx\",\"D. limit越大越好\"]', 'A。或 MaxRAMPercentage=70。Xmx=limit 必 OOMKill。', NULL, '[\"调优\",\"必坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'docker run --rm 的语义？', NULL, '[\"A. 容器退出即自动删除（临时容器）\",\"B. 强制删除运行中\",\"C. 清理镜像\",\"D. 免重启\"]', 'A。一次性任务容器标配，防堆积。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 3, '容器访问宿主服务（宿主端口仅127.0.0.1监听）的方式？', NULL, '[\"A. host.docker.internal / 网关IP 172.17.0.1（需监听0.0.0.0或用host网络）\",\"B. 容器直接127.0.0.1\",\"C. 不可能\",\"D. 必须公网\"]', 'A。容器里的 localhost 是容器自己——高频认知坑。', NULL, '[\"网络\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '如何让容器随 Docker 开机自启？', NULL, NULL, '1. run 时 --restart unless-stopped（always 也随守护进程拉起）
2. compose 里 restart: unless-stopped
3. 依赖顺序靠 depends_on+健康检查
注意：手动 stop 后 unless-stopped 不再拉起（区别 always），符合运维直觉。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 3, '镜像层只读、容器层可写，那容器里 apt install 的东西去哪了？重启还在吗？', NULL, NULL, '写在容器可写层：重启容器（docker restart）还在；**删除容器重建（compose up 重建）就没了**——这就是"不可变基础设施"要义：变更进镜像（Dockerfile），不进容器运行时。临时装包只应急用。', NULL, '[\"原理\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker version 与 docker info 的区别？', NULL, '[\"A. 客户端/服务端版本 vs 引擎全局状态（存储驱动/容器数）\",\"B. 相同\",\"C. 后者只看版本\",\"D. 前者看容器\"]', 'A。排 Docker 环境问题先 info。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker images 的 <none> 镜像是？', NULL, '[\"A. 悬空镜像（旧层/构建残留）\",\"B. 病毒\",\"C. 系统镜像\",\"D. 运行中\"]', 'A。docker image prune 清理。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker run -v /data 的效果？', NULL, '[\"A. 匿名卷（Docker随机命名管理）\",\"B. 挂载宿主/data\",\"C. 只读\",\"D. 报错\"]', 'A。与 -v name:/data（命名卷）、-v /host:/c（bind）三态区分。', NULL, '[\"存储\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'docker logs -f 与 docker events 的区别？', NULL, '[\"A. 单容器日志 vs 引擎事件流（启停/挂载等动作）\",\"B. 相同\",\"C. 前者引擎级\",\"D. 后者是日志\"]', 'A。"容器为什么重启了"查 events。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器退出后 docker start 回来，数据在吗？', NULL, '[\"A. 在（可写层保留）；rm 后才丢\",\"B. 丢失\",\"C. 部分丢\",\"D. 卷才保留\"]', 'A。重建（run 新容器/up --force-recreate）=新可写层，数据只在 volume 里持久。', NULL, '[\"原理\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, 'compose 里 env_file 与 environment 的优先级？', NULL, '[\"A. environment 覆盖 env_file\",\"B. 反\",\"C. 相同\",\"D. 报错\"]', 'A。分层配置：公共 env_file + 环境差异化 environment。', NULL, '[\"compose\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 3, '容器内时间是 UTC，应用要 CST，最快修法？', NULL, '[\"A. -e TZ=Asia/Shanghai（镜像含tzdata）或 Dockerfile ENV TZ\",\"B. 改宿主机即可\",\"C. 每次手动date\",\"D. 无法\"]', 'A。日志时间差 8 小时的根治；镜像缺 tzdata 则需装或用带时区的镜像。', NULL, '[\"坑\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '为什么 docker exec 修改容器文件不持久到镜像？如何持久？', NULL, NULL, '可写层属于容器实例：commit 可固化但不推荐；正规是改 Dockerfile 重建（可审计可复现）。"运行时改"只应急。', NULL, '[\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 3, '如何限制容器日志与磁盘写入（防写满宿主盘）？', NULL, NULL, '1. 日志：daemon.json log-driver json-file + max-size/max-file
2. 容器写大量数据：--mount readonly 或挂专用 volume 到数据盘
3. 构建残留：定期 prune + buildkit 缓存上限
4. 监控：docker system df 采集告警
原则：容器是"易耗品"，大文件流不放可写层。', NULL, '[\"运维\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, 'docker ps 默认不显示已停止容器，参数？', NULL, '[\"A. -a\",\"B. -s\",\"C. -q\",\"D. -l\"]', 'A。-q 只列ID（配 xargs 用）。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 2, '容器时区/data盘/日志 三件套哪个不是 run 必配？', NULL, '[\"A. 看需求都要/e TZ、-v、日志在daemon配置\",\"B. 时区必须\",\"C. 都不用\",\"D. 日志必须 run 传\"]', 'A。日志限制是 daemon.json 全局；TZ 与数据卷是容器级。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, 'docker history 能帮你做什么排障？', NULL, NULL, '看镜像每层构建指令与大小：定位"镜像为什么这么大"（哪层引入了大文件/没清理缓存）、验证 Dockerfile 变更是否生效（层时间戳）。CI 里给镜像瘦身提供依据。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 3, '如何设计容器的优雅停机链路（从 docker stop 到应用收尾）？', NULL, NULL, '1. ENTRYPOINT exec 格式（PID1 正确）
2. docker stop -t 30（宽限时间 ≥ 应用收尾耗时）
3. 应用注册 SIGTERM 钩子：停止接新请求→排空线程池→flush
4. 强杀前日志标记，便于区分"没收到信号"与"收尾太慢"
5. 编排层（K8s）再加 preStop/terminationGracePeriod
完整链路通才叫优雅。', NULL, '[\"必考\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'CHOICE', 1, '查看容器 IP 的最快方式？', NULL, '[\"A. docker inspect -f \\"{{.NetworkSettings.IPAddress}}\\" x\",\"B. docker ip x\",\"C. ifconfig\",\"D. ping容器名\"]', 'A。或进容器 ip a；compose 网络内直接用服务名。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(5, 'QA', 2, '容器一启动就退出且 logs 为空，从哪查起？', NULL, NULL, '1. inspect 看 ExitCode 与 Error（可能命令不存在/权限）
2. --entrypoint sh 手动进去跑原命令复现
3. 镜像架构不匹配（exec format error → ARM/x86）
4. 磁盘/配额
"logs空≠没原因"，inspect 是第二现场。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(6, 'CHOICE', 1, 'K8s 最小调度单位是？', NULL, '[\"A. 容器\",\"B. Pod\",\"C. Node\",\"D. Deployment\"]', 'B。Pod=共享网络/存储的一组容器（含 pause 基础容器持有网络栈）。', NULL, '[\"基础\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'etcd 在集群中的角色？', NULL, '[\"A. 计算节点\",\"B. 集群状态存储（唯一数据源）\",\"C. 网络插件\",\"D. 调度器\"]', 'B。备份集群=备份 etcd。apiserver 是唯一读写方。', NULL, '[\"架构\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'Service 默认类型是？', NULL, '[\"A. NodePort\",\"B. ClusterIP\",\"C. LoadBalancer\",\"D. ExternalName\"]', 'B。集群内虚拟IP；对外暴露依次是 NodePort（节点端口）→ LoadBalancer（云LB）。', NULL, '[\"Service\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'CrashLoopBackOff 的直接含义？', NULL, '[\"A. 调度失败\",\"B. 容器反复启动失败，kubelet指数退避重拉\",\"C. 镜像拉不下来\",\"D. 资源不足\"]', 'B。看 kubectl logs --previous。镜像拉取失败是 ImagePullBackOff，没调度上是 Pending。', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'readinessProbe 失败的效果？', NULL, '[\"A. 重启容器\",\"B. 从Service摘除流量\",\"C. 删除Pod\",\"D. 扩容\"]', 'B。liveness 失败才重启容器。滚动发布不断流靠 readiness。', NULL, '[\"探针\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'rolling update 中 maxSurge/maxUnavailable 默认值？', NULL, '[\"A. 25%/25%\",\"B. 50%/50%\",\"C. 10%/10%\",\"D. 0/100%\"]', 'A。maxSurge 可超频新增、maxUnavailable 允许下线量，都可为绝对数。maxUnavailable=0+maxSurge=1 即"先建后删"零不可用。', NULL, '[\"发布\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, '回滚上个版本的命令？', NULL, '[\"A. kubectl rollout undo deploy/api\",\"B. kubectl rollback\",\"C. kubectl delete --prev\",\"D. 重新apply旧yaml不必要\"]', 'A。--to-revision=N 指定版本；history 查看。旧 ReplicaSet 保留是回滚底气。', NULL, '[\"发布\",\"必背\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'Ingress 与 Service 的关系？', NULL, '[\"A. 替代Service\",\"B. Ingress按域名/路径路由到不同Service（七层）\",\"C. 四层转发\",\"D. 只做TLS\"]', 'B。链路：入口LB→ingress-controller(Pod)→按规则→各Service→Pod。', NULL, '[\"网络\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'ConfigMap 三种注入方式中哪种支持热更新？', NULL, '[\"A. 环境变量\",\"B. 卷挂载文件\",\"C. init容器\",\"D. command参数\"]', 'B。卷挂载会周期刷新（symlink切换）；env 注入后不变（Pod需重建）。', NULL, '[\"配置\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'Pod 状态 Pending 常见原因？', NULL, '[\"A. 应用崩溃\",\"B. 没节点能满足资源/亲和性/污点，或PVC未绑定\",\"C. 镜像错\",\"D. 网络错\"]', 'B。kubectl describe pod 的 Events 给答案：Insufficient cpu / node(s) had taint。', NULL, '[\"排障\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'StatefulSet 适用的场景特征？', NULL, '[\"A. 无状态\",\"B. 稳定网络标识+独立持久卷+有序伸缩（DB类）\",\"C. 一次性任务\",\"D. CronJob\"]', 'B。PodName-序号 稳定、PVC 跟随不回收、配套 headless service。无状态应用用 Deployment。', NULL, '[\"对象\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'HPA 默认依据什么扩缩容？', NULL, '[\"A. 内存\",\"B. CPU利用率（可配内存/自定义指标/QPS）\",\"C. 请求数\",\"D. 磁盘\"]', 'B。需要 metrics-server；自定义指标走 Prometheus Adapter。扩容快缩容慢（防抖动）。', NULL, '[\"伸缩\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 3, 'kube-proxy 的 ipvs 模式相比 iptables 优势？', NULL, '[\"A. 不需要\",\"B. 大规模服务下性能更好（哈希查找O(1) vs 线性规则遍历）\",\"C. 更安全\",\"D. 支持UDP\"]', 'B。Service 数千+时 iptables 规则更新与匹配都是瓶颈，ipvs 常是生产标配。', NULL, '[\"网络\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'PV 的回收策略 Retain 与 Delete 区别？', NULL, '[\"A. 一样\",\"B. Retain 保留数据需手动清理；Delete 随PVC删除存储\",\"C. Retain更省\",\"D. Delete保留\"]', 'B。数据库类慎用 Delete（PVC误删=数据没了）；云盘常 Retain+定期清理策略。', NULL, '[\"存储\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'annotations 与 labels 的区别？', NULL, '[\"A. 一样\",\"B. labels 用于选择器匹配（selector）；annotations 存非标识元数据（ingress类、构建信息）\",\"C. annotations用于调度\",\"D. labels只能字母\"]', 'B。kubectl get -l app=xx 就是 label selector；annotations 给工具/控制器读。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'Resource Requests 与 Limits 的作用分别？', NULL, '[\"A. 都限制\",\"B. Requests 供调度决策（预留）；Limits 上限（超内存被OOM杀，CPU被节流）\",\"C. Requests限制\",\"D. Limits调度\"]', 'B。调度看 requests 之和 vs 节点可分配；内存超 limit → OOMKilled；CPU超 limit → throttle（不杀）。', NULL, '[\"资源\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'namespace 的作用？', NULL, '[\"A. 网络隔离\",\"B. 资源配额与权限隔离的组织单位（默认不隔离网络）\",\"C. 节点分组\",\"D. 存储分区\"]', 'B。环境（dev/prod）或团队划分；配 ResourceQuota/LimitRange/RBQ。网络默认互通（隔离需 NetworkPolicy）。', NULL, '[\"基础\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 3, 'Job 与 CronJob 的 completions/parallelism 控制什么？', NULL, '[\"A. 副本数\",\"B. 完成Pod总数/并发数\",\"C. 重试\",\"D. 超时\"]', 'B。批处理三件套：completions 总数、parallelism 并发、backoffLimit 失败重试上限。', NULL, '[\"对象\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '描述一次 Pod 起不来的完整排查流程。', NULL, NULL, '四步定位法：
1. `kubectl get pods` 看状态归类：Pending/CrashLoop/ImagePull/RunContainer
2. `kubectl describe pod` 看 Events：调度失败原因、镜像拉取失败原因、探针失败
3. `kubectl logs --previous` 看上次崩溃日志
4. `kubectl exec` 进去复现（网络/依赖/配置）
按状态分流：Pending→资源/污点/PVC；CrashLoop→应用日志；ImagePull→凭证/名称/仓库', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '滚动更新期间如何保证不断流？（完整机制）', NULL, NULL, '1. maxSurge 新 Pod 先起、readiness 通过才加入 Service（Endpoints 挂载）
2. 旧 Pod 摘除：先从 Endpoints 摘（preStop sleep 5s 让 LB 感知）→ 发 TERM（应用优雅停）→ grace period 后 KILL
3. readiness 必须真实反映可用（别只查进程活）
4. preStop 钩子对长连接/注册中心场景关键

能说出 Endpoints 摘除时序就是实战派。', NULL, '[\"发布\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, 'K8s 里应用如何获取自己的真实需求配置（多环境）？', NULL, NULL, '1. ConfigMap 按环境分 namespace 或同名不同内容（overlay：kustomize base+overlays/prod）
2. 注入优先卷挂载（热更）或 envFrom
3. 敏感信息 Secret（+ 加密 etcd encryption at rest / 外部 KMS/Vault）
4. 镜像与环境解耦：一个镜像走天下，配置外置', NULL, '[\"配置\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, 'Service ClusterIP 为什么 ping 不通但 curl 通？', NULL, NULL, 'ClusterIP 是虚拟 IP，仅由 iptables/ipvs 规则拦截**特定端口**的 TCP/UDP 转发，没有真实设备响应 ICMP。所以 ping 不通是设计使然，curl vip:port 正常。排障别用 ping 测 Service。', NULL, '[\"网络\",\"经典\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 3, 'K8s 集群 etcd 怎么备份恢复？', NULL, NULL, '```
# 备份（任一 master）
ETCDCTL_API=3 etcdctl snapshot save /backup/etcd-$(date +%F).db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=... --cert=... --key=...
# 恢复（停 apiserver，所有节点）
etcdctl snapshot restore ... --data-dir=/var/lib/etcd-restore
```
要点：定期快照+异地保存+演练恢复（没演练过的备份=没有备份）。kubeadm 集群也可备份 pki 与 etcd 一并。', NULL, '[\"运维\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '节点 NotReady 怎么排查？', NULL, NULL, '1. `kubectl describe node` 看 conditions（MemoryPressure/DiskPressure/PIDPressure）
2. 上节点：systemctl status kubelet（证书过期/挂了是两大主因）
3. journalctl -u kubelet 看报错
4. PLEG not healthy：容器运行时无响应
5. 网络：节点与 apiserver 连通（6443）
6. 磁满：磁盘 <15% kubelet 自动驱逐压力
7. 处置：cordon 排空后修（drain --ignore-daemonsets）', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 3, 'Pod 间网络是怎么打通的（CNI 做了什么）？', NULL, NULL, '1. 同 Pod：lo（共享网络栈）
2. 同 Node：veth pair 连容器与网桥（cni0/br0）
3. 跨 Node：CNI 打隧道（VXLAN，Flannel）或云网络路由（VPC route，Terway）——Pod IP 全网唯一可达
4. NetworkPolicy 由 CNI 策略层实现（Calico）

答出"overlay 路由 + veth 网桥"即达标。', NULL, '[\"网络\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '如何安全地把一个有状态服务（如 MySQL）搬进 K8s？要点三步。', NULL, NULL, '1. **存储先行**：PV/PVC（云盘 StorageClass 动态分配）+ 备份策略（xtrabackup 定时到对象存储）
2. **StatefulSet + 探针**：有序实例、stable DNS、liveness 轻量、readiness 查同步状态；PodDisruptionBudget 保证维护期可用副本
3. **接入层**：Service 暴露 + 密码 Secret + 参数 ConfigMap；切换用主从复制蓝绿迁移（新集群做从库追平后切主）

提到 PDB 与"复制追平再切换"就是加分。', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, 'K8s 的资源限额怎么设置比较合理？', NULL, NULL, '1. 基线：压测/监控（Prometheus container metrics）得单实例 P95 用量
2. requests = 稳态值（影响调度密度），limits：内存=峰值×1.5（防OOM杀），CPU 可不设 limit（避免节流延迟抖动）或峰值×2
3. namespace 配 LimitRange 兜底 + ResourceQuota 总量控制
4. JVM 注意容器感知（8+自动），-Xmx 略小于 limit

"CPU 不设 limit"是很多大厂实践，说出理由即亮点。', NULL, '[\"资源\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, 'headless service 是什么？什么时候用？', NULL, NULL, 'clusterIP: None 的 Service——不做负载均衡，DNS 直接解析出所有 Pod IP 列表。用途：
1. StatefulSet 的稳定域名（web-0.mysql.ns.svc.cluster.local）
2. 客户端自己做负载均衡/直连（gRPC 长连接场景避免经 kube-proxy 丢失源IP）', NULL, '[\"网络\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 3, 'apiserver证书过期了怎么处理与预防？', NULL, NULL, '应急：
1. kubeadm 集群：kubeadm certs renew all && 重启 kubelet/控制面静态Pod
2. 手工签发的：重新签发替换文件并滚动重启组件
预防：
1. 监控证书有效期告警（openssl x509 -enddate | 提前30天）
2. kubeadm 升级时自动续期；长效方案 cert-manager 轮转
现象参考：kubectl 报 x509: certificate has expired。', NULL, '[\"运维\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, 'Deployment、ReplicaSet、Pod 三者关系？', NULL, NULL, 'Deployment 管理 ReplicaSet，ReplicaSet 保证副本数，Pod 是实例。每次改镜像 Deployment 新建一个 RS（旧保留），滚动=新旧 RS 副本此消彼长；回滚=调大旧 RS。kubectl get rs 能看到历史版本。', NULL, '[\"架构\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 3, '为什么 Java 应用镜像常常把 JVM 的容器感知参数专门设置？', NULL, NULL, '老 JVM（8u191前）看不到 cgroup 限额，按宿主内存算堆 → 容器512M limit 起了2G堆被 OOMKill。
现代 JVM 默认 MaxRAMPercentage 感知容器；推荐显式：-XX:MaxRAMPercentage=70.0（留30%给元空间/线程栈/直接内存），而不是写死 -Xmx。CPU 同理影响 GC 线程数。', NULL, '[\"调优\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '如何把 K8s 集群的审计做到位？', NULL, NULL, '1. apiserver 开启 audit log（policy 分级：metadata 级日常，requestbody 关键资源）
2. 日志外发（fluent-bit → ES）与留存（合规 180d+）
3. 告警规则：谁 exec 进了 prod Pod、谁改了 RBAC/Secret
4. RBQ 最小权限 + admission（OPA/Gatekeeper 禁 latest 镜像、禁特权容器）

答 OPA admission 是亮点。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'SCENARIO', 2, '发布后 5 分钟错误率升高，如何用 kubectl 快速回滚并保留现场？', NULL, NULL, '1. **先止血**：kubectl rollout undo deploy/api --to-revision=N（RevisionNo 由 rollout history 查）
2. rollout status 确认回滚完成 + 观察指标回落
3. **留现场**：保留问题 ReplicaSet（别删）；摘一个问题 Pod 日志：kubectl logs 保存；describe 存档；必要时 kubectl debug 抓现场
4. 复盘：为何预检没拦住（发布单加灰度验证步骤）

顺序意识：止血→保现场→复盘。', NULL, '[\"应急\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'SCENARIO', 3, '某个节点上 Pod 全部 Evicted，什么原因与处理？', NULL, NULL, '原因：节点资源压力（磁盘<15%、内存压力）kubelet 驱逐；或 preemption 抢占。
处理：
1. kubectl describe node 看 Pressure 状态
2. 磁盘：docker 日志/镜像占满清理（system df）
3. 内存：单 Pod 泄漏驱逐合理；整体超卖调 requests
4. Pod 侧：Evicted 的 Pod 不会自动重建则删掉重建；PodDisruptionBudget 保护关键服务
5. 长期：容量规划+节点资源预留（kube-reserved）', NULL, '[\"排障\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'SCENARIO', 3, '服务跨 namespace 访问数据库 Service 失败，可能原因？', NULL, NULL, '1. DNS 写全名：mysql.other-ns.svc.cluster.local（跨 ns 必须带 ns；同 ns 可短名）
2. NetworkPolicy 是否限制跨 ns 流量
3. 目标 ns 的 Service 存在且端口对（容器端口）
4. 验证：kubectl run tmp --rm -it --image=busybox -n 源ns -- wget -qO- http://mysql.other-ns:3306 连通性分层测试

考察：集群内 DNS FQDN 结构。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'kubectl apply 与 create 的区别？', NULL, '[\"A. apply 声明式可反复执行；create 一次性的\",\"B. 相同\",\"C. create更强\",\"D. apply删旧建新\"]', 'A。apply 记录 last-applied 配置支持 diff/回退；GitOps 全用 apply。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'Deployment 的 selector 的作用？', NULL, '[\"A. 匹配要管理的 Pod 标签\",\"B. 选节点\",\"C. 选Service\",\"D. 选namespace\"]', 'A。selector 与 Pod labels 不匹配=管不到（部署成功但副本0排障点）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'kubectl exec 临时容器与普通 exec 的场景差异？', NULL, '[\"A. 容器无 shell/工具时用 ephemeral container（kubectl debug）\",\"B. 相同\",\"C. 前者更快\",\"D. 后者更安全\"]', 'A。distroless 镜像排障标配：kubectl debug -it pod --image=busybox --target=x。', NULL, '[\"排障\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'PodDisruptionBudget 保护什么？', NULL, '[\"A. 主动运维（drain/升级）期间的至少可用副本\",\"B. 宕机\",\"C. 网络\",\"D. 配额\"]', 'A。minAvailable: 2 让自愿驱逐遵循可用性；节点故障（非自愿）它不管。', NULL, '[\"高可用\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'terminationGracePeriodSeconds 默认值与作用？', NULL, '[\"A. 30秒；TERM后到KILL的宽限期\",\"B. 10秒\",\"C. 5分钟\",\"D. 无限\"]', 'A。长任务/优雅停机不足时调大；配合 preStop sleep 让 LB 先摘流量。', NULL, '[\"发布\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'nodeSelector 与 affinity 的差别？', NULL, '[\"A. 前者简单匹配；后者支持偏好/反亲和/软约束\",\"B. 相同\",\"C. 后者废弃\",\"D. 前者更灵活\"]', 'A。生产常用 podAntiAffinity 把同服务副本打散到不同节点。', NULL, '[\"调度\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'taint/toleration 与 affinity 的分工？', NULL, '[\"A. taint 驱赶（节点拒绝）；toleration 容忍；affinity 吸引（Pod挑选）\",\"B. 都一样\",\"C. 反的\",\"D. 无关联\"]', 'A。专用节点：打 taint + 目标负载 toleration。', NULL, '[\"调度\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'kube-scheduler 调度失败最常见三类原因？', NULL, '[\"A. 资源不足/亲和冲突/PVC未绑定\",\"B. 网络断\",\"C. 镜像拉不下\",\"D. API超时\"]', 'A。describe 的 Events 会写 Insufficient xxx。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'Endpoints 与 EndpointSlice 的关系？', NULL, '[\"A. EndpointSlice 是 Endpoints 的扩展替代（大规模性能）\",\"B. 无关\",\"C. 前者新\",\"D. 同一对象两个名\"]', 'A。Service 后端实际指向；排 "Service 不通" 先看 endpoints 是否为空（selector/labels 不匹配）。', NULL, '[\"网络\",\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'Service externalTrafficPolicy: Local 的意义？', NULL, '[\"A. 只转发本节点Pod（保源IP，牺牲跨节点）\",\"B. 更快\",\"C. 安全\",\"D. 必开\"]', 'A。需要真实客户端IP的 NodePort/LB 场景；Cluster 模式 SNAT 丢源IP。', NULL, '[\"网络\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'K8s 中 Secret 的 base64 与加密的区别？', NULL, '[\"A. base64只是编码；加密需 etcd encryption at rest/外部KMS\",\"B. base64就是加密\",\"C. 自动加密\",\"D. 无Secret机制\"]', 'A。RBAC 控制 + 静态加密 + 审计才是完整方案。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'Helm chart 的 values 覆盖顺序（低→高）？', NULL, '[\"A. 默认values → values.yaml → -f 覆盖 → --set\",\"B. --set最低\",\"C. 随机\",\"D. 只认--set\"]', 'A。多环境：同一 chart + 不同 values 文件。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 3, 'Pod QoS 等级 Guaranteed 的条件？', NULL, '[\"A. 每个容器 requests=limits（CPU与内存都设）\",\"B. 只设limits\",\"C. 不设\",\"D. 内存大\"]', 'A。驱逐顺序：BestEffort → Burstable → Guaranteed。核心服务建议 Guaranteed。', NULL, '[\"资源\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 3, 'etcd quorum 丢失（多数节点挂）集群会？', NULL, '[\"A. 只读保护（不可写），多数恢复后自愈\",\"B. 完全不可用含读\",\"C. 自动重建\",\"D. 选新主继续写\"]', 'A。3节点挂2=不可写。这就是控制面建议3或5节点奇数的原因。', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 3, 'kubectl drain 做了什么？', NULL, '[\"A. cordon不可调度+驱逐Pod（遵守PDB）\",\"B. 关机\",\"C. 删节点\",\"D. 重启kubelet\"]', 'A。维护窗口标准动作：drain → 维修 → uncordon。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, 'Service 访问不通的排查五步。', NULL, NULL, '1. endpoints 是否有地址（selector/labels 匹配？）
2. Pod 本身 ready？（readiness 没过不在 endpoints）
3. 用 ClusterIP+port curl（注意是 Service port 还是 targetPort）
4. 临时 pod 分层测：DNS 名 → IP → 直连 Pod
5. NetworkPolicy/kube-proxy(ipvs/iptables) 状态

80% 是 selector 不匹配或 readiness 没过。', NULL, '[\"排障\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '如何给 K8s 里的 Java 服务做优雅发布（完整链路）？', NULL, NULL, '1. 镜像 tag 唯一 + readiness 真实健康
2. preStop: sleep 10（等LB摘流）+ 应用 SIGTERM 优雅停（线程池排空）
3. terminationGracePeriodSeconds ≥ 停机时长
4. maxSurge/maxUnavailable 控制节奏
5. 发布中 pause 观察 P99/错误率，异常 undo
6. 数据库变更提前单独发布且向后兼容', NULL, '[\"发布\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 3, '集群证书、组件、节点的巡检清单（月度）。', NULL, NULL, '1. 证书：kubeadm certs check-expiration（<30天告警）
2. 组件：systemctl status kubelet、控制面静态Pod 状态
3. etcd：健康+延迟+磁盘（db size）+快照备份可恢复演练
4. 节点：NotReady、Pressure、内核版本一致性
5. 漏洞：镜像 CVE 扫描、kube-bench（CIS基线）
6. 容量：各节点分配率/水位趋势', NULL, '[\"运维\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'kubeadm init 生成的 join 有效期与重生成？', NULL, '[\"A. 默认24h；kubeadm token create --print-join-command\",\"B. 永久\",\"C. 1h不可重发\",\"D. 无法\"]', 'A。过期加入失败的常见处理。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'ConfigMap 大小限制？', NULL, '[\"A. ~1MB（etcd 单对象限制）\",\"B. 无限制\",\"C. 10MB\",\"D. 100KB\"]', 'A。大配置拆分或改用挂载文件/对象存储。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'Pod 重启次数高但当前 Running，先看什么？', NULL, '[\"A. RESTARTS 与上次退出原因（describe 的 Last State + logs --previous）\",\"B. 直接删\",\"C. 看 CPU\",\"D. 无需关注\"]', 'A。CrashLoopOff 的前置形态；退出码 137→OOM，1→应用错。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'kubectl get 的 -o wide 多给你什么？', NULL, '[\"A. IP/节点名（pod）或端口（svc）\",\"B. 更多日志\",\"C. 事件\",\"D. 权限\"]', 'A。快速看调度分布与 IP 的捷径。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, '一个 Service select 不到 Pod 但 Pod Ready，最可能？', NULL, '[\"A. labels 与 selector 不匹配（targetPort 也常错）\",\"B. 网络错\",\"C. DNS\",\"D. 节点满\"]', 'A。kubectl get endpoints 一眼看穿（空=选择器问题）。', NULL, '[\"排障\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'kubectl cp 的等价底层实现？', NULL, '[\"A. exec tar 流传输\",\"B. 挂载\",\"C. API 直读\",\"D. scp直连\"]', 'A。所以容器没 tar 时会失败（报错特征）。', NULL, '[\"命令\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 3, 'Pod OOMKilled 但 limits 设的 4G 而 JVM Xmx 3G，可能？', NULL, '[\"A. 堆外（直接内存/元空间/线程栈）超预算\",\"B. 不可能\",\"C. K8s记错\",\"D. 磁盘问题\"]', 'A。MaxDirectMemorySize、线程数×栈、Native 库都会吃堆外——容器内存账要全算。', NULL, '[\"调优\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '怎么把运行中 Pod 的完整现场保存下来供离线分析？', NULL, NULL, '```bash
kubectl describe pod x > x.describe
kubectl logs x --all-containers --previous > x.log
kubectl get pod x -o yaml > x.yaml
kubectl get events --sort-by=.lastTimestamp > events.txt
# 深度：kubectl debug（ephemeral容器）进现场 jstack/heap dump
```
先保现场再重启——排障纪律。', NULL, '[\"排障\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 3, '集群 API 延迟高（kubectl 卡），排查方向？', NULL, NULL, '1. apiserver 负载：etcd 延迟（etcd metrics grpc 与 fsync）、请求 QPS（--max-requests-inflight）
2. LIST 大对象（大量 CRD/事件未过期）——监控 WATCH/LIST 慢查询
3. 控制面资源不足（master 规格小）
4. 客户端侧：大量控制器频繁 full-list（应用自带 informer 配置不当）
5. 升级/ Velero 等任务集中 LIST
体现"apiserver 是唯一入口，etcd 是瓶颈底座"的认知。', NULL, '[\"性能\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'kubectl get all 包含什么？', NULL, '[\"A. svc/deploy/pod/replicaset 等（不含secret/cm）\",\"B. 一切资源\",\"C. 只pod\",\"D. 节点\"]', 'A。快速总览命名空间工作负载。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'Pod 的 restartPolicy 默认？', NULL, '[\"A. Always\",\"B. Never\",\"C. OnFailure\",\"D. 随机\"]', 'A。Job 里必须改 Never/OnFailure 否则失败无限重启。', NULL, '[\"基础\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'deployment 的 revisionHistoryLimit？', NULL, '[\"A. 保留历史RS数量（回滚余地）\",\"B. 镜像版本数\",\"C. 副本数\",\"D. 无意义\"]', 'A。设0=不能rollout undo——谨慎缩减。', NULL, '[\"发布\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'Service 的 targetPort 与 port 区别？', NULL, '[\"A. port 对外（svc）；targetPort 容器实际端口\",\"B. 相同\",\"C. 反的\",\"D. 仅LB用\"]', 'A。nodePort 才是节点端口。三端口概念必须分清。', NULL, '[\"网络\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'configmap 挂载后应用没读到新值，原因？', NULL, '[\"A. env注入不热更（需重启）或卷刷新延迟~1分钟\",\"B. K8s不支持热更\",\"C. 必须删pod\",\"D. API问题\"]', 'A。可靠做法：checksum 注解触发滚动。', NULL, '[\"配置\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 3, 'Pod 处于 Terminating 很久，常见原因？', NULL, '[\"A. finalizer未移除/preStop卡住/挂载卸载失败/PDB限制\",\"B. 正常\",\"C. 网络问题\",\"D. API server挂\"]', 'A。describe 看 events；finalizers 字段非空时需手动处理（理解后果后）。', NULL, '[\"排障\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '如何查询某节点上跑了哪些 pod？', NULL, NULL, '```bash
kubectl get pods -A --field-selector spec.nodeName=node1
```
排障单节点（资源/驱逐）时用。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '想让某个 Pod 固定调度到指定节点，有几种方式？', NULL, NULL, '1. nodeName（直接指定，最硬）
2. nodeSelector（标签匹配）
3. nodeAffinity requiredDuringScheduling（表达式更灵活）
4. 污点+容忍（专用节点专用负载，推荐）
固定调度常用于 GPU/许可证绑定/本地盘场景。', NULL, '[\"调度\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 3, '集群里某节点频繁 NotReady 又自愈，怎么排查？', NULL, NULL, '1. 时间轴对齐：kubelet 日志（journalctl -u kubelet）在掉线前报什么（证书/PLEG/内存）
2. 节点资源：内存压力 OOM 杀 kubelet？磁盘满？
3. 网络：节点与 apiserver 6443 链路抖动（mtr 长跑）
4. 容器运行时无响应（containerd 日志）
5. 联动：cordon 该节点摘流后深入
"间歇性"问题靠长周期日志与监控留存。', NULL, '[\"排障\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'K8s 中"命名空间"被删卡住，常因为？', NULL, '[\"A. 里面有资源的 finalizer 未完成\",\"B. 网络慢\",\"C. 正常\",\"D. 权限\"]', 'A。kubectl get ns x -o yaml 看 spec.finalizers；处理完依赖（如 LB/存储未释放）再清。', NULL, '[\"排障\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 2, 'HPA 扩容后 Pod Pending，先看？', NULL, '[\"A. describe 新 Pod 的 Events（资源/配额）\",\"B. 重启HPA\",\"C. 删HPA\",\"D. 网络\"]', 'A。常见：集群资源不足或 namespace ResourceQuota 顶满。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, 'K8s 集群里如何给所有节点统一打标签/污点？', NULL, NULL, 'kubectl label node <selector> key=value --overwrite；批量：for/kubectl get -o name 遍历。污点 kubectl taint node x key=value:NoSchedule。标签是调度体系（nodeSelector/affinity）的基础数据，命名规范先行（env/role/zone）。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 3, '业务要 7×24，K8s 集群自身升级怎么做？', NULL, NULL, '1. 控制面逐节点（kubeadm upgrade）：先 etcd 备份；apiserver 轮转
2. worker 逐台 drain→升级→uncordon（PDB 保业务副本数）
3. 版本策略：一次小版本、先预发集群
4. 兼容性：kubelet 不得高于 apiserver；先看 release note 的废弃项
5. 回退预案与断点续做
答"逐台+PDB+备份"即专业。', NULL, '[\"运维\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'CHOICE', 1, 'kubectl set image deploy api api=img:v2 的作用？', NULL, '[\"A. 滚动更新镜像\",\"B. 只改配置不发布\",\"C. 重启\",\"D. 扩容\"]', 'A。触发滚动发布；rollout status 观察进度。', NULL, '[\"发布\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(6, 'QA', 2, '如何查 Pod 被调度到的节点与 IP？', NULL, NULL, '```bash
kubectl get pod x -o wide
# 或
kubectl get pod x -o custom-columns=NODE:.spec.nodeName,IP:.status.podIP
```
登录该节点可 docker/ctr 看到对应容器。', NULL, '[\"命令\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(1, 'CHOICE', 1, '查看当前目录下所有文件（含隐藏文件）的详细信息，用哪个命令？', NULL, '[\"A. ls -l\",\"B. ls -a\",\"C. ls -la\",\"D. ls -R\"]', 'C。ls -l 详细列表，-a 含隐藏文件，-la 合并两者。', NULL, '[\"基础\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '命令 cp -r /src /dest 的 -r 表示？', NULL, '[\"A. 覆盖前确认\",\"B. 递归复制目录\",\"C. 保留权限\",\"D. 显示过程\"]', 'B。-r 递归处理目录及其子目录；保留权限是 -p；确认是 -i。', NULL, '[\"基础\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '删除一个非空目录 /tmp/old 应使用？', NULL, '[\"A. rm /tmp/old\",\"B. rmdir /tmp/old\",\"C. rm -rf /tmp/old\",\"D. del /tmp/old\"]', 'C。rm -rf 递归强制删除；rmdir 只能删空目录。生产慎用 -rf，路径最好用绝对路径且先 ls 确认。', NULL, '[\"基础\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看文件末尾 100 行并持续跟踪新内容？', NULL, '[\"A. tail -100f x.log\",\"B. head -100 x.log\",\"C. cat -n x.log\",\"D. less x.log\"]', 'A。tail -100f = 显示末尾100行并 follow；等价 tail -n 100 -f。', NULL, '[\"日志\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '权限 -rwxr-x--- 对应数字是？', NULL, '[\"A. 755\",\"B. 750\",\"C. 754\",\"D. 740\"]', 'B。rwx=7, r-x=5, ---=0 → 750。', NULL, '[\"权限\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '把文件属主和属组一起改为 app:app？', NULL, '[\"A. chmod app:app f\",\"B. chown app:app f\",\"C. chgrp app f\",\"D. usermod app f\"]', 'B。chown 改属主（可带属组）；chgrp 只改属组。', NULL, '[\"权限\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看系统当前登录用户？', NULL, '[\"A. who / w\",\"B. whoami\",\"C. last\",\"D. id\"]', 'A。who/w 显示所有登录会话；whoami 只显示自己；last 是历史登录。', NULL, '[\"用户\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '切换用户执行命令且加载其环境变量：su - app -c "cmd"，其中 "-" 的作用？', NULL, '[\"A. 减少权限\",\"B. 模拟完整登录（加载 profile）\",\"C. 后台执行\",\"D. 无意义\"]', 'B。带 - 是 login shell，会加载目标用户环境变量；不带则继承当前环境（PATH 可能不对，脚本里常见坑）。', NULL, '[\"用户\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看进程 1234 打开了哪些文件？', NULL, '[\"A. lsof -p 1234\",\"B. ls -p 1234\",\"C. stat 1234\",\"D. file 1234\"]', 'A。lsof -p 列进程打开的所有文件、socket、管道，排障神器。', NULL, '[\"进程\",\"排障\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'nohup 命令的作用？', NULL, '[\"A. 提升优先级\",\"B. 挂起信号忽略，退出终端后进程继续运行\",\"C. 立即执行\",\"D. 定时执行\"]', 'B。nohup 忽略 SIGHUP，配合 & 后台运行，终端关闭不影响。', NULL, '[\"进程\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看系统内存使用情况最直观的命令？', NULL, '[\"A. free -h\",\"B. df -h\",\"C. du -sh\",\"D. vmstat\"]', 'A。free -h 人类可读显示内存；df 是磁盘分区；du 是目录大小。注意 available 才是真正可用（buff/cache 可回收）。', NULL, '[\"内存\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'df -h 与 du -sh 的区别？', NULL, '[\"A. 没区别\",\"B. df 看文件系统使用率，du 统计目录实际占用\",\"C. du 更快\",\"D. df 只看内存\"]', 'B。df 从文件系统超级块读全局使用率；du 逐文件累加。两者差异大时提示：删除的文件仍被进程占用（lsof | grep deleted）。', NULL, '[\"磁盘\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查找 /var/log 下 7 天内修改过的 .log 文件？', NULL, '[\"A. find /var/log -name \\"*.log\\" -mtime +7\",\"B. find /var/log -name \\"*.log\\" -mtime -7\",\"C. find /var/log \\"*.log\\" -time 7\",\"D. grep -7 /var/log\"]', 'B。-mtime -7 表示7天内修改；+7 是7天前；-mtime 7 是恰好第7天。', NULL, '[\"find\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '在文件 huge.txt 中查找包含 "error" 的行并显示行号？', NULL, '[\"A. grep error huge.txt\",\"B. grep -n error huge.txt\",\"C. find error huge.txt\",\"D. awk error huge.txt\"]', 'B。grep -n 显示行号；-i 忽略大小写；-v 反选；-c 计数。', NULL, '[\"grep\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '统计文件行数？', NULL, '[\"A. wc -l file\",\"B. count file\",\"C. line file\",\"D. cat -n | sum\"]', 'A。wc -l 行数；-w 单词；-c 字节。常配合管道：ps aux | wc -l。', NULL, '[\"基础\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '建立 /opt/app/current → /opt/app/v2.1 的软链接？', NULL, '[\"A. ln /opt/app/v2.1 /opt/app/current\",\"B. ln -s /opt/app/v2.1 /opt/app/current\",\"C. link -s v2.1 current\",\"D. cp -s v2.1 current\"]', 'B。ln -s 源 目标。软链接是发布切换（蓝绿/版本目录）的经典手段。', NULL, '[\"文件\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '把命令 mytask 放到后台并脱离当前会话运行？', NULL, '[\"A. mytask &\",\"B. nohup mytask &\",\"C. bg mytask\",\"D. disown -a\"]', 'B。& 只放后台，终端退出仍可能被 HUP；nohup + & 才能脱离会话。已运行的作业可用 disown 补救。', NULL, '[\"进程\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'top 里 load average 三个值的含义？', NULL, '[\"A. CPU/内存/IO 使用率\",\"B. 1/5/15 分钟平均负载\",\"C. 用户/系统/空闲\",\"D. 运行/睡眠/停止进程数\"]', 'B。分别是 1、5、15 分钟的系统负载均值（可运行+不可中断进程数），用于看趋势。', NULL, '[\"性能\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看内核日志（如 OOM 记录）的命令？', NULL, '[\"A. kmsg\",\"B. dmesg -T\",\"C. syslog -a\",\"D. kern.log -f\"]', 'B。dmesg 读取内核环形缓冲区，-T 人类可读时间。OOM Kill、硬件报错、TCP 拒绝等第一现场。', NULL, '[\"排障\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'ulimit -n 控制的是？', NULL, '[\"A. 进程数上限\",\"B. 每进程打开文件描述符上限\",\"C. 内存上限\",\"D. CPU 时间\"]', 'B。文件描述符上限，高并发服务（Too many open files）必调项。永久生效需写 /etc/security/limits.conf 或 systemd LimitNOFILE。', NULL, '[\"调优\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看某个端口（8080）当前 TCP 连接数？', NULL, '[\"A. ss -ant | grep 8080 | wc -l\",\"B. netstat -p 8080\",\"C. lsof 8080 count\",\"D. ss --count 8080\"]', 'A。ss 过滤后计数；或 ss -ant state established "( sport = :8080 )" | wc -l。', NULL, '[\"网络\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '快速创建 1GB 测试文件？', NULL, '[\"A. touch big && resize 1G\",\"B. dd if=/dev/zero of=big bs=1M count=1024\",\"C. mkfile 1G big\",\"D. cat /zero > big\"]', 'B。dd 标准做法；要稀疏文件用 truncate -s 1G big（瞬间完成、不占实际空间）。', NULL, '[\"磁盘\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'journalctl 查看 nginx 服务最近 1 小时日志？', NULL, '[\"A. journalctl -u nginx --since \\"1 hour ago\\"\",\"B. journalctl nginx -t 60m\",\"C. logctl nginx\",\"D. journal nginx --last 1h\"]', 'A。-u 指定单元，--since 支持自然语言时间。加 -f 跟随。', NULL, '[\"systemd\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'systemctl enable 与 start 的区别？', NULL, '[\"A. 一样\",\"B. start 立即启动，enable 设置开机自启（软链接到 multi-user.target.wants）\",\"C. enable 立即启动\",\"D. start 是自启\"]', 'B。两者独立：可只 start 不自启，或 enable 未启动。生产常组合 enable --now。', NULL, '[\"systemd\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看当前用户的 crontab 列表？', NULL, '[\"A. crontab -l\",\"B. cron --list\",\"C. cat /etc/crontab\",\"D. crontab -e\"]', 'A。-l 查看，-e 编辑。/etc/crontab 是系统级（多了用户字段）。', NULL, '[\"crontab\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看某进程 1234 的启动时间和命令行？', NULL, '[\"A. ps -p 1234 -o lstart,cmd\",\"B. top -p 1234 -c\",\"C. ls /proc/1234\",\"D. A 和 C 都可以\"]', 'D。ps -o lstart,cmd 直接显示；/proc/1234/stat、cmdline 也有（cmdline 用空格分隔参数，tr "\0" " " 查看）。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '以下哪个不是查看 CPU 核数的正确方式？', NULL, '[\"A. nproc\",\"B. lscpu\",\"C. cat /proc/cpuinfo | grep -c processor\",\"D. free -h\"]', 'D。free 看内存。其余都是 CPU 信息。注意超线程：lscpu 的 CPU(s) 是逻辑核。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, '进程状态 D 表示？', NULL, '[\"A. 僵尸\",\"B. 不可中断睡眠（通常在等 IO）\",\"C. 停止\",\"D. 死锁\"]', 'B。D 状态大量出现且 load 飙高 = IO 子系统问题（磁盘坏、NFS 挂死）。Z 才是僵尸，T 是停止。', NULL, '[\"进程\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看目录本身的属性而非其内容：ls -ld /var 的 -d 作用？', NULL, '[\"A. 递归\",\"B. 只显示目录本身\",\"C. 按时间排序\",\"D. 显示隐藏\"]', 'B。检查目录权限（如应用能否进入目录）时必用，否则 ls 的是目录内的文件。', NULL, '[\"权限\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'tar 打包压缩目录 app 为 app.tar.gz？', NULL, '[\"A. tar -czf app.tar.gz app\",\"B. tar -xf app.tar.gz app\",\"C. zip app app.tar.gz\",\"D. gzip -r app\"]', 'A。-c 创建 -z gzip -f 文件名；解压 -xzf。备份脚本基本功。', NULL, '[\"备份\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看服务器已运行多长时间及当前负载？', NULL, '[\"A. uptime\",\"B. time\",\"C. whoami\",\"D. top -n 1\"]', 'A。uptime 一行输出：时间、运行时长、登录用户数、1/5/15分钟负载。', NULL, '[\"基础\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, '绝对路径和相对路径的区别？. 和 .. 分别代表什么？', NULL, NULL, '绝对路径从 / 开始，任何位置都有效；相对路径基于当前目录。. 是当前目录，.. 是上级目录。脚本里引用文件建议用绝对路径，避免因执行目录不同而找不到文件（crontab 里最常见的坑）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, '简述 rwx 对文件和对目录的区别？', NULL, NULL, '对文件：r 读内容、w 改内容、x 可执行。
对目录：r 能列出文件名（ls）、w 能增删文件、x 能进入目录（cd）和访问内部文件。

常见坑：有目录 x 无 r 则不能 ls 但知道文件名仍可访问；目录只给 r 不给 x 几乎无用。删除文件需要的是**目录**的 w+x，与文件自身权限无关。', NULL, '[\"权限\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '什么是 umask？怎么给新文件设置默认权限 640？', NULL, NULL, 'umask 是权限掩码，新文件权限 = 默认权限 - umask（文件默认666，目录777）。

640 文件：umask = 666-640 = 026。
```
umask 026          # 当前会话生效
echo "umask 026" >> ~/.bashrc   # 永久
```
应用侧常用于保证新建日志/上传文件不给其他用户读。', NULL, '[\"权限\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '特殊权限位 SUID/SGID/Sticky 分别是什么？各举一典型例子。', NULL, NULL, '- **SUID**（作用于可执行文件）：执行时以文件属主身份运行。例：/usr/bin/passrd（普通用户改密码要写 /etc/shadow）
- **SGID**（目录）：目录内新建文件自动继承目录属组。例：团队共享目录 /data/share 设组 dev，新文件自动属组 dev
- **Sticky**（目录）：只有文件属主能删除自己的文件。例：/tmp（所有人可写但不能互删）

数字表示：SUID=4 SGID=2 Sticky=1，放在权限最前（如 1777 = rwxrwxrwt）。', NULL, '[\"权限\",\"进阶\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '怎么找出系统里所有 SUID 的文件？为什么要定期检查？', NULL, NULL, '```
find / -perm -4000 -type f 2>/dev/null
```
安全巡检项：SUID 程序若存在漏洞可被用来提权（如历史 CVE 的 exim/find 等）。发现非标准的 SUID 文件（如 /tmp 下）基本可判定入侵痕迹。', NULL, '[\"权限\",\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, 'vim 中如何快速跳到文件头、文件尾、第 100 行？如何搜索关键词？', NULL, NULL, '```
gg       跳到文件头
G        跳到文件尾
:100     跳到第100行
/error   向后搜索 error（n 下一个，N 上一个）
?error   向前搜索
```
排障看大日志时 :set nu 显示行号、/关键字 定位是基本功。', NULL, '[\"vim\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, 'less 和 more 的区别？less 下常用操作有哪些？', NULL, NULL, 'less 支持前后翻页和搜索，more 只能向后。less 常用：空格翻页、b 上翻、/搜索、G 到尾、q 退出、F 进入跟随模式（类似 tail -f，Ctrl+C 退出跟随）。大文件用 less 代替 cat 避免刷屏。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '进程、线程、协程的区别（运维视角）？', NULL, NULL, '- **进程**：资源分配单位，独立内存空间。ps 看到的基本单位。Java 一个 JVM 是一个进程
- **线程**：CPU 调度单位，共享进程内存。Java 多线程；top -H / ps -eLf 可见
- **协程**：用户态轻量"线程"，切换不进内核（Go goroutine、Kotlin 协程），单线程内可跑百万级

运维关注点：进程数（fork 炸弹防护 ulimit -u）、线程数（Java 线程泄漏排查 jstack）。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '什么是孤儿进程和守护进程（daemon）？', NULL, NULL, '- **孤儿进程**：父进程先退出，子进程被 init/PID 1 收养，最终正常退出回收，无害
- **守护进程**：脱离终端、在后台长期运行的服务进程（sshd、crond、nginx master）。特征：父进程是1、无控制终端（TTY 为 ?）

查看守护进程：ps -eo pid,ppid,tty,cmd | awk ''$2==1 && $3=="?"''', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何让一个普通用户临时拥有 root 权限执行特定命令（不用给 root 密码）？', NULL, NULL, '配置 sudo 白名单：visudo 添加
```
appuser ALL=(root) NOPASSWD: /usr/bin/systemctl restart myapp, /usr/bin/tail /var/log/myapp/*
```
优点：审计（/var/log/secure 记录）、最小权限、免密指定命令。比直接给 root 或 setuid 更安全，是企业标配做法。', NULL, '[\"用户\",\"sudo\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '服务器被疑似入侵，第一时间该做哪些检查？（应急响应入门）', NULL, NULL, '1. **看异常进程**：top / ps aux --sort=-%cpu，重点看 CPU 高且名字怪异的
2. **看网络连接**：ss -antp 找外连可疑 IP；ls -l /proc/<pid>/exe 确认程序真实路径
3. **看登录痕迹**：last、lastb（失败登录）、who
4. **看定时任务**：crontab -l、ls /etc/cron.*、/var/spool/cron/（挖矿常用持久化）
5. **看新增 SUID**：find / -perm -4000
6. **止损**：断外连（iptables/安全组）、kill 进程、删除持久化、改密码
7. **保留证据**：打包 /proc 信息与日志再操作', NULL, '[\"安全\",\"应急\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, '说明 /etc/passwd 一行各字段含义？', NULL, NULL, '```
appuser:x:1001:1001::/home/appuser:/bin/bash
用户名:密码占位x:UID:GID:描述:家目录:shell
```
- 密码在 /etc/shadow（passwd 里只有 x）
- shell 为 /sbin/nologin 表示禁止登录（服务账号）
- UID 0 是 root；系统账号通常 <1000', NULL, '[\"用户\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何给用户追加一个附加组而不影响已有组？', NULL, NULL, '```
usermod -aG docker appuser
```
**关键 -a（append）**：不加 -a 会把用户移出其他所有组（覆盖式），是经典事故操作。改完重新登录生效（newgrp 免重登）。', NULL, '[\"用户\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, '硬链接有什么限制？为什么 /tmp 下不同分区的文件不能互建硬链接？', NULL, NULL, '硬链接本质是同一 inode 的多个目录项，因此：
1. **不能跨文件系统**（inode 号只在单个文件系统内唯一）
2. 不能对目录建（防止环）
3. 删除原"文件名"不影响数据（引用计数>0）

软链接存路径字符串，无以上限制。ln 不带 -s 即硬链接。', NULL, '[\"文件\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'mount 挂载选项 noatime 是干什么的？什么时候用？', NULL, NULL, '关闭访问时间更新（atime）。每次读文件都更新 atime 会产生额外写 IO；数据库、日志密集型服务挂盘常加 noatime 减少无谓 IO。数据盘 fstab 示例：
```
/dev/sdb1 /data ext4 defaults,noatime 0 2
```', NULL, '[\"磁盘\",\"调优\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何查看和修改系统时间？时间不同步对服务有什么影响？', NULL, NULL, '```
date                        # 查看
timedatectl                 # 时区/NTP状态
timedatectl set-timezone Asia/Shanghai
chronyc sources -v          # chrony 同步源
```
影响：日志时间错乱、证书校验失败（HTTPS 报时间错误）、分布式锁/订单超时异常、K8s 证书过期误判。生产必须 NTP（chrony）。', NULL, '[\"基础\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '简述 Linux 开机启动流程（systemd 时代）。', NULL, NULL, '1. BIOS/UEFI 自检 → 选启动盘
2. Bootloader（GRUB2）加载内核与 initramfs
3. 内核初始化：驱动、挂载根分区（initramfs 负责切换）
4. 启动 PID 1 = systemd
5. systemd 按依赖启动默认 target（multi-user / graphical）下的服务

排障相关：内核起不来看 GRUB 编辑（rd.break 救援）；服务顺序问题看 After/Requires。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'systemd 服务单元文件里 Type=notify 和 Type=simple 的区别？', NULL, NULL, '- **simple**：fork 就绪即认为启动完成（实际应用可能还没准备好）
- **notify**：服务主动调 sd_notify("READY=1") 才算就绪，systemd 会在此时才启动依赖它的服务
- **forking**：主进程 fork 子进程后退出

Java 应用接入 notify 需要额外支持；常用 simple + exec 前缀。语义准确性影响"服务就绪"判断和启动顺序。', NULL, '[\"systemd\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '怎么限制某个服务（systemd）的内存和重启策略？', NULL, NULL, '单元文件：
```
[Service]
MemoryMax=512M
Restart=on-failure
RestartSec=5
```
systemctl daemon-reload 生效。相比 shell 启动脚本，systemd 自带资源限额（cgroups）与自愈（Restart），是无容器部署的标准做法。', NULL, '[\"systemd\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'rsync 与 cp/scp 的区别？常用参数？', NULL, NULL, 'rsync 增量同步（只传差异块）、支持断点续传、删除同步、排除规则：
```
rsync -avz --delete --exclude "*.log" /data/src/ user@backup:/data/backup/
```
- -a 归档（保留权限时间等）、-v 详细、-z 压缩
- **注意结尾斜杠**：src/ 是目录内容，src 是整个目录
- --delete 让目标与源完全一致（危险参数，先 --dry-run 演练）

备份/发布同步首选；scp 只能整文件复制。', NULL, '[\"备份\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '服务器卡顿，如何区分是 CPU、内存、还是 IO 瓶颈？', NULL, NULL, '一套组合拳：
1. `vmstat 1`：us 高=CPU 逻辑问题；sy 高=系统调用/上下文切换；**wa 高=IO 等待**
2. `free -h`：available 低、swap used 增长 = 内存压力
3. `iostat -x 1`：%util 接近100、await 高 = 磁盘瓶颈
4. `sar -q 1`：runq-sz 持续大于核数 = CPU 排队

定位层次后再向下钻（CPU→进程/线程栈；IO→哪个盘哪个进程 iotop）。', NULL, '[\"性能\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'swappiness 参数是什么？数据库机器为什么常调低？', NULL, NULL, 'vm.swappiness（0-100）控制内核使用 swap 的倾向，值越高越积极换出内存页。
数据库（MySQL/Redis）机器常设 10 甚至 1：数据页被换出到 swap 会造成不可控的慢查询（Page Cache 频繁换入换出）。
```
sysctl vm.swappiness=10       # 临时
echo "vm.swappiness=10" >> /etc/sysctl.conf && sysctl -p
```', NULL, '[\"调优\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, '什么是 NUMA？Java/数据库大内存机器为什么要关注？', NULL, NULL, '多路 CPU 架构下每个 CPU 有本地内存，跨 NUMA 节点访存延迟显著更高。
- numactl --hardware 查看拓扑
- 进程内存跨节点（numastat 的 other_node 高）会莫名变慢
- 常见做法：numactl --interleave=all 弥散分配，或绑节点跑

大内存 Java/MySQL 机器性能调优进阶项，面试提到即加分。', NULL, '[\"调优\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'Linux 下如何做文件/目录的实时监控（如安全审计）？', NULL, NULL, '基础：auditd（内核审计子系统）：
```
auditctl -w /etc/passwd -p wa -k identity_change
ausearch -k identity_change
```
轻量方案：inotifywait -m /data（脚本联动）。容器/K8s 环境常用 Falco（基于内核事件）。面试答 auditd + 说明用途即可。', NULL, '[\"安全\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何安全清理 /var/log 下的大日志（不能停服务）？', NULL, NULL, '**不要直接 rm**（进程持有句柄空间不释放）。正确姿势：
```
# 方案1：truncate 清空（保留句柄）
> /var/log/app/huge.log
# 方案2：logrotate 强制轮转
logrotate -f /etc/logrotate.d/app
```
若已 rm 且空间没回来：lsof | grep deleted 找进程，`> /proc/<pid>/fd/<n>` 清空或安排重启。', NULL, '[\"日志\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何查看某个端口被哪个进程占用（三种方法）？', NULL, NULL, '```
ss -tlnp | grep :8080
lsof -i :8080
netstat -tlnp | grep 8080
fuser 8080/tcp          # 直接给 PID，可接 -k 杀掉
```', NULL, '[\"排障\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, 'history 看不到刚敲过的命令？如何让 history 带时间戳？', NULL, NULL, '```
export HISTTIMEFORMAT="%F %T "
history | tail
```
写入 ~/.bashrc 永久生效。审计场景（谁在什么时候执行了什么）很有用；另外 history 不记录未落盘会话（异常退出）与未加空格的命令（HISTCONTROL=ignorespace 时）。', NULL, '[\"基础\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'scp 传大文件中断后如何续传？', NULL, NULL, 'scp 不支持续传，改用 rsync（断点续传+增量）：
```
rsync -avzP bigfile user@host:/data/
```
-P = --partial --progress。也可用 sftp 的 reget/reput 或分段工具。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'df 显示空间没满但创建文件报 "No space left on device"，怎么回事？', NULL, NULL, '两种常见原因：
1. **inode 耗尽**：df -i 看 IUse%，海量小文件（缓存、session）导致。定位最多文件的目录：`for d in /*; do echo $d $(find $d | wc -l); done` 或 ncdu
2. 磁盘配额（quota）限制
解决：清理小文件源头，或扩 inode（xfs 无法在线扩，需迁移）。', NULL, '[\"磁盘\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何生成高强度随机密码 / 随机字符串？', NULL, NULL, '```
openssl rand -base64 18
head -c 16 /dev/urandom | base64
tr -dc A-Za-z0-9 </dev/urandom | head -c 20; echo
```
自动化脚本初始化密码常用第一种（简洁且含足够熵）。', NULL, '[\"基础\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, '一次 fork 炸弹 :(){ :|:& };: 的原理与防范？', NULL, NULL, '递归定义函数 : 并不断后台 fork 自身，指数级耗尽进程表。
防范：
1. ulimit -u 限制用户最大进程数（/etc/security/limits.conf）
2. systemd 服务级别 TasksMax=
3. 容器场景 K8s/Docker 都有 pids cgroup 限额（--pids-limit）

考察点：cgroups 的 pids 子系统。', NULL, '[\"安全\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何让服务端 tcpdump 只抓访问 8080 的 SYN 包（看新连接来源）？', NULL, NULL, '```
tcpdump -i eth0 "tcp[tcpflags] & tcp-syn != 0 and tcp[tcpflags] & tcp-ack == 0 and port 8080" -nn
```
SYN 不含 ACK = 客户端首包。用于确认流量来源、排查连接是否到达本机。', NULL, '[\"抓包\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '描述一次你排查 "CPU 100%" 的完整过程。', NULL, NULL, '按框架答：
1. `top` 确认进程与线程级占用（top -H -p <pid>）
2. 线程号转16进制：printf "%x" <tid>
3. Java：jstack <pid> | grep -A 20 <hex> 定位代码栈；非 Java：strace -p / perf top 看系统调用/热点
4. 判断类型：us 高=业务计算（死循环/正则回溯/GC）；sy 高=系统调用风暴（频繁 fork、锁竞争）
5. **先止血后根因**：摘流量/重启，再修代码

能讲出"线程级定位+区分 us/sy"即达标。', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '一句话解释 /proc 文件系统？列举 3 个常用文件。', NULL, NULL, '内核把进程与系统信息暴露为伪文件系统（内存中，不占磁盘）。
- /proc/cpuinfo、/proc/meminfo：硬件信息
- /proc/loadavg：负载（监控采集源）
- /proc/<pid>/cmdline、/proc/<pid>/fd/：进程命令行与打开的文件

很多命令（ps/top/free）底层就是读 /proc。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '服务器重启后服务没起来，你的排查顺序？', NULL, NULL, '1. `systemctl status xxx` 看状态与失败原因
2. `journalctl -u xxx -b`（本次开机以来的日志）
3. 检查是否 enable（开机自启）：systemctl is-enabled xxx
4. 看依赖：After=network.target 但网络慢就绪？数据库没起来导致应用退出？
5. 手动 systemctl start 复现，看报错（配置错/权限/路径）
6. 修复后：systemctl enable --now + 验证 Restart= 策略', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '怎么把当前机器的公钥分发到多台机器实现免密登录（运维自动化第一步）？', NULL, NULL, '```
ssh-keygen -t ed25519                 # 生成密钥对
ssh-copy-id user@node1                 # 逐台分发
# 批量：
for h in node{1..10}; do ssh-copy-id user@$h; done
```
原理：公钥追加到目标 ~/.ssh/authorized_keys（权限必须 600，目录 700）。免密是后续 Ansible/批量脚本的前提。', NULL, '[\"ssh\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, '登录一台陌生服务器做性能巡检，说出你的前 10 条命令。', NULL, NULL, '```
uptime                    # 负载与运行时长
free -h                   # 内存
df -h                     # 磁盘
top -bn1 | head -20       # CPU/进程概览
ss -s                     # 连接概览
systemctl --failed        # 失败服务
journalctl -p err -b      # 本次开机错误日志
dmesg -T | tail -30       # 内核异常（OOM等）
last | head               # 登录记录
cat /proc/loadavg; iostat -x 1 3   # IO
```
面试考察的是"有没有体系"，按 CPU/内存/磁盘/网络/日志/安全分层答。', NULL, '[\"巡检\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '环境变量 PATH 的作用？脚本提示 "command not found" 但文件明明在，怎么排查？', NULL, NULL, 'PATH 是命令搜索路径列表。排查：
1. `which cmd` / `command -v cmd` 看命中的是哪个
2. `echo $PATH` 确认目标目录是否在内（crontab/systemd 里 PATH 极简，用绝对路径）
3. 文件是否有可执行权限（ls -l）
4. 是否是脚本且 shebang（#!/bin/bash）正确
5. Windows 换行符导致 #!/bin/bash^M 报错：dos2unix 修复', NULL, '[\"基础\",\"排障\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何统计一个目录下每种类型文件的数量与大小（如做容量分析）？', NULL, NULL, '```
find /data -type f | sed ''s/.*\.//'' | sort | uniq -c | sort -rn      # 按扩展名计数
du -sh /data/* | sort -rh | head                                    # 一级目录大小 TOP
find /data -type f -size +100M -exec ls -lh {} \;                  # 大文件清单
```
容量治理（清理什么、扩多少）的标准三板斧。', NULL, '[\"磁盘\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'crontab 里 `0 2 * * *` 和 `*/30 9-18 * * 1-5` 分别什么含义？', NULL, NULL, '- 每天凌晨 2 点
- 工作日（周一到周五）9 点到 18 点每 30 分钟

字段顺序：分 时 日 月 周。注意 `*/n` 是步进；9-18 对"分"字段无效（分最大59），本题 9-18 作用在小时位因前面是 */30 分。', NULL, '[\"crontab\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '服务器时间比标准时间快了 10 分钟，直接 date -s 改有什么风险？', NULL, NULL, '直接跳变时间会导致：
1. 依赖单调时钟的程序异常（定时器紊乱、Java CMS GC 假死）
2. 数据库事务/日志乱序，监控图表跳变
3. 认证票据（Kerberos/JWT）校验异常

正确做法：配置 chrony 让它小步平滑校准（chronyc makestep 可控跳变），生产禁用手动大步调时。', NULL, '[\"基础\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何找出并终止运行超过 24 小时的某类进程？', NULL, NULL, '```
ps -eo pid,etime,cmd | awk ''/worker.py/ && $2 ~ /-/''    # etime 含 - 表示超过24h
# 终止：
pkill -f -o worker.py        # 最老的一个
```
etime 格式 [[dd-]hh:]mm:ss，出现 dd- 即超一天。常用于清理僵留任务。', NULL, '[\"进程\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '一次发版后服务起不来，日志只显示 exited，你有哪些排查入口？', NULL, NULL, '1. systemd：journalctl -u app -n 100 --no-pager（多数答案在这里）
2. 手动前台跑：切到 app 用户执行启动命令，直接看报错（权限/配置/路径）
3. 检查配置文件语法（nginx -t、sshd -t、java -jar 前置 dry-run）
4. 检查端口占用、依赖（DB/Redis）连通性
5. 检查文件权限与属主（发布目录属主错是高频原因）
6. ulimit 与内存（启动即 OOM：dmesg | tail）

思路：**把后台问题前台化**。', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'SCENARIO', 2, '你接手的机器 /var 分区每周涨 20GB，如何做容量治理？', '当前使用率 85%，大量日志与备份文件混放。', NULL, '1. **摸底**：du -sh /var/* 逐层定位；重点 /var/log、/var/lib/docker、备份目录
2. **止血**：logrotate 策略收紧（按天+压缩+保留14份）；清理已满日志用 truncate 而非 rm
3. **迁移**：docker data-root 迁到数据盘；备份迁对象存储/备份机
4. **根治**：日志接 ELK/Loki 后本地只留短期；监控告警阈值降到 70%；容量规划按增长速率预估扩盘
5. 制度：大文件审批、定期巡检脚本（find +100M 周报）', NULL, '[\"磁盘\",\"容量\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'SCENARIO', 2, '应用频繁假死（进程在、端口在、但不响应），重启恢复，怎么办？', '无错误日志，CPU/内存正常。', NULL, '怀疑线程/连接层卡死：
1. 假死时抓现场：jstack <pid>（线程都在干嘛——死锁/等锁/线程池耗尽）、ss -ant 看连接（CLOSE_WAIT 堆积=后端不关连接）
2. `curl -m 3 localhost:port/health` 区分"接入层死"还是"业务死"
3. 检查线程池/连接池配置与监控指标
4. 系统层：conntrack 表满（dmesg: nf_conntrack: table full）、fd 耗尽（Too many open files）
5. 根因多为：下游慢导致池耗尽。加超时+熔断+池监控才是根治

强调"先抓现场再重启"的纪律。', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'SCENARIO', 3, '凌晨批量任务把机器负载打到 30+（8核），白天正常，怎么优化？', '任务是日志压缩与备份脚本。', NULL, '1. **错峰**：任务分散到不同时段（非整点，避开 0:00 高峰——所有人都整点跑是经典问题）
2. **限流**：gzip 换 zstd（CPU 更省）；nice/ionscope 降优先级：`nice -n 19 ionice -c3 tar ...`
3. **拆分**：find 全量扫描改增量（-newer 时间戳文件）
4. **搬走**：备份拉到独立备份机/对象存储，不在生产算
5. 监控任务时长趋势，超阈值告警', NULL, '[\"性能\",\"调优\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'SCENARIO', 2, '开发说服务器连不上他的服务（其他服务正常），你如何快速验证是谁的问题？', '拓扑：开发本机 → SLB → Nginx → 应用（8080）。', NULL, '分段定位：
1. 本机：`curl -v http://slb-ip:port` —— refused/timeout/502 分别指向不同层
2. 到 Nginx 机器：`curl -I http://127.0.0.1:80`（网关活着吗）
3. 直连后端：`curl 127.0.0.1:8080/health`（应用活着吗）
4. 反差定位：你能通他不能 → 客户端网络/VPN/防火墙；都不通 → 服务端问题
5. 证据：各层 ss/tail 日志，curl -w "%{http_code} %{time_total}" 量化

回答要点：**从中间往两边查**，每一步都有明确输出。', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'SCENARIO', 3, '发现某服务以 root 运行，如何安全地降权为普通用户运行？', '二进制服务，监听 80 端口，目录 /opt/svc。', NULL, '1. 建服务账号：useradd -r -s /sbin/nologin svcuser
2. 目录授权：chown -R svcuser:svcuser /opt/svc（最小权限 750/640）
3. **80 端口问题**（<1024 需要特权）：
   - 方案A：cap_net_bind_service（setcap cap_net_bind_service=+ep /opt/svc/bin）
   - 方案B：改监听 8080，前面 Nginx/SLB 转 80
4. systemd 单元加 User=svcuser + MemoryMax + Restart
5. 验证：systemctl restart 后 ps -o user 确认降权；回归业务

风险点：文件属主/端口权限，答出 cap 或前置代理即优秀。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'SCENARIO', 2, '同事误执行了 rm -rf /data（部分文件已删），第一时间做什么？', 'ext4 文件系统，无快照，业务在跑。', NULL, '1. **立即止损**：kill 掉 rm 进程（每秒都在删）；umount /data 或只读重挂（mount -o remount,ro）防止覆盖已删块
2. **评估损失**：从业务侧统计缺哪些（不要反复 ls 刷盘）
3. **恢复优先级**：昨夜备份/异地副本 → 恢复到新目录 → 校验
4. 深度恢复（无备份时）：extundelete/testdisk 只读挂载尝试（成功率随写入时间递减）
5. **事后**：rm alias 二次确认、高危命令审计（auditd）、备份演练、按 SRE 流程复盘

考察：先停止破坏>保护现场>再恢复的顺序感。', NULL, '[\"应急\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '哪个命令查看文件内容时显示行号？', NULL, '[\"A. cat -n\",\"B. cat -l\",\"C. nl only\",\"D. wc\"]', 'A。cat -n 或 nl 均可；grep -n 显示匹配行号。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '把 /a 重命名为 /b 用？', NULL, '[\"A. mv /a /b\",\"B. rn /a /b\",\"C. cp -r\",\"D. rename all\"]', 'A。mv 同时承担移动与改名。跨文件系统 mv = 复制+删除。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看命令帮助的正确姿势（两个）？', NULL, '[\"A. man cmd / cmd --help\",\"B. help cmd only\",\"C. ? cmd\",\"D. cmd -h only\"]', 'A。man 全手册，--help 快速摘要。tldr 工具更友好（社区）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '递归列出目录树结构？', NULL, '[\"A. tree / find -print\",\"B. ls -R\",\"C. A和B都对\",\"D. du\"]', 'C。tree 直观（需安装），ls -R 自带，find -print 带路径。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '统计目录内（含子目录）文件总数？', NULL, '[\"A. find /path -type f | wc -l\",\"B. ls | wc\",\"C. du -c\",\"D. tree -a\"]', 'A。ls 不递归；du 统计的是大小。inode 治理高频命令。', NULL, '[\"find\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'which 与 whereis 的区别？', NULL, '[\"A. 一样\",\"B. which 找 PATH 中可执行；whereis 连 man/源码一起找\",\"C. whereis更快\",\"D. which找文件\"]', 'B。定位命令位置：which java。type cmd 看是否内建/别名。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '创建多级目录 /a/b/c 一步到位？', NULL, '[\"A. mkdir -p /a/b/c\",\"B. mkdir /a/b/c\",\"C. mkdir -m\",\"D. mkpath\"]', 'A。-p 递归创建且已存在不报错（脚本幂等必备）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '两个文件内容合并（上下拼接）？', NULL, '[\"A. cat a b\",\"B. join a b\",\"C. paste a b\",\"D. merge\"]', 'A。cat 顺序拼接；paste 是左右按行合并；join 是按键关联。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '快速查看二进制文件类型的命令？', NULL, '[\"A. file x\",\"B. cat x\",\"C. type x\",\"D. stat x\"]', 'A。file 识别 ELF/文本/压缩包等；stat 看元数据（权限/时间）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'stat 与 ls -l 相比多给你什么？', NULL, '[\"A. 颜色\",\"B. inode号/精确时间戳/大小字节\",\"C. 递归\",\"D. 无区别\"]', 'B。脚本里取元数据用 stat -c，如 stat -c %a 取权限数字。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '把标准错误单独追加到文件、标准输出到屏幕？', NULL, '[\"A. cmd 2>>err.log\",\"B. cmd >err.log\",\"C. cmd &>err.log\",\"D. 不可能\"]', 'A。2>> 专捕 stderr；&> 全部；>> 追加。', NULL, '[\"重定向\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '/dev/null 的用途？', NULL, '[\"A. 空设备，丢弃输出的黑洞\",\"B. 备份\",\"C. 内存盘\",\"D. 日志\"]', 'A。静默执行 cmd >/dev/null 2>&1；清空文件 >file 借用同一机制。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看当前 shell 与所有环境变量？', NULL, '[\"A. echo $SHELL; env\",\"B. show env\",\"C. setenv\",\"D. print all\"]', 'A。env/export -p 看导出变量；set 看全部（含局部）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'export 的作用？', NULL, '[\"A. 导出变量给子进程\",\"B. 删除变量\",\"C. 加密\",\"D. 打印\"]', 'A。VAR=x 仅当前 shell；export VAR=x 子进程可见（脚本调用脚本传参常用）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '别名 alias 与函数的选择：带参数时用？', NULL, '[\"A. alias 也行\",\"B. 函数（alias 不能带位置参数）\",\"C. 都不行\",\"D. script only\"]', 'B。alias 只做文本替换；函数可 $1 $2。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '修改文件时间戳为当前时间的命令？', NULL, '[\"A. touch f\",\"B. time f\",\"C. stamp f\",\"D. update f\"]', 'A。touch 还能创建空文件；-d 指定任意时间。增量脚本用 -newer 判断。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '把命令放入后台后调回前台？', NULL, '[\"A. jobs; fg %1\",\"B. bg only\",\"C. Ctrl+Z 不行\",\"D. unbg\"]', 'A。Ctrl+Z 暂停 → bg 转后台运行 → fg 调回。jobs 列任务。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看进程树（父子关系）？', NULL, '[\"A. pstree -p / ps -ef --forest\",\"B. ps aux\",\"C. top\",\"D. tree\"]', 'A。排僵尸进程、看进程派生链必备。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '按内存排序列出前 10 进程？', NULL, '[\"A. ps aux --sort=-%mem | head -11\",\"B. ps aux -m only\",\"C. top -m\",\"D. free top\"]', 'A。--sort=-%mem 或 -%cpu；head 去表头计数。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '限制单次命令的 CPU/优先级再执行？', NULL, '[\"A. nice -n 19 cmd\",\"B. limit cmd\",\"C. cpulimit only\",\"D. 不支持\"]', 'A。nice 启动时指定；renice 改运行中进程。IO 用 ionice。', NULL, '[\"调优\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'strace 最常用的两个场景？', NULL, '[\"A. 看系统调用/定位卡在哪个调用\",\"B. 看内存\",\"C. 改文件\",\"D. 加速\"]', 'A。strace -p PID / strace cmd；-f 跟子进程，-e filter。定位"程序在等什么"神器。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'watch 命令的作用？', NULL, '[\"A. 周期执行并全屏刷新输出\",\"B. 监控文件变化告警\",\"C. 计时\",\"D. 锁屏\"]', 'A。watch -n 2 "ss -s" 每2秒刷新；-d 高亮差异。临时监控神器。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'nl、sort -u、uniq 的关系：仅去重不计数？', NULL, '[\"A. sort -u\",\"B. uniq\",\"C. A和B（uniq要求先sort）\",\"D. grep -v\"]', 'C。uniq 假设相邻重复——必须先 sort；sort -u 一步到位。', NULL, '[\"文本\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '把 TAB 转空格/删除 Windows 回车符？', NULL, '[\"A. dos2unix f / tr -d \\"\\r\\"\",\"B. cat\",\"C. sed 不行\",\"D. 无法\"]', 'A。跨平台脚本报 "^M" 或 shebang 错误时的标准修复。', NULL, '[\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'kill 默认发送的信号是？', NULL, '[\"A. SIGTERM(15)\",\"B. SIGKILL(9)\",\"C. SIGSTOP\",\"D. SIGHUP\"]', 'A。优雅终止先 15，不听话再 -9；-HUP 重读配置。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'pkill 与 kill 的区别？', NULL, '[\"A. pkill 按名字/模式匹配批量杀\",\"B. kill只能-9\",\"C. 相同\",\"D. pkill更危险不能用\"]', 'A。pkill -f "pattern" 匹配完整命令行。危险点：模式太宽误杀（如 -f java 杀掉所有Java）。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看系统版本信息（两个常用）？', NULL, '[\"A. cat /etc/os-release; uname -a\",\"B. version\",\"C. lsb_release only\",\"D. sysinfo\"]', 'A。uname -r 看内核版本；os-release 看发行版。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'uname -r 显示 5.15.0-91-generic，91 表示？', NULL, '[\"A. 内核 ABI/构建版本\",\"B. CPU型号\",\"C. 补丁级别\",\"D. 随机\"]', 'A。运维只需要知道：同 major.minor 下 ABI 兼容；装驱动按内核版本匹配。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'chroot 的作用？', NULL, '[\"A. 限制进程的文件系统根（早期隔离手段）\",\"B. 改权限\",\"C. 换主机\",\"D. 改shell\"]', 'A。把进程关进指定目录树；容器雏形之一（现代由 namespace 取代）。系统救援（grub损坏）也用它。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, '僵尸进程的父进程退出后僵尸去哪？', NULL, '[\"A. 被init(PID1)收养并回收\",\"B. 永久残留\",\"C. 变孤儿不回收\",\"D. 重启机器 only\"]', 'A。所以处理僵尸=杀父或修父代码（wait）。容器里 PID1 的僵尸回收能力是选基础镜像的考量。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'CentOS 与 Ubuntu 包管理的对应关系？', NULL, '[\"A. yum/dnf ↔ apt\",\"B. 相同\",\"C. rpm ↔ apt\",\"D. 无对应\"]', 'A。搜索/安装/更新：yum search↔apt search、yum install↔apt install。rpm/dpkg 是底层。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, '服务器负载高但 CPU idle 也高，最可能？', NULL, '[\"A. IO wait 高（D状态进程多）\",\"B. CPU不够\",\"C. 内存泄漏\",\"D. 网络满\"]', 'A。load 含不可中断进程；vmstat 看 wa/b 列。磁盘坏/NFS 挂死的典型表现。', NULL, '[\"性能\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'iostat 中 await 与 %util 含义？', NULL, '[\"A. 平均IO耗时ms / 设备繁忙度\",\"B. 等待进程数\",\"C. 带宽/速率\",\"D. 错误率\"]', 'A。await 高=慢盘或争抢；%util≈100=饱和。SSD 多队列下 %util 高不一定瓶颈，结合 await。', NULL, '[\"性能\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'sar 的价值？', NULL, '[\"A. 历史性能回看（后台周期采集）\",\"B. 实时only\",\"C. 只看CPU\",\"D. 日志分析\"]', 'A。sysstat 包装好后保留历史，"昨晚3点发生了什么"全靠它。sar -q/-r/-n DEV/-d。', NULL, '[\"性能\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, '一次磁盘写入请求到达后经过的缓存层次？', NULL, '[\"A. page cache → 块层 → 磁盘缓存 → 介质\",\"B. 直接写盘\",\"C. 应用缓存→盘\",\"D. 无缓存\"]', 'A。所以"写完没落盘断电会丢"——数据库有自己的 redo/WAL 就为绕开这个不确定性。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'XFS 与 ext4 的运维差异点？', NULL, '[\"A. XFS 大文件/并发强、无法收缩；ext4 全面但上限低\",\"B. 无差异\",\"C. XFS不能快照\",\"D. ext4不支持journal\"]', 'A。RHEL 默认 XFS；缩容需求选 ext4。备份工具 xfsdump/xfsrestore 专用。', NULL, '[\"磁盘\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'LVM 的核心价值？', NULL, '[\"A. 卷在线扩容/快照\",\"B. 加速\",\"C. 加密\",\"D. 备份 only\"]', 'A。物理卷→卷组→逻辑卷三层抽象；扩盘不停业务、快照做一致性备份。云盘时代弱化但机房仍是标配。', NULL, '[\"磁盘\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'swap 分区 vs swap 文件？', NULL, '[\"A. 功能等价，文件方式更灵活（可后加）\",\"B. 文件慢10倍\",\"C. 分区only\",\"D. 文件不持久\"]', 'A。fallocate + mkswap + swapon 三步加 swap 文件应急内存不足。', NULL, '[\"内存\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'OOM killer 选受害者的主要依据？', NULL, '[\"A. oom_score（内存占用大者先死）\",\"B. 随机\",\"C. CPU高者\",\"D. 最老进程\"]', 'A。/proc/PID/oom_score 可查；关键服务可 oom_score_adj 保护。Java 应用常是最大受害者。', NULL, '[\"内存\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'ulimit -u 限制的是什么？', NULL, '[\"A. 用户最大进程/线程数\",\"B. CPU时间\",\"C. 文件数\",\"D. 内存\"]', 'A。防 fork 炸弹；对应 cgroup pids。注意 Java 线程也计入——线程池上限要与之匹配。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'top 里 steal(st) 高说明？', NULL, '[\"A. 虚拟化宿主机资源被别人抢（超卖）\",\"B. 磁盘慢\",\"C. 网络问题\",\"D. 正常\"]', 'A。公有云突发实例超卖时常见；应用无慢查询却周期性卡顿，看 st。', NULL, '[\"性能\",\"云\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'inotify 是什么？', NULL, '[\"A. 内核文件事件通知机制（inotifywait）\",\"B. 日志系统\",\"C. 网络工具\",\"D. 数据库\"]', 'A。文件变化触发脚本（同步/审计）；海量文件时受 watch 数限制（fs.inotify.max_user_watches）。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'ulimit 与 cgroups 的本质区别？', NULL, '[\"A. ulimit 单进程会话级粗粒度；cgroup 进程组级精确计量+硬限\",\"B. 相同\",\"C. cgroup只管CPU\",\"D. ulimit更强\"]', 'B 描述正确。cgroup 是容器资源限制的基础；ulimit 多用于 shell 环境遗产配置。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, '如何快速确认一台机器能否上网（三种手段）？', NULL, NULL, '```bash
ping -c2 223.5.5.5           # IP层
curl -sI --max-time 3 http://mirrors.aliyun.com >/dev/null && echo OK   # 应用层
dig baidu.com +short          # 解析层
```
分不清层就乱测是新手常见问题：IP通+域名不通=DNS。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '说明 rpm -qa 与 dpkg -l 各自用于什么系统？怎么查某包是否安装？', NULL, NULL, 'CentOS/RHEL：rpm -qa | grep nginx；Ubuntu/Debian：dpkg -l | grep nginx（或 apt list --installed）。脚本判断：rpm -q nginx || dpkg -s nginx。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '服务器时间慢了 8 小时，最可能是什么问题？', NULL, NULL, '时区配置：UTC vs CST（Asia/Shanghai）。timedatesetc set-timezone Asia/Shanghai 修正。区别于 NTP 不准（慢几分钟/漂移）。日期日志差 8h 排查第一嫌疑。', NULL, '[\"基础\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何找出 10 分钟内被修改过的所有配置文件（/etc）？', NULL, NULL, '```bash
find /etc -type f -mmin -10
```
应急排查"谁改了配置"的时间窗检索；配合 stat 看精确改动时间、审计日志找操作人。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '计划任务每分钟执行的日志去哪看？', NULL, NULL, '1. 任务自身的输出（是否重定向）
2. cron 服务日志：grep CRON /var/log/syslog（Ubuntu）或 /var/log/cron（CentOS），journalctl -u cron
3. 邮件 /var/spool/mail/$USER（未重定向时）

三层都查才算完整。', NULL, '[\"crontab\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'ulimit 改了 /etc/security/limits.conf 但 systemd 服务不生效，为什么？', NULL, NULL, 'limits.conf 只对 PAM 登录会话生效；systemd 服务走单元配置：
```ini
[Service]
LimitNOFILE=65536
```
systemctl daemon-reload 后重启服务。这是 Java 服务 Too many open files 的经典修复路径。', NULL, '[\"systemd\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, 'Linux 启动卡在某个服务很久，如何定位？', NULL, NULL, '1. systemd-analyze blame / critical-chain 看耗时排行
2. 多为网络等待（network.target 超时、DNS 慢）或 NFS/挂载不可达
3. 处理：After 调整、超时配置（TimeoutStartSec）、服务并行化

面试提 systemd-analyze 就是实战信号。', NULL, '[\"systemd\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, '一次变更后部分用户报"连不上"，但监控全绿，怎么破？', NULL, NULL, '监控盲区思路：
1. 全绿可能只覆盖了"整体可用性"，长尾用户（某地域/运营商/某接入点）不可见→按用户特征（IP段）聚合日志
2. 复现路径：模拟该用户网络（代理/拨测）
3. 检查变更：DNS TTL 未到（部分人还解析旧IP）、CDN 节点部分回源失败
4. 快速验证：让用户 nslookup + curl -v 输出对比

考点：监控覆盖度与"分维度下钻"意识。', NULL, '[\"排障\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看当前目录绝对路径？', NULL, '[\"A. pwd\",\"B. cd\",\"C. dir\",\"D. ls -p\"]', 'A。print working directory。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '清屏快捷键/命令？', NULL, '[\"A. Ctrl+L / clear\",\"B. Ctrl+C\",\"C. Ctrl+D\",\"D. exit\"]', 'A。Ctrl+D 是退出会话。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '终止当前前台进程的快捷键？', NULL, '[\"A. Ctrl+C\",\"B. Ctrl+Z\",\"C. Ctrl+L\",\"D. Ctrl+A\"]', 'A。Ctrl+Z 是挂起到后台（暂停）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'history 中执行第 55 条命令？', NULL, '[\"A. !55\",\"B. #55\",\"C. 55\",\"D. run 55\"]', 'A。!! 上一条；!$ 上条最后参数。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'cp 时覆盖前逐个确认？', NULL, '[\"A. cp -i\",\"B. cp -f\",\"C. cp -n\",\"D. cp -a\"]', 'A。alias cp=cp -i 的由来；-f 强制 -n 不覆盖。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看文件前 20 行？', NULL, '[\"A. head -20 f\",\"B. top -20\",\"C. first 20\",\"D. tail -20\"]', 'A。head 默认10行；tail 看尾部。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '把 a.txt 的内容覆盖到 b.txt？', NULL, '[\"A. cat a.txt > b.txt\",\"B. cp only\",\"C. mv a b\",\"D. echo a > b\"]', 'A。> 覆盖 >> 追加。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'df 中 tmpfs 是？', NULL, '[\"A. 内存文件系统（/dev/shm 等，重启即失）\",\"B. 临时磁盘\",\"C. 损坏分区\",\"D. 网络盘\"]', 'A。/tmp 部分发行版也是 tmpfs——容器内存限制要算上它。', NULL, '[\"磁盘\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看本机所有用户的 crontab？', NULL, '[\"A. ls /var/spool/cron/crontabs/\",\"B. crontab -l all\",\"C. cron -a\",\"D. 无法\"]', 'A。root 可遍历该目录看全部用户任务（巡检项）。', NULL, '[\"crontab\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'chown -R 的 -R？', NULL, '[\"A. 递归处理子目录\",\"B. 强制\",\"C. 备份\",\"D. 只读\"]', 'A。chown/chmod/cp 的 -R 都是递归。', NULL, '[\"权限\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看某用户（app）的所有进程？', NULL, '[\"A. ps -u app / pgrep -u app\",\"B. ps app\",\"C. top -u only\",\"D. 不支持\"]', 'A。按用户过滤，排资源归属常用。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '快速查看文件倒数第三行？', NULL, '[\"A. tail -3 f | head -1\",\"B. tail -1\",\"C. head -3\",\"D. sed 3p\"]', 'A。组合思维：tail 取段 head 取行。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '把文本里所有 windows 换行去掉？', NULL, '[\"A. dos2unix f / sed -i \\"s/\\r$//\\" f\",\"B. rm -r\",\"C. tr 无法\",\"D. cat\"]', 'A。脚本莫名 "bad interpreter" 的修复。', NULL, '[\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '同时查看两个命令输出并排？', NULL, '[\"A. paste <(cmd1) <(cmd2)\",\"B. cat cat\",\"C. join only\",\"D. 不支持\"]', 'A。进程替换 <() 组合 paste——对比清单神器。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '统计某个 IP 的 TCP 连接数（按目标）？', NULL, '[\"A. ss -ant | grep \\"10.0.0.9:80\\" | wc -l\",\"B. ping -c\",\"C. arp\",\"D. netstat -r\"]', 'A。连接分布画像基础命令。', NULL, '[\"网络\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '排查 CPU 高时 top 里 ni 是？', NULL, '[\"A. nice 值调整过的进程占CPU\",\"B. 网络\",\"C. 空闲\",\"D. 新进程\"]', 'A。低优先级批任务应体现在 ni 高而非 us。', NULL, '[\"性能\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看 SELinux 状态与临时关闭？', NULL, '[\"A. getenforce / setenforce 0\",\"B. selinux off\",\"C. 不存在SELinux\",\"D. systemctl stop selinux\"]', 'A。排障二分法之一（Enforcing 常拦服务）。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'journalctl 磁盘占用过大怎么办？', NULL, '[\"A. journalctl --vacuum-size=500M\",\"B. rm /var/log\",\"C. 重启\",\"D. 无法限制\"]', 'A。配 /etc/systemd/journald.conf 的 SystemMaxUse 长效。', NULL, '[\"日志\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'at 与 crontab 的区别？', NULL, '[\"A. at 一次性任务；cron 周期任务\",\"B. 相同\",\"C. at更强\",\"D. cron一次性\"]', 'A。改网络前 at 安排回滚是老鸟技巧。', NULL, '[\"任务\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查找命令实际执行的文件（含别名）？', NULL, '[\"A. type -a cmd\",\"B. which only\",\"C. find cmd\",\"D. whereis最好\"]', 'A。type 显示 alias/函数/路径全部来源。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '把进程 123 的输出重定向但进程已在跑，能改吗？', NULL, '[\"A. 不能直接改（可用 gdb/重启）；启示：启动前重定向\",\"B. 随时可改\",\"C. tail 可以\",\"D. nohup 可以\"]', 'A。"启动时没接管道"是运维常见遗憾——初始化脚本要写对。', NULL, '[\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'vmstat 的 si/so 列非零说明？', NULL, '[\"A. 正在换入换出 swap（内存压力实锤）\",\"B. 网络\",\"C. 正常\",\"D. 磁盘IO正常\"]', 'A。持续非零=内存不足，考虑加内存或查泄漏。', NULL, '[\"性能\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'cgroup v1 与 v2 的差异（一句话）？', NULL, '[\"A. v2 统一挂载层级、接口更简洁\",\"B. v1更安全\",\"C. 无差异\",\"D. v2不支持CPU限制\"]', 'A。新发行版默认 v2；容器运行时都兼容。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 1, '如何查看一个目录下今天新增的文件？', NULL, NULL, '```bash
find /path -type f -newermt "$(date +%F)"
# 或 -mmin -$(( $(date +%H) * 60 + $(date +%M) )) 从0点算
```
应急排查"今天谁动了文件"第一枪。', NULL, '[\"find\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, 'free -h 里 buff/cache 很大要清理吗？', NULL, NULL, '不需要。它是可回收的页缓存（加速读写），内存紧张时内核自动释放。手动 echo 3 > /proc/sys/vm/drop_caches 仅测试场景可用（会短暂降低性能）。看 available 判断真实可用。', NULL, '[\"内存\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '同一命令 root 能跑 appuser 报 command not found，为什么？', NULL, NULL, 'PATH 不同：root 的 PATH 含 /usr/sbin:/sbin 而普通用户可能没有（sbin 下的命令如 ip、tcpdump）。修复：绝对路径调用或给用户 PATH 追加。分层排 PATH 是用户级问题的常见原因。', NULL, '[\"基础\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '一台机器 root 密码丢失（有物理/控制台权限），救援思路？', NULL, NULL, '1. 控制台重启，GRUB 编辑内核行加 rd.break（init=/bin/bash）
2. 以读写重挂 /：mount -o remount,rw /sysroot
3. passwd 改密（或 chroot 后改）
4. touch /.autorelabel（SELinux）后重启
考察单用户救援，云上用 VNC/救援模式同理。', NULL, '[\"应急\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, '服务器每天 3 点准时卡顿 5 分钟，怎么定位？', NULL, NULL, '1. 对时间窗：sar 历史看 3:00 各项指标（CPU/IO/网络）
2. cron 全局扫描：所有用户 crontab + /etc/cron.*
3. 日志/备份任务：logrotate、备份脚本、索引重建
4. 系统级：updatedb、apt 自动任务、证书续期
5. 修法：错峰（3:07）、限速（nice/ionice）、拆分
"整点扎堆"是经典现象，先看 cron 再看日志。', NULL, '[\"性能\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'ls -lh 中文件大小显示 2.0K 表示？', NULL, '[\"A. 人类可读约2KB\",\"B. 2000字节精确\",\"C. 磁盘块数\",\"D. inode\"]', 'A。h=human readable。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'mkdir 同时设权限 700？', NULL, '[\"A. mkdir -m 700 d\",\"B. mkdir -p\",\"C. chmod后补 only\",\"D. 不支持\"]', 'A。-m 创建即授权（免 umask 影响）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看二进制依赖库？', NULL, '[\"A. ldd /path/bin\",\"B. cat\",\"C. strings\",\"D. file\"]', 'A。"not found" 依赖缺失导致起不来的排查。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'md5sum 的运维用途？', NULL, '[\"A. 文件完整性校验（传输/篡改）\",\"B. 加密存储\",\"C. 压缩\",\"D. 重命名\"]', 'A。发布包校验、监控配置变化。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看 shell 历史条数上限变量？', NULL, '[\"A. HISTSIZE\",\"B. HISTFILE only\",\"C. LIMIT\",\"D. 无限制\"]', 'A。HISTSIZE 会话内条数，HISTFILESIZE 文件条数。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'id 命令输出 uid=0 的用户是谁？', NULL, '[\"A. root\",\"B. 第一个用户\",\"C. 任意\",\"D. 无意义\"]', 'A。uid=0 即 root 权限（无论名字）——安全审计看 uid 不看名。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '查看端口对应进程的 lsof 写法？', NULL, '[\"A. lsof -i:8080\",\"B. lsof -p 8080\",\"C. lsof -u 8080\",\"D. lsof 8080\"]', 'A。-i 网络过滤；-p 是进程号；-u 是用户。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, '把 /var/log 下所有 .conf 找出来但排除子目录 etc？', NULL, '[\"A. find /var/log -name \\"*.conf\\" -not -path \\"*/etc/*\\"\",\"B. find | grep -v\",\"C. 不支持\",\"D. 只能两步\"]', 'A。-not -path 组合过滤。find 表达式是很强的语言。', NULL, '[\"find\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'nl 与 cat -n 输出差异？', NULL, '[\"A. 基本相同，nl 可自定义格式\",\"B. 完全不同\",\"C. nl不编号\",\"D. cat不编号\"]', 'A。nl -w 宽度、-s 分隔符。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'cut -c1-10 的含义？', NULL, '[\"A. 每行第1到10字符\",\"B. 第1和10列\",\"C. 前10行\",\"D. 字节数10\"]', 'A。-c 按字符（-b 字节；中文注意字节数）。', NULL, '[\"文本\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'sh -c "cmd" 与直接 cmd 在脚本调度里的差别？', NULL, '[\"A. sh -c 明确起子shell执行字符串（xargs/su -c常用）\",\"B. 相同\",\"C. 前者更快\",\"D. 后者危险\"]', 'A。组合执行（xargs -I{} sh -c "...{}..."）的载体。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'tar 解包到指定目录？', NULL, '[\"A. tar -xzf f.tgz -C /dst\",\"B. tar -C after\",\"C. cd only\",\"D. mv\"]', 'A。-C 指定目标目录（发布脚本常客）。', NULL, '[\"备份\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'sysctl -p 做什么？', NULL, '[\"A. 重载 /etc/sysctl.conf\",\"B. 查看内核版本\",\"C. 关机\",\"D. 重启网络\"]', 'A。改内核参数（如 somaxconn）后生效。', NULL, '[\"调优\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'nohup.out 与重定向都没配时 nohup cmd & 的输出？', NULL, '[\"A. 默认写当前目录 nohup.out\",\"B. 丢弃\",\"C. 报错\",\"D. 终端\"]', 'A。规范还是显式 >> log 2>&1。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 3, 'systemd 的 After=network-online.target 需要额外启用什么？', NULL, '[\"A. systemctl enable NetworkManager-wait-online\",\"B. 自动生效\",\"C. 无此target\",\"D. 重启即可\"]', 'A。不启用 wait-online 则 online target 立即过——启动依赖网络的服务仍可能连不上（经典坑）。', NULL, '[\"systemd\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '把当前目录所有文件名含空格的文件批量把空格换下划线？', NULL, NULL, '```bash
for f in *" "*; do mv "$f" "${f// /_}"; done
```
${var// /_} 全局替换。引号必须。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, '磁盘 IO 高但不知道哪个文件在被读写，怎么定位？', NULL, NULL, '1. iotop -o 找进程
2. cat /proc/<pid>/io 看累计读写
3. lsof -p <pid> | grep -E "REG"（ Regular 文件）
4. 深度：fatrace/bcc（biolatency-bpfcc）文件级追踪
5. 场景联想：日志刷屏/数据库脏页/大文件构建', NULL, '[\"性能\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, 'cp -a 与 cp -r 的区别？', NULL, '[\"A. -a 归档（含权限/时间/链接，等-rpP）\",\"B. 相同\",\"C. -a更快\",\"D. -r保权限\"]', 'A。备份目录用 -a。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'rm -i 与 rm -f 的经典 alias 建议是？', NULL, '[\"A. root 默认 rm=rm -i（多一道确认）\",\"B. 建议 rm=rm -f\",\"C. 无 alias\",\"D. 脚本里用 -i\"]', 'A。交互确认保命；脚本里避免依赖 alias（用绝对判断）。', NULL, '[\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '如何查看与合并上一条命令的 stdout 和 stderr 都落日志？', NULL, NULL, '```bash
command >>app.log 2>&1   # 或 &>>app.log
```
顺序不能反（2>&1 要在 > 之后）。', NULL, '[\"重定向\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '新手运维最常犯的三个危险操作？如何预防？', NULL, NULL, '1. rm -rf 变量空（rm -rf /$DIR 当 DIR 空）→ 判空+绝对路径校验
2. 在生产库直连执行 update 无 where → 变更平台+备份+begin 前 select 确认
3. 覆盖配置不备份 → cp xx xx.$(date +%F).bak
共同解法：高危命令 checklist + 二次确认 + 操作可回滚。', NULL, '[\"素养\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, '服务器负载高但你 top/df/free 都看了正常，下一步？', NULL, NULL, '1. vmstat 1 看 r 列（运行队列）与 cs（上下文切换）
2. pidstat -w 看谁在切换（锁竞争/线程过多）
3. iostat -x 1 换窗口看瞬时（top 瞬时值可能错过尖刺）
4. dmesg 尾部看内核异常
5. 对照监控历史曲线（sar）定位开始时刻与关联变更
"瞬时问题用滑动窗口工具看"。', NULL, '[\"性能\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 3, '解释 /etc/fstab 六个字段。', NULL, NULL, '设备(或UUID) 挂载点 类型 挂载选项 dump备份频次 fsck顺序。
运维要点：用 UUID（设备名会变）；nofail 防外挂盘故障卡启动；改错 fstab 会导致启动失败（rescue 模式修）。', NULL, '[\"磁盘\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 1, '查看系统已开机多久？', NULL, '[\"A. uptime\",\"B. time\",\"C. date\",\"D. clock\"]', 'A。load average 一起输出。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'CHOICE', 2, 'nohup 忽略的信号是？', NULL, '[\"A. SIGHUP\",\"B. SIGKILL\",\"C. SIGINT\",\"D. SIGTERM\"]', 'A。挂断信号（终端关闭时发）。', NULL, '[\"进程\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(1, 'QA', 2, '快速对比两台机器目录结构差异？', NULL, NULL, '```bash
# 各自执行
cd /etc/nginx && find . | sort > /tmp/tree.txt
# 拉到一起
diff a-tree.txt b-tree.txt
```
内容级对比再上 rsync -ncv 或 md5 清单。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(2, 'CHOICE', 1, '一次 HTTP 请求默认端口是？', NULL, '[\"A. 80\",\"B. 443\",\"C. 8080\",\"D. 53\"]', 'A。https 443，DNS 53。', NULL, '[\"基础\",\"必背\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'telnet 通但应用登录报 "connection closed"，方向？', NULL, '[\"A. 端口通了是应用层断连（认证失败/协议不匹配/后端依赖）\",\"B. 网络问题\",\"C. DNS\",\"D. 一定防火墙\"]', 'A。分层定位：TCP OK 后问题移交应用日志。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '怎么快速判断"网站慢"是前端资源还是接口慢？', NULL, NULL, '浏览器 F12 Network（或 curl -w 分段）：
1. HTML/静态资源总耗时 vs XHR 接口耗时
2. 接口 waiting(TTFB) 长=服务端；content download 长=传输/体积
3. 前端渲染（Performance 面板）
给结论必须带数据（哪个资源/接口多少ms）。', NULL, '[\"排障\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, '设计单点登录(SSO)的网络与会话要点（运维视角）。', NULL, NULL, '1. 统一认证中心 + 票据（token）校验
2. 会话：集中存储（Redis）+ 签名 cookie（HttpOnly/Secure）
3. 各业务系统回调白名单
4. 登出广播（token 失效）
5. 认证中心自身高可用与压测（它是全站单点！）', NULL, '[\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, '抓包文件过大（几个G），怎么高效分析？', NULL, NULL, '1. 捕获时就过滤（host/port），或 -s 0 换 -s 96 抓头
2. 多文件轮转：-C 100 -W 20
3. 分析用 editcap 切片 / tshark 过滤统计（tshark -r x.pcap -Y "http" ）
4. 元数据先行：capinfos 看概览
"抓包前想清楚要什么"是最好的优化。', NULL, '[\"抓包\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'HTTPS 默认端口？', NULL, '[\"A. 443\",\"B. 80\",\"C. 8443\",\"D. 8080\"]', 'A。必背端口组：80/443/22/3306/6379。', NULL, '[\"必背\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, 'ping 显示的 time 是什么耗时？', NULL, NULL, 'ICMP 回显往返时延（RTT）：本机→目标→本机。局域网 <1ms，跨城 20-40ms，跨国 150ms+。是链路质量的粗粒度信号（不含应用处理）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'OSI 七层模型中路由器工作在哪一层？', NULL, '[\"A. 数据链路层\",\"B. 网络层\",\"C. 传输层\",\"D. 应用层\"]', 'B。路由器按 IP 转发=网络层；交换机=数据链路层（MAC）。', NULL, '[\"基础\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'TCP 和 UDP 最大的区别？', NULL, '[\"A. TCP更快\",\"B. TCP面向连接可靠有序，UDP无连接不保证\",\"C. UDP不能传数据\",\"D. TCP加密\"]', 'B。TCP 三次握手/确认重传/排序；UDP 轻量（DNS、视频、游戏）。选型：日志采集常 UDP（可容忍丢）、支付必须 TCP。', NULL, '[\"TCP\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'HTTPS 默认端口、SSH、MySQL、Redis 分别是？', NULL, '[\"A. 443/22/3306/6379\",\"B. 80/22/3306/6379\",\"C. 443/23/3307/6380\",\"D. 8443/22/3306/6379\"]', 'A。常考端口号：HTTP 80、HTTPS 443、SSH 22、MySQL 3306、Redis 6379、PG 5432、Mongo 27017、ZK 2181、Kafka 9092。', NULL, '[\"基础\",\"必背\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '三次握手中第二次报文携带的标志位是？', NULL, '[\"A. SYN\",\"B. ACK\",\"C. SYN+ACK\",\"D. FIN\"]', 'C。客户端 SYN → 服务端 SYN+ACK → 客户端 ACK。', NULL, '[\"TCP\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '收到大量来自本机的 TIME_WAIT 说明什么？', NULL, '[\"A. 本机作为客户端高频短连接\",\"B. 被攻击\",\"C. 服务端连接未关闭\",\"D. 网卡故障\"]', 'A。TIME_WAIT 出现在主动关闭方，本机大量 TIME_WAIT = 本机频繁发起短连接（连DB忘用连接池、压测机）。治本：长连接/连接池。', NULL, '[\"TCP\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'CLOSE_WAIT 堆积说明什么问题？', NULL, '[\"A. 本机主动关连接\",\"B. 对端已关连接但本机代码没调用 close\",\"C. 网络超时\",\"D. 正常现象\"]', 'B。收到对方 FIN 进入 CLOSE_WAIT，等待本机应用 close。堆积=代码缺陷（连接泄漏）。排查：lsof 看持有进程 + 代码 review 关闭逻辑。', NULL, '[\"TCP\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, '查看本机路由表的命令？', NULL, '[\"A. route -n / ip route\",\"B. netstat -r only\",\"C. ifconfig\",\"D. arp -a\"]', 'A。ip route（新版）或 route -n。排查"为什么连不上某网段"先看路由。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'curl 中 -s -o /dev/null -w "%{http_code}" 的作用？', NULL, '[\"A. 下载文件\",\"B. 静默请求只输出状态码（探活常用）\",\"C. 上传\",\"D. 代理\"]', 'B。健康检查脚本标配。加 %{time_total} 可测延迟。', NULL, '[\"工具\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'nslookup 与 dig 的共同作用？', NULL, '[\"A. 测连通性\",\"B. DNS 查询\",\"C. 扫端口\",\"D. 抓包\"]', 'B。dig 更强大：dig +trace 看递归全过程、dig @8.8.8.8 指定服务器对比（判断本地 DNS 污染/缓存）。', NULL, '[\"DNS\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'A 记录与 CNAME 的区别？', NULL, '[\"A. 一样\",\"B. A 记录域名→IP；CNAME 域名→域名（别名）\",\"C. CNAME→IP\",\"D. A→域名\"]', 'B。cdn.example.com CNAME 到厂商域名，厂商再 A 到边缘节点。注意：CNAME 与其他记录不能共存于同一主机名。', NULL, '[\"DNS\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'HTTP 状态码 301 与 302 的区别？', NULL, '[\"A. 无区别\",\"B. 301 永久重定向（缓存），302 临时\",\"C. 302 永久\",\"D. 都是错误\"]', 'B。301 会被浏览器缓存——换域名后旧域名 301 到新域名；临时切流用 302 避免被永久缓存。', NULL, '[\"HTTP\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'HTTP 状态码 499 代表？', NULL, '[\"A. 服务器错误\",\"B. Nginx 专有：客户端提前断开（超时取消）\",\"C. 认证失败\",\"D. 限流\"]', 'B。客户端等不及主动断开。大量 499 = 后端太慢，用户端超时放弃——常与 504 同时出现，指向后端慢。', NULL, '[\"HTTP\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '一个请求从浏览器到服务端延迟很高，tcpdump 显示重传很多，最可能的原因？', NULL, '[\"A. 带宽打满或网络质量差（丢包）\",\"B. CPU 高\",\"C. DNS 错\",\"D. 证书过期\"]', 'A。重传=丢包。看网卡流量（sar -n DEV）、是否有烟罐（带宽跑满）、跨机房线路质量。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'curl 报 "Could not resolve host" 首先检查什么？', NULL, '[\"A. 服务是否启动\",\"B. DNS 配置与解析（resolv.conf / dig 测试）\",\"C. 防火墙\",\"D. 端口\"]', 'B。域名解析层问题：cat /etc/resolv.conf、dig 域名、对比 dig @223.5.5.5。再查 /etc/hosts 是否有错误绑定。', NULL, '[\"DNS\",\"排障\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'telnet 127.0.0.1 3306 通，telnet 192.168.1.10 3306 不通，最可能？', NULL, '[\"A. MySQL 挂了\",\"B. MySQL 只绑定了 127.0.0.1（bind-address）\",\"C. DNS\",\"D. 密码错\"]', 'B。服务只监听回环地址。改配置 bind-address=0.0.0.0（或指定 IP）+ 防火墙放行。SS 见端可确认：ss -tlnp | grep 3306。', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '内网机器时间同步用的 NTP 端口是？', NULL, '[\"A. 123/udp\",\"B. 123/tcp\",\"C. 323\",\"D. 161\"]', 'A。NTP 用 UDP 123。161 是 SNMP，162 trap。', NULL, '[\"端口\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'ip addr 里 eth0 的 /24 表示？', NULL, '[\"A. 24 号网卡\",\"B. 掩码 255.255.255.0（前24位网络位）\",\"C. MTU\",\"D. 优先级\"]', 'B。CIDR 表示法。10.0.1.5/24 → 网络 10.0.1.0，可用主机 10.0.1.1-254。', NULL, '[\"基础\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '本机可以 ping 通 IP 但 ping 不通域名，问题出在？', NULL, '[\"A. 网线\",\"B. DNS 解析环节\",\"C. 路由\",\"D. 防火墙\"]', 'B。分层清晰的表现：网络层通，解析挂。查 resolv.conf、DNS 服务器状态。', NULL, '[\"DNS\",\"排障\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'HTTP keep-alive 的作用？', NULL, '[\"A. 加密\",\"B. 复用 TCP 连接减少握手开销\",\"C. 压缩\",\"D. 缓存\"]', 'B。一次 TCP 建连传多个 HTTP 请求。HTTP/1.1 默认开启；配合连接池消除大量 TIME_WAIT。HTTP/2 在此之上多路复用。', NULL, '[\"HTTP\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'tcpdump 中 -nn 参数作用？', NULL, '[\"A. 不解析域名和端口名（显示原始数字，更快）\",\"B. 双倍抓包\",\"C. 两个网卡\",\"D. 保存两次\"]', 'A。生产抓包必加，避免反查 DNS 拖慢丢包。', NULL, '[\"抓包\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'MTU 不一致导致的典型现象？', NULL, '[\"A. 完全不通\",\"B. 小包通大包卡（ping 大小分界、网页打不开但 curl 小文件正常）\",\"C. 延迟高\",\"D. 乱码\"]', 'B。隧道/VPN 场景经典问题：`ping -M do -s 1400 目标` 二分测试，路径上超过 MTU 的包被丢（且依赖 PMTUD）。', NULL, '[\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 3, '为什么 TCP 需要 TIME_WAIT 等 2MSL？', NULL, '[\"A. 让服务器休息\",\"B. 报文自然消亡+确保最后ACK可达（可重发FIN）\",\"C. 缓存连接\",\"D. 防黑客\"]', 'B。两点：旧连接报文过期防串扰；被动方若收不到 ACK 会重发 FIN，主动方还能应答。', NULL, '[\"TCP\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'ss -ant 中 SYN-RECV 大量出现说明？', NULL, '[\"A. 半连接堆积：可能 SYN Flood 或 accept 队列溢出/应用来不及处理\",\"B. 正常\",\"C. DNS 问题\",\"D. 磁盘满\"]', 'A。配合 dmesg 看 "TCP: request_sock_TCP: Possible SYN flooding" 与 netstat -s | grep -i listen 溢出计数。', NULL, '[\"安全\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'ifconfig eth0 0 或 ip addr 后看不到 IP 了，如何恢复？（考察恢复思路）', NULL, '[\"A. 重启机器\",\"B. 从同网段其他方式登录（控制台）重新配 IP 或 ifup eth0\",\"C. 没救\",\"D. 等\"]', 'B。教训：远程改网络配置前，用 at/cron 安排自动回滚（echo "ifup eth0" | at now + 3 minutes），防止把自己锁外面。', NULL, '[\"运维素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'HTTP 请求头中 Host 的作用？', NULL, '[\"A. 认证\",\"B. 一个 IP 上多个虚拟主机靠它区分站点\",\"C. 缓存\",\"D. 压缩\"]', 'B。HTTP/1.1 必带。Nginx 按 server_name 分发、SLB 按域名路由都依赖它。反代时必须 proxy_set_header Host $host 透传。', NULL, '[\"HTTP\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'X-Forwarded-For 头的作用？', NULL, '[\"A. 加速\",\"B. 传递客户端真实 IP（经代理后不丢失）\",\"C. 加密\",\"D. 跨域\"]', 'B。每经一层代理追加一个 IP。Nginx 取真实IP：proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for；应用日志/限流依赖它。注意可伪造，可信边界内才使用。', NULL, '[\"HTTP\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'traceroute 某一跳显示 * * * 但后面跳数正常，说明？', NULL, '[\"A. 该路由器不回 ICMP TTL 超时（禁ping），链路正常\",\"B. 断路\",\"C. 一定有问题\",\"D. DNS 错\"]', 'A。中间节点不响应很常见，只要后续跳正常到达即可。整体到不了才是问题。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'curl 访问 HTTPS 报 certificate verify failed，业务上可接受的临时处理？', NULL, '[\"A. -k 跳过校验（临时/测试，有中间人风险）\",\"B. 关防火墙\",\"C. 换HTTP\",\"D. 重启\"]', 'A。根因多为：缺少中间证书、CA 包过旧（update-ca-certificates）、系统时间错。生产应修证书链而非长期 -k。', NULL, '[\"HTTPS\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'netstat -s | grep -i retrans 重传数持续增长，先查什么？', NULL, '[\"A. 网络质量与负载（丢包/带宽/网卡错误）\",\"B. 内存\",\"C. 磁盘\",\"D. DNS\"]', 'A。sar -n DEV 看流量与丢包（rx_drop）、ifconfig 看 errors、云厂商看烟罐与限速。', NULL, '[\"排障\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'http 和 https 默认工作在 OSI 的哪两层？', NULL, '[\"A. 都是应用层（HTTPS 之下有表示层TLS的概念）\",\"B. 传输层\",\"C. 网络层\",\"D. 会话层\"]', 'A。HTTP 应用层；TLS 严格说在会话/表示之间，实际面试答"应用层（HTTP over TLS）"即可。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '画出/口述一次 HTTPS 请求的完整过程（含 DNS/TCP/TLS/HTTP）。', NULL, NULL, '1. URL 解析 → 浏览器缓存/hosts/系统缓存 → 递归 DNS 解析（本地→根→com→权威）拿 IP
2. TCP 三次握手建立连接
3. TLS 握手：ClientHello（套件+随机数）→ ServerHello+证书 → 客户端验证证书链 → 密钥交换 → 会话密钥
4. 发送 HTTP 请求（加密传输）：方法/路径/Host/头/体
5. 服务端处理返回（状态码+头+体）
6. 连接复用（keep-alive）或四次挥手关闭

排障思路就藏在这条时间线里：断在哪步，查哪层。', NULL, '[\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '怎么判断一个端口不通是防火墙问题还是服务没起？', NULL, NULL, '两步：
1. **服务端本机** `ss -tlnp | grep <port>`：无监听=服务没起；有监听看绑定地址是否只 127.0.0.1
2. 本机 `curl 127.0.0.1:port` 通、外部不通 → 中间链路：防火墙/安全组（`timeout vs refused` 也能佐证：**refused=到了机器没服务；timeout=路上被丢**）
3. 服务端 `tcpdump port <port>` 看包到没到：到了没回=本机防火墙（iptables -L / firewalld / 云安全组）', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '解释 refused 与 timeout 的本质区别（一句话+排查方向）。', NULL, NULL, '- **Connection refused**：目标机器明确回包说"没这个服务"→ 查服务/端口/绑定地址
- **Timeout**：请求石沉大海 → 查防火墙 DROP、路由、安全组、对端过载

一个是"明确拒绝"，一个是"失联"，先分类再排查，能省一半时间。', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '什么是 SYN Flood？如何缓解？', NULL, NULL, '攻击者伪造源 IP 发大量 SYN 不回 ACK，占满半连接队列，正常用户无法建连。
缓解：
1. 内核参数：tcp_syncookies=1（队列满用 cookie 编码状态，不占资源）
2. net.ipv4.tcp_max_syn_backlog 调大
3. 前置防护：云 DDoS 清洗、防火墙限速

答出 syncookies 即达标。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, 'HTTP/1.1、HTTP/2、HTTP/3 的核心演进？', NULL, NULL, '- **1.1**：文本协议，keep-alive 复用，但请求排队（队头阻塞）
- **2**：二进制分帧 + **多路复用**（一条连接并行多请求）+ 头部压缩 HPACK
- **3**：基于 **QUIC（UDP）**，彻底解决 TCP 队头阻塞，0/1-RTT 建连

运维视角：Nginx http2 on 一行开启；QUIC 需 UDP 443 放行。', NULL, '[\"HTTP\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '什么是 CDN？回源是什么意思？', NULL, NULL, 'CDN 把内容缓存到离用户近的边缘节点：用户 → 调度（DNS/GSLB）→ 边缘节点命中直接返回。
**回源**：边缘无缓存/过期时向源站请求。运维关注：回源率（命中率）、缓存规则（静态长缓存+动态绕过）、源站保护（只允许 CDN IP 段访问，防绕过）。', NULL, '[\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '什么是正向代理与透明代理？企业里怎么用？', NULL, NULL, '- 正向代理：替客户端出去（公司上网代理、灰度跨地域测试——代理到指定地域出口）
- 透明代理：客户端无感知被劫持（运营商缓存）
- 运维常用姿势：用 curl -x 指定代理模拟不同地域/内网用户验证；排障区分"代理层问题"与"源站问题"（XFF 头与日志比对）', NULL, '[\"架构\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '如何验证一台服务器出口 IP 与公网带宽？', NULL, NULL, '```
curl ifconfig.me              # 或 curl cip.cc 出口IP
speedtest-cli / iperf3 -c 对端   # 带宽测试（内网用 iperf3 更准）
```
排障场景：白名单没生效（出口 IP 变了）、NAT 后多出口选路异常。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '如果抓包看到大量 RST 包，可能有哪些原因？', NULL, NULL, '1. 访问了未监听端口（服务挂了/重启中）→ refused
2. 防火墙 REJECT（reject-with tcp-reset）
3. 应用主动断连：连接数超限、认证失败、协议非法
4. LB 摘除节点时强制断开存量连接

RST 是"异常断开"的信号，结合来源方向（谁发的）判断责任方。', NULL, '[\"抓包\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '简述 ARP 协议与 ARP 欺骗的危害。', NULL, NULL, 'ARP：同一二层网络内，IP → MAC 的解析（广播问"谁是x.x.x.x"，目标回应MAC）。
ARP 欺骗：攻击者冒充网关/目标 MAC，流量被劫持（抓包/篡改/断网）。
防护：交换机动态 ARP 检测（DAI）、静态绑定网关、内网隔离。运维排查 IP 冲突：arping -D 检测。', NULL, '[\"安全\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '一台机器有多个出口路由（双网卡），怎么指定某服务走特定出口？', NULL, NULL, '策略路由：
```
ip rule add from 192.168.1.10 table 100
ip route add default via 192.168.1.1 dev eth1 table 100
```
或应用层绑定源 IP。场景：内网专线 + 公网双出口分流。', NULL, '[\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '内网 DNS 解析偶发超时（几秒），怎么排查？', NULL, NULL, '1. 确认现象：dig +stats 看 Query time 与是否偶发 SERVFAIL
2. resolv.conf 检查：nameserver 顺序、**options timeout:1 attempts:2**（默认5秒超时太长——偶发卡顿常见原因）
3. 本地 DNS 负载/转发上游质量（unbound dnsmasq 日志）
4. 应用侧：JVM 默认不带 OS 缓存（networkaddress.cache.ttl），高并发加本地缓存或 JVM 参数
5. 根治：内网部署缓存 DNS（dnsmasq/CoreDNS）+ 监控解析延迟', NULL, '[\"DNS\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, 'curl 一个接口第一次慢（3s）后续快（50ms），什么原因？', NULL, NULL, '典型"首包慢"：
1. DNS 解析慢（首次解析，后续缓存）——dig 验证
2. TCP+TLS 建连开销 + 无连接复用（keep-alive 未开/连接池未复用）
3. 服务端 JIT/缓存冷启动

定位：curl -w 各阶段耗时：`curl -w "dns:%{time_namelookup} tcp:%{time_connect} tls:%{time_appconnect} total:%{time_total}"`，哪段大修哪段。', NULL, '[\"性能\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '如何在不登录目标机器的情况下，批量检测 100 台机器的 8080 端口连通性？', NULL, NULL, '```
# nmap 快扫（最佳）
nmap -p 8080 --open 192.168.1.0/24
# nc 并行
cat hosts.txt | xargs -P 50 -I {} sh -c ''echo {} $(nc -z -w2 {} 8080 && echo OK || echo FAIL)''
```
输出汇总成清单。这也是巡检脚本的基础段。', NULL, '[\"工具\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, 'LB 后端健康检查配置成 TCP 检查，但后端"假死"（端口通不处理请求），怎么办？', NULL, NULL, 'TCP 层探活测不出应用层假死。升级为**应用层健康检查**：HTTP GET /health（要求返回200且内容校验），K8s 对应 readinessProbe。
注意 /health 实现要轻量（不做全依赖检查或区分 liveness/readiness），否则级联故障。', NULL, '[\"架构\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '怎么定位"只有某个用户访问慢"的问题？', NULL, NULL, '用户维度信息收集：地域/运营商（出口IP）、URL、时间点、截图。
1. 用相同地域测试源（拨测平台多地测试）复现
2. 服务端按用户特征查访问日志耗时（$request_time vs $upstream_response_time：**前者含网络**——大 = 用户到服务器链路慢）
3. 运营商侧：跨网抖动、该区域 CDN 节点异常

答题亮点：说出 nginx 日志两个时间字段的区别。', NULL, '[\"排障\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, 'IPv6 与 IPv4 运维上需要注意什么？', NULL, NULL, '1. 双栈下 localhost 可能解析 ::1，服务绑定 0.0.0.0 只监听 v4 → 偶发连不上：显式绑定或 ::
2. 防火墙/安全组要同时放行 v6（ip6tables）
3. 无 NAT、地址规划（前缀）、SLAAC 与 DHCPv6
4. 工具兼容：ss -6、dig AAAA

面试提"localhost ::1 坑"就是实战派信号。', NULL, '[\"基础\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '说说你对"网络分区"的理解，分布式系统怎么应对？', NULL, NULL, '网络分区=部分节点间断连（机房链路/交换机故障），节点"活着但互不可达"。
应对：
1. 多数派仲裁（etcd/Redis哨兵 quorum），防双主脑裂
2. 客户端超时+重试幂等
3. 跨机房架构：同城双活（RTT 低）优于异地多活

SRE 面试常由"脑裂"话题引出。', NULL, '[\"架构\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'SCENARIO', 2, '用户反馈 https 打不开但 http 正常，你怎么排查？', 'Nginx 443 + 证书。', NULL, '1. 分层：`curl -v https://域名` 看卡在哪步（DNS/TCP/TLS/HTTP）
2. TLS 阶段失败常见：
   - 443 未监听/防火墙未放行（telnet 443）
   - 证书过期：`openssl s_client -connect 域名:443` 看 notAfter
   - 证书链不完整（缺中间证书，部分客户端失败）
   - TLS 版本/套件不匹配（老客户端）
3. nginx -t 与 error.log 第一现场
4. 修复后多端验证（curl/浏览器/老安卓）', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'SCENARIO', 3, '接口偶发 1% 请求超时，无规律，怎么查？', 'Nginx → 应用多实例。', NULL, '1. **缩小范围**：日志统计超时请求的共性（某实例？某时段？某 URL？某上游？）
   - 按 upstream_addr 聚合：集中在单实例 → 该实例问题
   - 均匀分布 → 共性问题（DB、线程池、GC）
2. 应用侧：慢日志/trace 看超时请求在哪个环节（Dubbo/HTTP client/DB）
3. 系统侧：GC 日志对时间轴（FullGC 停顿=偶发超时经典原因）、CPU steal（虚拟化争抢）
4. 网络侧：重传统计、conntrack
5. 证据留存：把超时请求打 traceId 串全链路日志

亮点：从"共性分析"入手而不是瞎猜。', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'SCENARIO', 2, 'SLB 后配置了会话保持，但用户仍随机掉登录态，怎么排查？', 'Java 应用 + Redis Session。', NULL, '1. 确认掉登录态的表现：回登录页（session 丢）vs 401（token 失效）
2. Session 机制核查：是否真的用 Redis 集中存储（若本地内存 + LB 轮询没保持 → 每次打到别的实例就丢）
3. 会话保持配置：源IP hash 对 NAT 后多用户聚簇；cookie 插入模式是否被前端吞
4. Cookie 属性：跨域/Secure/Path 配错导致未携带
5. Redis 过期/逐出策略（maxmemory allkeys-lru 把 session 挤掉——经典事故）
6. 复现手段：登录后带 cookie 逐实例 curl 验证', NULL, '[\"排障\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'SCENARIO', 3, '跨机房专线迁移后，A 机房访问 B 机房 DB 延迟从 2ms 涨到 40ms，怎么办？', '应用响应时间明显变长。', NULL, '1. 确认路径：mtr/traceroute 看是否走了公网绕行（专线没生效/路由没切换）
2. 带宽与 QoS：专线打满（sar -n DEV、云专线监控），专线限速策略
3. 架构应对：
   - 读写分离，写留主库机房
   - 就近缓存热点数据
   - 批量化/减少 RTT 次数（一次 40ms×100 次调用 = 4s！）
4. 终极方案：单元化部署，数据随应用走

考点：延迟×调用次数的放大效应。', NULL, '[\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'SCENARIO', 2, '安全组已放行 8080，但外部仍访问不通，列出你的检查清单。', '云服务器，应用监听 8080。', NULL, '1. 服务真的监听 0.0.0.0:8080？（ss -tlnp，排除只绑 127.0.0.1）
2. 本机 curl 127.0.0.1:8080 是否通（应用本身是否正常）
3. 系统防火墙叠加：iptables/firewalld/ufw（云安全组之外还有一层）
4. 安全组规则方向（入方向）、协议、端口段、源地址是否真的对
5. 是否有 NAT/映射（容器端口映射、云内网 IP vs 弹性 IP）
6. tcpdump 看包是否到达（到了不回=本机防火墙；没到=云网络层）', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'TCP 头部不含以下哪个字段？', NULL, '[\"A. 源端口\",\"B. 序列号\",\"C. TTL\",\"D. 窗口大小\"]', 'C。TTL 在 IP 头（每过一跳减1）；TCP 头有端口/序号/确认号/窗口/标志位。', NULL, '[\"TCP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'UDP 适合以下哪种场景？', NULL, '[\"A. 文件传输\",\"B. 视频直播\",\"C. 网页\",\"D. 支付\"]', 'B。实时性优先容忍丢包：直播/语音/游戏/DNS。可靠传输文件必须 TCP。', NULL, '[\"UDP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'IP 127.0.0.0/8 与 169.254.0.0/16 分别是？', NULL, '[\"A. 回环 / 链路本地（DHCP失败自配）\",\"B. 都是回环\",\"C. 私网/公网\",\"D. 广播组播\"]', 'A。看到 169.254 = DHCP 没拿到地址（排障信号）。私网：10/8、172.16/12、192.168/16。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'netmask 255.255.255.0 等价 CIDR？', NULL, '[\"A. /8\",\"B. /16\",\"C. /24\",\"D. /32\"]', 'C。24 个 1。/30 只剩 2 个可用地址（点对点链路）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'TCP 三次握手中 accept 发生在？', NULL, '[\"A. 收到SYN\",\"B. 完成三次握手后（全连接队列取）\",\"C. 发FIN后\",\"D. 无accept概念\"]', 'B。SYN 进半连接队列，握手完成进全连接（accept）队列；应用来不及 accept → 队列溢 → SYN_OK 但连接被拒。', NULL, '[\"TCP\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'netstat -s 里 "listen queue overflow" 增长说明？', NULL, '[\"A. 全连接队列溢出（应用accept太慢或backlog小）\",\"B. 网卡坏\",\"C. DNS\",\"D. 正常\"]', 'A。调大 backlog（somaxconn/应用配置）或查应用为何不 accept。', NULL, '[\"排障\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '滑动窗口的作用？', NULL, '[\"A. 流量控制（接收方告知可接收量）\",\"B. 拥塞控制\",\"C. 加密\",\"D. 路由\"]', 'A。窗口=接收缓冲余量；拥塞控制是另一套（cwnd 慢启动/拥塞避免）。两者取 min 决定发送速率。', NULL, '[\"TCP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '慢启动指的是？', NULL, '[\"A. TCP拥塞窗口从小到大指数增长探测带宽\",\"B. 网卡慢\",\"C. 应用启动慢\",\"D. DNS慢\"]', 'A。这也是短连接传输小文件效率低的原因之一（还没加速就传完了）——大文件/长连接性能更好。', NULL, '[\"TCP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'Nginx 访问日志 X-Forwarded-For 有多个 IP，第一个是？', NULL, '[\"A. 客户端真实IP（后续是途经代理追加）\",\"B. 最后一跳\",\"C. 随机\",\"D. 服务端IP\"]', 'A。前提：链路可信。伪造风险：客户端可自带假 XFF，第一跳网关应覆盖而非追加。', NULL, '[\"HTTP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'HTTP 方法中幂等的是？', NULL, '[\"A. GET/PUT/DELETE\",\"B. POST\",\"C. PATCH\",\"D. 都不\"]', 'A。重试安全性基础：POST 不幂等，网关自动重试 POST 有重复风险（需幂等键）。', NULL, '[\"HTTP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'Cookie 属性 HttpOnly 的作用？', NULL, '[\"A. 禁 JS 读取（防 XSS 窃取）\",\"B. 只走HTTPS\",\"C. 跨域\",\"D. 压缩\"]', 'A。Secure 才是仅 HTTPS 传输。安全面试基础题。', NULL, '[\"HTTP\",\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '跨域 CORS 是谁做的检查？', NULL, '[\"A. 浏览器\",\"B. 服务器单方面\",\"C. DNS\",\"D. 代理\"]', 'A。服务器返回 Access-Control-Allow-Origin，浏览器决定拦截。curl 无跨域概念——前后端联调排障要点。', NULL, '[\"HTTP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'WebSocket 与 HTTP 的关系？', NULL, '[\"A. 经 HTTP 101 Upgrade 握手后转长连接\",\"B. 完全无关\",\"C. 轮询\",\"D. 只加密\"]', 'A。反向代理需配置 Upgrade/Connection 头透传（Nginx proxy_set_header Upgrade $http_upgrade）。', NULL, '[\"HTTP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'HTTP 状态码 204 与 304 分别？', NULL, '[\"A. 成功无Body / 缓存有效未变\",\"B. 都错误\",\"C. 服务器空/客户端错\",\"D. 重定向\"]', 'A。304 配合 If-None-Match/ETag 协商缓存省带宽。', NULL, '[\"HTTP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'DNS 的 A/AAAA/PTR/MX 分别？', NULL, '[\"A. IPv4/IPv6/反解/邮件\",\"B. 别名4种\",\"C. 全是IP\",\"D. 加密\"]', 'A。反解 PTR 由 IP 查域名（邮件服务器反垃圾常用）；别名是 CNAME。', NULL, '[\"DNS\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'dig 返回 NOERROR 但无记录（ANSWER=0），说明？', NULL, '[\"A. 域名存在但无该类型记录\",\"B. DNS挂了\",\"C. 网络不通\",\"D. 域名被劫持必然\"]', 'A。区分 NXDOMAIN（域名不存在）与 NOERROR 空 answer。排障别混为一谈。', NULL, '[\"DNS\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'hosts 文件优先级与 DNS 谁高？', NULL, '[\"A. hosts 高\",\"B. DNS高\",\"C. 随机\",\"D. 相同\"]', 'A。/etc/hosts 先查——劫持排查与本地测试（把域名指到测试机）的原理。', NULL, '[\"DNS\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'nmap -sS 与 -sT 的区别？', NULL, '[\"A. SYN半开扫描（不完成握手，隐蔽） / 完整连接扫描\",\"B. 一个快一个慢无别\",\"C. TCP/UDP\",\"D. 内外网\"]', 'A。安全扫描/资产盘点常用；-sU 扫 UDP。合法授权场景使用。', NULL, '[\"工具\",\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'mtr 相比 traceroute 的优势？', NULL, '[\"A. 持续发包+丢包率统计（路径质量画像）\",\"B. 更快\",\"C. 图形\",\"D. 无区别\"]', 'A。mtr 报告是跨机房链路工单的标准附件。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'iftop / nethogs 的分工？', NULL, '[\"A. 连接级流量 / 进程级流量\",\"B. 相同\",\"C. 磁盘/内存\",\"D. 都是CPU\"]', 'A。"带宽被谁吃了"两步走：iftop 看哪个连接 → nethogs 定位进程。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 3, 'conntrack table full 报错的含义与应急？', NULL, '[\"A. 连接跟踪表满：调大 nf_conntrack_max / 关不必要跟踪\",\"B. 内存不足\",\"C. 文件句柄\",\"D. CPU满\"]', 'A。NAT/防火墙场景高并发典型故障；dmesg 可见。K8s 节点也常见（kube-proxy iptables 模式）。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 3, 'BGP 与 OSPF 的层级区别？', NULL, '[\"A. BGP 自治系统间（互联网骨干）/ OSPF 单域内\",\"B. 都内网\",\"C. BGP更快\",\"D. 无区别\"]', 'A。运维接触点：多云专线互联、机房出口双线。面试说出 AS 概念即可。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 3, 'VXLAN 解决什么？', NULL, '[\"A. 二层网络跨三层打通（overlay，K8s/数据中心）\",\"B. 加密\",\"C. 加速\",\"D. DNS\"]', 'A。容器网络（Flannel calico）与数据中心大二层的基础；代价是封装开销。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 3, 'QUIC 的连接迁移指？', NULL, '[\"A. 换网（WiFi→4G）连接不断（基于Connection ID不依赖四元组）\",\"B. 迁服务器\",\"C. 虚机漂移\",\"D. 未知\"]', 'A。TCP 用四元组标识，换IP即断。HTTP/3 场景：地铁通勤直播不断流。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, 'telnet/nc 测端口与 ping 测主机的结论组合怎么解读？', NULL, NULL, 'ping通+端口通=全通；ping通+端口不通=服务/防火墙问题；ping不通+端口更不通=网络层断（但注意禁ping的主机）。组合定位法比单点结论快得多。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '列出你抓包时会用的过滤器（至少4个）。', NULL, NULL, '```bash
tcpdump -i any host 10.0.0.5
tcpdump port 443
tcpdump src 10.1.1.1 and dst port 80
tcpdump "tcp[tcpflags] & tcp-rst != 0"
tcpdump -i any net 192.168.0.0/16
tcpdump icmp
```', NULL, '[\"抓包\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '为什么内网服务之间调用也建议加超时与重试？', NULL, NULL, '内网≠不丢包不过载。默认无限等待会把故障放大：一个下游卡死→线程池占满→上游级联雪崩。三件套：连接/读超时（如1s/3s）+ 有界重试（幂等接口）+ 熔断降级。这是稳定性设计第一课。', NULL, '[\"架构\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, '描述长连接（TCP/HTTP keep-alive/WebSocket）的运维注意事项。', NULL, NULL, '1. 贅 balance：长连接会粘在某一实例（新实例没量）→ 服务端主动过期（如300s）或网关重连风暴控制
2. 发布：需要优雅断开提示客户端重连（K8s preStop + 客户端重试）
3. 监控：连接数与存活比（假连接：心跳机制）
4. LB 空闲超时要小于应用心跳间隔，防中间设备掐断', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, '子网 10.1.1.0/26 可用主机数？', NULL, '[\"A. 62\",\"B. 64\",\"C. 30\",\"D. 126\"]', 'A。64地址-网络-广播=62。速算：2^(32-26)-2。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'MAC 地址的层数与长度？', NULL, '[\"A. 二层 / 48位\",\"B. 三层/32位\",\"C. 一层/64\",\"D. 四层/16\"]', 'A。arp 做 IP↔MAC 映射。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, '一个 C 类私网默认掩码？', NULL, '[\"A. 255.255.255.0\",\"B. 255.255.0.0\",\"C. 255.0.0.0\",\"D. 255.255.255.255\"]', 'A。255.255.255.255 是广播地址（DHCP 发现用）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'HTTP/1.1 队头阻塞指？', NULL, '[\"A. 前一请求未完成阻塞后续（同连接串行）\",\"B. 服务器宕机\",\"C. DNS慢\",\"D. TCP丢包 only\"]', 'A。H2 多路复用解决应用层，TCP 层丢包仍会阻塞流（H3 解决）。', NULL, '[\"HTTP\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '幂等重试失败的 POST，网关层怎么做才安全？', NULL, '[\"A. 带客户端幂等键透传，后端按键去重\",\"B. 直接重试\",\"C. 不重试不管\",\"D. 转GET\"]', 'A。支付类接口标准：Idempotency-Key。', NULL, '[\"HTTP\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'SNMP 用于？', NULL, '[\"A. 网络设备监控采集（161/162）\",\"B. 邮件\",\"C. 文件传输\",\"D. 认证\"]', 'A。交换机/路由器指标采集主流； trap 是主动告警。', NULL, '[\"监控\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'ifconfig 已停用的建议替代？', NULL, '[\"A. ip 命令（ip a / ip link / ip route）\",\"B. ethtool\",\"C. 无替代\",\"D. netstat同源\"]', 'A。netstat→ss、route→ip route、ifconfig→ip a 全套迁移。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'ethtool 的典型用途？', NULL, '[\"A. 网卡速率/双工/链路状态诊断\",\"B. 路由\",\"C. DNS\",\"D. 防火墙\"]', 'A。ethtool eth0 看 Link detected；带宽协商错（百兆）是隐性瓶颈。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '两台同网段机器 ping 不通但各自正常，最常见？', NULL, '[\"A. IP 冲突或掩码/网关配错\",\"B. CPU高\",\"C. DNS\",\"D. 磁盘满\"]', 'A。arping -D 查冲突；ifconfig 看掩码。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'HTTP 请求头 Range 用于？', NULL, '[\"A. 断点续传/分片下载\",\"B. 缓存\",\"C. 压缩\",\"D. 跨域\"]', 'A。206 Partial Content 响应；大文件下载与对象存储分片基础。', NULL, '[\"HTTP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 3, 'DDoS 与 CC 攻击的差别？', NULL, '[\"A. DDoS 打流量/连接层；CC 模拟真实请求耗应用资源\",\"B. 相同\",\"C. CC只打DNS\",\"D. DDoS只UDP\"]', 'A。防护：DDoS靠清洗中心/高防IP；CC靠限流+验证码+风控。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 3, 'BFD 与 NTP 心跳检测的层次差别？', NULL, '[\"A. BFD 毫秒级链路检测（网络层）；应用心跳在应用层\",\"B. 相同\",\"C. BFD是DNS\",\"D. 无差别\"]', 'A。双活/HA 主备切换速度取决于故障检测速度。', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '如何验证某个防火墙规则是否生效？', NULL, NULL, '1. 看规则与计数：iptables -L -nv（pkts列）/ firewall-cmd --list-all / nft list ruleset
2. 实测：curl/nc 从外部打；tcpdump 在目标机看包到没到
3. 云上还有安全组（独立一层）与系统防火墙叠加
"规则存在≠规则命中"，看计数器。', NULL, '[\"安全\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '什么是四层反向代理的健康检查与直通（DR）模式？', NULL, NULL, 'LVS 的 DR 模式：请求改 MAC 转发，响应由 RS 直接回客户端（吞吐最高，要求同网段）。健康检查由 keepalived 探测后摘除 VIP。了解即可，体现知识广度。', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, '公司要上多云，网络互联怎么设计？', NULL, NULL, '1. 专线/VPN 打通（云厂商专线或 IPSec over公网）
2. 规划统一地址段（避免重叠，CIDR 提前分配）
3. 路由与 DNS 策略（私有域解析互访）
4. 安全边界：只放行必要网段/端口，东西向隔离
5. 主干可用性：双专线+公网加密兜底
6. 延迟预算：跨云调用链路 RTT 纳入架构评估', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, '抓包发现客户端不断重传 SYN 无响应，中间设备正常，怎么继续？', NULL, NULL, '1. 确认目标：服务端是否监听、backlog 满会**丢弃**SYN（无RST）→ netstat -s | grep -i listen 溢出计数
2. 服务端本机 tcpdump：SYN 到了吗？到不回=防火墙INPUT DROP
3. 半连接队列打满（SYN Flood）
4. NAT/安全组黑洞：路径分段 ping/telent 验证
"SYN 丢失"三嫌疑：队列溢出、防火墙静默丢、链路。', NULL, '[\"排障\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '为什么域名解析刚改完有人生效有人没生效？', NULL, NULL, 'DNS 层级缓存 + TTL：递归DNS/本地缓存/浏览器各自缓存到 TTL 到期。处理：
1. 改解析前提前降 TTL（如60s）
2. 改后验证用权威 + 公共DNS 对比：dig @ns记录 vs dig @223.5.5.5
3. 灰度切换期保留双端可用，别立刻下线旧IP
这是"DNS 生效时间"工单的标准答案。', NULL, '[\"DNS\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, '内网 HTTP 服务想给外部临时预览，有哪些安全姿势？', NULL, NULL, '1. 反向代理+Basic Auth/IP白名单（首选）
2. 隧道：ssh -R 反向/frp/ngrok（选型看合规）
3. 云侧：SLB+ACL 或 API 网关+鉴权
4. 期限与审计：临时开通、到期回收、访问日志
原则：绝不裸奔公网 + 明确授权边界。', NULL, '[\"安全\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, '0.0.0.0 作目标地址时代表？', NULL, '[\"A. 不作为有效目标（监听时=全部网卡）\",\"B. 广播\",\"C. 回环\",\"D. 网关\"]', 'A。语境区分：监听0.0.0.0=所有接口；路由0.0.0.0/0=默认路由。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'curl 走系统代理的环境变量？', NULL, '[\"A. http_proxy/https_proxy\",\"B. CURL_PROXY\",\"C. PROXY\",\"D. 无此机制\"]', 'A。加 no_proxy 排除内网——CI 里高频坑。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 1, 'ss -tlnp 四个参数含义？', NULL, '[\"A. TCP/监听/数字/进程\",\"B. 统计/UDP/长格式/端口\",\"C. 相同\",\"D. tcp/log/numeric/pid只有\"]', 'A。-t TCP -u UDP -l 监听 -n 数字 -p 进程 -a 全部。', NULL, '[\"工具\",\"必背\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'HTTP 401 与 403？', NULL, '[\"A. 未认证（没登录）/已认证但无权限\",\"B. 相同\",\"C. 服务器错\",\"D. 资源没了\"]', 'A。404 才是没资源。', NULL, '[\"HTTP\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'TCP keepalive 与 HTTP keep-alive？', NULL, '[\"A. TCP层探活保连 / 应用层连接复用，是两回事\",\"B. 相同机制\",\"C. 都应用层\",\"D. 都内核\"]', 'A。高频混淆概念，分清即加分。', NULL, '[\"概念\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, '一次 curl 显示 "connection reset by peer" 发生在哪一步？', NULL, '[\"A. 传输中收到RST（服务端/中间设备断）\",\"B. DNS\",\"C. TLS前必\",\"D. 客户端错误\"]', 'A。常见：服务重启、防火墙 reject、协议不匹配（http 打 https）。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 2, 'DNS 解析结果 TTL=60 意味？', NULL, '[\"A. 缓存方最多存60秒\",\"B. 60次查询\",\"C. 60ms\",\"D. 无意义\"]', 'A。切流量前把 TTL 调小是标准预备动作。', NULL, '[\"DNS\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'CHOICE', 3, 'socks5 与 http 代理的差别？', NULL, '[\"A. socks5 通用四层（任意TCP/UDP）；http代理仅HTTP语义\",\"B. 相同\",\"C. http更底层\",\"D. socks5仅浏览\"]', 'A。ssh -D 动态转发即 socks5。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '如何测试服务器到某 IP:Port 的 UDP 连通？', NULL, NULL, 'nc -u -z -w2 1.2.3.4 53（无连接，只能靠响应判断）；更可靠是发实际协议请求：dig @1.2.3.4 或 ntpdate。UDP 无连接语义是本质原因。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '同机房两台机器延迟从 0.5ms 变 5ms，说明什么？', NULL, NULL, '物理距离不变，延迟涨=路径变化或排队：跨机架/汇聚层拥塞/vSwitch 负载/容器 overlay 封装。用 mtr 看路径与跳数；小量级延迟放大（×每次调用次数）依然伤业务。', NULL, '[\"排障\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, '设计多环境（dev/test/prod）的网络隔离策略。', NULL, NULL, '1. VPC/子网划分 + 安全组默认拒绝、按角色最小放行
2. 堡垒机统一入口，禁止直连生产
3. 环境间仅允许特定单向依赖（prod数据不出：脱敏回流）
4. 跳板审计（堡垒机会话录像）
5. 标签化治理（所有资源打 env 标签）防搭错', NULL, '[\"架构\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, 'SYN 包到达但服务器回 RST 而非 SYN+ACK，可能？', NULL, NULL, '1. 目标端口无监听（回RST是标准行为——所以 refused=明确拒绝）
2. iptables REJECT with tcp-reset
3. 服务端负载均衡器端口未配置
区别 DROP（静默=timeout）。RST 通常是"告诉你不行"。', NULL, '[\"排障\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '域名 a.com 和 www.a.com 解析结果不同的可能原因？', NULL, NULL, '记录类型不同（裸域常 A 到 LB，www 常指向 CDN）；配置遗漏其一；CNAME 链不同。处理：dig 两个都查，记录要成对配置。做"根域也解析"是上线检查项。', NULL, '[\"DNS\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '长 ping 的输出里 time 偶尔从 20ms 跳到 2000ms，说明什么？', NULL, NULL, '网络抖动（jitter）：瞬时拥塞/路由震荡/虚拟化调度。对 TCP 影响小于对实时业务（语音）；但如果伴随丢包（loss>0）需查链路。把 ping 结果留存（-D 时间戳）作为报障证据。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 3, '网关层如何识别并防护恶意爬虫？', NULL, NULL, '1. 特征：UA 异常、无 JS/cookie 行为、高频规律请求
2. 限流（UA/IP/指纹维度）+ 验证码挑战
3. WAF 规则（路径遍历/注入特征）
4. 人机验证（JS challenge）与蜜罐路径
5. 信用分级（正常用户/疑似/黑）动态策略
答"分层+动态"即体现工程思维。', NULL, '[\"安全\",\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(2, 'QA', 2, '如何确认"丢包发生在哪一段"？', NULL, NULL, '多点同时 mtr/ping：客户端→网关→机房入口→目标机。丢包首次出现的链段即嫌疑段。云上可开路径分析工具；证据（各点数据）比单点结论有力。', NULL, '[\"排障\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(3, 'CHOICE', 1, '输出重定向 >> 与 2>> 分别？', NULL, '[\"A. 追加stdout / 追加stderr\",\"B. 相同\",\"C. 覆盖\",\"D. 只文件\"]', 'A。日志分离采集常用：out 与 err 分文件。', NULL, '[\"重定向\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '判断字符串包含子串的标准写法？', NULL, '[\"A. [[ $s == *sub* ]]\",\"B. grep only\",\"C. == \\"sub\\"\",\"D. 无法\"]', 'A。或 case "$s" in *sub*) ;; esac（POSIX）。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何让脚本在CentOS/Ubuntu/alpine都能跑？', NULL, NULL, '1. #!/bin/sh + POSIX 语法（alpine 无 bash！）
2. 避免 bashism：[[ ]]、数组、<()
3. shellcheck --shell=sh 检查
4. 差异命令做探测分支（yum/apt/apk）
跨平台脚本必考"sh 兼容"意识。', NULL, '[\"工程化\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 3, '写一段：从 etcd/consul 之外最简单的方式让多台机器共享一份配置（运维脚本视角）。', NULL, NULL, '最简：HTTP 拉取（对象存储/内网 nginx 放配置，脚本 curl -f -o 下载+校验 md5+reload 服务），失败保留旧版本。三要素：**可校验、原子替换（tmp+mv）、失败可回退**。后续演进 git+ansible。', NULL, '[\"实战\",\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '输出重定向覆盖文件并显示内容用？', NULL, '[\"A. cmd | tee file\",\"B. cmd > file only\",\"C. cmd 2>&1\",\"D. cat cmd\"]', 'A。tee 双写；追加 -a。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '统计文件里某个单词出现总次数？', NULL, NULL, '```bash
grep -o "error" app.log | wc -l
```
-o 每次匹配单独一行输出再计数；-c 只数行数（一行多次算1）。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '以下哪个是正确的 if 判断"文件存在且可执行"？', NULL, '[\"A. [ -f x && -x x ]\",\"B. [ -x /path/x ]\",\"C. if -x x then\",\"D. test x -exec\"]', 'B。单个条件直接 [ -x 文件 ]；多条件：[ -f x ] && [ -x x ]。方括号两边必须有空格。', NULL, '[\"语法\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '$#、$?、$$ 分别是？', NULL, '[\"A. 参数个数/上条退出码/当前脚本PID\",\"B. 全部参数/上条输出/PID\",\"C. 参数个数/错误/PID\",\"D. 文件数/状态/用户\"]', 'A。脚本三件套：$# 传参数量、$? 退出码（0成功）、$$ 当前PID（做锁文件/临时文件名）。', NULL, '[\"变量\",\"必背\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '遍历所有位置参数的正确写法？', NULL, '[\"A. for a in \\"$@\\"\",\"B. for a in $@ 都一样\",\"C. for a in $1\",\"D. while args\"]', 'A。加引号的 "$@" 每个参数独立（含空格不拆）；$* 拼一个串。脚本健壮性考点。', NULL, '[\"变量\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'sed 将文件第 3 行整行替换为 hello？', NULL, '[\"A. sed -i \\"3chello\\" f\",\"B. sed -i \\"3s/.*/hello/\\" f\",\"C. sed \\"3=hello\\" f\",\"D. A 和 B 都对\"]', 'D。c 命令换行、s 全替换均可。sed -i 直接改文件（改前备份：sed -i.bak）。', NULL, '[\"sed\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '打印文件第二列，分隔符为冒号？', NULL, '[\"A. awk \\"{print $2}\\" f\",\"B. awk -F: ''{print $2}'' f\",\"C. cut -d: -f1 f\",\"D. awk ''{print :2}''\"]', 'B。-F 指定分隔符；cut 写法为 cut -d: -f2。', NULL, '[\"awk\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '以下哪个不是合法的算术写法？', NULL, '[\"A. $((1+2))\",\"B. let a=1+2\",\"C. expr 1 + 2\",\"D. $[1+2] 都不行\"]', 'D。前三个都合法（注意 expr 参数间要有空格）。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '脚本第一行 #!/bin/bash 称为？作用是？', NULL, '[\"A. 注释，无作用\",\"B. shebang，指定解释器\",\"C. 版权\",\"D. 编译指令\"]', 'B。内核据此选择解释器。常见坑：文件是 Windows 换行（^M）导致 /bin/bash^M 不存在报错——dos2unix 修复。', NULL, '[\"基础\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'set -e 的作用？', NULL, '[\"A. 打印每条命令\",\"B. 任一命令失败立即退出脚本\",\"C. 设置环境变量\",\"D. 忽略错误\"]', 'B。生产脚本必备；配合 set -u（未定义变量报错）、-x（调试）、-o pipefail（管道任一失败即失败）。', NULL, '[\"健壮性\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '比较两个文件内容差异？', NULL, '[\"A. diff -u a b\",\"B. cmp -l a b\",\"C. A 和 B 都可以\",\"D. cat a b\"]', 'C。diff -u 人类可读（patch 格式）；cmp 逐字节比二进制。', NULL, '[\"工具\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '统计当前目录下 .log 文件数量？', NULL, '[\"A. ls *.log | wc -l\",\"B. find . -name \\"*.log\\" | wc -l\",\"C. A 和 B（B 含子目录更准）\",\"D. count *.log\"]', 'C。ls 在文件多时报错/被 glob 限制；find 递归且准确。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '管道中 "$?" 取到的是谁的退出码？', NULL, '[\"A. 管道第一条\",\"B. 管道最后一条命令\",\"C. 随机一条\",\"D. 全部\"]', 'B。要检测管道中任意环节失败需 set -o pipefail。', NULL, '[\"健壮性\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '获取脚本所在目录（不管从哪里执行）？', NULL, '[\"A. pwd\",\"B. dirname $(readlink -f $0)\",\"C. echo $PWD\",\"D. cd .\"]', 'B。经典写法：SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)。脚本内引用同目录文件必须这样，否则 crontab/别的目录执行就找不到。', NULL, '[\"实战\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'trap ''cleanup; exit'' SIGINT SIGTERM 的作用？', NULL, '[\"A. 忽略信号\",\"B. 收到 Ctrl+C/kill 时先执行清理再退出\",\"C. 定时执行\",\"D. 死循环\"]', 'B。优雅退出：删临时文件、释放锁。生产脚本（尤其有锁文件的）必备。', NULL, '[\"健壮性\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '并发执行 10 个子任务且等待全部完成？', NULL, '[\"A. 顺序 for\",\"B. 命令后加 & 再 wait\",\"C. nohup\",\"D. screen\"]', 'B。
```
for t in tasks; do do_it $t &; done
wait
echo all done
```
限并发版：xargs -P 10 或 GNU parallel。', NULL, '[\"并发\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '读取文件的每一行（带空格的行不被拆）？', NULL, '[\"A. for line in $(cat f)\",\"B. while read -r line; do ...; done < f\",\"C. read f\",\"D. cat f | while 正确且变量不丢\"]', 'B。for 会按空白拆词；管道子 shell 变量带不出。D 前半对但循环内变量外不可见（除非 done < <(cat f)）。', NULL, '[\"语法\",\"坑\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'crontab 任务输出去哪了（未重定向时）？', NULL, '[\"A. 黑洞\",\"B. 邮件（/var/spool/mail），常堆积或丢失\",\"C. /tmp\",\"D. dmesg\"]', 'B。所以规范：任务必须 >> log 2>&1，否则排障无据可查。', NULL, '[\"crontab\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '字符串比较"等于"用？', NULL, '[\"A. =（POSIX test）或 ==（bash 内部）\",\"B. -eq\",\"C. eq\",\"D. == only\"]', 'A。-eq 是**数值**比较；字符串用 = / !=。混用是常见 bug。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '脚本中 ${var:-default} 的含义？', NULL, '[\"A. 默认值：var 未设置或为空时取 default\",\"B. 减法\",\"C. 数组\",\"D. 报错\"]', 'A。姊妹版：${var:=default}（并赋值）、${var:?msg}（为空报错退出）、${#var}（长度）、${var%.log}（去后缀）。', NULL, '[\"语法\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '把命令输出同时显示到屏幕并写入文件？', NULL, '[\"A. cmd | tee file\",\"B. cmd > file\",\"C. cmd 2>1\",\"D. cp cmd file\"]', 'A。tee；追加 tee -a。调试长任务进度常用。', NULL, '[\"基础\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 3, 'mktemp 的作用？', NULL, '[\"A. 建目录树\",\"B. 创建唯一临时文件（防冲突，set -u 友好）\",\"C. 计时\",\"D. 格式化\"]', 'B。TMP=$(mktemp) 替代 $$ 拼 tmp 名（更安全防符号链接攻击）。清理配 trap。', NULL, '[\"安全\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 1, '写一条命令：统计 access.log 中 404 的数量。', NULL, NULL, '```
awk ''$9==404'' access.log | wc -l
# 或
grep -c " 404 " access.log
```
扩展：统计各状态码分布 awk ''{print $9}'' access.log | sort | uniq -c | sort -rn。', NULL, '[\"日志\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '写命令：找出 /data 下最大的 10 个文件。', NULL, NULL, '```
du -ah /data | sort -rh | head -11     # 含目录
find /data -type f -printf "%s %p\n" | sort -rn | head -10 | awk ''{printf "%.1fMB %s\n", $1/1048576, $2}''
```', NULL, '[\"磁盘\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何批量把所有 .txt 改名为 .txt.bak？', NULL, NULL, '```
for f in *.txt; do mv "$f" "$f.bak"; done
# 或更安全（名字带空格也稳）：
find . -maxdepth 1 -name "*.txt" -print0 | xargs -0 -I{} mv {} {}.bak
```', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何监控一个日志文件，出现 ERROR 关键词就告警？', NULL, NULL, '```
tail -Fn app.log | while read -r line; do
  case "$line" in *ERROR*) echo "$line" | mail -s "ERROR" ops@x.com ;; esac
done
```
生产建议：filebeat→ES 告警 或 Promtail/Loki 规则，脚本适合临时方案。要点：tail -F（文件轮转后仍跟随）。', NULL, '[\"日志\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '写一个脚本：检查某 URL，失败连续 3 次则重启服务并发通知。', NULL, NULL, '```bash
#!/bin/bash
set -euo pipefail
URL=http://127.0.0.1:8080/health
FAIL=0
for i in 1 2 3; do
  curl -sf -m 3 "$URL" >/dev/null && { echo ok; exit 0; }
  FAIL=$((FAIL+1)); sleep 2
done
logger -p user.err "health fail x3, restarting"
systemctl restart myapp
# 告警 webhook
curl -s -X POST -H "Content-Type: application/json" \
  -d ''{"msg":"myapp 重启(健康检查3次失败)"}'' "$DING_WEBHOOK" >/dev/null
```
考察点：curl -sf --max-time、重试计数、logger 落系统日志、告警动作。', NULL, '[\"实战\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '解释 $(...) 与反引号的区别？为什么推荐前者？', NULL, NULL, '功能等价（命令替换），但 $(...) 可嵌套、可读性好：`$(dirname $(which java))`；反引号嵌套需转义极易错。新脚本一律 $()。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, 'bash 与 sh（dash）的区别？脚本 #!/bin/sh 要注意什么？', NULL, NULL, 'Ubuntu 的 sh 指向 dash：更快但功能少（无 [[ ]]、数组、进程替换 <(...)、== 等 bashism）。#!/bin/sh 脚本必须写 POSIX 语法，否则换环境就崩。CI 容器（alpine 无 bash）里跑脚本是高频坑。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '写一条命令：把 ps 输出里 CPU 前 5 的进程名与占用列出来。', NULL, NULL, '```
ps aux --sort=-%cpu | head -6 | awk ''NR>1{printf "%-20s %s%%\n", $11, $3}''
```', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何让脚本只能单实例运行（防重复执行）？', NULL, NULL, '```
exec 9>/var/run/myjob.lock
flock -n 9 || { echo "已在运行"; exit 1; }
```
flock 原子加锁，脚本退出自动释放。替代方案：mkdir 锁目录 + trap 清理（mkdir 原子性）。', NULL, '[\"并发\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何在脚本中安全使用 rm？给出你的规范。', NULL, NULL, '规范：
1. 变量判空：[ -z "$DIR" ] && exit 1（防 rm -rf ""/意外展开 /）
2. 路径限定：case "$DIR" in /|/usr|/var) exit 1;; esac
3. find 定向删优于 rm -rf 目录
4. 高危操作前 echo 预览 + 二次确认（-i 或日志）
5. 测试环境先跑 shellcheck

本质是"最小破坏半径"设计。', NULL, '[\"安全\",\"素养\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '解释 echo 和 printf 的选择？', NULL, NULL, 'printf 格式可控、不自动加换行、跨实现一致；echo 在不同 shell 对 -e/\c 处理不一。脚本输出建议 printf，尤其输出内容来自变量（echo $var 还会被 glob 展开）。', NULL, '[\"语法\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 3, '写一个支持 -h/-n 参数的脚本骨架（getopts）。', NULL, NULL, '```bash
#!/bin/bash
while getopts "hn:" opt; do
  case $opt in
    h) usage; exit 0 ;;
    n) NAME=$OPTARG ;;
    *) usage; exit 1 ;;
  esac
done
shift $((OPTIND-1))
```
复杂参数可用长选项工具（getopt 长格式或直接 $1 case）。', NULL, '[\"语法\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '写一条命令找出 Nginx access.log 中访问量最高的 URL（第7列）。', NULL, NULL, '```
awk ''{print $7}'' access.log | sort | uniq -c | sort -rn | head -10
```
经典四件套 awk→sort→uniq -c→sort -rn，面试必须秒写。', NULL, '[\"日志\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何统计每个 IP 当天 14 点的请求量？', NULL, NULL, '```
grep "25/Oct/2026:14:" access.log | awk ''{print $1}'' | sort | uniq -c | sort -rn
```
先 grep 时间段过滤再聚合。', NULL, '[\"日志\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 3, '解释 2>&1 以及 >file 2>&1 与 2>&1 >file 的区别？', NULL, NULL, '2>&1：把 stderr 指向 stdout **当前**指向的地方。
- `>f 2>&1`：stdout→f，stderr 跟着→f ✅（都进文件）
- `2>&1 >f`：stderr→屏幕(此时stdout指向屏幕)，stdout→f ❌（错误还在屏幕）
顺序很重要。现代写法：&>f。', NULL, '[\"重定向\",\"进阶\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何把长命令多行书写？', NULL, NULL, '行尾 \ 续行；或heredoc。团队规范常用：
```
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d ''{...}'' \
  http://api/xx
```
注意 \ 后不能有空格。', NULL, '[\"基础\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '脚本里如何生成 YYYY-MM-DD 格式日期与时间戳互转？', NULL, NULL, '```
date +%F_%T           # 2026-10-25_14:30:00
date -d "@1761379200" +%F_%T   # 时间戳转可读
date -d "2026-10-25 14:30" +%s  # 反向
```
备份文件名 %F、日志切割按小时 %Y%m%d%H 都是标配。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何实现"删除 7 天前的备份文件"？写完整脚本片段（含日志）。', NULL, NULL, '```bash
#!/bin/bash
set -euo pipefail
BAK=/data/backup
LOG=/var/log/bak_clean.log
cd "$BAK"
find . -maxdepth 1 -name "*.tar.gz" -mtime +7 -print -delete >> "$LOG" 2>&1
echo "$(date +%F_%T) cleanup done" >> "$LOG"
```
-print 落日志，delete 前可先换成 -exec ls 预演。', NULL, '[\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 3, '如何在脚本中调用另一个脚本的函数？source 与执行的区别？', NULL, NULL, 'source（或 .）在**当前 shell** 执行：函数/变量直接可用，常用于加载公共库（lib.sh）。
直接执行（bash x.sh / ./x.sh）：子进程，变量隔离，只能通过 exit code/stdout 传信息。

工程实践：公共函数库 + source，是消除脚本重复的标准做法。', NULL, '[\"工程化\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '写一条命令快速统计 800 个文件里有多少行含 "timeout"。', NULL, NULL, '```
grep -rl "timeout" dir/ | wc -l      # 含它的文件数
grep -rh "timeout" dir/ | wc -l      # 总行数(-h 去文件名)
```
递归 grep -r 是重点。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'SCENARIO', 2, '你的 crontab 脚本手动能跑，定时跑失败，排查思路？', '脚本操作数据库并写文件。', NULL, '四大经典差异逐一排除：
1. **PATH 极简**：脚本开头 source /etc/profile 或全用绝对路径
2. **% 转义**：date +%F 要写 \%，最好放脚本里让 cron 只调脚本
3. **无控制终端**：需要 tty 的命令（sudo 交互）失败
4. **相对路径**：cd 到脚本目录（SCRIPT_DIR 套路）
5. 看证据：cron 日志 grep CRON /var/log/syslog；脚本内重定向日志；任务加锁防重叠

答题结构：先说"环境差异"框架再列项。', NULL, '[\"crontab\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'SCENARIO', 2, '写一个发布脚本需要包含哪些环节？口述设计。', NULL, NULL, '```bash
#!/bin/bash
set -euo pipefail
APP=webapp; VER=$1
lock; backup_current; pull_artifact $VER
copy_to_release/$VER; ln -sfn release/$VER current
health_check || rollback
reload_nginx; verify; notify
```
要素：参数校验、版本目录+软链切换（原子回滚）、**健康检查失败自动回滚**、通知与日志。答出"软链切换+回滚"是亮点（等价蓝绿思想）。', NULL, '[\"发布\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'SCENARIO', 3, '日志文件太大（10GB），无法直接打开，如何分析错误分布？', NULL, NULL, '不下载不打开，用流式处理：
1. 计数：`grep -c ERROR big.log`；分布：`grep ERROR big.log | awk ''{print $4}'' | sort | uniq -c | sort -rn | head`
2. 抽样：`sed -n ''1000000,1000100p''` 或 `awk ''NR%100000==0''` 抽行看模式
3. 分片并行：split -l 50000000 再 xargs -P 并行统计
4. 长期方案：接入 ELK/Loki（大文件分析本身就是该上日志平台的信号）', NULL, '[\"日志\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'SCENARIO', 3, '批量操作 500 台机器（如改一个配置），如何设计与执行？', NULL, NULL, '1. **绝不上裸 for ssh 手撸**：用 Ansible（playbook + 分批 serial: 10%）
2. 流程：改 staging 验证 → 备份目标文件（copy back或 snapshot）→ 分批执行 → 每批验证（语法检查+服务健康）→ 异常自动暂停
3. 幂等设计：脚本重复跑无副作用
4. 全程日志与变更单

考察：灰度/分批意识与幂等概念，答案里没有"分批"不合格。', NULL, '[\"自动化\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '$0、$1、shift 分别是？', NULL, '[\"A. 脚本名/第一个参数/参数左移\",\"B. 都错误码\",\"C. PID\",\"D. 进程数\"]', 'A。shift 丢弃 $1 后续前移——处理可变参数循环的利器。', NULL, '[\"变量\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, 'test -z 与 test -n？', NULL, '[\"A. 空 / 非空\",\"B. 数字/字符串\",\"C. 文件/目录\",\"D. 相等/不等\"]', 'A。[-z "$var" ] 为真=空。变量永远加引号（否则空变量变 [ -z ] 语义错乱）。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '数值比较用哪个？', NULL, '[\"A. -eq -ne -gt -lt\",\"B. = !=\",\"C. eq ne\",\"D. ==\"]', 'A。字符串用 = !=；数值用 -eq 家族。混用是经典 bug。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, 'if [ -d /x ] 判断什么？', NULL, '[\"A. 目录存在\",\"B. 文件存在\",\"C. 可执行\",\"D. 空文件\"]', 'A。-d 目录 -f 文件 -x 可执行 -r 可读 -e 存在（不限类型）。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, 'for i in {1..5} 与 seq 1 5？', NULL, '[\"A. 都生成1到5序列\",\"B. 不同结果\",\"C. bash不支持花括号\",\"D. seq不推荐\"]', 'A。{a..z}、{1..10..2} 步进；seq 用于变量边界 seq $a $b。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '死循环标准写法？', NULL, '[\"A. while :; do ...; done 或 while true\",\"B. for(;;) bash支持最好\",\"C. loop\",\"D. do while\"]', 'A。守护型脚本标配，配 sleep 与退出条件，避免空转烧 CPU。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'case 语句匹配任意字符的分支？', NULL, '[\"A. *)\",\"B. default\",\"C. _\",\"D. else\"]', 'A。case "$x" in a) ;; b) ;; *) 默认 ;; esac。getopts 处理参数就用它。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '函数定义与调用？', NULL, '[\"A. f(){ ...; }; f\",\"B. function=f\",\"C. def f\",\"D. call f\"]', 'A。local 变量防污染全局；return 返回码（0-255），要返回字符串用 echo+命令替换。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '读取用户交互输入？', NULL, '[\"A. read -p \\"提示\\" var\",\"B. input()\",\"C. scan\",\"D. get\"]', 'A。-s 隐输（密码）、-t 超时（脚本防卡死）。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '数组定义与遍历？', NULL, '[\"A. a=(x y z); for i in \\"${a[@]}\\"\",\"B. list a\",\"C. array[]\",\"D. 不支持\"]', 'A。${#a[@]} 长度、${a[0]} 元素。bash 4+ 支持关联数组 declare -A。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'printf "%-20s %s\n" a b 中 -20 的含义？', NULL, '[\"A. 左对齐宽20\",\"B. 右对齐\",\"C. 截断20\",\"D. 20进制\"]', 'A。生成表格对齐输出；%05d 补零。报告类脚本必用。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'grep -E 与 grep -o 组合的典型用途？', NULL, '[\"A. 扩展正则+只输出匹配部分（提取字段）\",\"B. 加速\",\"C. 递归\",\"D. 计数\"]', 'A。提取 IP/错误码等：grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" log | sort | uniq -c。', NULL, '[\"grep\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'grep 排除注释和空行看配置？', NULL, '[\"A. grep -vE \\"^#|^$\\" f\",\"B. grep -d\",\"C. grep ^#\",\"D. cat -s\"]', 'A。审配置最常用一行。', NULL, '[\"grep\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'sort -k2 -n -r 的含义？', NULL, '[\"A. 按第2列数值倒序\",\"B. 按第2字符\",\"C. 去重\",\"D. 逆序文件\"]', 'A。-t 指定分隔符；-u 去重；-h 人类可读排序（10K<2M）。', NULL, '[\"sort\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'wc -l 与 grep -c 的差异？', NULL, '[\"A. wc 数全部行；grep -c 数匹配行\",\"B. 相同\",\"C. wc更快\",\"D. grep多算\"]', 'A。注意 grep -c 在无匹配时返回退出码1（脚本 set -e 会误退出）。', NULL, '[\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'tr 的两个高频用法？', NULL, '[\"A. 大小写转换 / 删除字符（tr -d \\"\\r\\"）\",\"B. 排序\",\"C. 替换单词\",\"D. 统计\"]', 'A。tr a-z A-Z < f；Windows 换行修复 tr -d "\r" < a > b。', NULL, '[\"文本\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'cut 与 awk 取列的选择？', NULL, '[\"A. 单分隔符简单取列用 cut；复杂逻辑用 awk\",\"B. 都用awk\",\"C. cut更强\",\"D. 无规则\"]', 'A。cut -d: -f1 /etc/passwd；连续空格分隔（ps 输出）只能 awk。', NULL, '[\"文本\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'xargs 的 -I 与 -n 区别？', NULL, '[\"A. -I 指定占位符替换；-n 每次传几个参数\",\"B. 相同\",\"C. 递归\",\"D. 并发\"]', 'A。find | xargs -I{} mv {} {}.bak；批量并发加 -P 10。', NULL, '[\"xargs\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'tee -a 与 > 的区别？', NULL, '[\"A. tee 同时输出屏幕并-a追加文件；> 只写文件覆盖\",\"B. 相同\",\"C. tee更慢必用\",\"D. >追加\"]', 'A。构建脚本既要看进度又要留日志用 tee。', NULL, '[\"重定向\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '管道里 echo 序号每行加前缀？', NULL, '[\"A. ... | awk ''{print NR\\": \\"$0}''\",\"B. cat -n only\",\"C. paste\",\"D. nl相同\"]', 'A。awk NR 全局行号；cat -n/nl 也行但管道里 awk 最顺。', NULL, '[\"awk\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 3, 'shellcheck 报 SC2086 通常是什么问题？', NULL, '[\"A. 变量未加双引号（分词风险）\",\"B. 语法错误\",\"C. 未定义变量\",\"D. 权限\"]', 'A。$var 空格拆词的经典坑，改 "$var"。CI 集成 shellcheck 是脚本质量卡点。', NULL, '[\"质量\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 3, '脚本如何获取自身绝对路径且支持软链调用？', NULL, '[\"A. readlink -f \\"$0\\" 再 dirname\",\"B. $0 就够\",\"C. pwd一定对\",\"D. 无解\"]', 'A。SCRIPT_DIR=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)。生产脚本头必备行。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 3, '两个脚本并发写同一文件如何避免内容交错？', NULL, '[\"A. flock 文件锁串行化追加\",\"B. 没事\",\"C. >> 天然安全\",\"D. 只能一个进程\"]', 'A。小块 >> 交错概率低但存在；flock 是标准答案；更彻底用消息队列/数据库。', NULL, '[\"并发\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '写一条命令：把 ps 输出里含 "java" 的行的第2列（PID）提取成一个列表文件。', NULL, NULL, '```bash
ps -ef | awk ''/java/{print $2}'' > /root/java.pids
```
扩展：kill 全部：awk ''/java/ && !/awk/{print $2}'' | xargs kill。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何让脚本报错时带上下文（哪一行失败）？', NULL, NULL, '```bash
#!/bin/bash
set -euo pipefail
trap ''echo "ERROR at line $LINENO" >&2'' ERR
```
组合 debug：set -x 或 bash -x 执行。错误可定位是可维护性的底线。', NULL, '[\"健壮性\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '写一个等待服务就绪的通用函数（发布脚本常用）。', NULL, NULL, '```bash
wait_for() {
  local i=0
  until curl -sf -m 2 "$1" >/dev/null 2>&1; do
    i=$((i+1)); [ $i -ge 30 ] && { echo "timeout: $1"; return 1; }
    sleep 2
  done
}
wait_for http://127.0.0.1:8080/health || exit 1
```
容器 depends_on、K8s initContainer 同思想：等依赖再起。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 3, '如何安全地在生产批量执行脚本（发布/清理）？给出流程清单。', NULL, NULL, '1. 幂等设计（重复跑无副作用）
2. 灰度：先 1 台 → 观察 → 10% → 全量
3. dry-run 模式（只打印不执行）
4. 备份先行（配置/数据）+ 回滚脚本备好
5. 日志落盘带时间戳与主机名
6. 加锁防重叠（flock）
7. 变更单+审批+执行窗口

用 Ansible 承载以上流程比裸脚本更专业。', NULL, '[\"素养\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, 'dirname 与 basename 的功能？', NULL, '[\"A. 取目录部分 / 取文件名部分\",\"B. 删除/改名\",\"C. 建目录\",\"D. 排序\"]', 'A。basename $(readlink -f $0) 常用于脚本定位。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '命令替换里多条命令想都执行，用 ; 还是 &&？', NULL, '[\"A. 看需求：; 无条件顺序，&& 前者成功才后者\",\"B. 相同\",\"C. 都不执行\",\"D. &&更快\"]', 'A。发布脚本用 && 链（失败即停）是安全默认。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '判断上条命令成功与否的规范写法？', NULL, '[\"A. if cmd; then ...; fi\",\"B. cmd; if [$?=0]\",\"C. 只有 $?\",\"D. 无法判断\"]', 'A。直接 if cmd 判退出码最清晰；$? 适合日志记录。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '把多行文本写入文件的标准方式？', NULL, '[\"A. cat > f <<EOF ... EOF\",\"B. echo 多次最好\",\"C. vi only\",\"D. printf 逐行\"]', 'A。heredoc；EOF 加引号（<<''EOF''）禁止变量展开。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '脚本中忽略某条命令的失败继续执行？', NULL, '[\"A. cmd || true\",\"B. 删掉set -e only\",\"C. 不可能\",\"D. cmd !\"]', 'A。局部豁免的标准姿势，比全局关 -e 安全。', NULL, '[\"健壮性\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, '对变量做默认值+写回的写法？', NULL, '[\"A. : ${VAR:=default}\",\"B. VAR=default\",\"C. $VAR-default\",\"D. 无法\"]', 'A。:= 未定义则赋值并使用；:- 只用不写回。', NULL, '[\"语法\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 3, '进程替换 <(...) 属于哪种用法场景？', NULL, '[\"A. 把命令输出当文件传给另一个命令\",\"B. 后台执行\",\"C. 管道别名\",\"D. 输入重定向旧写法\"]', 'A。diff <(cmd1) <(cmd2) 对比两命令输出。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '写一条命令：把 ls -l 输出按第5列（大小）数值排序取最大文件的文件名。', NULL, NULL, '```bash
ls -l | sort -k5 -n | tail -1 | awk ''{print $NF}''
```
注意符号链接与列偏移；更严谨用 find -printf。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何防止脚本被 Ctrl+C 打断清理一半（要原子性）？', NULL, NULL, 'trap 捕获信号完成清理再退出：
```bash
TMP=$(mktemp)
trap ''rm -f "$TMP"; exit 130'' INT TERM
# ... 使用 TMP ...
rm -f "$TMP"; trap - INT TERM
```
先写临时文件最后 mv（原子替换）也是同思想。', NULL, '[\"健壮性\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 3, '解释 (( ))、[[ ]] 相对 [ ] 的增强。', NULL, NULL, '(( ))：算术上下文（((n++))、(( n > 3 ))）；[[ ]]：字符串比较更安全（无词切分）、支持 && || 和 =~ 正则。均为 bashism——#!/bin/sh 脚本别用。', NULL, '[\"语法\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, 'head -c 100 f 的作用？', NULL, '[\"A. 前100字节\",\"B. 前100行\",\"C. 第100行\",\"D. 后100字节\"]', 'A。-c 字节 -n 行。二进制截取分析用。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 1, '命令行补全快捷键？', NULL, '[\"A. Tab\",\"B. Ctrl+K\",\"C. Esc\",\"D. F1\"]', 'A。双 Tab 列候选；Ctrl+R 搜历史。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'grep -A3 -B1 "ERR" f 的含义？', NULL, '[\"A. 匹配行后3行前1行（看异常栈上下文）\",\"B. 前3后1行数\",\"C. 计数\",\"D. 排除\"]', 'A。查错误上下文的黄金参数。', NULL, '[\"grep\",\"必背\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'ls | xargs rm 与 ls | xargs -n1 rm 的差别场景？', NULL, '[\"A. 后者每文件一次rm（参数超长保护）\",\"B. 相同\",\"C. 前者安全\",\"D. 后者慢必用\"]', 'A。文件多时一次传参超限；-n 分批更稳。空格名文件用 -d "\n" 或 find -print0。', NULL, '[\"xargs\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 2, 'sort -t: -k3 -n /etc/passdu 按？', NULL, '[\"A. 冒号第3列（UID）数值排\",\"B. 字符串排\",\"C. 行号\",\"D. 逆序\"]', 'A。-t分隔 -k列 -n数值。', NULL, '[\"sort\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'CHOICE', 3, 'eval 的作用与风险？', NULL, '[\"A. 把变量内容当代码执行（动态拼接）——注入风险慎用\",\"B. 求值数学\",\"C. 调试\",\"D. 无作用\"]', 'A。多数场景有更安全的替代（数组/函数）。', NULL, '[\"进阶\",\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '一条命令：把 /etc/passwd 中所有使用 nologin shell 的用户名列出。', NULL, NULL, '```bash
grep nologin /etc/passwd | cut -d: -f1
# 或 awk -F: ''/nologin/{print $1}'' /etc/passwd
```
账号审计基础命令。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 2, '如何统计一个目录下各扩展名文件的数量 TOP5？', NULL, NULL, '```bash
find /path -type f | sed ''s/.*\.//'' | sort | uniq -c | sort -rn | head -5
```
无扩展名会出杂项，可 grep -v 排除。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 3, 'set -e 与管道的组合陷阱是什么？怎么解决？', NULL, NULL, '陷阱：set -e 只看管道**最后一条**退出码——`false | true` 不退出。
解决：set -o pipefail（任一环节失败即失败）。生产模板标配 -euo pipefail 三连。', NULL, '[\"健壮性\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(3, 'QA', 3, '写一个函数：重试某命令最多3次（间隔2秒）。', NULL, NULL, '```bash
retry() {
  local n=0
  until "$@"; do
    n=$((n+1)); [ $n -ge 3 ] && return 1
    sleep 2
  done
}
retry curl -sf http://x/health
```
网络类操作重试+幂等意识是发布脚本基础件。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(4, 'CHOICE', 1, 'Nginx 的工作模型常被概括为？', NULL, '[\"A. 多进程+单线程事件驱动（epoll）\",\"B. 多线程每连接\",\"C. 单进程\",\"D. 协程池\"]', 'A。master/worker + 非阻塞 IO。', NULL, '[\"原理\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'proxy_next_upstream 默认含 error timeout，POST 也会重试吗？', NULL, '[\"A. 会在这些场景重试（POST需幂等保护）\",\"B. 不会\",\"C. 默认关闭重试\",\"D. 仅GET\"]', 'A。non_idempotent 相关配置要懂——交易接口重试风险。', NULL, '[\"坑\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '站点静态资源偶发 404，刷新又好了，什么鬼？', NULL, NULL, '多实例（或灰度/CDN 多节点）版本不一致：请求轮询/解析到旧节点而资源是新版 hash 命名。排查：比对各节点文件（mdsum）；规范：静态资源带 hash、双版本共存发布、CDN 刷新。', NULL, '[\"排障\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 3, 'Nginx 作为 TCP 四层代理（stream）转发 MySQL 的配置要点？', NULL, NULL, '```nginx
stream {
  upstream mysql { server 10.0.0.1:3306; }
  server { listen 3307; proxy_pass mysql; }
}
```
注意：需编译 --with-stream；与 http{} 平级；无法做 HTTP 级路由，但可 proxy_timeout/连接数控制。典型用途：读写端口分离、外网暴露收敛。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, 'Nginx reload 的信号机制？', NULL, '[\"A. master 收 HUP 重新加载配置并平滑换 worker\",\"B. 重启进程\",\"C. KILL worker\",\"D. 客户端断连\"]', 'A。nginx -s reload 即发 HUP。', NULL, '[\"原理\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '如何只对 POST 请求做特殊处理（Nginx）？', NULL, NULL, '```nginx
if ($request_method = POST) { ... }
```
if 内只能做有限动作（return/rewrite）；复杂逻辑交给应用或 map+变量。记住"if is evil"慎用原则。', NULL, '[\"配置\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, 'Nginx master 与 worker 的分工？', NULL, '[\"A. master 处理请求\",\"B. master 管配置/worker 进程，worker 处理请求\",\"C. 一样\",\"D. worker 管日志\"]', 'B。master 读配置、管理 worker、平滑 reload；worker 单线程 epoll 处理请求。所以 worker 数=CPU核数（auto）。', NULL, '[\"架构\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, '平滑重载 Nginx 配置（不断连接）？', NULL, '[\"A. nginx -s reload\",\"B. systemctl restart nginx\",\"C. kill -9\",\"D. reboot\"]', 'A。reload 发 HUP：旧 worker 处理完存量连接后退出，新 worker 用新配置。restart 会断连。改配置必须先 nginx -t。', NULL, '[\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, 'location 优先级最高的是？', NULL, '[\"A. location /xxx 前缀\",\"B. location = /xxx 精确匹配\",\"C. location ~ 正则\",\"D. location ^~ /xxx\"]', 'B。精确 > ^~ > 正则（按顺序）> 最长前缀。', NULL, '[\"配置\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'proxy_pass http://backend/ 与 http://backend（带不带斜杠）的区别？', NULL, '[\"A. 一样\",\"B. 带/替换location前缀路径；不带/拼接完整路径\",\"C. 相反\",\"D. 带报错\"]', 'B。location /api/ { proxy_pass http://b/; } → /api/x 转发为 /x；不带斜杠 → /api/x。改配置忘斜杠导致 404 是经典事故。', NULL, '[\"配置\",\"坑\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'upstream 中 ip_hash 的作用与隐患？', NULL, '[\"A. 加速；无隐患\",\"B. 同一客户端IP固定打到同一后端（会话保持）；NAT后分布不均/后端增减时重排\",\"C. 哈希URL\",\"D. 随机\"]', 'B。会话保持有状态方案；更主流做法是应用无状态化+集中session（Redis）。', NULL, '[\"负载均衡\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, '502 的直接含义？', NULL, '[\"A. 后端超时\",\"B. 网关连不上后端/后端返回无效响应\",\"C. 网关过载\",\"D. 客户端错\"]', 'B。连不上（进程挂/端口错/防火墙）。504 才是"连上了但等超时"。', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, '504 的直接含义？', NULL, '[\"A. 后端挂了\",\"B. 后端在 proxy_read_timeout 内没返回\",\"C. 证书错\",\"D. 限流\"]', 'B。后端慢：慢SQL、死锁、下游卡。排查后端日志/慢查询，不是重启 Nginx。', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'Nginx 默认的 access.log 字段中 $upstream_response_time 表示？', NULL, '[\"A. 客户端耗时\",\"B. 上游后端处理耗时（可能多个用逗号分隔）\",\"C. TLS耗时\",\"D. 日志时间\"]', 'B。排障黄金字段：$request_time（总）远大于 $upstream_response_time → 慢在客户端网络/传输；两者接近 → 后端慢。', NULL, '[\"排障\",\"进阶\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'client_max_body_size 的作用？', NULL, '[\"A. 限制并发\",\"B. 请求体大小上限（上传413）\",\"C. 日志大小\",\"D. 缓存\"]', 'B。默认1m，上传大文件报 413 Request Entity Too Large 时改它。', NULL, '[\"配置\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'worker_connections 4096 时，作为反代最大并发客户端连接约多少？', NULL, '[\"A. 4096×workers\",\"B. 约一半（每客户端连接占2个：client→ng, ng→backend）\",\"C. 无限\",\"D. 4096\"]', 'B。反代场景每个客户端消耗2个连接。面试口算题。', NULL, '[\"调优\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, '开启 gzip 的指令位置与关键参数？', NULL, '[\"A. http{gzip on; gzip_types text/css application/json; gzip_min_length 1k;}\",\"B. 只能server\",\"C. 需要模块编译\",\"D. 默认开启\"]', 'A。注意 gzip_types 默认只压缩 text/html；图片视频已压缩无需再压；gzip_comp_level 4-6 性价比高。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'access 日志里大量 499，说明什么？', NULL, '[\"A. 后端挂\",\"B. 客户端（用户/上游超时设置）等不及主动断开——通常后端太慢\",\"C. 正常\",\"D. 限流\"]', 'B。499=client closed request。与 504 常伴生。治理方向：后端提速、超时对齐、异步化。', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'Nginx 限流 limit_req 是哪种算法？', NULL, '[\"A. 令牌桶\",\"B. 漏桶（匀速流出）\",\"C. 滑动窗口计数\",\"D. 随机\"]', 'B。limit_req_zone 定义速率，burst 桶容量，nodelay 允许瞬时消费桶内配额。', NULL, '[\"限流\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, '反向代理时把客户端真实IP传给后端的头？', NULL, '[\"A. X-Real-IP / X-Forwarded-For\",\"B. Host\",\"C. Cookie\",\"D. Referer\"]', 'A。标配三件：proxy_set_header Host $host; X-Real-IP $remote_addr; X-Forwarded-For $proxy_add_x_forwarded_for。', NULL, '[\"配置\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'server_name 匹配优先级？', NULL, '[\"A. 精确名 > 最长通配符前缀(*.x) > 最长后缀(x.*) > 正则\",\"B. 书写顺序\",\"C. 随机\",\"D. 长度\"]', 'A。默认 server（default_server）兜底未匹配的 Host。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'nginx -t 报 "host not found in upstream"，原因？', NULL, '[\"A. upstream 写了域名但启动时解析不到（DNS/域名错）\",\"B. 端口错\",\"C. 权限\",\"D. 内存\"]', 'A。Nginx 启动时解析 upstream 域名。动态解析需 resolver + variable 写法（proxy_pass http://$backend;）。K8s 场景常见。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, '限流返回状态码定制为 429 用哪个指令？', NULL, '[\"A. limit_req_status 429\",\"B. error_page 429\",\"C. return 429\",\"D. 不能改\"]', 'A。配合 error_page 429 /429.html 可返回友好页面。', NULL, '[\"限流\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 3, 'stream 模块与 http 模块的区别？', NULL, '[\"A. 一样\",\"B. stream 工作在四层（TCP/UDP转发），http 七层\",\"C. stream 更快没区别\",\"D. stream 只能代理MySQL\"]', 'B。四层转发（数据库、Redis、TCP服务），七层做 HTTP 路由。编译需 --with-stream。', NULL, '[\"架构\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 1, '写一段最简反向代理配置：/api 转发到本机 9000，其余返回静态页。', NULL, NULL, '```nginx
server {
    listen 80;
    location /api/ { proxy_pass http://127.0.0.1:9000/; }
    location / { root /var/www/html; index index.html; }
}
```
注意 /api/ 带斜杠的路径替换语义。', NULL, '[\"配置\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, 'Nginx 如何做 HTTP 强制跳转 HTTPS？', NULL, NULL, '```nginx
server {
    listen 80;
    return 301 https://$host$request_uri;
}
```
301 永久重定向浏览器会缓存；临时切流用 302。', NULL, '[\"HTTPS\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '如何配置一个 upstream 含两台后端，一台权重加倍，一台只做备份？', NULL, NULL, '```nginx
upstream apps {
    server 10.0.0.1:8080 weight=2;
    server 10.0.0.2:8080;
    server 10.0.0.3:8080 backup;   # 全挂才上
}
```
还有 down（摘除）、max_fails+fail_timeout（被动探活）。主动探活需商业版 health_check 或开源第三方。', NULL, '[\"负载均衡\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '线上 Nginx 修改配置的标准操作流程（含回滚预案）？', NULL, NULL, '1. cp nginx.conf nginx.conf.$(date +%F-%H%M).bak（备份即可回滚）
2. 修改配置
3. nginx -t（语法与upstream解析检查）
4. nginx -s reload（平滑生效）
5. 验证：curl 业务 + error.log tail
6. 异常：cp 回备份再 reload（或 systemctl restart 兜底）

纪律：**先备份、必 -t、后 reload**。', NULL, '[\"运维素养\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, 'access_log 太大，如何按天切割并保留 14 天？', NULL, NULL, 'logrotate /etc/logrotate.d/nginx：
```
/var/log/nginx/*.log {
    daily
    rotate 14
    compress
    missingok
    sharedscripts
    postrotate
        [ -f /run/nginx.pid ] && kill -USR1 $(cat /run/nginx.pid)
    endscript
}
```
USR1 让 Nginx 重开日志句柄（不重启服务）。', NULL, '[\"日志\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '如何用 Nginx 做灰度：内网 IP 走新版本，其他走旧版本？', NULL, NULL, '```nginx
upstream new { server 10.0.0.10:8080; }
upstream old { server 10.0.0.20:8080; }
geo $gray {
    default old;
    10.0.0.0/8  new;      # 内网走新
}
server {
    location / { proxy_pass http://$gray; }
}
```
geo/map 按 IP/Cookie/Header 分流是网关灰度基础。', NULL, '[\"发布\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 3, '解释 Nginx 的 epoll 为什么能支撑高并发（对比 select）？', NULL, NULL, 'select：每次遍历全部 fd（O(n)）、有 1024 上限；epoll：内核事件回调只返回就绪 fd（O(1)）、百万连接。加上 Nginx 的 master/worker 非阻塞 + 状态机（一个 worker 单线程处理上万连接，无线程切换开销），构成 C10K 时代的标准答案。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, 'proxy_next_upstream 有什么用？', NULL, NULL, '请求失败时自动重试下一台后端：
```
proxy_next_upstream error timeout http_502;
proxy_next_upstream_tries 2;
```
注意：**只对幂等请求安全**（GET）；POST 重试可能重复下单——生产要限制 error timeout 且业务带幂等键。', NULL, '[\"配置\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '如何定位 Nginx 自身的 CPU/内存问题？', NULL, NULL, 'CPU 高：
1. 看是哪个 worker、连接数（stub_status 模块：active connections）
2. 日志级别过高（info→warn）
3. 正则恶意回溯/超大 header 攻击 → 抓包看请求模式
内存高：
1. 连接数×缓冲区（proxy_buffering 大响应、client_body_buffer）
2. 日志变量昂贵（$request_body）
工具：strace -p、perf top 定位热点。', NULL, '[\"调优\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, 'Nginx 如何获取客户端真实 IP（前面有多层代理）？', NULL, NULL, '第一层 Nginx：set_real_ip_from 受信代理段; real_ip_header X-Forwarded-For; real_ip_recursive on;
之后 $remote_addr 即还原的真实 IP。应用侧取第一个非受信 IP。核心：**只有受信边界内的 XFF 可信**。', NULL, '[\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '什么是雪崩保护：后端全挂时 Nginx 能做什么？', NULL, NULL, '1. 备份服务器 backup 兜底（静态降级页）
2. error_page 502 503 /maintenance.html + 503 返回（体面降级）
3. proxy_cache 对 GET 做兜底缓存（proxy_cache_use_stale error timeout updating）——后端挂了返回旧缓存
4. 限流保护残存节点

"优雅降级"思维是 SRE 加分项。', NULL, '[\"高可用\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'SCENARIO', 2, '扩容后端从 2 台到 4 台，Nginx 需要做什么？直接 reload 有风险吗？', 'upstream 静态配置。', NULL, '1. 新机器健康检查通过（应用启动完成、监听正确）
2. nginx.conf upstream 添加两行 → nginx -t → reload（平滑，不断连接）
3. 观察 error.log 无 "no live upstreams"、access.log upstream_addr 分布均匀
风险点：
- 长连接场景（keepalive 到 upstream）需 upstream 里 keepalive 指令配合
- 新机器未预热缓存会导致瞬时压力集中——可先摘掉一台旧机器流量再平移

答"先健康检查再 reload、说出现察指标"即优秀。', NULL, '[\"负载均衡\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'SCENARIO', 2, '某接口突发大量 502，但后端进程都在，怎么查？', 'Nginx → Java 应用 4 实例。', NULL, '1. error.log 搜具体错误：
   - connect() failed (111 refused) → 后端没监听（容器重启中/端口映射断）
   - upstream timed out → 不是502是504
   - **recv() failed / reset by peer** → 后端主动断：OOM被杀（dmesg）、连接队列满（ backlog）、协议错
2. 瞬时并发检查：是否发布中（滚动更新摘流量不充分）、连接池打满
3. 后端侧：GC 日志、accept 队列（ss -lnt Recv-Q）、日志报错
4. 证据链：同一时刻 Nginx 错误 + 后端现象对齐时间轴', NULL, '[\"排障\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'SCENARIO', 3, '老板要求"接口 P99 从 2s 降到 500ms"，Nginx 层你能做什么？', 'Nginx + 后端 Java。', NULL, '先定位再动手（P99 慢的组成）：
1. 日志分析 $request_time vs $upstream_response_time：网络 vs 后端
2. Nginx 可做的：
   - 开启 keepalive 连接池（upstream keepalive 64; proxy_http_version 1.1; Connection ""）省重复建连
   - gzip/brotli 减传输（大响应体）
   - 静态化+proxy_cache 热点接口
   - 错误 fast path（快速失败防拖垮）
3. 主要靠后端：慢 SQL、并行调用、缓存——网关只是透传

答出"先看两个 time 字段定位瓶颈在谁"是关键。', NULL, '[\"性能\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, 'Nginx 配置文件的主结构与层次？', NULL, '[\"A. main→http→server→location\",\"B. server→http\",\"C. location→server→http\",\"D. 平级\"]', 'A。events{} 在 main 层；upstream 在 http 层。指令位置错会报 "directive not allowed here"。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, '静态站点 root 与 alias 的区别？', NULL, '[\"A. root 拼接location路径；alias 直接替换\",\"B. 相同\",\"C. alias只能全局\",\"D. root只支持变量\"]', 'A。location /i/ { root /data/w; } → /data/w/i/x；alias /data/w/ → /data/w/x。alias 结尾斜杠易错。', NULL, '[\"配置\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, 'return 与 rewrite 都能跳转，简单跳转用？', NULL, '[\"A. return（直接返回，高效）\",\"B. rewrite\",\"C. proxy\",\"D. error_page\"]', 'A。return 301 https://...；rewrite 适合需要捕获变量/多条规则的复杂场景。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'client_body_timeout 与 proxy_read_timeout 分别管哪段？', NULL, '[\"A. 客户端发体的时长 / 等后端响应的时长\",\"B. 相同\",\"C. DNS/证书\",\"D. 都是连接超时\"]', 'A。三个超时各管一段：客户端侧（client_*）、到后端（proxy_connect/send/read）。定位超时要先分段。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'proxy_set_header Host $host 为什么重要？', NULL, '[\"A. 后端按域名区分虚拟主机/路由必须\",\"B. 仅记录\",\"C. 安全\",\"D. 无关\"]', 'A。不透传 Host，后端多站点会全落到默认站。同组必带 X-Real-IP/XFF。', NULL, '[\"配置\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'stub_status 模块看什么？', NULL, '[\"A. active connections/读写等待数（Nginx 自身状态）\",\"B. 后端状态\",\"C. 日志\",\"D. CPU\"]', 'A。location /nginx_status { stub_status; } 配白名单。判断 Nginx 层是否为瓶颈。', NULL, '[\"监控\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'error.log 里 "upstream sent too big header" 怎么办？', NULL, '[\"A. 调 proxy_buffer_size/proxy_buffers\",\"B. 重启\",\"C. 换机器\",\"D. 502正常\"]', 'A。后端返回大 cookie/header 时常见：proxy_buffer_size 32k; proxy_busy_buffers_size 64k。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, '"worker_connections are not enough" 说明？', NULL, '[\"A. 连接数达上限：调大配置与ulimit\",\"B. 内存不足\",\"C. CPU\",\"D. 后端问题\"]', 'A。同时核对 worker_rlimit_nofile 与系统 nofile。', NULL, '[\"调优\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'geoip/realip 模块：set_real_ip_from 用于？', NULL, '[\"A. 声明可信代理段，从XFF还原真实IP\",\"B. 封禁IP\",\"C. 加速\",\"D. 日志\"]', 'A。多层代理链必备；real_ip_recursive on 处理多级。', NULL, '[\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, '同一个 server_name 多个域名的写法？', NULL, '[\"A. server_name a.com b.com *.c.com;\",\"B. 多个server块 only\",\"C. 不支持\",\"D. 分号分隔不同含义\"]', 'A。泛域名 *.x.com 与正则 server_name ~^... 也可。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'Nginx 变量 $host、$http_host、$proxy_add_x_forwarded_for 分别？', NULL, '[\"A. 请求主机名 / 带端口的原样Host / 追加本机IP的XFF链\",\"B. 相同\",\"C. 客户端IP三种\",\"D. 服务端信息\"]', 'A。反代三件套必背。', NULL, '[\"配置\",\"必背\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 3, 'map 指令的典型用途？', NULL, '[\"A. 按条件给变量赋值（灰度分流/日志开关）\",\"B. 地图\",\"C. 路由表\",\"D. 限流 only\"]', 'A。map $http_x_gray $up { default prod; "1" canary; } + proxy_pass http://$up。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 3, 'upstream keepalive 为什么要配 proxy_http_version 1.1？', NULL, '[\"A. HTTP/1.1 默认长连接，1.0 短连接会废掉连接池\",\"B. 性能玄学\",\"C. 安全\",\"D. 不必要\"]', 'A。还需 proxy_set_header Connection ""。三行组合是反代提速标配。', NULL, '[\"调优\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 3, 'split_clients 指令用于？', NULL, '[\"A. 按比例哈希分流（百分比灰度）\",\"B. 分割日志\",\"C. 限流\",\"D. 静态切分\"]', 'A。split_clients "${remote_addr}${...}" $bucket { 10% canary; * prod; }。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 3, 'Nginx 热升级（二进制）流程的核心？', NULL, '[\"A. 新二进制+USR2+WINCH+QUIT 平滑切worker\",\"B. 直接覆盖重启\",\"C. reload即可\",\"D. 不支持\"]', 'A。低频但体现原理理解：master 不杀老 worker 直到确认新版本稳定。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '一段标准 HTTPS + HTTP2 + 反代 + 静态站点的 server 配置（默写要点）。', NULL, NULL, '```nginx
server {
  listen 443 ssl http2;
  server_name app.com;
  ssl_certificate /c/fullchain.pem;
  ssl_certificate_key /c/privkey.pem;
  location /api/ { proxy_pass http://apps/; proxy_set_header Host $host; proxy_set_header X-Real-IP $remote_addr; }
  location / { root /var/www/app; try_files $uri $uri/ /index.html; }
}
server { listen 80; return 301 https://$host$request_uri; }
```', NULL, '[\"配置\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, 'Nginx 502 你在 error.log 里见过哪几种报错？分别指向什么？', NULL, NULL, '1. connect() failed (111: Connection refused) → 后端没监听
2. connect() failed (110: timed out) → 后端/防火墙黑洞
3. recv() failed (104: Connection reset by peer) → 后端崩/杀连接（OOM常见）
4. upstream sent too big header → 缓冲区
5. no live upstreams → 全部摘除

按报错分流处理，别一律重启。', NULL, '[\"排障\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 3, '如何在 Nginx 层保护后端（防止被打穿）？至少4个手段。', NULL, NULL, '1. limit_req/limit_conn 限流限连
2. 超时收紧（proxy_connect 3s/read 10s）快速失败
3. max_fails 摘除故障后端 + backup 降级页
4. 请求体与头大小限制（client_max_body_size/large_client_header_buffers）
5. 条件封禁（geo/deny 恶意段）
6. 缓存兜底（proxy_cache_use_stale）
网关是保护后端的第一道闸门。', NULL, '[\"高可用\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, 'try_files $uri $uri/ /index.html 的作用？', NULL, '[\"A. 静态优先，回退SPA入口（前端路由）\",\"B. 压缩\",\"C. 限流\",\"D. 反代\"]', 'A。Vue/React history 路由刷新 404 的标准修复。', NULL, '[\"配置\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, 'access_log off 是？', NULL, '[\"A. 该 location 不记访问日志\",\"B. 关错误日志\",\"C. 停nginx\",\"D. 清空日志\"]', 'A。健康检查路径常关日志防刷盘。error_log 不能 off（可 /dev/null）。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'proxy_redirect 什么时候需要？', NULL, '[\"A. 后端 3xx 的 Location 重写（内网地址暴露时）\",\"B. 日常必配\",\"C. 限流\",\"D. 静态\"]', 'A。后端返回 http://10.0.0.1:8080/xxx 需改写为对外域名。', NULL, '[\"配置\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'X-Accel-Redirect 是什么？', NULL, '[\"A. 后端控制网关内网读文件下载（X-Sendfile）\",\"B. 重定向301\",\"C. 加速静态\",\"D. 熔断\"]', 'A。鉴权后让 Nginx 直接发文件，后端不流经文件流。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'deny/allow 生效顺序？', NULL, '[\"A. 顺序匹配第一个命中即止\",\"B. allow优先\",\"C. deny优先\",\"D. 随机\"]', 'A。写反了会全 deny——配完必测。', NULL, '[\"安全\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'nginx -T 的用途？', NULL, '[\"A. 输出展开后的完整配置（含include）\",\"B. 仅测试\",\"C. 重启\",\"D. 版本\"]', 'A。-t 是测试，-T 测试并打印全量——排查"配置到底加载了啥"。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, 'Nginx 配置了 HTTPS 但报 "ssl certificate not found"，检查什么？', NULL, NULL, '1. 证书/私钥路径与属主权限（worker 用户可读，私钥建议 600 root）
2. fullchain 含中间证书
3. listen 443 ssl 语法（老版本需显式 ssl）
4. nginx -T 看最终加载
5. 磁盘/SELinux 拦截读取', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '为什么 nginx -s reload 后旧 worker 还在（存在几分钟）？', NULL, NULL, '正常现象：旧 worker 优雅退出——处理完存量连接才退出。长连接（WebSocket）会一直挂着：可 worker_shutdown_timeout 或让客户端重连。看 worker 代际：ps 里新旧行并存。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 3, '给 Nginx 添加第三方模块（如 brotli）的正确姿势？', NULL, NULL, '需编译进二进制：下载源码 ./configure --add-module=... --with原有参数 && make，替换二进制后热升级（USR2）。apt 版无法动态加（部分模块支持 dynamic module --add-dynamic-module+load_module）。体现对二进制交付物的理解。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, 'Nginx 安装后默认站点目录（Ubuntu）？', NULL, '[\"A. /var/www/html\",\"B. /usr/share/nginx/html\",\"C. /opt/nginx\",\"D. /www\"]', 'A。Ubuntu 系默认；CentOS 系常是 B。改 root 即换站。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 1, '错误日志级别 debug|warn|error 谁最详细？', NULL, '[\"A. debug\",\"B. warn\",\"C. error\",\"D. crit\"]', 'A。debug 最详细（性能损耗，临时排障用）；error_log 级别递增：debug<info<notice<warn<error<crit。', NULL, '[\"日志\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'location 里 root 与 index 的关系？', NULL, '[\"A. index 指定默认尝试文件（拼在root后）\",\"B. 无关\",\"C. index是目录\",\"D. root是文件\"]', 'A。index index.html index.htm; 依次尝试。SPA 场景常再加 try_files。', NULL, '[\"配置\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'Nginx 访问日志 "$request_time 5s" 但后端日志 50ms，问题在？', NULL, '[\"A. 网络传输/客户端慢（后端无辜）\",\"B. 后端慢\",\"C. Nginx bug\",\"D. 一定是DDoS\"]', 'A。两时间字段对比定位法——网关与后端时间轴对齐。', NULL, '[\"排障\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, '同一 server 想对不同来源返回不同缓存时长？', NULL, '[\"A. map $http_user_agent 等 + if/expires 变量化\",\"B. 不支持\",\"C. 只能多server\",\"D. 重写模块才行\"]', 'A。移动端/爬虫差异化策略的思路（if 谨慎用，location 拆分更稳）。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 2, 'proxy_pass 到变量（如 http://$backend）时必须配什么？', NULL, '[\"A. resolver（运行时DNS）\",\"B. 无需\",\"C. upstream必须\",\"D. 不支持变量\"]', 'A。否则报 no resolver defined——K8s 动态服务名场景必踩。', NULL, '[\"配置\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'CHOICE', 3, 'Nginx worker 进程数设为 CPU 核数的 2 倍会更好吗？', NULL, '[\"A. 不会，推荐 auto（=核数）\",\"B. 会更快\",\"C. 必须双倍\",\"D. 无影响\"]', 'A。worker 单线程事件驱动，超核数徒增切换。', NULL, '[\"调优\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, '如何临时给某接口加维护页（10分钟）？', NULL, NULL, '```nginx
location /api/pay/ {
    return 503;
    error_page 503 /maint.html;
}
location = /maint.html { root /var/www/maint; internal; }
```
reload 秒级生效；应急止血不改代码。体现"网关层兜底"意识。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 2, 'Nginx 报 "414 Request-URI Too Large"？', NULL, NULL, '超大 URL（常是误用 GET 传大数据/攻击）。处理：large_client_header_buffers 8 32k 调大；治本是让调用方改 POST body 传参。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(4, 'QA', 3, 'Nginx 层如何做 A/B 测试（按 cookie 分组）？', NULL, NULL, '```nginx
map $cookie_abgroup $pool {
    default main;
    "B"      exp;
}
upstream main { server ...; }
upstream exp { server ...; }
location / { proxy_pass http://$pool; }
```
配后端埋点对比转化率。讲 map+upstream 组合即达标。', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(8, 'CHOICE', 1, 'node_exporter 监控的是？', NULL, '[\"A. 主机层（CPU/内存/磁盘/网络）\",\"B. 应用JVM\",\"C. 数据库\",\"D. K8s对象\"]', 'A。应用用 micrometer、K8s 用 kube-state-metrics/cAdvisor。', NULL, '[\"监控\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '告警模板里带 runbook 链接的意义？', NULL, '[\"A. 值班一键看处置步骤（缩短MTTR）\",\"B. 好看\",\"C. 合规 only\",\"D. 无意义\"]', 'A。无 runbook 的告警等于噪音。', NULL, '[\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 3, '你要在 5 分钟内向 CTO 汇报一次线上故障，讲什么？', NULL, NULL, '模板：
1. 一句话现状：什么服务、什么影响（用户量/资损）、现在还坏吗
2. 时间线：发现→止血（已做/在做）
3. 初判根因方向（不确定就说不确定）
4. 需要的支持（决策/资源）
5. 下一步与预计恢复时间
汇报≠甩锅也≠细节堆砌：**影响+进展+诉求**。', NULL, '[\"素养\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 3, '监控告警"狼来了"之后团队麻痹，怎么系统性治理？', NULL, NULL, '1. 数据盘点：两周告警总量/分类/响应率
2. 分层砍杀：不可行动的删、可合并的聚合（group）、可自动处理的自愈（脚本接管）
3. 阈值重定：基于 SLO 与环比而非拍脑袋
4. 升级机制：长时间无人认领自动升级主管
5. 每月告警质量复盘（信噪比 KPI）
治理是持续过程，不是一次性运动。', NULL, '[\"治理\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'PromQL 中 [5m] 表示？', NULL, '[\"A. 回看5分钟窗口\",\"B. 未来5分钟\",\"C. 每5分钟\",\"D. 延迟5分\"]', 'A。range selector，配合 rate/increase 使用。', NULL, '[\"PromQL\",\"必背\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'Prometheus 的数据抓取模式是？', NULL, '[\"A. Push\",\"B. Pull（主动拉取 /metrics）\",\"C. 双向\",\"D. 混合\"]', 'B。拉模式天然感知目标存活、调试方便（curl /metrics）。短任务例外走 Pushgateway。', NULL, '[\"Prometheus\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'counter 与 gauge 指标类型的区别？', NULL, '[\"A. 一样\",\"B. counter 只增（请求数）；gauge 可升可降（内存、连接数、队列长度）\",\"C. gauge只增\",\"D. counter可清零手动\"]', 'B。counter 配 rate() 看速率；gauge 直接看瞬时值。histogram 算分位数。', NULL, '[\"指标\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'rate(http_requests_total[5m]) 的含义？', NULL, '[\"A. 5分钟总量\",\"B. 以5m窗口每秒平均增速（QPS）\",\"C. 最大值\",\"D. 平均延迟\"]', 'B。counter 必须先 rate/increase。increase(x[1h]) 才是小时增量。', NULL, '[\"PromQL\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '四个黄金指标不含？', NULL, '[\"A. 延迟\",\"B. 流量\",\"C. 错误率\",\"D. 代码行数\"]', 'D。延迟/流量/错误/饱和度。任何服务先配齐这四个。', NULL, '[\"SRE\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'ELK 中 Filebeat 的角色？', NULL, '[\"A. 存储\",\"B. 轻量采集转发（盯文件尾部）\",\"C. 解析\",\"D. 展示\"]', 'B。采集→(可选Logstash解析)→ES存储→Kibana展示。Filebeat 不做重解析。', NULL, '[\"日志\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'Loki 相比 ES 的核心差异？', NULL, '[\"A. 更快全文搜索\",\"B. 只索引标签不索引正文，存储成本低一个量级\",\"C. 不支持查询\",\"D. 只能K8s\"]', 'B。配 LogQL 按标签过滤+正则管道。中小团队降本首选。选型答"查得多存不起就 Loki"。', NULL, '[\"日志\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'P99 延迟指标需要应用暴露什么类型的指标？', NULL, '[\"A. counter\",\"B. gauge\",\"C. histogram（分桶）\",\"D. summary只能\"]', 'C。histogram 分桶可聚合（跨实例）；summary 预计算不能聚合。micrometer 命名 *_seconds_bucket。', NULL, '[\"指标\",\"进阶\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '告警疲劳的治理手段不含？', NULL, '[\"A. 分级路由\",\"B. 静默与抑制\",\"C. 基于症状+持续时长\",\"D. 把阈值调到永不触发\"]', 'D。正确做法是提高信噪比而不是砍掉告警。每条告警必须 actionable。', NULL, '[\"告警\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'Alertmanager 的 inhibition（抑制）用于？', NULL, '[\"A. 禁用告警\",\"B. 故障级联时只发根因告警（机房挂了抑制其上服务告警）\",\"C. 延迟发送\",\"D. 升级\"]', 'B。配套 group_by 聚合去风暴。', NULL, '[\"告警\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'SLI 与 SLO 的关系？', NULL, '[\"A. 相同\",\"B. SLI 是测量指标；SLO 是该指标的目标值（99.9%请求<300ms）\",\"C. SLO是工具\",\"D. SLI是目标\"]', 'B。错误预算=1-SLO，预算耗尽=停止发布优先稳定性。', NULL, '[\"SRE\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'MTTR 是指？', NULL, '[\"A. 平均故障间隔\",\"B. 平均恢复时间（发现→修复）\",\"C. 平均响应\",\"D. 无意义\"]', 'B。MTBF=平均无故障时间。可靠性=提高MTBF、降低MTTR，监控告警本质服务于降 MTTR。', NULL, '[\"SRE\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '饱和度（saturation）最贴切的例子？', NULL, '[\"A. QPS\",\"B. 线程池活跃度/连接池使用率/磁盘使用率\",\"C. 错误率\",\"D. 延迟\"]', 'B。"满的程度"——队列与资源水位。饱和度上涨往往先于延迟恶化，是前瞻指标。', NULL, '[\"SRE\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '日志采样率应该怎么定（trace）？', NULL, '[\"A. 100%最好\",\"B. 按流量权衡：常态1-10%，错误请求100%，可动态调整\",\"C. 0%\",\"D. 固定50%\"]', 'B。全量在促销高峰开销巨大；尾部采样（错误/慢请求必采）是现代实践（OTel tail sampling）。', NULL, '[\"链路\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'traceId 串联的价值？', NULL, '[\"A. 加密\",\"B. 跨服务/日志/指标关联定位问题环节\",\"C. 计费\",\"D. 压缩\"]', 'B。三支柱（metrics/logging/tracing）互通的钥匙：指标报警→trace定位环节→日志看细节。', NULL, '[\"可观测\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '监控分层里"业务指标"的价值？', NULL, '[\"A. 没价值\",\"B. 最先反映用户受损（订单量/支付成功率），且技术指标全正常时也能发现资损\",\"C. 技术更准\",\"D. 仅运营用\"]', 'B。经典案例：全站技术指标正常但下单 0——活动页配置错了。告警从上层触发、下层数据定位。', NULL, '[\"监控\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 3, 'Prometheus 长期存储/扩展的常见方案？', NULL, '[\"A. 无解\",\"B. Thanos / VictoriaMetrics / Cortex（远程写入+降采样）\",\"C. 加内存\",\"D. 重启\"]', 'B。单机 Prometheus 保留15d，长期与全局视图靠这些方案。答出任一+原理（对象存储块/降采样）即加分。', NULL, '[\"Prometheus\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '黑洞监控（告警了没人处理）的正确处置？', NULL, '[\"A. 加大音量\",\"B. 复盘分级：删不可行动的、改阈值/收敛到能行动的、升级处理路径\",\"C. 全体通报批评\",\"D. 忽略\"]', 'B。告警的纪律：每条必须有 owner 与 runbook，否则删除。', NULL, '[\"告警\",\"素养\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '日志级别 WARN 与 ERROR 的使用边界？', NULL, '[\"A. 随意\",\"B. ERROR=需要人介入；WARN=自愈/降级但需关注趋势\",\"C. ERROR更详细\",\"D. 只用INFO\"]', 'B。ERROR 泛滥=狼来了——真故障被淹没。日志规范是团队基本功。', NULL, '[\"日志\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '写 PromQL：过去 5 分钟订单接口错误率（5xx 占比）。', NULL, NULL, '```promql
sum(rate(http_server_requests_seconds_count{uri="/order",status=~"5.."}[5m]))
/
sum(rate(http_server_requests_seconds_count{uri="/order"}[5m]))
```
要点：counter 用 rate、除法算占比、status 正则匹配 5xx。', NULL, '[\"PromQL\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '写 PromQL：实例维度的 P95 接口延迟。', NULL, NULL, '```promql
histogram_quantile(0.95,
  sum(rate(http_server_requests_seconds_bucket[5m])) by (le, instance)
)
```
by(le) 是 histogram_quantile 的必须项；加 instance 维度可找出慢实例。', NULL, '[\"PromQL\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '如何给一个 Spring Boot 服务接入 Prometheus 监控？', NULL, NULL, '1. 依赖：micrometer-registry-prometheus + actuator
2. 暴露：management.endpoints.web.exposure.include=prometheus,health
3. 常用指标自动有：jvm_*, http_server_requests_*, hikari_*
4. 业务指标：MeterRegistry 自定义 Counter/Timer（下单量/支付耗时）
5. Prometheus 抓取任务（k8s sd 自动发现）+ Grafana 面板（社区模板 4701 JVM）
6. 告警规则：错误率/延迟/内存/GC', NULL, '[\"实战\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '设计一个服务的告警规则集（至少6条，含阈值理由）。', NULL, NULL, 'P0（电话）：
1. 可用性：health 探测失败 2 次
2. 错误率 >2% 持续 5m
3. P99 >2s 持续 10m
P1（IM）：
4. QPS 环比跌 50%（流量异常/上游故障）
5. Pod 重启 >2 次/小时（crashloop）
6. 内存 >85% 持续 15m（防OOM前置）
7. 连接池活跃 >90%（饱和前瞻）
每条附 runbook 链接。理由：症状优先+持续防抖+分级路由。', NULL, '[\"告警\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '日志采集方案怎么做才专业？（结构化/多行/脱敏）', NULL, NULL, '1. **结构化输出**：JSON 格式（含 time/level/traceId/userId/cost），别 printf 拼接
2. 多行合并：异常栈按 Filebeat multiline（^s+at 续行）
3. 脱敏：手机号/身份证打码在应用层完成（不指望采集层）
4. 分级落盘：ERROR 单独告警通道
5. 采样与限流：debug 默认关，防止日志风暴打死采集器
6. 保留策略：ERROR 90d、INFO 30d（ILM/对象存储冷归档）', NULL, '[\"日志\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '什么是 USE 方法与 RED 方法？分别用于看什么？', NULL, NULL, '- **USE**（资源）：Utilization 使用率 / Saturation 饱和度 / Errors 错误——看机器、磁盘、网络等**资源**
- **RED**（服务）：Rate 请求量 / Errors 错误 / Duration 时长——看**服务/接口**
面试答法：资源用 USE 逐层扫，服务用 RED 建面板，业务再加转化率。', NULL, '[\"方法论\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 3, '容量规划的标准流程？（数字怎么来）', NULL, NULL, '1. 压测得单实例容量：wrk/jmeter 加压到 P99 逼近 SLO 临界（例：单 Pod 800QPS@P99 300ms）
2. 需求预测：业务峰值 ×1.5 冗余（大促另计）
3. 需要实例数 = 目标QPS / 单机容量，再 +N 容错
4. 弹性：HPA 按指标自动伸缩+定时预扩（活动前）
5. 验证：全链路压测（影子流量/流量回放）
6. 水位看板：当前峰值/容量上限 >70% 告警扩容

有数字框架就赢了大多数人。', NULL, '[\"容量\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '什么叫可观测性（Observability）三支柱，怎么配合排障？', NULL, NULL, 'Metrics（有没有问题）→ Tracing（哪一环）→ Logging（为什么）。
实例：错误率告警 → 拿 traceId 看链路发现 cart 服务到 Redis 段 800ms → Redis slowlog/日志定位大 key。三者靠 traceId 打通；工具上 OTel 统一规范。', NULL, '[\"可观测\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 3, '混沌工程和"故意搞破坏"的区别？工程化要求是什么？', NULL, NULL, '区别：有假设、有稳态指标、有爆炸半径控制、可随时停止。
流程：定义稳态（错误率<0.1%）→ 假设（杀掉一个实例不影响）→ 注入（chaosblade/pumba 杀Pod）→ 验证系统行为 → 复盘改进（自动切换？告警及时？）。
价值：故障演练在可控窗口发现弱点，而非生产被动挨打。答"爆炸半径/稳态假设"是关键。', NULL, '[\"SRE\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, 'oncall 的良好实践（轮值机制）？', NULL, NULL, '1. 明确升级路径（15min未响应升级到 backup/主管）
2. 告警带 runbook（新人也能照做）
3. 事后复盘 blameless（对事不对人）+ action 跟踪
4. 轮值交接文档（当前已知问题/风险）
5. 补偿与减负：非值班周专注开发

考察运维成熟度，能讲 runbook+blameless 即可。', NULL, '[\"SRE\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 3, '如何监控"监控本身"？（元监控）', NULL, NULL, '1. Prometheus 自监控：up{job=...} == 0、抓取失败/超时率、tsdb 写入延迟
2. 告警链路探针：定时发一条测试告警到企业微信确认链路活着
3. 采集覆盖度：目标数对比清单（新服务没接入要能发现）—— CI 里强制打标签
4. Grafana 面板数据新鲜度（query max(time)）
监控挂了没人知道是最恐怖的故障。', NULL, '[\"监控\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'SCENARIO', 2, '凌晨收到"下单接口 P99 5秒"告警，你的完整处理流程？', '值班中，下单核心链路。', NULL, '1. **确认影响面**（2min）：错误率是否也升？业务量是否掉？（决定是止血还是观察）
2. 快速定位大头：Grafana 下钻——哪个服务段慢（trace 链路对比：应用vs DBvs下游）
3. 常见嫌疑逐个看：慢SQL（DB监控）、GC（jvm面板 FullGC？）、依赖超时、流量突增被打
4. **止损优先**：可回滚先回滚（最近有发布？）；可降级（关推荐/异步化）；可扩容（HPA手动）
5. 恢复后：留现场（日志/trace 归档），48h 内出复盘（时间线/根因/改进项）

框架：影响面→定位→止血→复盘。', NULL, '[\"应急\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'SCENARIO', 3, 'Kafka 消费组 lag 告警，但用户反馈"无感知"，怎么平衡响应？', 'lag 500万，持续增长。', NULL, '1. 判断影响：这些消息的时效性（埋点可以慢，支付回调不能）→ 分级
2. 止损：扩消费者（≤分区数）、批量消费提速、跳过过期（时效性场景）
3. 根因：消费逻辑慢 SQL？下游瓶颈？rebalance 风暴？——消费耗时指标定位
4. 告警治理：按业务时效分级阈值（核心 1w 告警、埋点 1h 才说）
5. 长期：容量评估+消费端限流保护下游

"告警分级与业务影响挂钩"是考点。', NULL, '[\"应急\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'SCENARIO', 3, '要给公司从零建监控体系，你的三个月路线图？', NULL, NULL, 'M1 基础：Prometheus+Grafana+Alertmanager 落地，节点+中间件 exporter 全接，四个黄金指标覆盖核心服务
M2 应用与日志：micrometer 接入规范（脚手架默认带）、结构化日志+Loki、告警分级路由到 IM/电话
M3 深化：trace（OTel/SkyWalking）打通三支柱、业务大盘、混沌演练首轮、告警复盘治理（信噪比 KPI）
原则：先覆盖后精细、告警必须 actionable、每个面板有 owner。', NULL, '[\"体系\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'Prometheus exporter 的本质？', NULL, '[\"A. 把现有指标翻译成 /metrics 文本格式的适配器\",\"B. 存储引擎\",\"C. 告警器\",\"D. 面板\"]', 'A。node_exporter=主机、mysqld_exporter=DB。自研暴露 micrometer/官方client。', NULL, '[\"Prometheus\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'Prometheus 的 Service Discovery 用于？', NULL, '[\"A. 自动发现抓取目标（K8s Pod 变化自动纳入）\",\"B. 服务注册\",\"C. 熔断\",\"D. DNS\"]', 'A。kubernetes_sd_configs 按标签选 Pod；新实例上线免手工配置。', NULL, '[\"Prometheus\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'relabel_configs 的用途？', NULL, '[\"A. 抓取前改写标签（只留 __address__、打环境标签）\",\"B. 告警规则\",\"C. 存储\",\"D. 面板\"]', 'A。drop/replace/keep——控制采集面与统一维度（env/cluster）。', NULL, '[\"Prometheus\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'recording rule（预聚合）的价值？', NULL, '[\"A. 高频查询预计算，面板更快且减轻即时计算\",\"B. 告警专用\",\"C. 备份\",\"D. 传输\"]', 'A。如提前算好 instance:p99:rate5m；大盘与高频告警标配。', NULL, '[\"Prometheus\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'avg_over_time / sum(rate()) 的场景区分？', NULL, '[\"A. gauge取窗口均值 / counter先rate再聚合\",\"B. 相同\",\"C. 都用于counter\",\"D. 都用于histogram\"]', 'A。类型决定函数：counter必rate、gauge直接over_time、histogram用quantile。', NULL, '[\"PromQL\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, ' Grafana 变量（Variables）用途？', NULL, '[\"A. 面板维度下钻（$env/$pod 动态过滤）\",\"B. 美化\",\"C. 告警\",\"D. 权限\"]', 'A。配 label_values() 自动列维度值；模板复用一套大盘全环境。', NULL, '[\"Grafana\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '告警规则里 "for: 5m" 的含义？', NULL, '[\"A. 条件需持续5分钟才触发（防毛刺）\",\"B. 每5分钟查一次\",\"C. 延迟5分钟发送\",\"D. 5分钟后恢复\"]', 'A。与 evaluate interval（评估周期）区分。', NULL, '[\"告警\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '日志级别调优：排查期临时开 DEBUG 的风险？', NULL, '[\"A. 日志量暴增拖垮磁盘/采集器\",\"B. 无风险\",\"C. 更安全\",\"D. 影响权限\"]', 'A。开箱要限时（15分钟后回收）+ 采样；最好是错误请求全量 debug 的按需方案。', NULL, '[\"日志\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '结构化日志的最大好处？', NULL, '[\"A. 字段可索引检索/聚合（JSON）\",\"B. 更短\",\"C. 更安全\",\"D. 压缩高\"]', 'A。traceId/userId/cost 等字段直接 group by；正则解析脆弱。', NULL, '[\"日志\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 3, 'Exemplars 是什么？', NULL, '[\"A. 指标关联trace的样本（从面板跳到链路）\",\"B. 采样器\",\"C. 告警样本\",\"D. 备份\"]', 'A。指标→链路的桥，可观测融合趋势。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 3, '高基数（high cardinality）标签的问题？', NULL, '[\"A. 每个值一条时间序列，存储爆炸（如把userId当标签）\",\"B. 查询快\",\"C. 无影响\",\"D. 告警多\"]', 'A。铁律：标签值有限集（env/instance），无界维度（userId/url全量）放日志/trace。', NULL, '[\"Prometheus\",\"必坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 3, 'VictoriaMetrics 相比 Prometheus 的定位？', NULL, '[\"A. 兼容协议的长期存储/更高压缩比与写入性能\",\"B. 替代告警\",\"C. 只读\",\"D. 面板工具\"]', 'A。vmagent+VM 是国内中小团队省资源的常见组合。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '写告警规则：磁盘预计 4 小时内写满（预测告警）。', NULL, NULL, '```promql
predict_linear(node_filesystem_avail_bytes{mountpoint="/data"}[1h], 4*3600) < 0
```
比固定 85% 更提前——水位+速率双保险。说出 predict_linear 即加分。', NULL, '[\"PromQL\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '你的服务要上线，上线前监控准备清单（最少8项）。', NULL, NULL, '1. /metrics 暴露与自动发现接入
2. 四黄金指标面板
3. JVM/连接池/线程池
4. 业务指标（订单量等）
5. 告警规则+分级路由+runbook
6. 日志接采集（结构化+traceId）
7. trace 接入
8. 大盘 owner 标注与巡检演练
"没监控不上线"是底线。', NULL, '[\"素养\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 3, '如何度量监控体系本身的效果？', NULL, NULL, '1. MTTD（平均发现时长）：故障是被监控发现还是用户报障？
2. 告警信噪比：有效告警占比、每告警均动作数
3. 覆盖率：核心服务四指标覆盖比例、日志/trace 接入率
4. 演练结果：注入故障被检测的成功率与耗时
把 SRE 自身也指标化，持续改进。', NULL, '[\"体系\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'Prometheus TSDB 默认保留时长？', NULL, '[\"A. 15天\",\"B. 永久\",\"C. 90天\",\"D. 1天\"]', 'A。长期存储用 Thanos/VM 远程写入方案。', NULL, '[\"Prometheus\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'PromQL 中 offset 的用途？', NULL, '[\"A. 取历史偏移（对比昨天同时段）\",\"B. 延迟告警\",\"C. 采样\",\"D. 聚合\"]', 'A。sum(rate(x[5m] offset 1d)) 环比分析。', NULL, '[\"PromQL\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'Grafana 面板 "No data" 的排查顺序？', NULL, '[\"A. 数据源连通→时间范围→查询标签匹配→采集目标up\",\"B. 刷新\",\"C. 重装\",\"D. 换机器\"]', 'A。up{job=...}==0 是第一嫌疑（采集挂了）。', NULL, '[\"Grafana\",\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '告警恢复通知的作用？', NULL, '[\"A. 通知值班\\"问题解除\\"（闭环认知）\",\"B. 无用\",\"C. 再告一次\",\"D. 升级\"]', 'A。防"恢复了没人知道，其实一直在闪断"的认知割裂。', NULL, '[\"告警\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '日志 ELK 的 ILM 是？', NULL, '[\"A. 索引生命周期管理（热→温→冷→删）\",\"B. 权限\",\"C. 采集器\",\"D. 告警\"]', 'A。控制成本的关键：热SSD 3天/温7天/冷30天/删。', NULL, '[\"日志\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '写 PromQL：当前 QPS 与昨天同时段对比下降超过 30% 告警。', NULL, NULL, '```promql
(sum(rate(http_requests_total[10m])) / sum(rate(http_requests_total[10m] offset 1d))) < 0.7
```
同比环比是流量异常的第一道网（绝对阈值难定）。', NULL, '[\"PromQL\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 3, '为什么指标要打 label，但又要克制？', NULL, NULL, 'label 用于维度聚合（env/instance/api），让一个指标支撑多维分析、告警可下钻。
克制：无界基数（userId、完整URL）会让序列爆炸（内存与查询劣化）。
口径：有限集合→label；高基数明细→日志/trace。这是 Prom 数据建模第一原则。', NULL, '[\"Prometheus\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'Prometheus 的 up 指标？', NULL, '[\"A. 目标抓取健康（1/0）——采集层第一告警\",\"B. CPU\",\"C. 在线用户\",\"D. 版本\"]', 'A。up==0 即目标不可达（服务挂或exporter挂，需区分）。', NULL, '[\"Prometheus\",\"必背\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 1, 'Grafana 大盘导入导出格式？', NULL, '[\"A. JSON\",\"B. YAML\",\"C. SQL\",\"D. 二进制\"]', 'A。社区模板复制 ID 直接 Import（如 1860 node）。', NULL, '[\"Grafana\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, '日志告警（如5分钟ERROR>N）更适合哪个体系？', NULL, '[\"A. Loki Ruler / ES watcher（日志侧）\",\"B. Prometheus（不适合非数值）\",\"C. 都是\",\"D. 手动\"]', 'A。指标报警走Prom、日志报警走日志平台，分工明确。', NULL, '[\"日志\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 2, 'oncall 手机收到 P0 电话后 60 秒内该做什么？', NULL, '[\"A. 确认告警内容与影响面→拉起应急频道→按runbook第一步行动\",\"B. 先睡醒再说\",\"C. 直接重启一切\",\"D. 等第二次告警\"]', 'A。承认收到（值班群回执）也是关键动作。', NULL, '[\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'CHOICE', 3, '监控数据断点（图表缺口）的原因排查？', NULL, '[\"A. 目标重启/网络抖动/采集超时/TSDB写入丢\",\"B. 正常\",\"C. 只有重启\",\"D. 面板问题\"]', 'A。prometheus_target_scrape_pool_targets 与 scrape_duration_seconds 定位；缺样率告警本身要配。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 2, '如何给"第三方依赖服务"（不受控外部接口）做监控？', NULL, NULL, '1. 主动探测：黑盒拨测（Prometheus blackbox_exporter：可用性+延迟+证书）
2. 被动观测：调用方记录失败率/延迟指标，按依赖分组聚合
3. 拨测频率别打爆对方（如30s，走只读接口）
4. 结果驱动降级策略
黑盒+白盒互补是完整答案。', NULL, '[\"监控\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(8, 'QA', 3, '要把 P99 延迟做告警，直方图桶边界怎么设计？', NULL, NULL, '桶要覆盖你关心的阈值两侧：如目标 300ms，桶设 100/200/250/300/500/1000/10000ms。若最细桶只到 500ms，P99 计算会"贴桶"失真。Micrometer service-level 指标可自动出 SLO 桶。桶设计=精度与基数成本平衡。', NULL, '[\"Prometheus\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(9, 'CHOICE', 1, '查看表索引的命令？', NULL, '[\"A. SHOW INDEX FROM t\",\"B. DESC only\",\"C. SHOW TABLES\",\"D. SHOW STATUS\"]', 'A。看 key_name/columns/cardinality（区分度参考）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '读多写少、允许秒级延迟的报表需求，方案？', NULL, '[\"A. 读写分离走从库（专设报表从库）\",\"B. 主库直跑\",\"C. 全量导出txt\",\"D. 停机跑\"]', 'A。隔离重查询，防打爆主库；更大规模再上数仓/ClickHouse。', NULL, '[\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '为什么主从架构下写后立刻读可能读到旧数据？怎么处理？', NULL, NULL, '异步复制延迟所致。方案：1) 关键写后读强制走主库（路由标记）2) 会话内写读绑定（事务内走主）3) 半同步降低概率 4) 前端展示容忍（提交后刷新按钮）。理解"你读的是哪个一致性版本"。', NULL, '[\"架构\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 3, '订单库要停机迁移到新集群（新版本），设计迁移方案。', NULL, NULL, '1. 双写期：新旧双写（旧为准），对账任务校验
2. 存量迁移：分批导入+核对（行数/抽样）
3. 追平延迟：双写持续至延迟≈0
4. 切读：按比例灰度读新库
5. 切写：低峰单向切换（保留快速回切开关）
6. 观察期后下线双写
本质：**可灰度、可对账、可回退**。', NULL, '[\"架构\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, '进入 mysql 客户端的命令？', NULL, '[\"A. mysql -uroot -p -h host\",\"B. mysql connect\",\"C. sql shell\",\"D. db login\"]', 'A。-p 后不写密码（交互输入更安全）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, 'MySQL 默认事务隔离级别？', NULL, '[\"A. 读未提交\",\"B. 读已提交RC\",\"C. 可重复读RR\",\"D. 串行化\"]', 'C。InnoDB RR 靠 MVCC+间隙锁基本解决幻读；互联网公司常改 RC（更少间隙锁、死锁少）。', NULL, '[\"事务\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '主从复制的实现依赖哪种日志？', NULL, '[\"A. redo log\",\"B. binlog\",\"C. undo log\",\"D. slow log\"]', 'B。主库 binlog → 从库 IO线程 → relay log → SQL线程重放。', NULL, '[\"复制\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'EXPLAIN 中 type=ALL 意味着？', NULL, '[\"A. 走索引\",\"B. 全表扫描\",\"C. 最优\",\"D. 主键查询\"]', 'B。全表扫描，OLTP 出现基本要优化。好→差：const>eq_ref>ref>range>index>ALL。', NULL, '[\"优化\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '哪个场景索引会失效？', NULL, '[\"A. WHERE id=1\",\"B. WHERE name LIKE ''abc%''\",\"C. WHERE YEAR(create_time)=2026（函数包列）\",\"D. WHERE a=1 AND b=2（联合索引a,b）\"]', 'C。函数包列、隐式类型转换、左模糊、不满足最左前缀都会失效。', NULL, '[\"索引\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'covering index（覆盖索引）是指？', NULL, '[\"A. 索引很大\",\"B. 查询所需字段都在索引里，无需回表\",\"C. 唯一索引\",\"D. 主键\"]', 'B。Extra 显示 Using index。select 少写字段、联合索引带出查询列是优化利器。', NULL, '[\"索引\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '慢查询日志的开启参数？', NULL, '[\"A. slow_query_log=ON + long_query_time\",\"B. slow=1\",\"C. log=slow\",\"D. query_cache\"]', 'A。分析用 mysqldumpslow / pt-query-digest。', NULL, '[\"慢查询\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '物理备份（热备）工具是？', NULL, '[\"A. mysqldump\",\"B. XtraBackup\",\"C. cp -r\",\"D. rsync\"]', 'B。物理+增量+不锁表；mysqldump 是逻辑备份。大库恢复速度：物理>>逻辑。', NULL, '[\"备份\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '连接数打满（Too many connections）应急第一步？', NULL, '[\"A. 重启DB\",\"B. 用预留管理连接进去看 processlist，KILL 空闲/问题连接\",\"C. 删库\",\"D. 等待\"]', 'B。SET GLOBAL max_connections 临时调大是第二步；根治看连接池配置/泄漏。', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 3, 'binlog 三种格式中最推荐？', NULL, '[\"A. STATEMENT\",\"B. ROW\",\"C. MIXED\",\"D. 无差别\"]', 'B。ROW 记录行变化，主从一致性最稳（函数/uuid 也安全），CDC（canal）依赖它。缺点量大。', NULL, '[\"复制\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 3, 'redo log 与 binlog 的两阶段提交为了解决？', NULL, '[\"A. 性能\",\"B. 两者的一致性（崩溃恢复不丢不错）\",\"C. 锁\",\"D. 复制\"]', 'B。redo prepare → binlog 写入 → commit。崩溃时按两阶段状态决定提交/回滚，保证"binlog 有则必恢复"。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'InnoDB 的 MVCC 依赖？', NULL, '[\"A. 锁\",\"B. undo log 版本链 + ReadView\",\"C. binlog\",\"D. 临时表\"]', 'B。快照读不加锁读旧版本；RR 的 ReadView 在事务首次读生成、RC 每次生成（故RR可重复读）。', NULL, '[\"原理\",\"进阶\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '大表加字段，8.0 的 INSTANT 算法特点？', NULL, '[\"A. 锁全表\",\"B. 只改元数据秒级完成（部分场景）\",\"C. 复制表\",\"D. 不可用\"]', 'B。加列在尾部等场景 INSTANT；加索引用 INPLACE；复杂变更仍需 gh-ost/pt-osc。', NULL, '[\"DDL\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '死锁的处理原则？', NULL, '[\"A. 无法避免\",\"B. InnoDB 自动检测回滚代价小的事务；应用需重试+保持加锁顺序\",\"C. 重启\",\"D. 加大锁\"]', 'B。SHOW ENGINE INNODB STATUS 看 LATEST DETECTED DEADLOCK 定位两条 SQL。', NULL, '[\"锁\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'RPO 与 RTO 分别指？', NULL, '[\"A. 备份大小/速度\",\"B. 能容忍丢多少数据/能容忍停多久\",\"C. 恢复工具\",\"D. 复制延迟\"]', 'B。备份策略由这两个指标倒推：RPO 5min → binlog 实时备份+延迟从库。', NULL, '[\"备份\",\"必背\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '主从延迟的 Seconds_Behind_Master 为 0 就一定没延迟吗？', NULL, '[\"A. 是\",\"B. 不一定（GTID 断点/网络中断时不可靠，pt-heartbeat 更准）\",\"C. 从不显示\",\"D. 无关\"]', 'B。经典坑。校验一致性另有 pt-table-checksum。', NULL, '[\"复制\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'int(11) 的 11 表示？', NULL, '[\"A. 最长11位数字\",\"B. 显示宽度（不影响存储范围）\",\"C. 11字节\",\"D. 索引长度\"]', 'B。存储范围由 int 类型决定。varchar(11) 才是真长度。老知识点但高频。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'Online DDL 期间的 DML？', NULL, '[\"A. 全阻塞\",\"B. INPLACE 算法允许并发DML（短暂元数据锁）\",\"C. 只读\",\"D. 只写\"]', 'B。注意：DDL 开始/结束需要短暂 MDL 排他锁——长事务未提交会卡住 DDL 并**连锁阻塞后续所有查询**（经典事故）。', NULL, '[\"DDL\",\"坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '主从复制的完整原理（三线程两日志）？', NULL, NULL, '主库：事务写 **binlog**，dump 线程推送。
从库：**IO 线程**拉取写入 **relay log**；**SQL 线程**重放。
监控：SHOW REPLICA STATUS\G 盘 IO/SQL 线程 Yes 与延迟。
GTID 模式下 failover 自动找位点，是现代标配。', NULL, '[\"复制\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, 'EXPLAIN 应该看哪几列？分别看什么？', NULL, NULL, '- **type**：访问方式（ALL 全表扫要消灭）
- **key/key_len**：命中索引与使用长度（联合索引用了几列）
- **rows**：预估扫描行数（数量级）
- **Extra**：Using index 覆盖（好）/ filesort、temporary（警惕）
- **possible_keys 有但 key NULL**：为什么没用上（隐式转换？优化器成本？）', NULL, '[\"优化\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '线上误 DELETE 了数据（没 WHERE），恢复思路？', NULL, NULL, '1. 立即停对应应用/只读（防止覆盖与扩大）
2. 有 binlog：`flashback`（binlog2sql/my2sql 生成反向 SQL）或全备+binlog 点位恢复到误删前
3. 延迟从库还在窗口内 → STOP REPLICA 抢救数据
4. 无任何手段： Undrop（innoDB 页级抢救，成功率随写入衰减）
5. 预防：高危 SQL 平台审核、DELETE 必带 WHERE+LIMIT、DBA 双人复核', NULL, '[\"应急\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '备份策略怎么定（以 RPO 1h 为例）？', NULL, NULL, '- 每日 XtraBackup 全备（凌晨低峰）→ 异地/对象存储
- binlog 实时备份（每分钟归档上传）→ 任意时间点恢复
- 每周**恢复演练**（自动化脚本恢复到临时实例+校验行数）——没演练过的备份不算备份
- 保留：全备 30d、binlog 7-30d
- 辅助：延迟从库（30min）应对逻辑误删', NULL, '[\"备份\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '一次慢查询的优化流程？', NULL, NULL, '1. 慢日志定位 SQL（pt-query-digest 聚合 top）
2. EXPLAIN 看计划：全表扫？回表多？filesort？
3. 常规手段：加/改索引（最左前缀、覆盖）、改写 SQL（别函数包列、大分页改游标 where id>）、必要时强制索引 hint
4. 结构手段：冷热分离、读写分离、汇总表/缓存
5. 验证：EXPLAIN 对比 + 线上灰度观察 P99
6. 防复发：慢查询告警+上线 SQL review 卡点', NULL, '[\"优化\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 3, '什么是间隙锁（gap lock）？什么场景踩坑？', NULL, NULL, 'RR 级别下范围条件会锁"间隙"防插入（防幻读）。
踩坑场景：`UPDATE t SET ... WHERE status=1`（无索引）→ 锁全表所有间隙 → 并发插入全堵死；等值未命中锁间隙 → 两个事务互相等 → 死锁。
缓解：列加索引、RC 隔离级别、缩小事务范围。死锁日志 SHOW ENGINE INNODB STATUS 是破案入口。', NULL, '[\"锁\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '连接池配置的运维要点（Druid/HikariCP）？', NULL, NULL, '1. maxActive 总和 < max_connections×0.8（所有应用实例加总！）
2. maxWait 有界（3s）快速失败，别无限等
3. 空闲回收 minIdle~maxIdle + testWhileIdle 保活
4. 泄漏检测：removeAbandoned/druid 的 stat（连接借出超时告警）
5. 监控：active/waiting 趋势图，active 顶格=容量或慢SQL拖住连接', NULL, '[\"调优\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 3, 'MySQL 双一（innodb_flush_log_at_trx_commit / sync_binlog）怎么选？', NULL, NULL, '- 双1（=1/1）：每次提交刷盘，不丢数据，性能最低——金融/核心交易
- 双0/100：攒批刷，性能高，宕机丢秒级数据——日志类可接受
- 折中：trx_commit=2 + sync_binlog=100，配合半同步复制兜底
面试要点：说出"安全与性能的取舍+按业务分级"。', NULL, '[\"调优\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '怎么安全地清退一张大表（drop 大表风险）？', NULL, NULL, '直接 DROP 大表：ibuf purge 与文件删除可能造成瞬时报警（IO打满、buffer pool 抖动）。
安全做法：
1. rename 成 trash_ 表名（应用立即"表不存在"快速失败）
2. 低峰期软链删除或 TRUNCATE 分步（5.7+ 大表 truncate 也有抖动，建议 rename+drop）
3. 主从逐台执行防延迟
4. 提前把表从业务配置摘除', NULL, '[\"运维\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '长事务的危害与治理？', NULL, NULL, '危害：undo 膨胀、MVCC 旧版本堆积（其他查询扫描变慢）、锁持有久、阻塞 DDL（连带阻塞后续查询雪崩）。
治理：
1. information_schema.innodb_trx 监控超过 60s 的事务并告警
2. 应用侧事务内禁外部调用（HTTP/MQ）
3. 大批量改分批 commit
4. kill 长事务脚本+审批流程', NULL, '[\"调优\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'SCENARIO', 2, 'CPU 100% 但 QPS 没涨，DB 层怎么排查？', 'MySQL 服务器。', NULL, '1. `SHOW PROCESSLIST` 看在跑什么（大量 Sending data/Sorting result？）
2. 是否慢SQL扫描行暴涨（新上的烂SQL/统计信息错乱致计划变化）——EXPLAIN 对比
3. 看是否在刷脏页/DDL/大事务 purge（SHOW ENGINE INNODB STATUS）
4. `SHOW GLOBAL STATUS LIKE ''Sort%''/''Created_tmp%''`：临时表/排序溢出
5. 锁等待：data_lock_waits（8.0）
6. 特殊：被扫库攻击（陌生 IP 查询）
定位后：kill 问题查询/回滚变更/加索引。', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'SCENARIO', 3, '从库延迟 30 分钟持续增长，怎么处理与根治？', '大促期间，写流量暴涨。', NULL, '应急：
1. 从库机器规格/IO 检查（是否被打满——和主库同规格吗）
2. 开并行复制（replica_parallel_workers + LOGICAL_CLOCK）
3. 大事务源头治理：应用批量 insert 拆小
4. 读切走或临时全走主库（评估主库压力）
根治：
- 写扩散审计（一条 binlog 改百万行？）
- 分库分表/归档降低单库写量
- 监控：pt-heartbeat 准确延迟+分级告警', NULL, '[\"排障\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'SCENARIO', 3, '发布后 DB CPU 与连接数缓慢爬升直到超限，定位思路？', '发布内容含 SQL 变更。', NULL, '1. 时间线对齐：爬升起点=发布时刻？→ 复盘发布 diff（SQL/索引/参数）
2. processlist 聚合：哪类 SQL 占用连接/耗时
3. 慢日志对比发布前后新增 SQL —— 典型：新查询没走索引 / 连接池参数改动泄漏
4. 止血：kill + 应用回滚（配置类可热改：连接池上限）
5. 复盘卡点：SQL 审核平台为何没拦（执行计划评审进发布单）', NULL, '[\"排障\",\"必考\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'SCENARIO', 2, '磁盘报警：MySQL 数据目录 90%，如何安全处置？', NULL, NULL, '1. 看构成：数据/索引、binlog、临时表、undo、error log
2. **binlog 常是元凶**：PURGE BINARY LOGS BEFORE NOW()-INTERVAL 3 DAY（先确认从库已消费）
3. 大表清单：information_schema.tables 按 data_length 排序——归档/分区的候选
4. 临时盘满：tmpdir 挪到独立盘（大排序/建索引）
5. 应急扩容后必须出根治单（归档策略/容量水位告警70%）
要点：不乱删文件、binlog 清理前确认复制位点。', NULL, '[\"运维\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, 'InnoDB 与 MyISAM 的关键差异？', NULL, '[\"A. 事务/行锁/崩溃恢复：InnoDB 有，MyISAM 无\",\"B. MyISAM更快必用\",\"C. 都支持事务\",\"D. 无差异\"]', 'A。8.0 已移除 MyISAM 系统表。InnoDB 聚簇索引+MVCC。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, '自增主键的好处（InnoDB）？', NULL, '[\"A. 顺序插入不页分裂、主键最短\",\"B. 随机分布均匀\",\"C. 无好处\",\"D. 仅规范\"]', 'A。UUID 做主键→随机写页分裂+索引膨胀（可用有序UUID方案）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, 'varchar(50) 与 char(50)？', NULL, '[\"A. varchar 变长省空间；char 定长补空格\",\"B. 相同\",\"C. char省\",\"D. 都变长\"]', 'A。定长短字段（国家码）char，其余 varchar。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '联合索引 (a,b,c) 对哪些查询有效？', NULL, '[\"A. a / a,b / a,b,c 与最左前缀范围\",\"B. 任意组合\",\"C. 只有a,b,c\",\"D. b,c也全用\"]', 'A。b 或 c 单独查用不上；a 范围后 b,c 失效（范围之后断前缀）。', NULL, '[\"索引\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'EXPLAIN rows=200万 type=ref 说明？', NULL, '[\"A. 走了非唯一索引但预估扫200万行——索引选择性差\",\"B. 很好\",\"C. 全表扫\",\"D. 主键查询\"]', 'A。加/改索引或改写；区分度低的列单列索引价值小（可考虑联合）。', NULL, '[\"优化\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'binlog 的三大用途？', NULL, '[\"A. 复制/时间点恢复/CDC(canal)\",\"B. 仅恢复\",\"C. 审计 only\",\"D. 性能\"]', 'A。ROW 格式是 CDC 生态基础。', NULL, '[\"复制\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '半同步复制（semi-sync）的意义？', NULL, '[\"A. 至少一个从库收到binlog才回客户端（降低丢失）\",\"B. 性能更高\",\"C. 全同步\",\"D. 免运维\"]', 'A。超时可退化为异步（rpl_semi_sync_master_timeout）。', NULL, '[\"复制\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'GTID 复制的最大好处？', NULL, '[\"A. 全局事务号自动定位位点，failover 简单安全\",\"B. 更快\",\"C. 免备份\",\"D. 无需主键\"]', 'A。CHANGE REPLICATION SOURCE ... SOURCE_AUTO_POSITION=1。', NULL, '[\"复制\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'innodb_buffer_pool_size 经验值？', NULL, '[\"A. 专机DB物理内存的60-70%\",\"B. 越大越好100%\",\"C. 固定4G\",\"D. 1G\"]', 'A。留内存给连接/排序/OS页缓存。最重要参数没有之一。', NULL, '[\"调优\",\"必背\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '读已提交(RC)下还有间隙锁吗？', NULL, '[\"A. 基本没有（仅外键/唯一检查等场景）\",\"B. 和RR一样\",\"C. 更多\",\"D. 完全没有锁\"]', 'A。互联网改RC减少锁冲突与死锁的原理。', NULL, '[\"锁\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'information_schema 与 performance_schema 的分工？', NULL, '[\"A. 元数据/运行时性能统计（等待、锁、内存）\",\"B. 相同\",\"C. 都是日志\",\"D. 一个读一个写\"]', 'A。排障常查：processlist、innodb_trx、data_locks、events_waits。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'SELECT ... FOR UPDATE 的作用？', NULL, '[\"A. 悲观行锁（写冲突高时保正确性）\",\"B. 只读锁\",\"C. 加速\",\"D. 提示优化器\"]', 'A。热点行扣减库存类场景；配合事务小粒度防死锁。', NULL, '[\"锁\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 3, 'redo log 写满会发生什么？', NULL, '[\"A. 触发 checkpoint 强制刷脏页，业务写入被压制\",\"B. 自动扩容\",\"C. 数据丢失\",\"D. 无影响\"]', 'A。写陡增+buffer pool 小时易现（log file 大小按业务调）。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 3, 'change buffer / double write 的作用？', NULL, '[\"A. 二级索引写优化 / 防页写断裂（部分写失败损坏）\",\"B. 都加速读\",\"C. 备份机制\",\"D. 无用\"]', 'A。说出 double write 防半页损坏是深度信号。', NULL, '[\"原理\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, 'show processlist 里大量 "Waiting for table metadata lock" 是什么事故？', NULL, NULL, 'DDL 等待未提交事务的 MDL 锁，同时阻塞后续所有该表查询（雪崩）。
处置：1) kill 卡住的 DDL 解除排队 2) 查 information_schema.innodb_trx 找长事务 kill 3) DDL 前先查长事务。
预防：低峰 DDL、pt-osc。', NULL, '[\"排障\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '如何安全清理 binlog？', NULL, NULL, '```sql
PURGE BINARY LOGS BEFORE NOW() - INTERVAL 7 DAY;
```
先确认从库已消费（SHOW REPLICA STATUS 的 Executed_Gtid_Set）；自动策略：binlog_expire_logs_seconds。磁盘告警的第一嫌疑。', NULL, '[\"运维\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 3, '单表 2 亿行需要分库分表吗？先做什么？', NULL, NULL, '先灵魂三问：慢吗（慢SQL治理）、写多大（QPS/单机容量）、业务增长曲线。
多数场景：好索引+读写分离+归档冷数据可支撑到千万级以上。
真到瓶颈：按业务分片（订单按 user_id hash），中间件 ShardingSphere/MyCat，同时接受跨片查询/分布式事务复杂度。
"先优化后拆分"，反问需求是加分项。', NULL, '[\"架构\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, 'datetime 与 timestamp 的选择？', NULL, '[\"A. timestamp 带时区转换且2038上限；datetime 存字面\",\"B. 相同\",\"C. timestamp更大\",\"D. 必用datetime\"]', 'A。国际化/时区敏感用 timestamp（或存UTC）；范围超2038用 datetime。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, 'NULL 的坑：count(col) 与 count(*) ？', NULL, '[\"A. count(col) 不数NULL行；count(*) 全数\",\"B. 相同\",\"C. count(col)更快\",\"D. 都不数NULL\"]', 'A。索引与比较 NULL<>NULL 三值逻辑是 SQL 面试常客。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'update 没 where 全表改了且已提交，第一反应？', NULL, '[\"A. 停应用止血→binlog 生成反向SQL/备份恢复演练\",\"B. 直接改回\",\"C. 没救\",\"D. 重启DB\"]', 'A。binlog2sql/my2sql 生成反向语句；备份+binlog PITR。', NULL, '[\"应急\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'error log 里 "Too many connections" 出现时机？', NULL, '[\"A. 连接数达 max_connections 上限（新连接被拒）\",\"B. 慢SQL\",\"C. 主从断\",\"D. 磁盘\"]', 'A。应急：预留管理连接+KILL；根治看连接池/泄漏。', NULL, '[\"排障\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 3, '分库分表后跨片查询与全局ID怎么解决（答要点）？', NULL, '[\"A. 冗余/宽表/ES二次索引；ID用号段或雪花\",\"B. 无法解决\",\"C. 只能JOIN跨片\",\"D. 随机ID\"]', 'A。架构取舍题：代理或客户端分片（ShardingSphere）+异构索引。', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '如何在线给 5000 万行表加索引（8.0）？', NULL, NULL, '1. 确认无长事务（innodb_trx）防 MDL 卡死
2. ALGORITHM=INLOCK 不存在——用 INPLACE：ALTER TABLE t ADD INDEX idx_x(x), ALGORITHM=INPLACE, LOCK=NONE
3. 低峰执行，观察磁盘空间与主从延迟
4. 更稳：gh-ost 可限速可暂停
5. 完成后 EXPLAIN 验证命中', NULL, '[\"DDL\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 3, '主库磁盘写满，binlog 在数据盘，怎么紧急腾空间？', NULL, NULL, '1. 立即评估：PURGE BINARY LOGS（确认从库位点已消费）保留 1-2 天
2. 临时迁移新 binlog 到其它盘（软链，风险动作，需停写窗口）
3. 治理大事务与 DDL 产生的巨型 binlog
4. 长期：binlog 独立盘/更大盘+expire 策略+水位告警 70%
顺序：先确认位点再 PURGE，别把从库需要的删了。', NULL, '[\"应急\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, 'USE 与 SHOW DATABASES 的权限关系？', NULL, '[\"A. 只能看到有权限的库\",\"B. 全部可见\",\"C. 无关\",\"D. 只看第一个\"]', 'A。"为什么少了一个库"——先查账号权限（SHOW GRANTS）。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 1, 'DESC table 的作用？', NULL, '[\"A. 查看表结构\",\"B. 降序排序\",\"C. 删表\",\"D. 描述引擎\"]', 'A。= SHOW COLUMNS。写SQL前先 DESC 是好习惯。', NULL, '[\"基础\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'EXPLAIN 的 rows 是精确值吗？', NULL, '[\"A. 基于统计信息的估算\",\"B. 精确\",\"C. 上限\",\"D. 无意义\"]', 'A。统计过期会偏差（可 ANALYZE TABLE 校正）。', NULL, '[\"优化\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, '在线 DDL 期间看到 "waiting for metadata lock" 排队，直接后果？', NULL, '[\"A. 后续该表所有查询被阻塞（雪崩）\",\"B. 只DDL等\",\"C. 无影响\",\"D. 从库only\"]', 'A。先 kill DDL 解围，再查长事务。', NULL, '[\"排障\",\"必坑\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 2, 'SHOW STATUS LIKE ''Threads_connected'' 与 max_connections 对比是看？', NULL, '[\"A. 连接水位（容量）\",\"B. 慢查询\",\"C. 复制\",\"D. 锁\"]', 'A。>80% 告警扩容或查泄漏。', NULL, '[\"监控\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'CHOICE', 3, 'XA/分布式事务与本地事务的运维差异？', NULL, '[\"A. XA有悬挂/悬挂恢复问题，排障复杂（xa recover）\",\"B. 无差异\",\"C. XA更快\",\"D. 本地事务更复杂\"]', 'A。能业务幂等+最终一致就别强XA。', NULL, '[\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '为什么 SELECT * 是坏习惯？', NULL, NULL, '1. 破坏覆盖索引（回表+网络放大）
2. 表结构变更（加列）隐式影响依赖方
3. 传输/内存浪费（大字段 text）
4. 语义不明确，review 困难
指定列名是基线素质。', NULL, '[\"规范\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 2, '数据库 CPU 100%，允许你执行三条命令，你怎么用？', NULL, NULL, '1. SHOW PROCESSLIST —— 看在跑什么（抓到耗CPU的SQL）
2. KILL <可疑查询pid> —— 止血
3. SHOW GLOBAL STATUS LIKE ''Threads_running'' —— 确认并发回落
然后保留现场：慢日志+processlist 快照落盘分析根因。体现"先止血后取证"。', NULL, '[\"应急\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(9, 'QA', 3, '如何评估一套 MySQL 参数调优是否真的有效？', NULL, NULL, '1. 基线压测（相同流量回放）前指标：QPS/P99/慢查数
2. 变更一次一项（控制变量）
3. 观察窗口内对比（同负载模型）
4. 看业务指标而非单参数：buffer 命中率提升≠P99 改善
5. 归档记录（变更单+数据）供回溯
没有压测对比的调优是玄学。', NULL, '[\"调优\",\"素养\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES
(10, 'CHOICE', 1, 'Redis set 与 zset 都能去重，什么场景必须 zset？', NULL, '[\"A. 需要按分数排序/范围取（排行榜、延迟队列）\",\"B. 都一样\",\"C. set更快必用\",\"D. zset省内存\"]', 'A。ZRANGE/ZRANGEBYSCORE 是 set 没有的能力。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Redis 主从复制断开重连后走全量还是增量？', NULL, '[\"A. 断太久/offet不可用则全量（PSYNC降级）\",\"B. 永远增量\",\"C. 永远全量\",\"D. 手动选择\"]', 'A。大实例频繁全量同步=复制风暴（网络抖动+diskless调优话题）。', NULL, '[\"Redis\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'Kafka 消息 key 设计的原则？', NULL, NULL, '1. 需要顺序的实体做 key（订单ID）——同 key 同分区有序
2. key 分布要均匀（防数据倾斜热点分区）
3. key 数量级稳定（避免极高基数）
4. 无顺序需求可空 key（轮询打匀）
key 一旦定下变更要评估重分区影响。', NULL, '[\"Kafka\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 3, '缓存与 DB 双写一致性：为什么"先删缓存再更新库"也有问题？', NULL, NULL, '删后、库更新前，并发读把**旧值**又填回缓存（脏数据长存）。
所以主流是"先更新库再删缓存"（不一致窗口极小）+ 过期兜底；强一致要求加 binlog 订阅删除（canal）或分布式锁串行化。能讲出并发时序图即优秀。', NULL, '[\"缓存\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 3, 'Redis Cluster 执行 mget 跨槽报错，除了 hash tag 还有方案？', NULL, NULL, '1. 客户端按 slot 分组并行请求再合并（主流 SDK 内置，如 lettuce/redisson）
2. 业务侧并行单 get（CompletableFuture）
3. 数据建模避免大 mget（按业务聚合为 hash）
hash tag 适合强关联 key；无关联的批量读用客户端分组。', NULL, '[\"Redis\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 3, 'MQ 消费端想"暂停一小时消费"（下游故障），怎么做最稳？', NULL, NULL, '1. 消费组暂停（Kafka pause()/RocketMQ 挂起消费者）——消息留在 broker
2. 不要直接 kill 消费者（可能触发重平衡乱象）
3. 恢复前评估 lag 与下游承受力，逐步放量
4. 若 broker 也扛不住堆积：转储 topic
配合 lag 告警窗口放大，防恢复瞬间打爆下游。', NULL, '[\"MQ\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'redis-cli --stat 的用途？', NULL, NULL, '滚动显示 keys/mem/hits/misses 概览——快速观察实例健康趋势（比反复 INFO 顺手）。配 --bigkeys 巡检更佳。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'Redis 为什么快（两个核心理由）？', NULL, '[\"A. 多线程+磁盘\",\"B. 内存+单线程无锁+IO多路复用epoll\",\"C. CPU高\",\"D. 压缩算法\"]', 'B。纯内存操作、单线程消除锁与上下文切换、epoll 处理海量连接。6.0 的多线程仅用于网络IO，命令仍单线程。', NULL, '[\"Redis\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'RDB 与 AOF 的取舍？', NULL, '[\"A. 二选一\",\"B. RDB恢复快丢分钟级；AOF丢1秒内文件大；生产用混合持久化\",\"C. 都不用\",\"D. AOF更快\"]', 'B。混合（4.0+）：aof-use-rdb-preamble yes，重写时 RDB 头+增量 AOF。', NULL, '[\"Redis\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, '缓存击穿的定义？', NULL, '[\"A. 查不存在的key\",\"B. 热点key过期瞬间大量请求打到DB\",\"C. 大批key同时失效\",\"D. Redis挂了\"]', 'B。对策：热点不过期/逻辑过期、互斥锁重建。穿透=不存在（布隆/空值）；雪崩=大面积失效或宕机。', NULL, '[\"缓存\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Redis 默认内存淘汰策略？', NULL, '[\"A. allkeys-lru\",\"B. noeviction（写报错）\",\"C. volatile-ttl\",\"D. allkeys-lfu\"]', 'B。默认不淘汰，内存满写报错——缓存场景应改 allkeys-lru/lfu。', NULL, '[\"Redis\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Redis Cluster 的分片单位是？', NULL, '[\"A. 节点\",\"B. 16384 个 hash slot\",\"C. key\",\"D. 库\"]', 'B。CRC16(key)%16384。扩缩容=迁移 slot。跨 slot 的 mget 会报错（hash tag {} 绑定同slot）。', NULL, '[\"Redis\",\"进阶\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, '正确释放分布式锁的姿势？', NULL, '[\"A. DEL key\",\"B. Lua：value是自己才DEL + 看门狗续期\",\"C. EXPIRE\",\"D. UNWATCH\"]', 'B。SET NX EX + 唯一value + Lua 原子判断删除 + Redisson watchdog。直接 DEL 可能删掉别人的锁。', NULL, '[\"Redis\",\"高频\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'Redis 生成全局 ID 的常用命令？', NULL, '[\"A. INCR/INCRBY\",\"B. SET\",\"C. APPEND\",\"D. HSET\"]', 'A。原子自增。进阶：分片号+时间戳+序列组合防溢出。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'bigkey 的标准处置？', NULL, '[\"A. 无所谓\",\"B. 拆分（hash分桶）+异步删除UNLINK + 扫描用SCAN\",\"C. 删库\",\"D. 加内存\"]', 'B。大key阻塞主线程（DEL 也阻塞）；SCAN 代 KEYS；MEMORY USAGE 量化。', NULL, '[\"Redis\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, '主从+哨兵的自动故障转移由谁决策？', NULL, '[\"A. 主库\",\"B. 哨兵多数派（quorum）选leader执行切换\",\"C. 客户端\",\"D. 人工\"]', 'B。主观下线→客观下线（quorum）→哨兵leader 选新主（优先级/偏移量）→通知客户端。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Kafka 一个 consumer group 内消费者数与分区数的关系？', NULL, '[\"A. 无关\",\"B. 消费者>分区数则多余者空闲\",\"C. 分区多了浪费\",\"D. 必须相等\"]', 'B。扩消费者上限=分区数；想再扩先扩分区。', NULL, '[\"Kafka\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, '消息不丢的"三段"是？', NULL, '[\"A. 生产/存储/消费 各自保证\",\"B. 只需消费ack\",\"C. 只需刷盘\",\"D. Kafka天然不丢\"]', 'A。生产 acks=all 重试；存储多副本 min.insync.replicas≥2；消费手动提交位移+处理成功后提交。', NULL, '[\"MQ\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, '消息重复消费的根治？', NULL, '[\"A. 关闭重试\",\"B. 消费端幂等（唯一键/状态机/去重表）\",\"C. 换MQ\",\"D. 加机器\"]', 'B。分布式重试必有重复，幂等是标配：UPDATE ... WHERE status=UNPAID。', NULL, '[\"MQ\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Kafka 的 ISR 指？', NULL, '[\"A. 消费组\",\"B. 与leader保持同步的副本集合\",\"C. 索引\",\"D. 保留策略\"]', 'B。acks=all 等 ISR 全部确认；ISR 收缩到1时兼顾性降级（min.insync.replicas 保护）。', NULL, '[\"Kafka\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'RocketMQ 事务消息解决什么？', NULL, '[\"A. 性能\",\"B. 本地事务与发消息的原子性（半消息+回查）\",\"C. 顺序\",\"D. 去重\"]', 'B。先发半消息→执行本地事务→commit/rollback，broker 回查兜底。本质是最终一致。', NULL, '[\"RocketMQ\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, '全局顺序消息的代价？', NULL, '[\"A. 无\",\"B. 单分区（牺牲吞吐）；分区数=1\",\"C. 更快\",\"D. 自动\"]', 'B。局部顺序：同 key 同分区（订单ID做key），生产消费均保序。', NULL, '[\"MQ\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, '延迟消息的典型实现？', NULL, '[\"A. 不可能\",\"B. RocketMQ 延迟等级/时间轮；Kafka 无原生需重试topic+时间戳\",\"C. sleep\",\"D. 数据库轮询唯一方案\"]', 'B。Redis zset 扫描也可做轻量延迟队列。订单超时关闭场景必问。', NULL, '[\"MQ\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 3, 'Redis 脑裂的防护参数？', NULL, '[\"A. 无\",\"B. min-replicas-to-write + min-replicas-max-lag（从库不足时拒写）\",\"C. maxmemory\",\"D. appendonly\"]', 'B。旧主被隔离时因不满足"有足够健康从库"而拒绝写入，减少切换后数据丢失。', NULL, '[\"Redis\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'Redis 缓存与数据库一致性方案（面经高频）？', NULL, NULL, '主流：**Cache Aside**——读：先缓存后库回填；写：**先更新DB再删缓存**。
- 为什么删不是更缓存：并发写易覆盖成脏数据
- 为什么先DB：DB失败缓存不脏；极端不一致由过期时间兜底
- 延迟双删/订阅binlog（canal）异步删：进一步缩小窗口
- 强一致不现实，业务接受最终一致+短过期。', NULL, '[\"缓存\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, '如何给热点 key 探测与分压？', NULL, NULL, '探测：redis-cli --hotkeys（lfu）、proxy/客户端埋点统计、监控单 key QPS。
分压：
1. 本地缓存多级（Caffeine 1s~10s 兜底）
2. key 打散：key_N 副本随机读，写时全部更新
3. 读写分离（从库扛读）
4. 极端：单独实例隔离热点（隔离故障半径）', NULL, '[\"Redis\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'Redis 的过期删除与内存淘汰机制区别？', NULL, NULL, '- **过期删除**：对设了 TTL 的 key——惰性（访问时查）+定期抽样（每100ms扫一批），主线程执行所以大量同刻过期会抖动（TTL 加随机）
- **内存淘汰**：内存达 maxmemory 的全局策略（noeviction/lru/lfu/random×2、volatile 前缀4种）
一个管"到期数据"，一个管"地方不够"。', NULL, '[\"Redis\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'Kafka 为什么快（4点架构层面）？', NULL, NULL, '1. 顺序写磁盘（append log，GB/s级）
2. 页缓存利用（读写都走 page cache）
3. 零拷贝 sendfile（数据不进用户态）
4. 批量+压缩（producer 攒批，网络与存储都摊薄）
外加分区水平扩展。答出零拷贝与顺序写是亮点。', NULL, '[\"Kafka\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, '消费堆积的标准处理 SOP？', NULL, NULL, '1. 定位：消费耗时×QPS vs 生产速率；消费者存活数、rebalance 日志
2. 短期：扩消费者（≤分区）、批量拉取（max.poll.records/fetch）、降级跳过过期消息（时效场景）
3. 中期：消费逻辑异步化（收到即落库/丢线程池，注意位移语义）、慢外部依赖治理
4. 爆仓：新 topic 转储离线消
5. 预防：lag 分级告警+容量评审', NULL, '[\"MQ\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, '如何设计订单超时未支付自动取消？', NULL, NULL, '方案对比：
1. **延迟消息**（RocketMQ 定时/Kafka 无原生）：到期触发，解耦，首选
2. Redis zset 时间戳扫描：轻量但需自研扫描器与重试语义
3. DB 定时扫描（分页+索引）：兜底/低量
4. 时间轮（Netty）：海量高精度
生产常"延迟消息主+定时任务兜底（对账）"双保险，幂等由状态机保证。', NULL, '[\"架构\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 3, 'Redis 6.0 多线程与前述"单线程"矛盾吗？', NULL, NULL, '不矛盾：命令执行仍单线程（保证原子性与无锁），多线程只做**网络IO读写与协议解析**（瓶颈转移后的优化）。类比 Nginx worker 模型。答这题=真正理解瓶颈分析演进。', NULL, '[\"Redis\",\"进阶\"]', 2, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, '用 Redis 怎么实现一个简单限流器？', NULL, NULL, '固定窗口：INCR key + EXPIRE 1s（临界突刺）。
滑动窗口（Lua 原子）：ZADD 时间戳 ZREMRANGEBYSCORE 清理 ZCARD 计数 >N 拒绝。
令牌桶：Lua 按速率补令牌。生产建议现成方案（redisson/gateway 限流），但手写原理是面试常客。', NULL, '[\"Redis\",\"实战\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'MQ 的死信队列（DLQ）设计要点？', NULL, NULL, '1. 触发：重试N次失败/过期/拒绝（requeue=false）进 DLQ
2. 消费与隔离监控：DLQ 告警必须独立且高优（消息积压=业务受损）
3. 修复闭环：DLQ 支持一键重放（修 bug 后回放）、坏消息标死（不无限循环）
4. 保留与审计：DLQ 消息带原 topic/traceId/错误栈', NULL, '[\"MQ\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'Redis 集群模式下的批量操作限制与绕过？', NULL, NULL, 'mget/mset 跨 slot 报错 CROSSSLOT。绕过：
1. hash tag：key 里 {orderId} 前缀使相关 key 同 slot
2. 客户端按 slot 分组分别请求再合并（SDK 已内置，如 jedis cluster mget）
3. 业务侧并行单 key 请求

答 hash tag 原理是关键。', NULL, '[\"Redis\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 3, 'canal/Debezium 监听 binlog 做缓存刷新/搜索索引的架构要点？', NULL, NULL, '1. 伪装从库拉 binlog（ROW 格式）解析变更事件
2. 下游投递 MQ（削峰+解耦），消费者按表路由：删缓存/重建 ES 文档/发事件
3. 关键：**顺序性**（同主键变更有序：按key hash 到分区）、幂等（版本/时间戳）
4. 延迟监控（binlog 位点滞后告警）
5. 全量初始化任务配套（首次建索引）', NULL, '[\"架构\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'SCENARIO', 2, '促销开始 Redis 响应陡增到 200ms+，定位顺序？', 'Redis 集群 + 本地无缓存。', NULL, '1. `redis-cli --latency` 与 slowlog（SLOWLOG GET）——慢命令？keys*/smembers 大key？
2. CPU：单线程打满？（拆分热点/读写分离）
3. bigkey 操作（hgetall 百万元素）→ 拆分或改 hscan
4. 网络带宽（跨机房？流量不对称）
5. 客户端侧：连接池耗尽排队（看池监控而非 Redis 本身）
6. 止血：热 key 本地缓存+从库分流

先分清"Redis真慢"还是"客户端排队"。', NULL, '[\"排障\",\"高频\"]', 4, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'SCENARIO', 3, 'MQ 积压 8000 万，消息 24h 过期，怎么处理？', 'Kafka，消费逻辑含慢外部接口。', NULL, '1. 先保高优：按 topic/业务分级，核心消息优先扩容消费
2. 提速三板斧：扩消费者（≤分区，不够先加分区）、消费改批量、外部调用异步化+超时收紧
3. **追不上的分流**：新建大分区 topic，用轻量转发程序"原 topic→新 topic"快速搬运，消费集群盯新 topic（绕开原分区数限制）
4. 过期丢失评估：时效性消息放弃（记录量级做资损评估）
5. 事后：消费耗时监控+容量预案', NULL, '[\"MQ\",\"必考\"]', 5, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'SCENARIO', 2, 'Redis 主从切换后应用大量报错 READONLY，怎么回事？', NULL, NULL, '原因：客户端仍连着旧主（已降级为从，只读）。
排查：哨兵事件是否送达（客户端订阅 switch-master 了吗）、哨兵 quorum 与网络分区、客户端连接池未刷新。
修复：客户端支持哨兵拓扑自动更新（spring.data.redis.sentinel 配置而非直连 IP）、重连。
预防：脑裂参数 min-replicas-to-write；演练主从切换。', NULL, '[\"排障\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'Redis 单实例建议最大内存量级？', NULL, '[\"A. ~10GB 级（过大导致持久化/复制/恢复慢）\",\"B. 越大越好\",\"C. 1TB\",\"D. 无限制\"]', 'A。超过就分片 Cluster 或业务拆分。fork 延迟与 RDB 恢复时间随内存涨。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'SCAN 与 KEYS 的区别？', NULL, '[\"A. SCAN 分批游标遍历不阻塞；KEYS 一次性阻塞主线程\",\"B. SCAN更快更全\",\"C. 相同\",\"D. KEYS安全\"]', 'A。生产禁 KEYS *；SCAN COUNT 100 配循环。删大 key 用 UNLINK。', NULL, '[\"Redis\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'Redis 的 hash tag 语法是？', NULL, '[\"A. {user1000}.order 与 {user1000}.profile 同slot\",\"B. #key\",\"C. key:tag\",\"D. @key\"]', 'A。Cluster 下多 key 操作（事务/mget）要求同 slot。', NULL, '[\"Redis\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'pipeline 与 mget 的区别？', NULL, '[\"A. pipeline 批量发送省RTT；mget单命令取多key\",\"B. 相同\",\"C. mget更快必用\",\"D. pipeline原子\"]', 'A。pipeline 非原子（每条独立执行）；事务原子但会阻塞更久。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Redis 事务（MULTI/EXEC）的局限？', NULL, '[\"A. 不支持回滚、排队期命令出错不撤销\",\"B. 原子完美\",\"C. 只读\",\"D. 不能批量\"]', 'A。复杂原子逻辑用 Lua；Lua 执行期间阻塞，别写慢脚本。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'redis-cli --pipe 与 -c 参数？', NULL, '[\"A. 大量导入模式 / Cluster 重定向跟随\",\"B. 压缩/加密\",\"C. 相同\",\"D. 只读\"]', 'A。迁移导入数据与集群客户端模式的标准姿势。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'AOF 重写（rewrite）时机与风险？', NULL, '[\"A. 体积达比例触发fork子进程重写；期间写入缓冲，内存/CPU尖峰\",\"B. 定时无风险\",\"C. 手动only\",\"D. 会丢数据必然\"]', 'A。大实例重写抖动排查点；auto-aof-rewrite-percentage 配置。', NULL, '[\"Redis\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'RDB 的 bgsave 与 save？', NULL, '[\"A. bgsave fork子进程不阻塞；save 阻塞主线程（禁产用）\",\"B. 相同\",\"C. save更安全\",\"D. bgsave丢库\"]', 'A。fork 瞬间阻塞与 copy-on-write 内存翻倍风险（maxmemory 别顶格）。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Kafka 的 __consumer_offsets 主题存？', NULL, '[\"A. 消费组位移（重平衡/回溯的依据）\",\"B. 数据副本\",\"C. 配置\",\"D. 死信\"]', 'A。重置位移操作（--to-offset/ earliest）改的就是它。', NULL, '[\"Kafka\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'RocketMQ 与 Kafka 的核心差异点？', NULL, '[\"A. RocketMQ 低延迟/事务/延迟消息/推拉兼顾；Kafka 高吞吐流式/生态\",\"B. 完全相同\",\"C. Kafka功能多\",\"D. 均无顺序\"]', 'A。国内电商常双用：Kafka 日志流 + RocketMQ 业务。', NULL, '[\"MQ\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, '消息顺序性被破坏的常见原因？', NULL, '[\"A. 多分区+多线程乱序消费/重试乱序\",\"B. MQ必然乱序\",\"C. 网络延迟\",\"D. 压缩\"]', 'A。保证：同 key 同分区 + 单线程/内存队列按 key 串行。', NULL, '[\"MQ\",\"高频\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Kafka producer 的 acks=1 与 acks=all？', NULL, '[\"A. leader确认 / ISR全部确认（all更可靠更慢）\",\"B. 1条消息/all消息\",\"C. 相同\",\"D. 数字无义\"]', 'A。配合 min.insync.replicas 与 retries 构成可靠生产。', NULL, '[\"Kafka\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 3, 'rebalance 风暴的诱因与治理？', NULL, '[\"A. 消费者频繁掉线（GC/超时）触发重分配：调 session/心跳/处理时长与 max.poll\",\"B. 分区太多 only\",\"C. 无解\",\"D. 加机器必然\"]', 'A。max.poll.interval.ms 小于最慢处理时间是经典雷。', NULL, '[\"Kafka\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 3, 'Redis 过期 key 的删除时机带来的坑？', NULL, '[\"A. 惰性+定期：到期不立即删，内存可能滞留；大量同刻过期卡顿\",\"B. 精准删除\",\"C. 全立即删\",\"D. 从不删除\"]', 'A。TTL 加随机抖动；监控 expired_keys 与内存曲线。', NULL, '[\"Redis\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, '如何用 Redis 统计"今日在线用户数"？', NULL, NULL, '```redis
SADD online:20261025 uid1 uid2
SCARD online:20261025
```
亿级用 bitmap（SETBIT uid位）+ BITCOUNT，内存降两个量级；再大 HyperLogLog（误差0.81%）。按数据结构选型作答是亮点。', NULL, '[\"Redis\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'Redis 缓存预热怎么做？', NULL, NULL, '1. 上线/重启前脚本加载热点数据（从DB批量读入）
2. 大促前全量预热+核对 key 数
3. 分批加载（SCAN 源数据）避免瞬间打爆 DB
4. 预热完成再放量（网关开关）
防止冷启动缓存击穿是活动保障 checklist 必备项。', NULL, '[\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 3, '设计一个"削峰"方案：秒杀 10万 QPS 下单，DB 只能承 2千。', NULL, NULL, '1. 前置：CDN/静态化、按钮置灰防重
2. 网关：限流（令牌桶 2万）+ 黑产风控
3. Redis 预扣库存（Lua 原子判断+扣减）+ MQ 异步落单
4. 消费端按 DB 能力匀速消费（2千/s）+ 幂等
5. 兜底：库存不足快速失败、排队页体验
核心思想：漏斗逐级衰减，最终写入速率与下游能力匹配。', NULL, '[\"架构\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'Redis GET 返回 nil 与空串 "" 的区别？', NULL, '[\"A. nil=不存在；\\"\\"=存在且值为空（EXISTS 可证）\",\"B. 相同\",\"C. nil报错\",\"D. 空串不存在\"]', 'A。缓存判空要区分（空串可作"已确认不存在"的占位——缓存空值方案）。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'DBSIZE 与 KEYS * 的安全差异？', NULL, '[\"A. DBSIZE O(1) 计数；KEYS 遍历阻塞\",\"B. 相同\",\"C. DBSIZE慢\",\"D. KEYS安全\"]', 'A。监控采集用 DBSIZE/INFO。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Redis INFO 里 instantaneous_ops_per_sec 是？', NULL, '[\"A. 每秒命令数（吞吐）\",\"B. 内存\",\"C. 连接数\",\"D. 延迟\"]', 'A。配 connected_clients、used_memory、blocked_clients 组成基础面板。', NULL, '[\"Redis\",\"监控\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Kafka 分区 Leader 与 Follower 的读写？', NULL, '[\"A. 只有 Leader 读写（客户端元数据找Leader）；Follower 仅同步\",\"B. 都可读\",\"C. 都可写\",\"D. 随机\"]', 'A。Follower 提供 HA 与读扩展（fetch follower 可配但少见）。', NULL, '[\"Kafka\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Kafka retention.ms 与 retention.bytes？', NULL, '[\"A. 按时间或按大小保留（先到为准）\",\"B. 且关系\",\"C. 只时间\",\"D. 无限存\"]', 'A。磁盘治理参数；重放需足够窗口。', NULL, '[\"Kafka\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'Redis 内存涨到 maxmemory 后应用写报错，缓存场景怎么办？', NULL, NULL, '1. maxmemory-policy 从 noeviction 改 allkeys-lru/lfu（CONFIG SET 立即生效）
2. 治理 bigkey（真实占用大户）：MEMORY USAGE 扫描
3. 评估容量：正常水位应 <80% maxmemory（fork/重写需要余量）
4. 需要更多容量→扩实例/Cluster 分片', NULL, '[\"Redis\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, '如何优雅迁移 Redis 实例（不停服）？', NULL, NULL, '1. 新实例搭好，作为旧实例从库全量同步（SYNC）追平
2. 校验数据量/抽样 key
3. 低峰切换：应用配置中心改地址（热配置）或 proxy 层切
4. 双写观察期（可选）+旧实例保留 24h 回退窗口
5. QPS 迁移监控两边对比
与 MySQL 主从切换同思想：先同构追平再切流。', NULL, '[\"Redis\",\"架构\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 3, '订单系统消息乱序导致状态机异常（支付先于扣库存到达），怎么设计？', NULL, NULL, '1. 同订单同 key 同分区（Kafka）保证物理有序
2. 消费端按订单ID串行（内存队列 hash 到单线程）
3. 状态机 + 版本号：旧消息（version小）直接丢弃
4. 兜底：定时对账修复状态
"传输有序 + 消费有序 + 业务幂等"三层防线。', NULL, '[\"MQ\",\"架构\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'redis-cli 进入交互后 -n 2 是？', NULL, '[\"A. 切换到 2 号数据库（单机逻辑库）\",\"B. 2倍速\",\"C. 集群模式\",\"D. 两个连接\"]', 'A。Cluster 不支持多 db（只有0）。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 1, 'EXPIRE 与 PERSIST？', NULL, '[\"A. 设过期 / 去掉过期（永生）\",\"B. 相反定时\",\"C. 都是删除\",\"D. 权限命令\"]', 'A。TTL 查剩余秒；-1永生 -2不存在。', NULL, '[\"Redis\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Redis 的 keyspace hits/misses 用在哪？', NULL, '[\"A. 命中率（缓存效果）监控\",\"B. 容量\",\"C. 延迟\",\"D. 连接\"]', 'A。命中率突降=穿透/Key被清空的重要信号。', NULL, '[\"Redis\",\"监控\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'Kafka 的 __consumer_group 重平衡期间消费者？', NULL, '[\"A. 暂停消费（rebalance 期间整组不可用）\",\"B. 更快\",\"C. 不影响\",\"D. 只影响写\"]', 'A。频繁重平衡=消费暂停抖动，监控 rebalance 次数。', NULL, '[\"Kafka\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'CHOICE', 2, 'RocketMQ 的 Tag 过滤发生在？', NULL, '[\"A. Broker 侧（减少网络传输）\",\"B. 消费者全量拉取后过滤\",\"C. 生产者\",\"D. 不支持\"]', 'A。但消费者仍按队列拉取——同队列不同Tag混布时仍有浪费（可独立Topic/消息分组优化）。', NULL, '[\"RocketMQ\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, '如何用 Redis 实现分布式环境下的"每日限额"（每用户每天100次）？', NULL, NULL, '```redis
INCR user:1000:cnt:20261025
# 首次（返回1）时设置过期：EXPIRE key 86400
```
Lua 把两步原子化。判断 >100 拒绝。按天 key 天然隔离，过期自清理。', NULL, '[\"Redis\",\"实战\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 2, 'Redis 集群某个 slot 迁移中节点宕机，怎么办？', NULL, NULL, '1. cluster-fail-state 看迁移状态；目标节点补迁（migrating/importing 记录在槽位）
2. 工具：redis-cli --cluster fix 自动修复槽位分配
3. 严重时（数据丢失风险）：以从库/备份恢复后重新分配
运维纪律：迁移分批+低峰+每批验证，避免大范围同时迁移。', NULL, '[\"Redis\",\"进阶\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置'),
(10, 'QA', 3, 'MQ 选型（Kafka/RocketMQ/RabbitMQ）你怎么给建议？', NULL, NULL, '按需求匹配：
- 日志/流处理/高吞吐：Kafka（生态 flink 等）
- 业务消息/事务/延迟/顺序丰富语义：RocketMQ
- 复杂路由/低延迟小流量/多协议：RabbitMQ
共同追问：团队运维经验与已有生态往往比纸面参数更决定成败。答出"结合团队现状"即成熟。', NULL, '[\"架构\",\"必考\"]', 3, '[\"junior-ops\",\"devops\",\"sre\"]', '内置');

INSERT INTO kb_article (topic_id, title, content_md) VALUES
(1, '文件权限数字速查与常用组合', '# 权限速查

r=4 w=2 x=1，三组 ugo。

| 数字 | 权限 | 场景 |
|---|---|---|
| 755 | rwxr-xr-x | 目录、脚本 |
| 644 | rw-r--r-- | 普通文件 |
| 600 | rw------- | 私密（密钥、.bash_history）|
| 700 | rwx------ | 私有目录（~/.ssh）|
| 1777 | +sticky | /tmp |
| 2775 | +SGID | 团队共享目录 |

**目录的 x** 是"进门权"：没 x 有 r 也 cd 不进去。
**删文件的权限**看目录 w+x，与文件本身权限无关。'),
(1, '进程状态与信号速查', '# 进程与信号

状态：R 运行 / S 可中断睡眠 / D 不可中断(IO) / T 停止 / Z 僵尸。D 大量出现查 IO；Z 杀父进程。

| 信号 | 编号 | 用途 |
|---|---|---|
| SIGTERM | 15 | 优雅退出（默认 kill）|
| SIGKILL | 9 | 强杀（不可捕获）|
| SIGHUP | 1 | 重读配置（nginx reload）|
| SIGUSR1 | 10 | nginx 重开日志 |

退出码：137=128+9 被 KILL/OOM；139=段错误；1=一般错误。'),
(1, '用户与组管理命令清单', '# 用户管理

```bash
useradd -m -s /bin/bash name    # 建用户
useradd -r -s /sbin/nologin svc  # 服务账号
usermod -aG docker app           # 追加组（-a 必须！）
passwd name / chpasswd           # 设密 nid name / getent passwd name
su - user -c "cmd"                # 模拟登录执行
```

文件：/etc/passwd（账号）、/etc/shadow（密码）、/etc/group（组）。
sudo 授权：/etc/sudoers.d/xxx（440），格式 `user ALL=(root) NOPASSWD: /path/cmd`。'),
(1, '磁盘三剑客：df / du / lsblk', '# 磁盘排查

```bash
df -h          # 分区使用率（-i 看 inode）
du -sh /path   # 目录大小（--max-depth=1 逐层）
lsblk          # 块设备与挂载树
```

经典组合：`du -sh /* 2>/dev/null | sort -rh | head` 逐层下钻。

**df 与 du 差异大** = 删除文件仍被进程持有 → `lsof +L1` 定位，`> /proc/PID/fd/N` 清空。
**df -i 满而 df -h 空** = 海量小文件耗尽 inode。'),
(1, 'systemd 服务单元模板', '# 自定义服务模板

```ini
[Unit]
Description=My App
After=network.target

[Service]
User=app
WorkingDirectory=/opt/app
ExecStart=/usr/bin/java -jar app.jar
Restart=on-failure
RestartSec=5
MemoryMax=512M
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

```bash
systemctl daemon-reload && systemctl enable --now myapp
journalctl -u myapp -f --since "10 min ago"
```'),
(1, 'lsof 使用场景速查', '# lsof 速查

```bash
lsof -i :8080            # 谁占用端口
lsof -p 1234             # 进程打开的文件
lsof +L1                # 已删除但仍被持有（空间不释放）
lsof /var/log/x.log      # 谁在写这个文件
lsof -u app              # 用户打开的文件
lsof -i tcp -sTCP:LISTEN # 所有监听
```

运维三大高频：查端口、查句柄泄漏、查空间不释放。'),
(1, '性能排查工具地图', '# 一图流

| 层 | 工具 | 看什么 |
|---|---|---|
| CPU | top/vmstat/perf | us, sy, wa |
| 内存 | free/smem | available, swap |
| IO | iostat/iotop | %util, await |
| 网络 | ss/sar -n DEV/tcpdump | 连接、重传、包 |
| 进程 | ps/pidstat/strace | 谁在吃资源 |
| 综合 | dmesg/-var/log | OOM、内核错 |

套路：top 总览 → 按 us/sy/wa 分流 → 对应层深挖 → 定位进程 → strace/jstack 看代码栈。'),
(1, '日志体系与 journalctl', '# 系统日志

```bash
journalctl -u nginx -f              # 服务日志跟随
journalctl -p err -b                # 本次开机错误
journalctl --since "1 hour ago"     # 时间窗
journalctl --disk-usage             # 占用（vacuum-size=500M 清理）
```

文件日志轮转：logrotate（daily/rotate 30/compress/postrotate kill -USR1）。
应用日志规范：结构化 JSON + 级别分级 + 按天切割 + ERROR 独立通道。'),
(1, '安全加固基线清单', '# 上线前基线

1. SSH：禁 root 直登、密钥登录、改端口可选
2. 账号：删无用账号、服务用 nologin 账号、sudo 白名单
3. 最小化：关无用服务、卸载多余包
4. 更新：安全补丁策略
5. 防火墙：默认拒绝、白名单放行
6. 审计：auditd 关键文件/命令、history 时间戳
7. 资源：limits（nofile/nproc）、cgroup 限额
8. SUID 巡检：find / -perm -4000
9. 时间同步 chrony'),
(2, '三次握手四次挥手精讲', '# TCP 连接生命周期

握手：SYN → SYN+ACK → ACK（为何三次：双方都需确认收发能力，防历史连接）。
挥手：FIN → ACK → FIN → ACK（为何四次：全双工单向关闭，被动方可能还有数据）。

状态排障：
- SYN_RECV 堆积：半连接攻击或 accept 不过来
- CLOSE_WAIT 堆积：**本机代码没 close**（连接泄漏）
- TIME_WAIT 海量：本机高频短连接，上连接池/长连接

查看：`ss -ant state close-wait`。'),
(2, 'DNS 排障手册', '# DNS

```bash
dig example.com +short        # 快速解析
dig @223.5.5.5 example.com    # 指定服务器对比
dig example.com +trace        # 递归全过程
nslookup example.com
```

层次：hosts → 本地缓存 → 递归DNS → 根 → 顶级 → 权威。
TTL 决定缓存时长；改解析不生效=缓存（本地 dnsmasq/浏览器）。
A→IP，CNAME→别名（CDN 标配）。
偶发解析慢：resolv.conf 加 options timeout:1 attempts:2。'),
(2, 'HTTP 状态码排障对照表', '# 状态码语义

| 码 | 含义 | 排查 |
|---|---|---|
| 301/302 | 永久/临时跳转 | 跳转目标与缓存 |
| 400 | 请求格式错 | 客户端参数/头 |
| 401/403 | 未认证/无权限 | 凭证、权限、防火墙 |
| 404 | 资源不存在 | 路由/路径 |
| 413 | 请求体过大 | client_max_body_size |
| 429 | 限流 | 限流策略 |
| 499 | 客户端提前断开 | 后端慢 |
| 502 | 网关连不上后端 | 后端进程/端口 |
| 504 | 后端超时 | 慢SQL/下游 |

502 vs 504：连不上 vs 等不起。'),
(2, 'curl 高级用法速查', '# curl 诊断

```bash
curl -v URL                          # 全过程
curl -s -o /dev/null -w "%{http_code} %{time_total}s\n" URL   # 指标
curl -w "dns:%{time_namelookup} tcp:%{time_connect} tls:%{time_appconnect}\n" URL
curl -H "Host: x.test" URL           # 伪造Host测虚拟主机
curl -x http://proxy:7890 URL        # 走代理
curl -k https://...                  # 忽略证书
curl --resolve host:443:1.2.3.4 https://host/   # 指定IP直连（绕DNS/绑测试机）
```

分段耗时定位首包慢：DNS/建连/TLS/传输哪段大修哪段。'),
(2, 'tcpdump 抓包配方集', '# tcpdump

```bash
tcpdump -i any port 8080 -nn -c 1000
tcpdump host 10.0.0.5 and port 443 -nn
tcpdump "tcp[tcpflags] & tcp-syn != 0" -nn            # 只看SYN
tcpdump -w /tmp/a.pcap -i any port 53                 # 落盘用wireshark
tcpdump -A port 80 -s0                                 # 看HTTP明文
```

三大场景：确认请求是否到机、握手断在哪步、谁发的 RST。'),
(2, 'HTTPS/TLS 要点与 openssl 实用命令', '# TLS

握手：ClientHello(套件+随机数) → 证书 → 验证链 → 密钥交换 → 对称加密。

```bash
openssl s_client -connect host:443 -servername host   # 看证书链
openssl x509 -in cert.pem -noout -dates               # 有效期
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout k.pem -out c.pem -subj "/CN=test"           # 自签
```

证书问题排查：过期/缺中间证书/域名不匹配/CA太旧/系统时间错。'),
(2, '四层与七层负载均衡', '# L4 vs L7

- L4（LVS、云NLB、ipvs）：IP+端口转发，性能高，不能按内容路由
- L7（Nginx、Envoy、云ALB）：解析HTTP，按域名/路径/Header 路由、改写、限流

经典组合：LVS 扛量 → Nginx 分流。K8s：kube-proxy=4层，Ingress=7层。
会话保持：ip_hash（NAT 聚簇风险）、cookie 插入、或应用无状态+集中 session。'),
(2, '连接异常状态字典', '# Connection 排障字典

| 现象 | 含义 | 动作 |
|---|---|---|
| refused | 到了机器无进程听 | 查服务/绑定地址 |
| timeout | 路上被丢 | 防火墙/安全组/路由 |
| reset (RST) | 被强制断 | 端口没听/防火墙REJECT/应用拒 |
| 502 | 网关连不上后端 | 后端死了 |
| 504 | 后端没及时回 | 后端慢 |

先分类再排查，省一半时间。'),
(2, 'IP/子网/网关基础', '# 寻址

CIDR：a.b.c.d/24 → 前24位网络位。/24 可用主机 254（去网络与广播）。
私网段：10/8、172.16/12、192.168/16。

```bash
ip addr / ip -4 -o addr      # 地址
ip route                     # 路由（default 网关）
ping / traceroute / mtr      # 连通与路径
arp -n                       # 二层映射
```
同网段直连（ARP），跨网段走网关。'),
(3, 'Bash 健壮脚本模板', '# 模板

```bash
#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
LOG=/var/log/myjob.log
exec >> "$LOG" 2>&1

lock() { exec 9>/tmp/myjob.lock; flock -n 9 || exit 0; }
trap ''rm -f /tmp/myjob.tmp'' EXIT

main() { :; }
lock; main
```

要点：失败即停、未定义报错、绝对路径、日志落盘、单实例、清理钩子。'),
(3, 'awk 实战二十式', '# awk 配方

```bash
awk ''{print $1}'' f                  # 取列
awk -F: ''{print $1}'' /etc/passwd    # 指定分隔符
awk ''$3>100'' f                      # 条件行
awk ''NR>=10 && NR<=20'' f            # 行段
awk ''{s+=$5} END{print s}'' f        # 求和
awk ''{c[$1]++} END{for(k in c) print k,c[k]}'' f   # 计数（免sort）
awk ''/ERROR/{n++} END{print n}'' f   # 匹配计数
awk ''length($0)>80'' f               # 长行
awk ''{print NF, $NF}'' f             # 列数与最后一列
awk ''prev{print prev,$0} {prev=$1}'' f # 上下行关联
```'),
(3, 'sed 替换速查', '# sed

```bash
sed ''s/a/b/'' f          # 每行第一处
sed ''s/a/b/g'' f         # 全局
sed -i ''s/.../.../'' f   # 改文件（先 -i.bak）
sed -n ''10,20p'' f       # 打印行段
sed ''3d'' f              # 删第3行
sed ''/^#/d'' f           # 删注释行
sed ''/^$/d'' f           # 删空行
sed ''$a\newline'' f      # 末尾追加
sed -E ''s/([0-9]+)/<\1>/'' f  # 分组捕获
```

与 tr/cut 的分工：sed 改、tr 单字符、cut 简单取列。'),
(3, '日志分析四件套与变体', '# 万能管线

```bash
awk ''{print $1}'' access.log | sort | uniq -c | sort -rn | head
```

变体：
- TOP URL：$7；状态码分布：$9；UA：替换列
- 时间窗：先 grep "25/Oct/2026:14:"
- 5xx：awk ''$9>=500''
- 组合维度：awk ''{print $1,$9}''（再 sort|uniq）
- 去重数：sort -u | wc -l
- 大文件并行：split 后 xargs -P'),
(3, 'crontab 完全避坑指南', '# cron

格式：分 时 日 月 周。`*/5 * * * *` 每5分钟；`0 3 * * 1` 周一3点。

五大坑：
1. `%` 特殊 → `\%`（date +%F）或进脚本
2. PATH 极简 → 绝对路径/source profile
3. 未重定向 → 邮件堆积，必 >> log 2>&1
4. 相对路径 → cd $(dirname $0) 或 SCRIPT_DIR
5. 重叠执行 → flock -n
排查：grep CRON /var/log/syslog；journalctl -u cron。'),
(3, 'find 查找删除全家桶', '# find

```bash
find / -name "*.log" -mtime +7 -delete      # 7天前日志
find . -type f -size +100M                  # 大文件
find /data -type d -empty -delete           # 空目录
find . -name "*.tmp" -exec rm {} \;         # 执行命令
find . -iname "*readme*"                    # 忽略大小写
find . -maxdepth 2 -type f                  # 限深
find . -newer /tmp/ref                      # 比参照新
```

生产习惯：先 `-ls` 预览，确认再 `-delete`；文件名带空格用 -print0 | xargs -0。'),
(3, '变量与引号详解', '# 引号

- 单引号：原样（不解析变量）
- 双引号：解析 $ 和命令替换，保空格
- 反引号 vs $()：同义，后者可嵌套，一律用 $()

```bash
name="a b"
 echo $name    # 两个词！
echo "$name"   # 一个词 ✅
file="x.log"
 echo "${file%.log}"    # 去后缀 → x
echo "${file:-default}" # 默认值
echo "${#file}"         # 长度
```

规矩：变量引用永远加双引号。'),
(3, '脚本调试三板斧', '# 调试

```bash
bash -n s.sh          # 语法检查不执行
bash -x s.sh          # 打印每步
set -x / set +x       # 片段调试
shellcheck s.sh       # 静态检查（强烈推荐）
echo "[$var]" >&2     # 带括号防空值误导
```

常见运行时错：command not found（PATH）、permission denied（+x）、CRLF（dos2unix）、[: too many arguments（变量没加引号）。'),
(3, '文本三剑客选型', '# 选型

| 需求 | 工具 |
|---|---|
| 按行过滤 | grep |
| 单字符映射/删除 | tr |
| 简单取列 | cut |
| 取列+条件+计算 | awk |
| 编辑/替换/删除行 | sed |
| 排序去重计数 | sort/uniq |
| 两个文件对齐 | paste/join |
| 差异 | diff |

日志统计 awk 主力；配置改写 sed 主力。'),
(4, 'location 匹配规则详解', '# location

优先级：`=` 精确 > `^~` 前缀(命中不看正则) > `~`/`~*` 正则(按序) > 最长前缀。

```nginx
location = /login { }        # 只有 /login
location ^~ /static/ { }     # 静态资源，抢过正则
location ~ \.(jpg|css)$ { }  # 正则
location /api/ { }           # 前缀兜底
```

坑：proxy_pass 带不带 `/` 的路径语义；正则 location 里的 proxy_pass 不能带 URI。'),
(4, '反向代理标准配置块', '# proxy 标准块

```nginx
upstream apps { server 10.0.0.1:8080; keepalive 64; }
server {
    listen 80;
    location /api/ {
        proxy_pass http://apps/;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 3s;
        proxy_read_timeout 60s;
    }
}
```'),
(4, '502/504/499 排障决策树', '# 网关错误树

502：
1. curl 后端真实地址 → refused=后端挂/端口错
2. error.log：connect() failed (111)？
3. 后端 OOM？docker inspect OOMKilled

504：后端慢 → 后端日志/慢SQL/GC，调 proxy_read_timeout 只是缓解

499：客户端等不及 → 通常与 504 同因，优化后端

日志黄金字段：$request_time（总） vs $upstream_response_time（后端）：差值大=网络传输慢。'),
(4, '限流配置（limit_req/limit_conn）', '# 限流

```nginx
# http{}: 漏桶 10r/s，按IP
limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
limit_req_status 429;

server {
    location /api/ {
        limit_req zone=api burst=20 nodelay;   # 桶20，突发放行
        limit_conn addr 50;                    # 需另配 limit_conn_zone
        proxy_pass ...;
    }
}
```

漏桶匀速（nginx）vs 令牌桶容忍突发（网关/guava）。499/503/429 返回语义按客户端约定。'),
(4, 'HTTPS 完整配置（现代版）', '# TLS 配置

```nginx
server {
    listen 443 ssl http2;
    ssl_certificate     /etc/nginx/certs/fullchain.pem;
    ssl_certificate_key /etc/nginx/certs/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE+AESGCM:ECDHE+CHACHA20;
    ssl_session_cache shared:SSL:10m;
    add_header Strict-Transport-Security "max-age=31536000" always;
}
server { listen 80; return 301 https://$host$request_uri; }
```

证书续期：certbot renew（cron 检查）+ reload；监控 notAfter 提前 30 天告警。'),
(4, '日志切割与日志字段', '# 日志

logrotate 模板：daily/rotate 30/compress/missingok + postrotate `nginx -s reopen`（USRI 信号重开句柄，不重启）。

常用字段：$remote_addr、$time_local、$request、$status、$body_bytes_sent、$request_time、$upstream_response_time、$http_user_agent。

分析四件套直接吃 access.log；聚合大站接 filebeat→Loki/ES。手工切割：mv + `nginx -s reopen`。'),
(4, '负载均衡与后端探活', '# upstream

```nginx
upstream apps {
    least_conn;                       # 或默认轮询/ip_hash/weight
    server 10.0.0.1:8080 max_fails=3 fail_timeout=10s;
    server 10.0.0.2:8080;
    server 10.0.0.3:8080 backup;
    keepalive 64;
}
```

被动探活：max_fails/fail_timeout；主动探活需商业版 health_check 或前置 LB。
摘流量：server ... down; 然后 reload。'),
(4, '动静分离与缓存', '# 静态与缓存

```nginx
location ~* \.(js|css|png|jpg|woff2)$ {
    root /data/static;
    expires 30d;
    add_header Cache-Control "public";
}
location /api/ { proxy_pass http://apps/; }

# 反代缓存（兜底旧数据）
proxy_cache_path /data/ncache keys_zone=one:10m;
proxy_cache one;
proxy_cache_use_stale error timeout updating;
```

强缓存(expires/Cache-Control) vs 协商缓存(Last-Modified/ETag)。'),
(4, '性能调优清单', '# 调优

```nginx
worker_processes auto;
events { worker_connections 10240; use epoll; }
http {
    sendfile on; tcp_nopush on;
    keepalive_timeout 65;
    gzip on; gzip_types text/css application/json;
    client_max_body_size 20m;
}
```

系统层：ulimit -n / worker_rlimit_nofile 对齐；TIME_WAIT 多→后端连接池/keepalive。
压测验证：ab/wrk 对比 P99，别拍脑袋调参。'),
(5, '常用命令场景速查表', '# 命令地图

| 场景 | 命令 |
|---|---|
| 日志 | docker logs -f --tail 100 x |
| 进入 | docker exec -it x sh |
| 状态 | docker ps -a / stats / inspect |
| 端口占用 | docker port x |
| 文件 | docker cp x:/path ./ |
| 资源 | docker system df -v |
| 清理 | image/container/builder prune |
| 停止 | docker stop（先TERM后KILL）|

镜像 tag 规范：git短hash-构建号，禁 latest。'),
(5, 'Dockerfile 最佳实践十条', '# 最佳实践

1. 小基础镜像（alpine/distroro/JRE）
2. 多阶段构建（build 与 run 分离）
3. exec 格式 ENTRYPOINT（信号可达）
4. 层排序：依赖清单先 COPY，源码最后
5. 同层清理：rm -rf /var/lib/apt/lists/*
6. .dockerignore 排除无关文件
7. 非 root USER
8. ENV 固定 TZ/LANG
9. HEALTHCHECK
10. 一个容器一个进程'),
(5, '容器排障：退出码字典', '# 退出码

| 码 | 含义 | 动作 |
|---|---|---|
| 0 | 正常退出 | 命令是瞬时的？前台进程问题 |
| 1 | 应用错误 | logs 看栈 |
| 137 | SIGKILL/OOM | inspect OOMKilled；调内存 |
| 139 | 段错误 | 版本/依赖 |
| 125 | docker 自身错误 | 参数/守护进程 |
| 126 | 不可执行 | 权限 |
| 127 | 命令不存在 | 路径 |

docker logs --previous（compose）；替换入口调试 --entrypoint sh。'),
(5, 'compose 编排要点', '# compose

```yaml
services:
  web:
    build: ./web
    ports: ["8080:8080"]
    environment: [REDIS_HOST=redis]
    depends_on:
      redis: { condition: service_healthy }
    restart: unless-stopped
    healthcheck: { test: ["CMD","curl","-sf","http://localhost:8080/health"], interval: 30s }
  redis:
    image: redis:7-alpine
    volumes: [redis-data:/data]
volumes: { redis-data: }
```

坑：改配置 restart 不生效（要 up -d 重建）；服务名即 DNS；端口用容器端口互通。'),
(5, '容器网络原理与模式', '# 网络

- bridge（默认）：veth→docker0，NAT；-p DNAT；自定义网络有 DNS
- host：共享宿主栈，性能最好
- none：仅 lo
- container:xx：共享另一容器（K8s Pod 原理）

服务互访：同自定义网络用**服务名**；端口通信用**容器端口**（不是宿主映射端口）。
排查：docker network inspect、容器内 ip a / curl。'),
(5, '数据持久化三种方式', '# 存储

1. volume：`-v name:/path` Docker 管理，独立生命周期，备份/迁移友好（推荐）
2. bind mount：`-v /host:/c` 直挂目录，开发热更方便，路径耦合
3. tmpfs：内存挂载，临时敏感数据

备份 volume：`docker run --rm -v v1:/src -v $PWD:/bak alpine tar czf /bak/v1.tgz -C /src .`
数据库容器必须挂 volume，否则删容器=删数据。'),
(5, '多阶段构建 Java 镜像', '# 多阶段

```dockerfile
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline      # 依赖层缓存
COPY src ./src
RUN mvn package -DskipTests

FROM eclipse-temurin:17-jre-alpine
COPY --from=build /app/target/app.jar /app.jar
ENV TZ=Asia/Shanghai
ENTRYPOINT ["java","-jar","/app.jar"]
```

镜像从 ~800M 降到 ~200M；依赖先 COPY 利用缓存加速 CI。'),
(5, 'Docker 安全要点', '# 安全

1. 非 root 运行（USER app）
2. 不用 --privileged；能力白名单 --cap-drop=ALL + 需要的 add
3. 只读根文件系统 + 可写 tmpfs
4. 镜像扫描（trivy）阻断高危
5. secrets 不进镜像/环境（用 vault/编排密钥）
6. socket 挂载=宿主 root，严格控权（CI 场景 sibling 模式）
7. registry 私有+签名（cosign）'),
(5, '磁盘治理：docker 占满磁盘怎么办', '# 磁盘治理

1. `docker system df -v` 分类定位（镜像/容器可写层/卷/缓存/日志）
2. 容器日志：truncate *-json.log；daemon.json 配 max-size/max-file 防复发
3. prune 家族（先 --dry-run 类预览，不碰运行中资源）
4. 可写层大：容器内写大数据是反模式 → volume 化
5. 镜像：清悬空；构建缓存 builder prune

原则：先分类，永远不动在线容器与在用卷。'),
(6, '核心对象关系一图流', '# 对象关系

```
Deployment ─管→ ReplicaSet ─保→ Pod
StatefulSet（有序+PVC）/ DaemonSet（每节点）/ Job / CronJob
Service（ClusterIP/NodePort/LB/Headless）→ 按 Label 选 Pod
Ingress → 路由到 Service
ConfigMap/Secret → 注入 env 或 volume
PV ← PVC ← Pod挂载（StorageClass 动态供给）
Namespace（组织与配额）
```

改镜像→新RS滚动；rollout undo 回滚旧RS。'),
(6, 'Pod 状态字典与排障入口', '# 状态字典

| 状态 | 原因 | 入口 |
|---|---|---|
| Pending | 资源/亲和/污点/PVC | describe Events |
| ContainerCreating | 拉镜像/挂卷慢 | describe |
| ImagePullBackOff | 镜像名/凭证 | describe |
| CrashLoopBackOff | 进程崩 | logs --previous |
| OOMKilled | 超内存limit | describe Last State |
| Evicted | 节点压力 | describe + 节点 Pressure |
| Terminating卡住 | finalizer/挂载 | describe |

四步：get → describe → logs --previous → exec。'),
(6, '探针设计规范', '# 探针

- startup：慢启动保护（failureThreshold×periodSeconds ≥ 启动最长时间）
- liveness：死锁检测；**不要**检查依赖（DB挂→全实例重启=雪崩）
- readiness：可用性；滚动发布不断流关键；过载可摘除

```yaml
startupProbe:  {httpGet: {path: /actuator/health/liveness, port: 8080}, periodSeconds: 5, failureThreshold: 30}
readinessProbe:{httpGet: {path: /actuator/health/readiness, port: 8080}, periodSeconds: 5}
```

Spring Boot 用 liveness/readiness 分组。'),
(6, 'Service 与网络路径', '# 网络

ClusterIP：虚拟IP仅集群内（iptables/ipvs），ping 不通 curl 通。
NodePort 30000-32767；LoadBalancer=云LB；Headless（None）直解析 PodIP（StatefulSet/自负载均衡）。

DNS：svc、svc.ns、svc.ns.svc.cluster.local（跨 ns 全名）。
排查：临时 pod busybox wget/nslookup 分层测；NetworkPolicy 是否拦截。'),
(6, '资源配额与 Requests/Limits', '# 资源

- requests：调度依据（节点可分配量减去预留）
- limits：内存超→OOMKilled；CPU超→节流（不杀）
- 经验：requests=稳态；内存limit=峰值×1.5；CPU 可不设 limit（防节流抖动）
- namespace：ResourceQuota 总量 + LimitRange 默认值兜底
- JVM：MaxRAMPercentage=70 感知容器

节点预留：kube-reserved/system-reserved，防系统组件被挤。'),
(6, '发布策略在 K8s 的落地', '# 发布

- 滚动：Deployment 默认（maxSurge/maxUnavailable），readiness 保不断流
- 蓝绿：两套 Deployment+Service selector 切换
- 金丝雀：Ingress 权重（nginx ingress canary 注解）/服务网格流量切分
- 暂停观察：rollout pause/resume（发现问题先冻结！）
- 回滚：rollout undo --to-revision=N

发布后 smoke + 指标观察窗，自动分析（Argo Rollouts）进阶。'),
(6, 'ConfigMap/Secret 实战', '# 配置

```yaml
volumes:
- name: cfg
  configMap: { name: app-config }
containers:
- volumeMounts: [{name: cfg, mountPath: /etc/app}]
```

env 注入不热更；卷挂载约 1 分钟刷新（configmap checksum 滚动法强制更新）。
Secret：base64≠加密，RBAC 控权 + etcd encryption at rest + 外部 KMS/Vault。
多环境：kustomize overlays 或 helm values。'),
(6, 'kubectl 十连（日常高频）', '# kubectl

```bash
kubectl get pods -A -o wide
kubectl describe pod x
kubectl logs x --previous -f
kubectl exec -it x -- sh
kubectl top pod/node
kubectl rollout status|undo|history deploy/x
kubectl port-forward svc/x 8080:80
kubectl get events --sort-by=.lastTimestamp
kubectl scale deploy x --replicas=3
kubectl drain node --ignore-daemonsets
```

排障四步：get→describe→logs→exec。'),
(6, 'etcd 备份与集群应急', '# etcd

```bash
ETCDCTL_API=3 etcdctl snapshot save /bak/etcd.db \
  --endpoints=https://127.0.0.1:2379 --cacert=.. --cert=.. --key=..
etcdctl snapshot restore etcd.db --data-dir=/var/lib/etcd-new
```

证书监控：kubeadm certs check-expiration；过期 kubeadm certs renew all。
节点 NotReady：kubelet 状态/证书/磁盘压力/PLEG。
原则：控制面多副本奇数、备份异地、定期恢复演练。'),
(7, 'Git 救命命令集', '# Git 急救

```bash
git reflog                        # 找回任何丢失提交
git reset --soft HEAD~1           # 撤销提交保留改动
git revert <c>                    # 安全撤销已push
git stash / stash pop             # 暂存现场
git checkout -- <f>               # 丢弃工作区改动
git log --oneline --graph --all   # 全景
git diff branch1..branch2         # 分支差异
git bisect start                  # 二分找坏提交
```

黄金法则：公共分支不 rebase、不 force（必须时 --force-with-lease）。'),
(7, 'GitHub Actions 模板（Java+Docker）', '# workflow

```yaml
name: ci
on: { push: { branches: [main] } }
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-java@v4
      with: { java-version: ''17'', distribution: temurin, cache: maven }
    - run: mvn -B test
    - run: mvn package -DskipTests
    - name: docker build
      run: |
        TAG=${GITHUB_SHA::7}
        docker build -t reg/app:$TAG .
        docker push reg/app:$TAG
```

secrets 用 ${{ secrets.X }}；PR 来自 fork 不注入。'),
(7, 'Jenkins 声明式流水线骨架', '# Jenkinsfile

```groovy
pipeline {
  agent any
  stages {
    stage(''checkout'') { steps { checkout scm } }
    stage(''test'')    { steps { sh ''mvn -B test'' } }
    stage(''build'')   { steps { sh ''mvn package -DskipTests'' } }
    stage(''image'')   { steps { sh ''docker build -t reg/app:$BUILD_NUMBER . && docker push ...'' } }
    stage(''deploy'')  { steps { sh ''kubectl set image deploy/app app=reg/app:$BUILD_NUMBER'' } }
  }
  post {
    failure { echo ''notify dingtalk'' }
    always { junit ''**/TEST-*.xml'' }
  }
}
```'),
(7, '发布策略对比矩阵', '# 发布策略

| 策略 | 资源 | 回滚 | 风险 | 适用 |
|---|---|---|---|---|
| 滚动 | 1+ | 中(重滚) | 中 | 常规 |
| 蓝绿 | 2x | 秒级 | 低 | 核心可停机窗口 |
| 金丝雀 | 1.x | 快 | 最低 | 高风险变更 |

金丝雀放量：1%→10%→50%→100%，指标（错误率/P99）护航自动推进。
DB 变更必须向后兼容、拆两次发布（先加后删）。'),
(7, '制品管理与镜像规范', '# 制品

- tag：git短hash-构建号（或日期）；**禁 latest**
- 部署清单记录 tag 或 digest（sha256 不可变，防覆盖）
- Harbor：项目隔离权限、漏洞扫描（trivy）阻断、保留策略清理旧版
- SBOM 与签名（cosign）供应链安全
- 回滚=部署旧tag，不是重新构建'),
(7, '分支模型与团队协作', '# 分支

主流：trunk-based（短分支+feature flag+CI快速反馈）或简化 gitflow（main+feature+hotfix）。
保护：PR 必审（CODEOWNERS）+CI绿+线性历史（rebase merge 或 squash）。
提交规范：Conventional Commits（feat/fix/chore）→自动 changelog。
冲突预防：小步、勤 rebase 主干、模块化降低同文件碰撞。'),
(7, '数据库变更工程化', '# DB 迁移

- Flyway/Liquibase 脚本进仓库随代码评审
- 铁律：向后兼容——先加列（带默认）→发应用→删旧列（下下版）
- 大表：online DDL（8.0 INSTANT/INPLACE）或 gh-ost，低峰+演练
- CI 对临时库执行迁移验证可重入
- 生产执行：变更单+备份点+回滚脚本+双人复核'),
(7, '回滚设计清单', '# 回滚

1. 制品库保留全部历史版本
2. 部署脚本支持 --to-version
3. K8s：rollout undo（旧RS还在）
4. 静态站点：版本目录+软链切换
5. DB：不做破坏性变更=代码可随意回滚
6. 配置变更也要可回滚（git 化）
7. 回滚演练纳入预发流程——没演练过的回滚不存在'),
(7, 'GitOps/ArgoCD 思想', '# GitOps

Git 仓库=期望状态（yaml/helm），控制器**拉模式**持续收敛集群。

优点：Git 即审计、防配置漂移、灾备=重新 apply、凭证不出集群。
组件：ArgoCD（UI+sync+drift检测）、FluxCD。
CI 只负责构建+提交清单变更，不再直接 kubectl（push→pull 的范式转变）。'),
(8, 'PromQL 常用查询配方', '# PromQL

```promql
# QPS
sum(rate(http_server_requests_seconds_count[5m]))
# 错误率
sum(rate(..._count{status=~"5.."}[5m])) / sum(rate(..._count[5m]))
# P99
histogram_quantile(0.99, sum(rate(..._bucket[5m])) by (le))
# 单实例维度定位慢实例
... by (le, instance)
# 内存使用率
(1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100
# 磁盘水位
(1 - node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"}) * 100
```'),
(8, '告警分级与路由设计', '# 告警

P0 电话/短信：服务不可用、错误率>2%、数据丢失风险
P1 IM群：P99劣化、容量水位、pod重启
P2 邮件：趋势类、证书到期

Alertmanager：group_by(service) 聚合防风暴；inhibition 级联抑制（机房down抑制其上服务）；silence 变更窗口静默（有期限）。
每条告警必须有 owner+runbook，不可行动的删掉。'),
(8, 'Spring Boot 接入监控清单', '# Java 接入

1. 依赖：actuator + micrometer-registry-prometheus
2. 暴露：management.endpoints.web.exposure.include=prometheus,health
3. 自动指标：jvm_*、http_server_requests_*、hikari_*、tomcat_*
4. 自定义：Counter（业务量）、Timer（耗时）、Gauge（队列）
5. 面板：Grafana 社区模板 4701(JVM)/11375(全栈)
6. 告警：错误率/P99/GC暂停/内存/连接池

注意关闭管理端点外网暴露。'),
(8, 'ELK/Loki 选型与落地', '# 日志平台

ELK：全文索引，强检索，重资源（ES 集群）。
Loki+Promtail：只索引标签，轻量便宜，LogQL 查询，配 Grafana 一体。

选型：查得多预算少→Loki；强全文/审计合规→ELK。
通用要点：JSON 结构化、traceId 必带、多行栈合并、保留策略（ERROR 90d/INFO 30d）、采集限流防风暴。'),
(8, '四个黄金指标与 USE/RED', '# 方法论

黄金指标（服务）：延迟/流量/错误/饱和度。
USE（资源）：Utilization/Saturation/Errors——扫机器。
RED（请求）：Rate/Errors/Duration——看接口。

实践：每个新服务上线前四指标配齐才放行；饱和度（池/队列/水位）是前瞻信号，涨了就要动，别等延迟炸。'),
(8, '链路追踪入门（OTel）', '# tracing

概念：trace（全链路）→ span（一段操作）上下文传播（W3C traceparent）。

价值：错误率告警后，按 traceId 看慢在哪一段（网关→服务A→DB 800ms）。

落地：OpenTelemetry SDK 自动埋点（Java agent 无侵入）+ 采样策略（常态 5-10%，错误/慢 100% 尾采样）+ 后端 Jaeger/SkyWalking/Tempo。
日志里打 traceId 打通三支柱。'),
(8, '容量规划速算模板', '# 容量

已知：单实例容量 C（压测：P99 达标下最大QPS），目标峰值 Q，冗余系数 1.5。
实例数 = Q×1.5 / C，再 +1 容错。

例：单 Pod 800QPS，大促 2万 QPS → 20000×1.5/800 ≈ 38 台。
配套：HPA 阈值与 min/max、定时预扩（活动前）、DB/缓存同步评估、云限额提前申请。
水位看板：当前峰值/容量 >70% 告警。'),
(8, '故障复盘（Postmortem）模板', '# 复盘模板

1. 概要：影响面（用户数/请求量/资损）、持续时长
2. 时间线：发现→响应→定位→恢复（每步时间戳）
3. 根因：技术根因+流程根因（为什么没拦住）
4. 好的方面：哪里起了作用
5. 改进项：负责人+deadline（防再发的检测/自动止损/演练）

文化：blameless 对事不对人；48h 内出初稿；改进项跟踪到关闭。'),
(8, '混沌工程最小实践', '# 混沌

步骤：定义稳态指标 → 提假设（杀一个实例不影响可用性）→ 控制爆炸半径（单实例/单可用区/可一键停止）→ 注入（杀进程/断网/磁盘满/延迟）→ 验证与复盘。

工具：chaosblade、pumba（容器）、Chaos Mesh（K8s）。
先在预发环境练：kill -9 进程、tc netem 加延迟、iptables 丢包都是手工混沌。'),
(8, 'SLO 与错误预算实践', '# SLO

SLI 示例：成功率、P99<300ms 的请求占比。
SLO：30天内成功率 ≥ 99.9%。
错误预算 = 1 - SLO = 0.1%（约43分钟不可用/月）。

预算耗尽 → 冻结发布、全力稳定性（这是 SLO 真正的威力：用数据平衡速度与稳定）。
落地：SLI 定义→监控告警→发布流程挂钩预算余量。'),
(9, 'EXPLAIN 列解读', '# EXPLAIN

- type：system>const>eq_ref>ref>range>index>**ALL（消灭它）**
- key/key_len：命中索引与长度（联合索引用了几列）
- rows：扫描行数量级
- Extra：Using index（覆盖✅）/ filesort（排序溢出⚠️）/ temporary（临时表⚠️）
- possible_keys 有但 key=NULL：隐式转换/函数包列/优化器成本

流程：慢日志→pt-digest聚合→EXPLAIN→加索引/改写→复测。'),
(9, '索引失效八大场景', '# 失效

1. 函数包列：YEAR(t)=2026 → 改范围
2. 运算：id+1=10
3. 隐式类型转换（字符串列用数字查）
4. 左模糊 LIKE ''%x''
5. 联合索引不满足最左前缀
6. OR 一侧无索引
7. != / NOT IN（选择性差时）
8. 字符集/join 列不一致

诊断：EXPLAIN 看 key 是否 NULL；SHOW INDEX 查已有索引防冗余。'),
(9, '主从复制配置与监控', '# 复制

```sql
CHANGE REPLICATION SOURCE TO SOURCE_HOST=''主'', SOURCE_USER=''repl'',
  SOURCE_PASSWORD=..., SOURCE_AUTO_POSITION=1;  -- GTID
START REPLICA;
SHOW REPLICA STATUS\G   -- 两线程YES + Seconds_Behind_Master
```
监控：延迟（pt-heartbeat 更准）、复制错误（Last_Error）、GTID 断点。
一致性校验：pt-table-checksum + pt-table-sync。'),
(9, '备份恢复体系', '# 备份

组合：每日 XtraBackup 全备（低峰）+ binlog 实时归档=任意时间点恢复（PITR）。
延迟从库（30min）应对逻辑误删：STOP REPLICA 抢救。

**每周自动化恢复演练**：恢复到临时实例+行数校验+核心查询抽查——没演练过的备份不算备份。
RPO（丢多少）与 RTO（停多久）由业务定策略。'),
(9, '连接数与线程池排障', '# 连接

Too many connections 应急：管理连接进入→SHOW PROCESSLIST→KILL 大量 Sleep→SET GLOBAL max_connections 临时上调。
根治：
1. 所有应用实例 maxActive 总和 < max_connections×0.8
2. wait_timeout 调小清僵尸
3. 排查连接泄漏（借出不还，druid stat）
4. 高并发引入 ProxySQL/线程池'),
(9, '事务/锁速查', '# 事务

隔离级别：RR（默认，MVCC+间隙锁）→ 互联网常改 RC（少间隙锁死锁）。
锁：记录锁/间隙锁/next-key；insert intention。
死锁：SHOW ENGINE INNODB STATUS → LATEST DETECTED DEADLOCK；保持加锁顺序、小事务、索引化条件。
MVCC：undo 版本链+ReadView（RR 首读生成，RC 每次生成）。'),
(9, '大表 DDL 安全清单', '# DDL

8.0：加列 INSTANT 秒级；加索引 INPLACE 不堵 DML。
复杂变更（改类型/字符集）：gh-ost/pt-osc 影子表+增量+原子切换。
注意：DDL 需要短暂 MDL 排他锁——**先确认无长事务**（innodb_trx），否则 DDL 卡住连锁阻塞全部查询（经典事故）。
低峰执行+磁盘空间评估+主从逐台。'),
(9, '慢查询治理 SOP', '# 慢SQL

1. 采集：slow_query_log + long_query_time=1；pt-query-digest 聚合 TOP
2. 线上抓现行：processlist time>5 → KILL
3. EXPLAIN 诊断 → 手段：加索引/覆盖索引/改写（游标分页、免函数）/hint
4. 结构性：读写分离、汇总表、缓存、归档冷数据
5. 防复发：SQL 审核平台卡点（执行计划检查进发布单）、慢日志日报'),
(9, '参数调优速查', '# 参数

```ini
innodb_buffer_pool_size = 物理内存60-70%   # 最重要
max_connections = 1000
innodb_flush_log_at_trx_commit = 1        # 双一(安全) 按业务取舍
sync_binlog = 1
binlog_format = ROW
innodb_io_capacity = SSD按盘调
slow_query_log = ON / long_query_time = 1
```

调参流程：定位瓶颈（IO/锁/连接）→ 一次改一项 → 压测对比 → 记录归档。'),
(10, 'Redis 数据结构选型', '# 选型

| 场景 | 结构 |
|---|---|
| 缓存/计数 | String（INCR 原子）|
| 对象字段 | Hash（部分读写）|
| 去重/标签/共同关注 | Set（交并差）|
| 排行榜 | ZSet（ZADD/ZREVRANGE）|
| 队列/最新列表 | List（LPUSH/BRPOP）|
| 限流/延迟 | ZSet 时间戳 |

大数据量 hash 拆桶：key:{id%100} 防 bigkey。'),
(10, '缓存三大问题对策表', '# 三大问题

| 问题 | 定义 | 对策 |
|---|---|---|
| 穿透 | 查不存在的key | 布隆/缓存空值/参数校验 |
| 击穿 | 热点过期瞬间 | 互斥重建/逻辑过期/热点永不过期 |
| 雪崩 | 大面积同时失效或宕机 | TTL加随机/多级缓存/集群/熔断降级 |

DB 兜底：连接池限流+慢查询熔断，别让缓存事故变成DB雪崩。'),
(10, '持久化与高可用架构', '# 高可用

持久化：RDB（快照/恢复快/丢分钟）+ AOF（everysec/丢1秒）+ 混合（推荐）。
HA：主从异步复制 → 哨兵（quorum 决策选主，秒级）→ Cluster（16384 slot 分片+副本自愈）。
选型：单库<10G 主从哨兵够；容量/写入瓶颈再 Cluster（客户端改动+多key限制）。
脑裂防护：min-replicas-to-write。'),
(10, '分布式锁正确实现', '# 锁

```redis
SET lock:order:1 <uuid> NX EX 10
# 释放（Lua 原子）
if redis.call("get",KEYS[1])==ARGV[1] then return redis.call("del",KEYS[1]) else return 0 end
```

三坑：误删他人锁（唯一 value+Lua）、业务超时锁过期（看门狗续期）、主从切换丢锁（RedLock 争议/业务幂等兜底）。
生产用 Redisson；强一致场景 etcd/zk。'),
(10, 'bigkey/hotkey 治理', '# key 治理

bigkey：
- 发现：--bigkeys / MEMORY USAGE / rdb 离线分析
- 危害：单线程阻塞（连 DEL 都卡）、迁移卡、内存倾斜
- 治理：hash 拆桶、异步 UNLINK、SCAN 代 KEYS

hotkey：
- 发现：--hotkeys、客户端统计、代理层
- 治理：本地多级缓存、副本打散（key_N 随机读）、隔离部署'),
(10, 'Kafka 核心概念速查', '# Kafka

- broker/topic/partition（分片有序）/replication（leader-follower, ISR）
- producer：acks=0/1/all，幂等+事务
- consumer group：分区一消费者；rebalance 触发（成员/订阅变化）
- offset 提交：手动 commitSync（处理完再提交）
- 顺序：同 key 同分区；全局顺序=单分区
- 保留：retention 按时间/大小，重放从头消费'),
(10, '消息不丢与幂等', '# 可靠性

不丢三段：
1. 生产：acks=all + retries + 本地消息表兜底
2. 存储：replication.factor≥3 + min.insync.replicas≥2
3. 消费：手动位移，失败进重试→死信

不重做不到 → 幂等必做：
- 唯一业务键+去重表（同库事务最稳）
- 状态机 UPDATE where status=OLD
- Redis SETNX 前置过滤
唯一业务键+去重表（同库事务最稳）、状态机 UPDATE where status=OLD、Redis SETNX 短时去重。'),
(10, '堆积处理与容量评估', '# 堆积

定位：消费耗时×并发 vs 生产速率；rebalance 风暴？慢外部依赖？
提速：扩消费者（≤分区，不够先加分区）、批量拉取、异步化+手动位移。
追不上：新大分区 topic 搬运转移、时效性消息跳过（评估资损）。
容量：分区数=目标吞吐/单分区吞吐（约10MB/s）取整×1.5；压测定基线。'),
(10, '延迟/定时任务方案对比', '# 延迟

| 方案 | 精度 | 量级 | 复杂度 |
|---|---|---|---|
| RocketMQ 定时消息 | 秒级 | 高 | 低（推荐）|
| Redis ZSet 扫描 | 秒级 | 中 | 中 |
| DB 轮询 | 分钟 | 低 | 低（兜底）|
| 时间轮 | 高 | 极高 | 高 |

订单超时关闭标配：延迟消息主 + 定时对账兜底 + 状态机幂等。'),
(10, 'binlog 驱动的数据同步（canal）', '# CDC

架构：canal 伪装从库拉 ROW binlog → 投 MQ → 消费者（刷缓存/建ES索引/发事件）。

要点：
- 顺序：同主键 hash 到同分区
- 幂等：版本/时间戳比较
- 全量初始化任务配套
- 位点监控（延迟告警）

用途：缓存准实时刷新、搜索索引、审计、跨系统事件解耦。');
