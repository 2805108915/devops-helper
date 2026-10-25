<template>
  <div>
    <el-alert v-if="docker && !docker.available" type="warning" :closable="false" class="page-card"
              title="Docker 不可用"
              description="实操实验需要本机 Docker。请启动 Docker Desktop（Windows 需 WSL2），启动后刷新本页。" />
    <el-alert v-else-if="docker && docker.available && !docker.imageReady" type="info" :closable="false" class="page-card"
              title="首次使用需构建基础镜像（约 3-10 分钟，下载 Ubuntu 及工具包）">
      <el-button type="primary" size="small" :loading="building" @click="buildImage">
        {{ building ? '构建中...' : '构建基础镜像' }}
      </el-button>
    </el-alert>

    <el-card class="page-card">
      <template #header>🧪 实操实验室（真实 Linux 容器沙箱，限时自动销毁）</template>
      <el-row :gutter="14">
        <el-col :span="8" v-for="item in labs" :key="item.lab.id">
          <el-card class="lab-card" shadow="hover">
            <div class="lab-head">
              <span class="lab-name">{{ item.lab.name }}</span>
              <el-tag v-if="item.completedCount > 0" type="success" size="small">已完成</el-tag>
            </div>
            <div class="lab-meta">
              <el-tag size="small" type="info">{{ store.topicName(item.lab.topicId) }}</el-tag>
              <el-tag size="small" :type="['', 'success', 'warning', 'danger'][item.lab.difficulty]">
                {{ ['','初级','中级','高级'][item.lab.difficulty] }}
              </el-tag>
              <el-tag v-for="t in item.lab.tags?.slice(0, 2)" :key="t" size="small" effect="plain">{{ t }}</el-tag>
            </div>
            <div class="lab-desc">{{ item.lab.scenario?.split('\n')[0] }}</div>
            <div class="lab-foot">
              <el-button v-if="item.activeInstance" type="warning" size="small" @click="go(item)">
                继续（剩 {{ remain(item.activeInstance) }} 分钟）
              </el-button>
              <el-button v-else type="primary" size="small" @click="go(item)">开始实验</el-button>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import api from '../api'
import { useAppStore } from '../stores/app'
import { useRouter } from 'vue-router'

const store = useAppStore()
const router = useRouter()
const labs = ref([])
const docker = ref(null)
const building = ref(false)

async function load() {
  docker.value = await api.labDockerStatus()
  if (docker.value.available) {
    labs.value = await api.labs()
  }
}

async function buildImage() {
  building.value = true
  try {
    await api.labBuildImage()
    ElMessage.success('镜像构建成功')
    load()
  } finally {
    building.value = false
  }
}

function go(item) {
  if (!item.activeInstance) {
    router.push(`/labs/${item.lab.id}?start=1`)
  } else {
    router.push(`/labs/${item.lab.id}`)
  }
}

function remain(instance) {
  const ms = new Date(instance.expiredAt) - Date.now()
  return Math.max(0, Math.round(ms / 60000))
}

onMounted(async () => {
  await store.loadTopics()
  load()
})
</script>

<style scoped>
.lab-card { margin-bottom: 14px; }
.lab-head { display: flex; justify-content: space-between; align-items: center; }
.lab-name { font-weight: 600; }
.lab-meta { display: flex; gap: 6px; margin: 8px 0; flex-wrap: wrap; }
.lab-desc { color: #909399; font-size: 13px; height: 40px; overflow: hidden; }
.lab-foot { margin-top: 6px; }
</style>
