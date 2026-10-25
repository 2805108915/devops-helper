<template>
  <div>
    <el-card class="page-card">
      <div class="filter-bar">
        <el-select v-model="query.topicId" placeholder="知识点" clearable style="width: 160px" @change="load(1)">
          <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
        </el-select>
        <el-select v-model="query.type" placeholder="题型" clearable style="width: 130px" @change="load(1)">
          <el-option label="问答" value="QA" />
          <el-option label="场景排障" value="SCENARIO" />
        </el-select>
        <el-select v-model="query.difficulty" placeholder="难度" clearable style="width: 110px" @change="load(1)">
          <el-option label="初级" :value="1" />
          <el-option label="中级" :value="2" />
          <el-option label="高级" :value="3" />
        </el-select>
        <el-select v-model="query.positionCode" placeholder="岗位" clearable style="width: 150px" @change="load(1)">
          <el-option label="初级运维" value="junior-ops" />
          <el-option label="DevOps" value="devops" />
          <el-option label="SRE" value="sre" />
          <el-option label="云计算" value="cloud" />
        </el-select>
        <el-input v-model="query.keyword" placeholder="搜索题干关键词" clearable style="width: 200px"
                  @keyup.enter="load(1)" @clear="load(1)" />
        <el-select v-model="query.order" style="width: 130px" @change="load(1)">
          <el-option label="高频优先" value="frequency" />
          <el-option label="随机" value="random" />
          <el-option label="最新" value="newest" />
        </el-select>
        <el-checkbox v-model="wrongOnly" @change="load(1)">只看错题</el-checkbox>
        <div class="spacer" />
        <el-button type="primary" @click="openCreate">+ 录入题目</el-button>
      </div>
    </el-card>

    <el-card class="page-card">
      <div v-if="list.length === 0 && !loading" class="empty">暂无题目，换个条件试试</div>
      <div v-for="q in list" :key="q.id" class="q-item" @click="openDetail(q.id)">
        <div class="q-main">
          <el-tag size="small" :type="typeTag(q.type)">{{ typeText(q.type) }}</el-tag>
          <el-tag size="small" type="info">{{ store.topicName(q.topicId) }}</el-tag>
          <el-tag size="small" :type="diffTag(q.difficulty)">{{ '★'.repeat(q.difficulty) }}</el-tag>
          <el-tag v-if="q.frequency >= 5" size="small" type="danger" effect="dark">高频</el-tag>
          <span class="q-title">{{ q.title }}</span>
        </div>
        <div class="q-side">
          <el-tag v-if="q.reviewState" :type="qualityTag(q.reviewState.latestQuality)" size="small">
            {{ qualityText(q.reviewState.latestQuality) }}
          </el-tag>
          <el-tag v-else size="small" type="info" effect="plain">未学</el-tag>
        </div>
      </div>
      <el-pagination v-if="total > query.size" layout="prev, pager, next, total" :total="total"
                     :page-size="query.size" :current-page="query.page" @current-change="load"
                     style="margin-top: 12px; justify-content: center" />
    </el-card>

    <!-- 题目详情抽屉 -->
    <el-drawer v-model="detailVisible" size="52%" :title="detail?.question?.title || '题目详情'">
      <div v-if="detail" class="detail">
        <div class="meta">
          <el-tag :type="typeTag(detail.question.type)">{{ typeText(detail.question.type) }}</el-tag>
          <el-tag type="info">{{ store.topicName(detail.question.topicId) }}</el-tag>
          <el-tag :type="diffTag(detail.question.difficulty)">{{ diffText(detail.question.difficulty) }}</el-tag>
          <el-tag v-for="t in detail.question.tags || []" :key="t" effect="plain" size="small">{{ t }}</el-tag>
        </div>

        <div v-if="detail.question.content" class="block scenario">
          <div class="block-title">背景场景</div>
          <MdPreview :modelValue="detail.question.content" />
        </div>

        <div v-if="detail.question.options?.length" class="block">
          <div class="block-title">选项</div>
          <div v-for="(o, i) in detail.question.options" :key="i" class="option">{{ o }}</div>
        </div>

        <div class="block">
          <div class="block-title">参考答案</div>
          <el-button v-if="!showAnswer" type="primary" plain @click="showAnswer = true">先想一想，再显示答案</el-button>
          <MdPreview v-else :modelValue="detail.question.answer || '（无参考答案）'" />
        </div>

        <div v-if="showAnswer && detail.question.followUps?.length" class="block">
          <div class="block-title">面试官可能的追问</div>
          <ul class="followups">
            <li v-for="(f, i) in detail.question.followUps" :key="i">{{ f }}</li>
          </ul>
        </div>

        <div class="block">
          <div class="block-title">我的笔记</div>
          <el-input v-model="note" type="textarea" :rows="3" placeholder="记录你的理解、口诀、踩坑（自动保存）" />
        </div>

        <div v-if="detail.relatedArticles?.length" class="block">
          <div class="block-title">相关知识库</div>
          <el-button v-for="a in detail.relatedArticles" :key="a.id" size="small" @click="goKb(a.id)">
            📄 {{ a.title }}
          </el-button>
        </div>

        <div class="block assess">
          <div class="block-title">自评（进入间隔复习计划）</div>
          <div class="assess-btns">
            <el-button type="danger" @click="assess(1)">❌ 不会</el-button>
            <el-button type="warning" @click="assess(3)">🤔 模糊</el-button>
            <el-button type="success" @click="assess(5)">✅ 会</el-button>
          </div>
          <div v-if="lastAssessMsg" class="assess-msg">{{ lastAssessMsg }}</div>
        </div>

        <div class="block actions">
          <el-button v-if="detail.question.source === '自建'" size="small" @click="openEdit">编辑</el-button>
          <el-button v-if="detail.question.source === '自建'" size="small" type="danger" @click="remove">删除</el-button>
        </div>
      </div>
    </el-drawer>

    <!-- 录入/编辑题目 -->
    <el-dialog v-model="formVisible" :title="form.id ? '编辑题目' : '录入题目'" width="640px">
      <el-form label-width="80px">
        <el-form-item label="知识点">
          <el-select v-model="form.topicId" placeholder="选择知识点">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="题型">
          <el-radio-group v-model="form.type">
            <el-radio value="QA">问答</el-radio>
            <el-radio value="SCENARIO">场景排障</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="难度">
          <el-rate v-model="form.difficulty" :max="3" />
        </el-form-item>
        <el-form-item label="题干">
          <el-input v-model="form.title" type="textarea" :rows="2" />
        </el-form-item>
        <el-form-item label="背景">
          <el-input v-model="form.content" type="textarea" :rows="2" placeholder="场景题的场景描述（可选）" />
        </el-form-item>
        <el-form-item label="参考答案">
          <el-input v-model="form.answer" type="textarea" :rows="6" placeholder="支持 Markdown" />
        </el-form-item>
        <el-form-item label="追问">
          <el-input v-model="followUpsText" type="textarea" :rows="2" placeholder="一行一个追问" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="formVisible = false">取消</el-button>
        <el-button type="primary" @click="save">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { MdPreview } from 'md-editor-v3'
import 'md-editor-v3/lib/preview.css'
import api from '../api'
import { useAppStore } from '../stores/app'
import { useRouter } from 'vue-router'

const store = useAppStore()
const router = useRouter()
const topics = ref([])
const list = ref([])
const total = ref(0)
const loading = ref(false)
const wrongOnly = ref(false)
const query = reactive({ topicId: null, type: null, difficulty: null, keyword: '', positionCode: null, order: 'frequency', page: 1, size: 20 })

const detailVisible = ref(false)
const detail = ref(null)
const showAnswer = ref(false)
const note = ref('')
const lastAssessMsg = ref('')

const formVisible = ref(false)
const form = reactive({ id: null, topicId: null, type: 'QA', difficulty: 1, title: '', content: '', answer: '' })
const followUpsText = ref('')

async function load(page = query.page) {
  query.page = page
  loading.value = true
  try {
    const data = await api.questions({ ...query, wrongOnly: wrongOnly.value || undefined })
    list.value = data.records
    total.value = data.total
  } finally {
    loading.value = false
  }
}

async function openDetail(id) {
  detail.value = await api.questionDetail(id)
  showAnswer.value = false
  note.value = detail.value.note?.content || ''
  lastAssessMsg.value = ''
}

watch(note, () => {
  if (detail.value) {
    clearTimeout(saveTimer)
    saveTimer = setTimeout(async () => {
      await api.saveNote({ targetType: 'question', targetId: detail.value.question.id, content: note.value })
    }, 800)
  }
})
let saveTimer = null

async function assess(quality) {
  const res = await api.review(detail.value.question.id, quality)
  lastAssessMsg.value = `已记录！下次复习时间：${res.nextReviewAt.replace('T', ' ').slice(0, 16)}`
  ElMessage.success(quality < 3 ? '已加入错题，明天再见' : '很好，按计划复习')
  load()
}

function openCreate() {
  Object.assign(form, { id: null, topicId: query.topicId, type: 'QA', difficulty: 1, title: '', content: '', answer: '' })
  followUpsText.value = ''
  formVisible.value = true
}

function openEdit() {
  const q = detail.value.question
  Object.assign(form, { id: q.id, topicId: q.topicId, type: q.type, difficulty: q.difficulty, title: q.title, content: q.content || '', answer: q.answer || '' })
  followUpsText.value = (q.followUps || []).join('\n')
  formVisible.value = true
}

async function save() {
  const data = { ...form, followUps: followUpsText.value.split('\n').map(s => s.trim()).filter(Boolean), source: '自建' }
  if (form.id) {
    await api.updateQuestion(form.id, data)
  } else {
    await api.createQuestion(data)
  }
  ElMessage.success('已保存')
  formVisible.value = false
  load()
}

async function remove() {
  await ElMessageBox.confirm('确认删除这道题目？', '删除', { type: 'warning' })
  await api.deleteQuestion(detail.value.question.id)
  detailVisible.value = false
  load()
}

function goKb(articleId) {
  router.push({ path: '/knowledge', query: { articleId } })
}

const typeText = t => ({ QA: '问答', SCENARIO: '场景', CHOICE: '选择' }[t] || t)
const typeTag = t => (t === 'SCENARIO' ? 'warning' : '')
const diffText = d => ['', '初级', '中级', '高级'][d]
const diffTag = d => ['', 'success', 'warning', 'danger'][d]
const qualityText = q => (q < 3 ? '生疏' : q < 5 ? '模糊' : '掌握')
const qualityTag = q => (q < 3 ? 'danger' : q < 5 ? 'warning' : 'success')

onMounted(async () => {
  await store.loadTopics()
  topics.value = store.topics
  // 支持从岗位页带入筛选
  const pf = store.questionFilter
  if (pf && Object.keys(pf).length) {
    Object.assign(query, pf)
    store.setQuestionFilter({})
  }
  load(1)
})
</script>

<style scoped>
.filter-bar { display: flex; gap: 10px; flex-wrap: wrap; align-items: center; }
.spacer { flex: 1; }
.empty { text-align: center; color: #999; padding: 40px 0; }
.q-item { display: flex; justify-content: space-between; align-items: center; gap: 8px; padding: 11px 8px; border-bottom: 1px solid #f0f0f0; cursor: pointer; border-radius: 6px; }
.q-item:hover { background: #f5f8ff; }
.q-main { display: flex; gap: 6px; align-items: center; flex-wrap: wrap; }
.q-title { font-size: 14px; }
.detail .meta { display: flex; gap: 6px; flex-wrap: wrap; margin-bottom: 14px; }
.block { margin-top: 18px; }
.block-title { font-weight: 600; margin-bottom: 8px; color: #303133; }
.scenario { background: #f7f9fc; padding: 10px; border-radius: 6px; }
.followups { padding-left: 18px; line-height: 1.9; color: #555; }
.assess-btns { display: flex; gap: 10px; }
.assess-msg { margin-top: 10px; color: #67c23a; font-size: 13px; }
.actions { border-top: 1px solid #eee; padding-top: 10px; }
.option { padding: 4px 0; }
</style>
