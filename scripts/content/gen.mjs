// 内容生成器：把各主题数据文件渲染成 Flyway SQL 与 Lab YAML
// 用法: node scripts/content/gen.mjs
import { writeFileSync, mkdirSync, readdirSync, unlinkSync } from 'node:fs'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'
import { createRequire } from 'node:module'

const require = createRequire(import.meta.url)
const root = resolve(dirname(fileURLToPath(import.meta.url)), '../..')
const out = []

const topicCode = {
  linux: 1, network: 2, shell: 3, nginx: 4, docker: 5, k8s: 6, cicd: 7, monitor: 8, mysql: 9, mw: 10, cloud: 11
}
// 补充数据文件别名：q_linux2.mjs → linux
const alias = { linux2: 'linux', network2: 'network', shell2: 'shell', nginx2: 'nginx', docker2: 'docker', k8s2: 'k8s', cicd2: 'cicd', monitor2: 'monitor', mysql2: 'mysql', mw2: 'mw', linux3: 'linux', network3: 'network', shell3: 'shell', nginx3: 'nginx', docker3: 'docker', k8s3: 'k8s', cicd3: 'cicd', monitor3: 'monitor', mysql3: 'mysql', mw3: 'mw', linux4: 'linux', network4: 'network', shell4: 'shell', nginx4: 'nginx', docker4: 'docker', k8s4: 'k8s', cicd4: 'cicd', monitor4: 'monitor', mysql4: 'mysql', mw4: 'mw', misc: 'linux', cloud2: 'cloud', cloud3: 'cloud' }

const esc = s => String(s ?? '').replace(/'/g, "''")
const jstr = v => `'` + JSON.stringify(v ?? null).replace(/'/g, "''").replace(/"/g, '\\"') + `'`

function questionValue(topic, q) {
  const type = { QA: 'QA', C: 'CHOICE', S: 'SCENARIO' }[q.t] || q.t
  const options = q.o ? jstr(q.o) : 'NULL'
  const content = q.c ? `'${esc(q.c)}'` : 'NULL'
  const fu = q.fu ? jstr(q.fu) : 'NULL'
  const tags = jstr(q.g || [])
  const pos = jstr(q.p || ['junior-ops', 'devops', 'sre'])
  const src = q.src || '内置'
  return `(${topic}, '${type}', ${q.d || 2}, '${esc(q.q)}', ${content}, ${options}, '${esc(q.a)}', ${fu}, ${tags}, ${q.f || 3}, ${pos}, '${src}')`
}

// ---------- 题库 ----------
const topicFiles = readdirSync(resolve(root, 'scripts/content')).filter(f => /^q_/.test(f))
let qTotal = 0
const qBatches = {}
for (const f of topicFiles) {
  const mod = await import('./' + f)
  const raw = f.replace(/^q_/, '').replace(/\.mjs$/, '')
  const code = alias[raw] || raw
  const tid = topicCode[code]
  if (!tid) throw new Error('未知主题: ' + f)
  if (!mod.Q?.length) throw new Error(f + ' 无题目')
  qTotal += mod.Q.length
  for (const q of mod.Q) {
    const t2 = topicCode[q.to] || tid   // 条目可用 to 字段覆盖主题
    qBatches[q.to || code] = [...(qBatches[q.to || code] || []), questionValue(t2, q)]
  }
}
// 云计算批次分流到 V16（V14 已应用，Flyway 校验和限制不可再改）
const cloudValues = qBatches['cloud'] || []
delete qBatches['cloud']

let sql = '-- 自动生成（scripts/content/gen.mjs），请勿手改\n'
for (const [code, values] of Object.entries(qBatches)) {
  sql += `\nINSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES\n${values.join(',\n')};\n`
}

// ---------- 知识库 ----------
const kbMod = await import('./kb_data.mjs')
let kbTotal = 0
const kbValues = []
for (const art of kbMod.ARTICLES) {
  if (!topicCode[art.t]) throw new Error('KB 未知主题: ' + art.t)
  kbValues.push(`(${topicCode[art.t]}, '${esc(art.title)}', '${esc(art.md)}')`)
  kbTotal++
}
sql += `\nINSERT INTO kb_article (topic_id, title, content_md) VALUES\n${kbValues.join(',\n')};\n`
writeFileSync(resolve(root, 'backend/src/main/resources/db/migration/V14__expand_content.sql'), sql)

// 云计算：新知识点 + 题目（独立迁移 V16）
if (cloudValues.length) {
  let sql16 = '-- 自动生成（scripts/content/gen.mjs），请勿手改\n'
  sql16 += `\nINSERT INTO topic (id, code, name, description, icon, sort_order, builtin) VALUES (11, 'cloud', '云计算', '云产品与云上架构运维（VPC/OSS/CDN/RDS/负载均衡/弹性/安全/成本/IaC）', 'Cloud', 11, 1);\n`
  sql16 += `\nINSERT INTO question (topic_id, type, difficulty, title, content, options, answer, follow_ups, tags, frequency, position_codes, source) VALUES\n${cloudValues.join(',\n')};\n`
  writeFileSync(resolve(root, 'backend/src/main/resources/db/migration/V16__cloud_content.sql'), sql16)
}

// ---------- Labs ----------
const labMod1 = await import('./labs_data.mjs')
const labMod2 = await import('./labs_data2.mjs')
const allLabs = [...(labMod1.LABS || []), ...(labMod2.LABS2 || [])]
const seen = new Set()
for (const L of allLabs) {
  if (seen.has(L.code)) throw new Error('Lab code 重复: ' + L.code)
  seen.add(L.code)
}
const defDir = resolve(root, 'labs/definitions')
for (const f of readdirSync(defDir)) if (/^x/.test(f)) unlinkSync(resolve(defDir, f))

const y = s => String(s).replace(/\r/g, '')
const block = s => '|\n' + y(s).split('\n').map(l => '  ' + l).join('\n').replace(/\s+$/, '')
function labYaml(L) {
  let s = `code: ${L.code}\nname: ${L.name}\ntopic: ${L.topic}\ndifficulty: ${L.d}\nsortOrder: ${L.sort}\ntags: [${(L.g || []).join(', ')}]\ntimeLimitMinutes: ${L.mins || 45}\n`
  s += `scenario: ${block(L.scenario)}\nsetup: ${block(L.setup)}\ncheck: ${block(L.check)}\n`
  s += `hints:\n${(L.hints || []).map(h => '  - ' + h).join('\n')}\n`
  s += `solution: ${block(L.solution)}\n`
  return s
}
let labTotal = 0
for (const L of allLabs) {
  if (!topicCode[L.topic]) throw new Error('Lab 未知主题: ' + L.topic + ' ' + L.code)
  if (!/^[a-z0-9-]+$/.test(L.code)) throw new Error('Lab code 非法: ' + L.code)
  writeFileSync(resolve(defDir, `x${String(L.sort).padStart(3, '0')}-${L.code}.yml`), labYaml(L))
  labTotal++
}

console.log(`✅ 题目 +${qTotal}  知识库 +${kbTotal}  Labs +${labTotal}`)
