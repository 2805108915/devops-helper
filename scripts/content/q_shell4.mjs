// shell4/nginx4/docker4/k8s4/cicd4/monitor4/mysql4/mw4 快问快答合集按主题拆分
export const Q = [
  { t: 'C', d: 1, q: 'head -c 100 f 的作用？', o: ['A. 前100字节', 'B. 前100行', 'C. 第100行', 'D. 后100字节'], a: 'A。-c 字节 -n 行。二进制截取分析用。', g: ['基础'] },
  { t: 'C', d: 1, q: '命令行补全快捷键？', o: ['A. Tab', 'B. Ctrl+K', 'C. Esc', 'D. F1'], a: 'A。双 Tab 列候选；Ctrl+R 搜历史。', g: ['基础'] },
  { t: 'C', d: 2, q: 'grep -A3 -B1 "ERR" f 的含义？', o: ['A. 匹配行后3行前1行（看异常栈上下文）', 'B. 前3后1行数', 'C. 计数', 'D. 排除'], a: 'A。查错误上下文的黄金参数。', g: ['grep', '必背'] },
  { t: 'C', d: 2, q: 'ls | xargs rm 与 ls | xargs -n1 rm 的差别场景？', o: ['A. 后者每文件一次rm（参数超长保护）', 'B. 相同', 'C. 前者安全', 'D. 后者慢必用'], a: 'A。文件多时一次传参超限；-n 分批更稳。空格名文件用 -d "\\n" 或 find -print0。', g: ['xargs'] },
  { t: 'C', d: 2, q: 'sort -t: -k3 -n /etc/passdu 按？', o: ['A. 冒号第3列（UID）数值排', 'B. 字符串排', 'C. 行号', 'D. 逆序'], a: 'A。-t分隔 -k列 -n数值。', g: ['sort'] },
  { t: 'C', d: 3, q: 'eval 的作用与风险？', o: ['A. 把变量内容当代码执行（动态拼接）——注入风险慎用', 'B. 求值数学', 'C. 调试', 'D. 无作用'], a: 'A。多数场景有更安全的替代（数组/函数）。', g: ['进阶', '安全'] },
  { t: 'QA', d: 2, q: '一条命令：把 /etc/passwd 中所有使用 nologin shell 的用户名列出。', a: '```bash\ngrep nologin /etc/passwd | cut -d: -f1\n# 或 awk -F: \'/nologin/{print $1}\' /etc/passwd\n```\n账号审计基础命令。', g: ['实战'] },
  { t: 'QA', d: 2, q: '如何统计一个目录下各扩展名文件的数量 TOP5？', a: '```bash\nfind /path -type f | sed \'s/.*\\.//\' | sort | uniq -c | sort -rn | head -5\n```\n无扩展名会出杂项，可 grep -v 排除。', g: ['实战'] },
  { t: 'QA', d: 3, q: 'set -e 与管道的组合陷阱是什么？怎么解决？', a: '陷阱：set -e 只看管道**最后一条**退出码——`false | true` 不退出。\n解决：set -o pipefail（任一环节失败即失败）。生产模板标配 -euo pipefail 三连。', g: ['健壮性', '必考'] },
  { t: 'QA', d: 3, q: '写一个函数：重试某命令最多3次（间隔2秒）。', a: '```bash\nretry() {\n  local n=0\n  until "$@"; do\n    n=$((n+1)); [ $n -ge 3 ] && return 1\n    sleep 2\n  done\n}\nretry curl -sf http://x/health\n```\n网络类操作重试+幂等意识是发布脚本基础件。', g: ['实战'] },
]
