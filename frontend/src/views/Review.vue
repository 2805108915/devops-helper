<template>
  <div>
    <el-card class="page-card">
      <div class="head">
        <h3>🔁 今日复习队列</h3>
        <span v-if="queue.length" class="progress">{{ done }} / {{ queue.length }} 已完成</span>
      </div>
      <el-progress v-if="queue.length" :percentage="Math.round(done / queue.length * 100)" />
    </el-card>

    <el-card v-if="queue.length === 0" class="page-card">
      <el-empty description="🎉 今日没有到期的复习任务">
        <el-button type="primary" @click="$router.push('/questions')">去题库学新题</el-button>
      </el-empty>
    </el-card>

    <el-card v-else-if="idx < queue.length" class="page-card">
      <div class="meta">
        <el-tag size="small" type="info">{{ store.topicName(cur.topicId) }}</el-tag>
        <el-tag size="small" :type="cur.reviewState && cur.reviewState.latestQuality < 3 ? 'danger' : 'warning'">
          上次：{{ cur.reviewState ? qualityText(cur.reviewState.latestQuality) : '—' }}
        </el-tag>
      </div>
      <h3 class="title">{{ cur.title }}</h3>
      <div v-if="cur.content" class="scenario">{{ cur.content }}</div>

      <div v-if="!showAnswer" class="center">
        <el-button type="primary" size="large" @click="showAnswer = true">想好了，看答案</el-button>
      </div>
      <template v-else>
        <el-divider>参考答案</el-divider>
        <MdPreview :modelValue="cur.answer || '（无答案）'" />
        <el-divider>自评</el-divider>
        <div class="center assess">
          <el-button type="danger" size="large" @click="assess(1)">❌ 不会（明天重来）</el-button>
          <el-button type="warning" size="large" @click="assess(3)">🤔 模糊</el-button>
          <el-button type="success" size="large" @click="assess(5)">✅ 会</el-button>
        </div>
      </template>
    </el-card>

    <el-card v-else class="page-card">
      <el-empty description="🎉 今日复习全部完成！">
        <el-button @click="$router.push('/labs')">去实操实验室练手</el-button>
      </el-empty>
    </el-card>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { MdPreview } from 'md-editor-v3'
import 'md-editor-v3/lib/preview.css'
import api from '../api'
import { useAppStore } from '../stores/app'

const store = useAppStore()
const queue = ref([])
const idx = ref(0)
const showAnswer = ref(false)
const done = computed(() => idx.value)
const cur = computed(() => queue.value[idx.value] || {})

async function load() {
  queue.value = await api.reviewToday(50)
  idx.value = 0
  showAnswer.value = false
}

async function assess(quality) {
  await api.review(cur.value.id, quality)
  ElMessage.success(quality < 3 ? '已安排明天重练' : '已更新复习计划')
  idx.value++
  showAnswer.value = false
}

const qualityText = q => (q < 3 ? '生疏' : q < 5 ? '模糊' : '掌握')

onMounted(async () => {
  await store.loadTopics()
  load()
})
</script>

<style scoped>
.head { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.progress { color: #909399; font-size: 13px; }
.meta { display: flex; gap: 6px; margin-bottom: 10px; }
.title { margin: 8px 0 14px; line-height: 1.6; }
.scenario { background: #f7f9fc; padding: 10px; border-radius: 6px; white-space: pre-wrap; color: #555; }
.center { text-align: center; }
.assess { display: flex; gap: 14px; justify-content: center; }
</style>
