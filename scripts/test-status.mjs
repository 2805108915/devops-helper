// 题目状态标记端到端测试：标记→查询状态→重置→未学
const B = 'http://127.0.0.1:9800/api'
const ok = (name, cond, extra = '') => console.log((cond ? '✅' : '❌') + ' ' + name + (extra ? ' | ' + extra : ''))

async function api(method, path, body) {
  const res = await fetch(B + path, {
    method, headers: { 'Content-Type': 'application/json' },
    body: body ? JSON.stringify(body) : undefined
  })
  return res.json()
}

async function main() {
  const qid = 500
  // 初始：重置到未学
  await api('DELETE', `/review/${qid}`)
  let d = await api('GET', `/questions/${qid}`)
  ok('初始状态=未学(无复习记录)', d.data.review == null)

  // 标记掌握(5)
  let r = await api('POST', `/review/${qid}`, { quality: 5 })
  ok('标记掌握成功', r.code === 0 && r.data.nextReviewAt, '下次复习 ' + r.data?.nextReviewAt?.slice(0, 10))
  d = await api('GET', `/questions/${qid}`)
  ok('状态变为掌握(quality=5)', d.data.review?.quality === 5)

  // 改标模糊(3)
  r = await api('POST', `/review/${qid}`, { quality: 3 })
  d = await api('GET', `/questions/${qid}`)
  ok('改标模糊(quality=3)', d.data.review?.quality === 3)

  // 列表页 reviewState 同步
  const list = await api('GET', `/questions?page=1&size=20&keyword=${encodeURIComponent(d.data.question.title.slice(0, 6))}`)
  const item = list.data.records.find(x => x.id === qid)
  ok('题库列表状态标签同步', item?.reviewState?.latestQuality === 3)

  // 重置为未学
  r = await api('DELETE', `/review/${qid}`)
  ok('重置接口成功', r.code === 0)
  d = await api('GET', `/questions/${qid}`)
  ok('重置后=未学(记录已删)', d.data.review == null)
}

main().catch(e => { console.error('异常:', e.message); process.exit(1) })
