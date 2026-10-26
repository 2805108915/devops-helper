// 知识库新功能端到端测试（UTF-8 保证中文正确）
const B = 'http://127.0.0.1:9800/api'

async function api(method, path, body) {
  const res = await fetch(B + path, {
    method,
    headers: { 'Content-Type': 'application/json' },
    body: body ? JSON.stringify(body) : undefined
  })
  return res.json()
}

const ok = (name, cond, extra = '') =>
  console.log((cond ? '✅' : '❌') + ' ' + name + (extra ? ' | ' + extra : ''))

async function main() {
  // 1. 新建分组
  const g = await api('POST', '/topics', { name: '我的收藏分组' })
  ok('新建自定义分组', g.code === 0 && g.data.id > 0, 'id=' + g.data?.id)
  const gid = g.data.id

  // 2. 重复名拒绝
  const dup = await api('POST', '/topics', { name: '我的收藏分组' })
  ok('重复分组名被拒绝', dup.code !== 0, dup.msg)

  // 3. 建文章 → 改两次 → 历史应有2条
  const a = await api('POST', '/kb', { topicId: gid, title: '历史测试文', contentMd: 'v1内容' })
  ok('创建文章', a.code === 0, 'id=' + a.data?.id)
  const aid = a.data.id
  await api('PUT', `/kb/${aid}`, { topicId: gid, title: '历史测试文', contentMd: 'v2内容' })
  await api('PUT', `/kb/${aid}`, { topicId: gid, title: '历史测试文改题', contentMd: 'v3内容' })
  const h = await api('GET', `/kb/${aid}/history`)
  ok('修改历史自动存档', h.code === 0 && h.data.length === 2, '共' + h.data.length + '条(改2次)')
  ok('历史含修改时间', h.data.length === 2 && !!h.data[0].savedAt, '最新存档时间: ' + h.data[0]?.savedAt)

  // 4. 回滚到最早版本（v1内容），当前v3也先入档
  const oldest = h.data[h.data.length - 1]
  const r = await api('POST', `/kb/${aid}/history/${oldest.id}/restore`)
  ok('回滚到最早版本', r.code === 0 && r.data.contentMd === 'v1内容', '内容=' + r.data?.contentMd)
  const h2 = await api('GET', `/kb/${aid}/history`)
  ok('回滚前版本也被存档(可撤销)', h2.data.length === 3, '现在' + h2.data.length + '条')

  // 5. 有文章的分组不可删
  const delBlocked = await api('DELETE', `/topics/${gid}`)
  ok('非空分组删除被拦截', delBlocked.code !== 0, delBlocked.msg)

  // 6. 删文章(连历史) → 删空分组成功
  const d1 = await api('DELETE', `/kb/${aid}`)
  ok('删除文章', d1.code === 0)
  const d2 = await api('DELETE', `/topics/${gid}`)
  ok('空分组删除成功', d2.code === 0)
}

main().catch(e => { console.error('测试异常:', e.message); process.exit(1) })
