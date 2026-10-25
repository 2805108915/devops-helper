<template>
  <div>
    <el-row :gutter="14">
      <el-col :span="12" v-for="p in positions" :key="p.position.id">
        <el-card class="page-card pos-card">
          <div class="pos-head">
            <h3>{{ p.position.name }}</h3>
            <el-button type="primary" size="small" plain @click="goQuestions(p.position.code)">
              刷该岗位题库 ({{ p.totalQuestions }})
            </el-button>
          </div>
          <div class="pos-desc">{{ p.position.description }}</div>
          <el-progress :percentage="pct(p)" :stroke-width="10"
                       :format="() => `${p.reviewedQuestions}/${p.totalQuestions} 已学`" />
          <div class="stages">
            <div v-for="(s, i) in p.position.skills || []" :key="i" class="stage">
              <div class="stage-name">{{ s.stage }}</div>
              <div class="stage-items">
                <el-tag v-for="item in s.items" :key="item" size="small" effect="plain">{{ item }}</el-tag>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '../api'
import { useAppStore } from '../stores/app'
import { useRouter } from 'vue-router'

const store = useAppStore()
const router = useRouter()
const positions = ref([])

const pct = p => (p.totalQuestions ? Math.round(p.reviewedQuestions / p.totalQuestions * 100) : 0)

function goQuestions(code) {
  store.setQuestionFilter({ positionCode: code })
  router.push('/questions')
}

onMounted(async () => {
  positions.value = await api.positions()
})
</script>

<style scoped>
.pos-card { margin-bottom: 14px; }
.pos-head { display: flex; justify-content: space-between; align-items: center; }
.pos-desc { color: #909399; font-size: 13px; margin: 6px 0 10px; }
.stages { margin-top: 12px; }
.stage { margin-bottom: 10px; }
.stage-name { font-weight: 600; font-size: 13px; margin-bottom: 6px; color: #409eff; }
.stage-items { display: flex; flex-wrap: wrap; gap: 6px; }
</style>
