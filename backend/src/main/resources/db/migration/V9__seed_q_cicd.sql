-- 题库种子：CI/CD 与 Git（10 题）
INSERT INTO `question` (`topic_id`, `type`, `difficulty`, `title`, `content`, `answer`, `follow_ups`, `tags`, `frequency`, `position_codes`) VALUES
(7, 'QA', 1, 'CI/CD 是什么？分别解决什么问题？', NULL,
 '- **CI 持续集成**：代码频繁合入主干，每次合入自动触发**构建 + 自动化测试**，尽早发现集成问题。核心价值：小步提交、快速反馈、避免"上线前大爆炸式合并"\n- **CD 持续交付（Delivery）**：CI 通过后自动打包制品并部署到**类生产环境**，随时可一键上生产\n- **CD 持续部署（Deployment）**：更进一步，测试通过后**自动发布生产**，无需人工点击\n\n工具链：代码托管（GitLab/GitHub）→ CI（Jenkins/GitHub Actions/GitLab CI）→ 制品库（Nexus/Harbor）→ 部署（Ansible/K8s）。\n\n答面试时结合自己项目："我的 Spring Boot 项目用 GitHub Actions：push 触发 mvn test → 构建镜像推 Harbor → 部署到 K8s dev 环境"。',
 '["持续交付和持续部署的区别？", "你们流水线有哪些阶段？"]', '["概念", "必考"]', 5, '["devops", "junior-ops", "sre"]'),

(7, 'QA', 2, 'git merge 和 git rebase 的区别？各适合什么场景？', NULL,
 '- **merge**：把两条分支的提交合成一个新提交（merge commit），**保留完整历史**，但主线呈网状\n- **rebase**：把当前分支的提交"摘下来"重放到目标分支上，历史呈**一条直线**，但改写了提交（hash 变）\n\n实践规范（面试加分点）：\n- **个人 feature 分支同步主干**：用 rebase（`git pull --rebase`），保持干净\n- **合入主干**：用 merge（--no-ff）或平台 PR/squash merge，可追溯\n- **黄金法则**：**已推送到公共分支的提交不要 rebase**（会 forcing push 影响他人）\n\nsquash merge：多个小提交压成一个再合入，主干历史干净。',
 '["rebase 冲突怎么处理？", "cherry-pick 什么时候用？"]', '["Git", "必考"]', 5, '["devops"]'),

(7, 'QA', 2, 'git reset 三种模式区别？怎么撤销一次已经 push 的提交？', NULL,
 '`git reset` 三模式（对工作区/暂存区的影响）：\n- `--soft`：只回退 commit，改动留在**暂存区**（想重新提交时用）\n- `--mixed`（默认）：回退 commit + 暂存区，改动留在**工作区**\n- `--hard`：全部丢弃，回到指定提交（**危险**，未提交改动丢失）\n\n撤回已 push 的提交，两种方式：\n1. **revert（推荐）**：`git revert <commit>` 生成一个"反向提交"抵消改动，再正常 push —— 历史不改写，公共分支安全\n2. reset + force push：仅限个人分支，且团队需知晓（`--force-with-lease` 更安全）\n\n找回丢失提交：`git reflog` 查所有 HEAD 移动记录，能救回 reset --hard 掉的提交。',
 '["git reflog 能恢复什么？", "--force-with-lease 比 --force 好在哪？"]', '["Git", "高频"]', 4, '["devops"]'),

(7, 'QA', 1, 'git pull 遇到冲突怎么处理？', NULL,
 '标准流程：\n```\ngit pull                       # 提示 CONFLICT\ngit status                     # 看哪些文件冲突\n# 编辑文件，搜索 <<<<<<< ======= >>>>>>> 标记，改成想要的最终内容\ngit add <files>\ngit commit                     # 完成合并\ngit push\n```\n\n要点：\n- `<<<<<<< HEAD` 是你本地的，`=======` 后面的是远端的\n- 冲突解决是**人工决策**，git 只标出来不替你选\n- 防冲突的工程习惯：小步提交、常拉取、模块拆分减少同文件修改\n- IDE（IDEA）的冲突三栏合并视图很好用\n- 想放弃合并回滚现场：`git merge --abort`',
 '["怎么减少团队冲突？", "rebase 时的冲突和 merge 冲突一样处理吗？"]', '["Git", "高频"]', 4, '["devops", "junior-ops"]'),

(7, 'QA', 2, '描述一条完整 CI 流水线应该包含哪些阶段？', NULL,
 '以 Java 项目为例：\n\n1. **拉代码**：checkout 指定分支/tag\n2. **静态检查**：代码规范（checkstyle/spotbugs）、安全扫描（依赖漏洞 trivy）\n3. **编译**：`mvn compile`\n4. **单元测试**：`mvn test`，产出覆盖率报告（JaCoCo）\n5. **打包**：`mvn package` 产出 jar\n6. **构建镜像**：docker build 并打上 **唯一 tag**（git commit 短 hash + 构建号，禁止只打 latest）\n7. **推送制品库**：push 到 Harbor/Nexus\n8. **部署 dev**：更新 K8s 镜像或 compose 部署\n9. **自动化验证**：冒烟测试、健康检查\n10. **通知**：飞书/钉钉 webhook 通知结果\n\n原则：**快速失败**（静态检查/单测放前面，失败早终止）、**一切自动化**、**制品不可变**（一次构建，多环境部署同一镜像）。',
 '["为什么镜像 tag 不该用 latest？", "怎么加速流水线（缓存）？"]', '["流水线", "高频"]', 5, '["devops"]'),

(7, 'QA', 2, 'Jenkins Pipeline 和 GitHub Actions 的核心概念分别是什么？', NULL,
 '**Jenkins Pipeline**：\n- 流水线即代码：`Jenkinsfile`，声明式（stages/steps/agent）为主\n- 节点（agent/node）分布执行，插件生态最大\n- 适合自建、内网、复杂企业场景\n\n**GitHub Actions**：\n- 事件驱动：`on: push/pull_request` 触发 workflow（`.github/workflows/*.yml`）\n- job → step → action（复用单元），runner 可托管或自建\n- 与 GitHub 深度集成（PR 检查、秘钥管理 secrets）\n\nGitLab CI 同理：`.gitlab-ci.yml` + runner 注册。\n\n选型：个人/开源项目 GitHub Actions 最省事；企业内网/传统环境 Jenkins 常见。',
 '["Jenkins 主从架构是什么？", "actions 里怎么用缓存加速？"]', '["工具", "高频"]', 4, '["devops"]'),

(7, 'QA', 2, '什么是制品库（Artifact Registry）？为什么需要它？', NULL,
 '制品库统一存储构建产物：jar 包（Nexus/Artifactory）、**镜像**（Harbor）。\n\n为什么需要：\n1. **制品不可变 + 可追溯**：同一个版本在任何环境部署的都是同一个制品（避免"开发说没问题，生产重新构建又不一样"）\n2. **不依赖外部源**：内网拉包快、不被墙（Maven 私服）\n3. **权限与审计**：谁能推生产镜像，有记录\n4. **漏洞扫描**：Harbor 内置 trivy 扫镜像 CVE\n5. 保留历史版本用于**回滚**：回滚 = 重新部署上一个 tag 的镜像，而不是重新构建\n\n实践：镜像 tag = `git短hash-日期`，生产部署清单里记录当前 tag。',
 '["为什么生产禁止 latest 标签？", "Harbor 的漏洞扫描怎么用？"]', '["制品", "高频"]', 4, '["devops"]'),

(7, 'QA', 2, '蓝绿发布、灰度发布（金丝雀）、滚动发布的区别？', NULL,
 '- **滚动发布**：新旧批次逐批替换（K8s Deployment 默认）。省资源、自动；但新旧共存时间长、出问题影响面渐进扩大\n- **蓝绿发布**：两套完整环境（蓝=旧 绿=新），新版本在绿环境验证后**切流量**（改 LB 指向）。秒级切换、秒级回滚；代价是双倍资源\n- **灰度/金丝雀**：新版本先放**小比例真实流量**（1%→10%→50%→100%），观察指标无异常再放量。风险最小、可结合用户分组（内部员工先吃自己的狗粮）\n\n生产组合：K8s 滚动 + readiness 保证不断流 + **灰度放量**（ingress 权重/网关规则）+ 监控指标护航。\n\n回滚速度对比：蓝绿最快（切流量），滚动需重滚，灰度本身就是逐步收缩。',
 '["灰度按什么维度切流量？", "发布期间怎么判断该不该回滚？"]', '["发布", "必考"]', 5, '["devops", "sre"]'),

(7, 'QA', 2, '上线后发现问题，怎么快速回滚？', NULL,
 '原则：**回滚要快、要演练过**，先止血再查根因。\n\nK8s：\n```\nkubectl rollout undo deploy/api --to-revision=2\nkubectl rollout status deploy/api   # 确认回滚完成\n```\n传统部署：\n- 部署前保留上一版本目录（`/opt/app/releases/v1.2.2`），软链接切换 + reload\n- 数据库变更**必须向后兼容**（先加列后删列、分两次发布），否则回滚代码对不上表结构\n\n预防机制：\n- 制品库保留全部历史版本（回滚=重部署旧制品）\n- 回滚脚本化，一键执行\n- 数据库 migration 也纳入版本管理（Flyway），破坏性变更拆开发布\n\n加分：说出"回滚不是失败，是标准应急动作；怕的是不敢回滚和回滚不兼容 DB"。',
 '["哪些变更不能直接回滚？", "回滚后怎么防再次发生？"]', '["发布", "高频"]', 4, '["devops", "sre"]'),

(7, 'QA', 1, '你们团队的 Git 分支模型是怎样的？', NULL,
 '中小团队主流是**简化版 GitFlow / 主干开发**：\n\n- `main`：永远可发布，受保护（PR + CI 通过才能合）\n- `develop`（可选）：集成分支\n- `feature/xxx`：功能分支，从 main 拉出，完成后 PR 合回\n- `hotfix/xxx`：生产紧急修复，从 main 拉出，修完合回 main 并打 tag\n- `release/x.y`：发布分支（有版本管理需求时）\n\n配套规范：\n- 分支保护：禁止直接 push main，必须 PR + 至少 1 人 review + CI 绿\n- commit message 规范：`feat/fix/chore/refactor: 描述`（Conventional Commits）\n- tag 对应发布版本，CI 按 tag 出正式制品',
 '["trunk-based 和 gitflow 怎么选？", "commit message 规范有什么用？"]', '["Git", "高频"]', 4, '["devops"]');
