<template>
  <div class="study" v-if="q">
    <!-- 顶部条 -->
    <div class="study-bar">
      <el-button @click="exit" :icon="ArrowLeft">退出刷题</el-button>
      <div class="bar-tags">
        <el-tag size="small" type="info">{{ store.topicName(q.topicId) }}</el-tag>
        <el-tag size="small" :type="{ QA: '', SCENARIO: 'warning', CHOICE: 'success' }[q.type]">
          {{ { QA: '问答', SCENARIO: '场景排障', CHOICE: '选择' }[q.type] || q.type }}
        </el-tag>
        <el-tag size="small" :type="['', 'success', 'warning', 'danger'][q.difficulty]">
          {{ ['', '初级', '中级', '高级'][q.difficulty] }}
        </el-tag>
        <el-tag v-if="q.frequency >= 5" size="small" type="danger" effect="dark">高频必考</el-tag>
      </div>
      <div class="spacer" />
      <span class="pos">{{ index + 1 }} / {{ ids.length }}</span>
    </div>

    <!-- 题目区 -->
    <el-card class="page-card">
      <div class="q-title">{{ q.title }}</div>
      <div v-if="q.content" class="q-scenario">{{ q.content }}</div>
      <div v-if="q.options?.length" class="q-options">
        <div v-for="(o, i) in q.options" :key="i" class="option"
             :class="{ selected: selectedOption === i, correct: showAnswer && isCorrect(i) }"
             @click="selectedOption = i">{{ o }}</div>
      </div>
      <el-button v-if="q.options?.length && !showAnswer" type="primary" plain @click="showAnswer = true">确认选择，看答案</el-button>
    </el-card>

    <!-- 答案区 -->
    <el-card class="page-card">
      <div class="sec-title">✅ 参考答案</div>
      <el-button v-if="!showAnswer" type="primary" @click="showAnswer = true">先想一想，再显示答案</el-button>
      <template v-else>
        <MdPreview :modelValue="q.answer || '（无参考答案）'" />
        <div v-if="q.followUps?.length" class="followups">
          <div class="sec-title">🎤 面试官可能的追问</div>
          <ul>
            <li v-for="(f, i) in q.followUps" :key="i">{{ f }}</li>
          </ul>
        </div>
      </template>
    </el-card>

    <!-- 面试语境 -->
    <el-card class="page-card">
      <div class="sec-title">💼 出题语境（面试官视角）</div>
      <div class="context">{{ interviewContext }}</div>
      <div class="ctx-tags">
        <el-tag v-for="t in q.tags || []" :key="t" size="small" effect="plain">{{ t }}</el-tag>
      </div>
      <div class="ctx-positions">
        常见于：
        <el-tag v-for="p in positionNames" :key="p" size="small" type="info" effect="plain">{{ p }}</el-tag>
        的面试
      </div>
    </el-card>

    <!-- 相关知识点 -->
    <el-card class="page-card" v-if="detail.relatedArticles?.length">
      <div class="sec-title">📚 相关知识点</div>
      <div>本题考查 <b>{{ store.topicName(q.topicId) }}</b>，延伸阅读：</div>
      <div class="rel-articles">
        <el-button v-for="a in detail.relatedArticles" :key="a.id" size="small" @click="$router.push({ path: '/knowledge', query: { articleId: a.id } })">
          📄 {{ a.title }}
        </el-button>
      </div>
    </el-card>

    <!-- 笔记 + 自评 -->
    <el-card class="page-card">
      <div class="sec-title">📝 我的笔记（自动保存）</div>
      <el-input v-model="note" type="textarea" :rows="3" placeholder="记录你的理解、口诀、踩坑..." />
      <div class="assess">
        <span class="assess-label">自评：</span>
        <el-button :type="lastQuality === 1 ? 'danger' : ''" size="small" @click="assess(1)">❌ 不会</el-button>
        <el-button :type="lastQuality === 3 ? 'warning' : ''" size="small" @click="assess(3)">🤔 模糊</el-button>
        <el-button :type="lastQuality === 5 ? 'success' : ''" size="small" @click="assess(5)">✅ 会</el-button>
        <span v-if="assessMsg" class="assess-msg">{{ assessMsg }}</span>
      </div>
    </el-card>

    <!-- 底部导航 -->
    <div class="nav-bar">
      <el-button size="large" :disabled="!hasPrev" @click="go(prevId)">⬅ 上一题</el-button>
      <el-button size="large" type="warning" plain @click="exit">退出</el-button>
      <el-button size="large" type="primary" :disabled="!hasNext" @click="go(nextId)">下一题 ➡</el-button>
    </div>
  </div>
  <div v-else class="study-loading"><el-skeleton :rows="6" animated /></div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import { ArrowLeft } from '@element-plus/icons-vue'
import { MdPreview } from 'md-editor-v3'
import 'md-editor-v3/lib/preview.css'
import api from '../api'
import { useAppStore } from '../stores/app'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()
const store = useAppStore()

const detail = ref(null)
const q = computed(() => detail.value?.question)
const ids = ref([])
const index = computed(() => ids.value.indexOf(Number(route.params.id)))
const showAnswer = ref(false)
const selectedOption = ref(-1)
const note = ref('')
const assessMsg = ref('')
const lastQuality = ref(null)

const prevId = computed(() => (index.value > 0 ? ids.value[index.value - 1] : null))
const nextId = computed(() => (index.value < ids.value.length - 1 ? ids.value[index.value + 1] : null))
const hasPrev = computed(() => prevId.value != null)
const hasNext = computed(() => nextId.value != null)

const positionNames = computed(() => ({
  'junior-ops': '初级运维', 'devops': 'DevOps工程师', 'sre': 'SRE', 'cloud': '云计算工程师'
}))

const interviewContext = computed(() => {
  if (!q.value) return ''
  const topic = store.topicName(q.value.topicId)
  const diff = ['', '基础送分题（答不好直接减分）', '中档题（区分候选人水平的关键）', '高阶压轴题（答好可加分定级）'][q.value.difficulty] || ''
  const freq = q.value.frequency >= 5 ? '属于高频必考题，出现率极高' : q.value.frequency >= 4 ? '较常出现' : '偶有考察'
  const typeText = q.value.type === 'SCENARIO'
    ? '面试官想看你真实的排查思路和动手能力，建议按「定位 → 原因 → 处理 → 预防」四步作答'
    : '面试官在考察知识体系的完整度，先给结论再展开细节'
  return `本题出自「${topic}」方向，${diff}，${freq}。${typeText}。`
})

async function loadIds() {
  if (store.questionIds.length) { ids.value = store.questionIds; return }
  const data = await api.questions({ page: 1, size: 2000 })
  ids.value = data.records.map(r => r.id)
}

async function load() {
  showAnswer.value = false
  selectedOption.value = -1
  assessMsg.value = ''
  lastQuality.value = null
  detail.value = await api.questionDetail(Number(route.params.id))
  note.value = detail.value.note?.content || ''
  if (detail.value.review) lastQuality.value = detail.value.review.quality
}

function isCorrect(i) {
  const ans = q.value.answer || ''
  return ans.trim().toUpperCase().startsWith(String.fromCharCode(65 + i))
}

let saveTimer = null
watch(note, () => {
  if (!detail.value?.question) return
  clearTimeout(saveTimer)
  saveTimer = setTimeout(() => {
    api.saveNote({ targetType: 'question', targetId: detail.value.question.id, content: note.value }).catch(() => {})
  }, 800)
})

async function assess(quality) {
  const res = await api.review(detail.value.question.id, quality)
  lastQuality.value = quality
  assessMsg.value = `已记录，下次复习：${res.nextReviewAt.replace('T', ' ').slice(0, 16)}`
}

function go(id) {
  if (id == null) return
  router.replace(`/study/${id}`)
}

function exit() {
  store.questionIds = ids.value
  router.push('/questions')
}

watch(() => route.params.id, () => { if (route.name === 'study') load() })

onMounted(async () => {
  await store.loadTopics()
  await loadIds()
  load()
})
</script>

<style scoped>
.study { padding-bottom: 70px; }
.study-loading { padding: 30px; background: #fff; border-radius: 6px; }
.study-bar { display: flex; gap: 12px; align-items: center; margin-bottom: 12px; }
.bar-tags { display: flex; gap: 6px; }
.spacer { flex: 1; }
.pos { color: #909399; font-size: 14px; }
.q-title { font-size: 17px; font-weight: 600; line-height: 1.7; white-space: pre-wrap; }
.q-scenario { margin-top: 10px; background: #f7f9fc; padding: 12px; border-radius: 6px; white-space: pre-wrap; color: #555; line-height: 1.8; }
.q-options { margin: 14px 0; display: grid; gap: 8px; }
.option { padding: 10px 14px; border: 1px solid #dcdfe6; border-radius: 6px; cursor: pointer; }
.option:hover { border-color: #409eff; }
.option.selected { border-color: #409eff; background: #ecf5ff; }
.option.correct { border-color: #67c23a; background: #f0f9eb; }
.sec-title { font-weight: 600; margin-bottom: 10px; }
.followups ul { padding-left: 18px; line-height: 2; color: #555; }
.context { line-height: 1.9; color: #444; }
.ctx-tags { margin-top: 10px; display: flex; gap: 6px; flex-wrap: wrap; }
.ctx-positions { margin-top: 8px; color: #909399; font-size: 13px; display: flex; gap: 6px; align-items: center; flex-wrap: wrap; }
.rel-articles { margin-top: 10px; display: flex; gap: 8px; flex-wrap: wrap; }
.assess { margin-top: 12px; display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }
.assess-label { color: #606266; font-size: 14px; }
.assess-msg { color: #67c23a; font-size: 13px; }
.nav-bar { position: fixed; bottom: 0; left: 210px; right: 0; background: #fff; border-top: 1px solid #ebeef5; padding: 10px 24px; display: flex; gap: 14px; justify-content: center; z-index: 10; box-shadow: 0 -2px 8px rgba(0,0,0,.04); }
</style>
