<template>
  <div>
    <el-row :gutter="14">
      <el-col :span="6" v-for="c in cards" :key="c.label">
        <el-card class="page-card stat">
          <div class="stat-num" :style="{ color: c.color }">{{ c.value }}</div>
          <div class="stat-label">{{ c.label }}</div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="14">
      <el-col :span="12">
        <el-card class="page-card">
          <template #header>知识点掌握度雷达</template>
          <div ref="radarRef" class="chart" />
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="page-card">
          <template #header>近 30 天复习量</template>
          <div ref="trendRef" class="chart" />
        </el-card>
      </el-col>
    </el-row>

    <el-card class="page-card">
      <template #header>薄弱知识点（生疏题目数 TOP）</template>
      <el-table :data="weakTopics" size="small">
        <el-table-column prop="topicName" label="知识点" />
        <el-table-column prop="weak" label="生疏题数" width="110" sortable />
        <el-table-column prop="learned" label="已学/总数" width="110">
          <template #default="{ row }">{{ row.learned }}/{{ row.total }}</template>
        </el-table-column>
        <el-table-column label="操作" width="140">
          <template #default="{ row }">
            <el-button size="small" type="primary" plain @click="drill(row)">专项练习</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, nextTick } from 'vue'
import * as echarts from 'echarts'
import api from '../api'
import { useAppStore } from '../stores/app'
import { useRouter } from 'vue-router'

const store = useAppStore()
const router = useRouter()
const stats = ref({ totalQuestions: 0, reviewedQuestions: 0, dueToday: 0, weakCount: 0, topicMastery: [], trend: [] })
const radarRef = ref()
const trendRef = ref()

const cards = computed(() => [
  { label: '题库总题数', value: stats.value.totalQuestions, color: '#409eff' },
  { label: '已学习', value: stats.value.reviewedQuestions, color: '#67c23a' },
  { label: '今日待复习', value: stats.value.dueToday, color: '#e6a23c' },
  { label: '生疏题目', value: stats.value.weakCount, color: '#f56c6c' }
])

const weakTopics = computed(() =>
  [...stats.value.topicMastery].filter(t => Number(t.weak) > 0).sort((a, b) => b.weak - a.weak).slice(0, 6)
)

function drill(row) {
  const topic = store.topics.find(t => t.name === row.topicName)
  store.setQuestionFilter({ topicId: topic?.id })
  router.push('/questions')
}

function renderCharts() {
  const mastery = stats.value.topicMastery || []
  const radar = echarts.init(radarRef.value)
  radar.setOption({
    tooltip: {},
    radar: {
      indicator: mastery.map(t => ({ name: t.topicName, max: 100 })),
      radius: '65%'
    },
    series: [{
      type: 'radar',
      areaStyle: { opacity: 0.25 },
      data: [{
        name: '掌握度',
        value: mastery.map(t => {
          const total = Number(t.total) || 1
          const learned = Number(t.learned) || 0
          const avgQ = t.avgQuality ? Number(t.avgQuality) : 0
          return Math.round((learned / total) * (avgQ / 5) * 100)
        })
      }]
    }]
  })

  const trend = stats.value.trend || []
  const line = echarts.init(trendRef.value)
  line.setOption({
    tooltip: { trigger: 'axis' },
    grid: { left: 40, right: 20, bottom: 30, top: 20 },
    xAxis: { type: 'category', data: trend.map(t => String(t.date).slice(5)) },
    yAxis: { type: 'value', minInterval: 1 },
    series: [{ type: 'line', smooth: true, areaStyle: { opacity: 0.15 }, data: trend.map(t => Number(t.count)) }]
  })
}

onMounted(async () => {
  await store.loadTopics()
  stats.value = await api.reviewStats()
  await nextTick()
  renderCharts()
})
</script>

<style scoped>
.stat { text-align: center; }
.stat-num { font-size: 34px; font-weight: 700; }
.stat-label { color: #909399; font-size: 13px; margin-top: 4px; }
.chart { height: 320px; }
</style>
