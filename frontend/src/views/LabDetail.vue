<template>
  <div class="lab-detail">
    <!-- 左侧：任务面板 -->
    <div class="panel">
      <el-page-header @back="$router.push('/labs')" :content="lab?.name || '实验'" />

      <el-card class="page-card" v-if="lab">
        <div class="scenario-title">📖 实验场景</div>
        <div class="scenario">{{ lab.scenario }}</div>
      </el-card>

      <el-card class="page-card" v-if="instance">
        <div class="status-line">
          <el-tag :type="statusType">{{ statusText }}</el-tag>
          <span v-if="countdown" class="countdown">⏳ 剩余 {{ countdown }}</span>
        </div>
        <div class="btns">
          <el-button type="success" :loading="checking" :disabled="instance.status !== 'RUNNING'" @click="check">
            ✅ 检测判分
          </el-button>
          <el-button type="warning" plain @click="restart">重新开始</el-button>
          <el-button type="danger" plain @click="stop">销毁环境</el-button>
        </div>

        <div v-if="result" class="result" :class="result.pass ? 'ok' : 'fail'">
          <div class="result-head">{{ result.pass ? '🎉 恭喜通关！' : '❌ 尚未达标' }}</div>
          <div class="result-msg">{{ result.message }}</div>
        </div>
      </el-card>

      <el-card class="page-card" v-if="lab">
        <div class="scenario-title">💡 提示（点一条少一条，先自己想）</div>
        <div v-for="(h, i) in lab.hints || []" :key="i">
          <div v-if="i < hintLevel" class="hint">{{ i + 1 }}. {{ h }}</div>
        </div>
        <el-button v-if="hintLevel < (lab.hints || []).length" size="small" plain @click="hintLevel++">
          提示 {{ hintLevel }}/{{ (lab.hints || []).length }}：再看一条
        </el-button>
      </el-card>

      <el-card class="page-card" v-if="lab">
        <div class="scenario-title">🔓 参考解法</div>
        <el-button v-if="!showSolution" size="small" plain @click="showSolution = true">我真的做不出来了</el-button>
        <pre v-else class="solution">{{ lab.solution }}</pre>
      </el-card>
    </div>

    <!-- 右侧：终端 -->
    <div class="terminal-wrap">
      <div class="term-bar">root@lab-terminal</div>
      <div ref="termRef" class="term" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Terminal } from '@xterm/xterm'
import { FitAddon } from '@xterm/addon-fit'
import '@xterm/xterm/css/xterm.css'
import api from '../api'
import { useRoute } from 'vue-router'

const route = useRoute()
const labId = route.params.id
const lab = ref(null)
const instance = ref(null)
const result = ref(null)
const checking = ref(false)
const hintLevel = ref(0)
const showSolution = ref(false)
const countdown = ref('')

let term = null
let ws = null
let timer = null

async function init() {
  lab.value = await api.labDetail(labId)
  // 查询进行中的实例
  const data = await api.labs()
  const item = data.find(d => String(d.lab.id) === String(labId))
  instance.value = item?.activeInstance || null
  if (!instance.value || route.query.start === '1') {
    await startInstance()
  }
  connect()
  timer = setInterval(tick, 30000)
  tick()
}

async function startInstance() {
  ElMessage.info('正在创建沙箱容器并预埋故障...')
  instance.value = await api.labStart(labId)
  result.value = null
  hintLevel.value = 0
  showSolution.value = false
}

function connect() {
  if (!instance.value) return
  term = new Terminal({
    fontSize: 14,
    cursorBlink: true,
    convertEol: false,
    theme: { background: '#1e1e2e' }
  })
  const fit = new FitAddon()
  term.loadAddon(fit)
  term.open(termRef.value)
  fit.fit()
  window.addEventListener('resize', () => fit.fit())

  const proto = location.protocol === 'https:' ? 'wss' : 'ws'
  ws = new WebSocket(`${proto}://${location.host}/ws/lab-terminal/${instance.value.id}`)
  ws.binaryType = 'arraybuffer'
  ws.onopen = () => term.focus()
  ws.onmessage = e => {
    if (e.data instanceof ArrayBuffer) {
      term.write(new Uint8Array(e.data))
    } else {
      term.write(e.data)
    }
  }
  ws.onclose = e => {
    if (e.code === 4000 || e.code === 1011) {
      term.write(`\r\n\x1b[31m[会话结束] ${e.reason}\x1b[0m\r\n`)
    } else {
      term.write('\r\n\x1b[33m[会话已断开]\x1b[0m\r\n')
    }
  }
  term.onData(data => {
    if (ws && ws.readyState === WebSocket.OPEN) ws.send(data)
  })
}

function tick() {
  if (!instance.value?.expiredAt) return
  const ms = new Date(instance.value.expiredAt) - Date.now()
  if (ms <= 0) {
    countdown.value = ''
    if (instance.value.status === 'RUNNING') {
      instance.value.status = 'EXPIRED'
      term?.write('\r\n\x1b[31m[实验已超时，环境已销毁，请重新开始]\x1b[0m\r\n')
    }
  } else {
    const m = Math.floor(ms / 60000)
    const s = Math.floor((ms % 60000) / 1000)
    countdown.value = `${m}:${String(s).padStart(2, '0')}`
  }
}

async function check() {
  checking.value = true
  try {
    result.value = await api.labCheck(instance.value.id)
    if (result.value.pass) {
      instance.value.status = 'COMPLETED'
    }
  } finally {
    checking.value = false
  }
}

async function restart() {
  await ElMessageBox.confirm('将销毁当前容器并重新预埋故障，确认？', '重新开始', { type: 'warning' })
  await startInstance()
  location.reload()
}

async function stop() {
  await ElMessageBox.confirm('销毁实验容器？', '销毁', { type: 'warning' })
  await api.labStop(instance.value.id)
  ws?.close()
  instance.value.status = 'DESTROYED'
}

onMounted(init)
onBeforeUnmount(() => {
  ws?.close()
  term?.dispose()
  clearInterval(timer)
})
</script>

<script>
export default { name: 'LabDetail' }
</script>

<style scoped>
.lab-detail { display: flex; gap: 14px; height: calc(100vh - 32px); }
.panel { width: 42%; overflow-y: auto; }
.terminal-wrap { flex: 1; display: flex; flex-direction: column; background: #1e1e2e; border-radius: 6px; overflow: hidden; }
.term-bar { background: #181825; color: #cdd6f4; padding: 6px 12px; font-size: 13px; font-family: Consolas, monospace; }
.term { flex: 1; padding: 8px; }
.scenario-title { font-weight: 600; margin-bottom: 8px; }
.scenario { white-space: pre-wrap; line-height: 1.8; color: #444; background: #f7f9fc; padding: 12px; border-radius: 6px; font-size: 14px; }
.status-line { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
.countdown { font-family: Consolas, monospace; color: #e6a23c; }
.btns { display: flex; gap: 8px; flex-wrap: wrap; }
.result { margin-top: 12px; padding: 12px; border-radius: 6px; }
.result.ok { background: #f0f9eb; border: 1px solid #e1f3d8; }
.result.fail { background: #fef0f0; border: 1px solid #fde2e2; }
.result-head { font-weight: 700; margin-bottom: 6px; }
.result-msg { white-space: pre-wrap; color: #555; font-size: 13px; }
.hint { padding: 6px 10px; background: #fdf6ec; border-radius: 4px; margin-bottom: 6px; color: #7a5b28; font-size: 13px; }
.solution { background: #1e1e2e; color: #cdd6f4; padding: 12px; border-radius: 6px; font-size: 13px; overflow-x: auto; }
</style>
