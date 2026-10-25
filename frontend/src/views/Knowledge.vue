<template>
  <div class="kb">
    <div class="kb-left">
      <el-card class="page-card">
        <el-button type="primary" size="small" style="width: 100%" @click="create">+ 新建文章</el-button>
        <div class="nav-item" :class="{ active: !currentTopicId && !editing }" @click="selectTopic(null)">
          全部
        </div>
        <div v-for="t in topics" :key="t.id" class="nav-item"
             :class="{ active: currentTopicId === t.id && !editing }" @click="selectTopic(t.id)">
          {{ t.name }}
          <span class="count">{{ countOf(t.id) }}</span>
        </div>
      </el-card>
    </div>

    <div class="kb-main">
      <el-card v-if="!editing" class="page-card">
        <template #header>
          <el-input v-model="keyword" placeholder="搜索标题/内容" clearable style="width: 260px"
                    @keyup.enter="load" @clear="load" />
        </template>
        <div v-if="articles.length === 0" class="empty">暂无文章，点左侧「新建文章」开始沉淀</div>
        <div v-for="a in articles" :key="a.id" class="article-item" @click="open(a.id)">
          <div class="a-title">📄 {{ a.title }}</div>
          <div class="a-meta">{{ store.topicName(a.topicId) }} · 更新于 {{ fmt(a.updatedAt) }}</div>
        </div>
      </el-card>

      <el-card v-else class="page-card">
        <div class="edit-head">
          <el-input v-model="form.title" placeholder="标题" style="width: 320px" />
          <el-select v-model="form.topicId" placeholder="知识点" style="width: 160px">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
          </el-select>
          <div class="spacer" />
          <el-button @click="editing = false">返回</el-button>
          <el-button type="primary" @click="save">保存</el-button>
          <el-button v-if="form.id" type="danger" plain @click="remove">删除</el-button>
        </div>
        <MdEditor v-model="form.contentMd" :style="{ height: 'calc(100vh - 220px)' }" language="zh-CN" />
      </el-card>
    </div>

    <!-- 查看模式 -->
    <el-drawer v-model="viewVisible" size="50%" :title="viewing?.title">
      <div v-if="viewing">
        <MdPreview :modelValue="viewing.contentMd || ''" />
        <el-divider v-if="viewQuestions.length">关联题目</el-divider>
        <div v-for="q in viewQuestions" :key="q.id" class="rel-q">• {{ q.title }}</div>
      </div>
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
const editing = ref(false)
const form = reactive({ id: null, title: '', contentMd: '', topicId: null })
const viewVisible = ref(false)
const viewing = ref(null)
const viewQuestions = ref([])

async function load() {
  articles.value = await api.kbList({ topicId: currentTopicId.value || undefined, keyword: keyword.value || undefined })
}

function selectTopic(id) {
  currentTopicId.value = id
  editing.value = false
  load()
}

function create() {
  Object.assign(form, { id: null, title: '', contentMd: '# 新文章\n\n', topicId: currentTopicId.value })
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
  ElMessage.success('已保存')
  editing.value = false
  load()
}

async function remove() {
  await ElMessageBox.confirm('删除这篇文章？', '删除', { type: 'warning' })
  await api.kbDelete(form.id)
  editing.value = false
  load()
}

const countOf = tid => articles.value.filter(a => a.topicId === tid).length
const fmt = s => (s || '').replace('T', ' ').slice(0, 16)

onMounted(async () => {
  await store.loadTopics()
  topics.value = store.topics
  load()
  // 从题库跳转
  if (route.query.articleId) open(Number(route.query.articleId))
})
</script>

<style scoped>
.kb { display: flex; gap: 14px; }
.kb-left { width: 210px; flex-shrink: 0; }
.kb-main { flex: 1; }
.nav-item { padding: 9px 10px; cursor: pointer; border-radius: 6px; font-size: 14px; margin-top: 6px; display: flex; justify-content: space-between; }
.nav-item:hover { background: #f5f7fa; }
.nav-item.active { background: #ecf5ff; color: #409eff; font-weight: 600; }
.count { color: #bbb; font-size: 12px; }
.empty { text-align: center; color: #999; padding: 40px 0; }
.article-item { padding: 10px 8px; border-bottom: 1px solid #f0f0f0; cursor: pointer; }
.article-item:hover { background: #f5f8ff; }
.a-title { font-size: 14px; }
.a-meta { color: #aaa; font-size: 12px; margin-top: 3px; }
.edit-head { display: flex; gap: 10px; margin-bottom: 10px; }
.spacer { flex: 1; }
.rel-q { padding: 4px 0; color: #555; font-size: 14px; }
</style>
