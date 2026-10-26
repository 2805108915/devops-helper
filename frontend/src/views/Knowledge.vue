<template>
  <div class="kb">
    <!-- 左侧：分组导航（可增删） -->
    <div class="kb-left">
      <el-card class="page-card">
        <div class="nav-add">
          <el-input v-model="newGroupName" size="small" placeholder="新分组名称" @keyup.enter="addGroup" />
          <el-button type="primary" size="small" :disabled="!newGroupName.trim()" @click="addGroup">添加</el-button>
        </div>
        <div class="nav-item" :class="{ active: !currentTopicId && !editing }" @click="selectTopic(null)">
          全部
          <span v-if="!editing" class="count">{{ countOf(null) }}</span>
        </div>
        <div v-for="t in topics" :key="t.id" class="nav-item"
             :class="{ active: currentTopicId === t.id && !editing }" @click="selectTopic(t.id)">
          <span class="nav-name">
            <span v-if="t.builtin === 1" class="lock" title="内置知识点，不可删除">🔒</span>
            {{ t.name }}
          </span>
          <span class="nav-side">
            <span class="count">{{ countOf(t.id) }}</span>
            <el-popconfirm v-if="t.builtin !== 1" title="删除该分组？（需先清空组内文章）"
                           confirm-button-text="删除" cancel-button-text="取消"
                           @confirm="removeGroup(t)">
              <template #reference>
                <el-button size="small" text type="danger" @click.stop>✕</el-button>
              </template>
            </el-popconfirm>
          </span>
        </div>
      </el-card>
    </div>

    <!-- 主区 -->
    <div class="kb-main">
      <!-- 列表模式 -->
      <el-card v-if="!editing" class="page-card">
        <template #header>
          <div class="list-head">
            <el-input v-model="keyword" placeholder="搜索标题/内容" clearable style="width: 240px"
                      @keyup.enter="load" @clear="load" />
            <el-button type="primary" size="small" @click="create">+ 新建文章</el-button>
          </div>
        </template>
        <div v-if="articles.length === 0" class="empty">暂无文章，点右上角「新建文章」开始沉淀</div>
        <div v-for="a in articles" :key="a.id" class="article-item">
          <div class="a-info" @click="open(a.id)">
            <div class="a-title">📄 {{ a.title }}</div>
            <div class="a-meta">
              {{ store.topicName(a.topicId) }} · 创建 {{ fmt(a.createdAt) }} · 修改 {{ fmt(a.updatedAt) }}
            </div>
          </div>
          <div class="a-ops">
            <el-button size="small" text type="primary" @click="edit(a)">修改</el-button>
            <el-button size="small" text @click="openHistory(a)">历史</el-button>
            <el-button size="small" text type="danger" @click="remove(a)">删除</el-button>
          </div>
        </div>
      </el-card>

      <!-- 编辑模式 -->
      <el-card v-else class="page-card">
        <div class="edit-head">
          <el-input v-model="form.title" placeholder="标题" style="width: 320px" />
          <el-select v-model="form.topicId" placeholder="所属分组" style="width: 170px">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
          </el-select>
          <div class="spacer" />
          <el-button @click="editing = false">返回</el-button>
          <el-button type="primary" @click="save">保存</el-button>
        </div>
        <MdEditor v-model="form.contentMd" :style="{ height: 'calc(100vh - 230px)' }" language="zh-CN" />
      </el-card>
    </div>

    <!-- 查看抽屉 -->
    <el-drawer v-model="viewVisible" size="50%" :title="viewing?.title">
      <div v-if="viewing">
        <div class="view-meta">
          创建：{{ fmt(viewing.createdAt) }} · 最近修改：{{ fmt(viewing.updatedAt) }}
        </div>
        <MdPreview :modelValue="viewing.contentMd || ''" />
        <el-divider v-if="viewQuestions.length">关联题目</el-divider>
        <div v-for="q in viewQuestions" :key="q.id" class="rel-q">• {{ q.title }}</div>
      </div>
    </el-drawer>

    <!-- 历史版本抽屉 -->
    <el-drawer v-model="historyVisible" size="44%" :title="`修改历史：${historyArticle?.title}`">
      <div v-if="historyList.length === 0" class="empty">暂无修改记录（保存首次修改后自动生成）</div>
      <el-timeline v-else>
        <el-timeline-item v-for="h in historyList" :key="h.id"
                          :timestamp="fmt(h.savedAt)" placement="top" type="primary">
          <div class="hist-card">
            <div class="hist-title">{{ h.title }}</div>
            <div class="hist-actions">
              <el-button size="small" text @click="previewSnap = h">{{ previewSnap?.id === h.id ? '收起' : '预览' }}</el-button>
              <el-button size="small" type="warning" plain @click="doRestore(h)">回滚到此版本</el-button>
            </div>
            <MdPreview v-if="previewSnap?.id === h.id" :modelValue="h.contentMd || ''" class="hist-preview" />
          </div>
        </el-timeline-item>
      </el-timeline>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { MdEditor, MdPreview } from 'md-editor-v3'
import 'md-editor-v3/lib/style.css'
import api from '../api'
import { useAppStore } from '../stores/app'
import { useRoute } from 'vue-router'

const route = useRoute()
const store = useAppStore()
const topics = ref([])
const articles = ref([])
const currentTopicId = ref(null)
const keyword = ref('')
const newGroupName = ref('')
const editing = ref(false)
const form = reactive({ id: null, title: '', contentMd: '', topicId: null })
const viewVisible = ref(false)
const viewing = ref(null)
const viewQuestions = ref([])
const historyVisible = ref(false)
const historyArticle = ref(null)
const historyList = ref([])
const previewSnap = ref(null)

async function loadTopics() {
  await store.loadTopics(true)
  topics.value = store.topics
}

async function load() {
  articles.value = await api.kbList({ topicId: currentTopicId.value || undefined, keyword: keyword.value || undefined })
}

function selectTopic(id) {
  currentTopicId.value = id
  editing.value = false
  load()
}

/** 需求1：新增自定义分组 */
async function addGroup() {
  const name = newGroupName.value.trim()
  if (!name) return
  try {
    await api.topicCreate({ name })
    newGroupName.value = ''
    ElMessage.success('分组已添加')
    await loadTopics()
  } catch (e) { /* 错误已由拦截器提示 */ }
}

/** 需求1：删除自定义分组 */
async function removeGroup(t) {
  try {
    await api.topicDelete(t.id)
    ElMessage.success('分组已删除')
    if (currentTopicId.value === t.id) currentTopicId.value = null
    await loadTopics()
    load()
  } catch (e) { /* 拦截器提示（内置/非空等原因） */ }
}

function create() {
  Object.assign(form, { id: null, title: '', contentMd: '# 新文章\n\n', topicId: currentTopicId.value })
  editing.value = true
}

function edit(a) {
  Object.assign(form, { id: a.id, title: a.title, contentMd: a.contentMd || '', topicId: a.topicId })
  editing.value = true
}

async function open(id) {
  const data = await api.kbDetail(id)
  viewing.value = data.article
  viewQuestions.value = data.questions || []
  viewVisible.value = true
}

async function save() {
  if (!form.title.trim()) {
    ElMessage.warning('请填写标题')
    return
  }
  if (form.id) {
    await api.kbUpdate(form.id, { ...form })
  } else {
    form.id = (await api.kbCreate({ ...form })).id
  }
  ElMessage.success('已保存（修改前的旧版本已自动存入历史）')
  editing.value = false
  await load()
}

/** 需求2：删除文章（连同历史） */
async function remove(a) {
  await ElMessageBox.confirm(
    `删除《${a.title}》？其全部修改历史将一并删除，不可恢复。`,
    '删除文章', { type: 'warning', confirmButtonText: '删除', cancelButtonText: '取消' })
  await api.kbDelete(a.id)
  ElMessage.success('已删除')
  load()
}

/** 需求2：查看修改时间线（旧版本快照按时间排列，不覆盖不丢失） */
async function openHistory(a) {
  historyArticle.value = a
  previewSnap.value = null
  historyList.value = await api.kbHistory(a.id)
  historyVisible.value = true
}

async function doRestore(h) {
  await ElMessageBox.confirm(
    `回滚到 ${fmt(h.savedAt)} 的版本？当前版本也会先存档（回滚本身可撤销）。`,
    '回滚确认', { type: 'warning', confirmButtonText: '回滚', cancelButtonText: '取消' })
  await api.kbRestore(historyArticle.value.id, h.id)
  ElMessage.success('已回滚')
  historyList.value = await api.kbHistory(historyArticle.value.id)
  load()
}

const countOf = tid => {
  if (tid === null) return articles.value.length && !currentTopicId.value ? articles.value.length : ''
  return articles.value.filter(a => a.topicId === tid).length
}
const fmt = s => (s || '').replace('T', ' ').slice(0, 16)

onMounted(async () => {
  await loadTopics()
  load()
  if (route.query.articleId) open(Number(route.query.articleId))
})
</script>

<style scoped>
.kb { display: flex; gap: 14px; }
.kb-left { width: 230px; flex-shrink: 0; }
.kb-main { flex: 1; min-width: 0; }
.nav-add { display: flex; gap: 6px; margin-bottom: 6px; }
.nav-item { padding: 8px 10px; cursor: pointer; border-radius: 6px; font-size: 14px; margin-top: 4px; display: flex; justify-content: space-between; align-items: center; }
.nav-item:hover { background: #f5f7fa; }
.nav-item.active { background: #ecf5ff; color: #409eff; font-weight: 600; }
.nav-name { display: flex; align-items: center; gap: 4px; min-width: 0; overflow: hidden; text-overflow: ellipsis; }
.nav-side { display: flex; align-items: center; gap: 2px; flex-shrink: 0; }
.lock { font-size: 12px; opacity: .6; }
.count { color: #bbb; font-size: 12px; }
.list-head { display: flex; justify-content: space-between; align-items: center; }
.empty { text-align: center; color: #999; padding: 40px 0; }
.article-item { display: flex; justify-content: space-between; align-items: center; padding: 10px 8px; border-bottom: 1px solid #f0f0f0; border-radius: 6px; }
.article-item:hover { background: #f5f8ff; }
.a-info { cursor: pointer; min-width: 0; flex: 1; }
.a-title { font-size: 14px; }
.a-meta { color: #aaa; font-size: 12px; margin-top: 3px; }
.a-ops { flex-shrink: 0; }
.edit-head { display: flex; gap: 10px; margin-bottom: 10px; }
.spacer { flex: 1; }
.view-meta { color: #909399; font-size: 13px; margin-bottom: 12px; padding-bottom: 8px; border-bottom: 1px solid #eee; }
.rel-q { padding: 4px 0; color: #555; font-size: 14px; }
.hist-card { border: 1px solid #f0f0f0; border-radius: 8px; padding: 10px 12px; }
.hist-title { font-size: 14px; font-weight: 600; margin-bottom: 6px; }
.hist-actions { display: flex; gap: 6px; }
.hist-preview { margin-top: 8px; border-top: 1px dashed #eee; padding-top: 6px; max-height: 300px; overflow-y: auto; }
</style>
