<template>
  <div class="lab-detail">
    <!-- 左侧：任务面板 -->
    <div class="panel">
      <el-page-header @back="$router.push('/labs')" :content="lab?.name || '实验'" />

      <el-alert v-if="error" type="error" :closable="false" class="page-card" :title="error">
        <el-button type="danger" size="small" @click="reboot">重开实验（销毁并重建环境）</el-button>
      </el-alert>

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
          <el-button type="warning" plain @click="reboot">重新开始</el-button>
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
      <div class="term-bar">
        <span>root@lab-terminal</span>
        <el-button v-if="instance" size="small" text type="primary" @click="reconnect">重连终端</el-button>
      </div>
      <div v-if="!instance && !error" class="term-loading">正在准备实验环境...</div>
      <div v-show="instance" ref="termRef" class="term" />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
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
const error = ref('')

let term = null
let ws = null
let timer = null
let fitAddon = null
let recovering = false

const statusType = computed(() => ({
  RUNNING: 'success', CREATED: 'info', COMPLETED: 'success', EXPIRED: 'warning', DESTROYED: 'info'
}[instance.value?.status] || 'info'))
const statusText = computed(() => instance.value?.status || '未创建')

function ensureTerm() {
  if (term) return
  term = new Terminal({ fontSize: 14, cursorBlink: true, theme: { background: '#1e1e2e' } })
  fitAddon = new FitAddon()
  term.loadAddon(fitAddon)
  term.open(termRef.value)
  fitAddon.fit()
  termRef.value.addEventListener('mousedown', () => term.focus())
  window.addEventListener('resize', resizeTerm)
  term.focus()
}

function resizeTerm() { try { fitAddon?.fit() } catch {} }

async function init() {
  try {
    lab.value = await api.labDetail(labId)
    const data = await api.labs()
    const item = data.find(d => String(d.lab.id) === String(labId))
    instance.value = item?.activeInstance || null
    if (!instance.value || route.query.start === '1') {
      await startInstance()
    }
    connect()
    timer = setInterval(tick, 30000)
    tick()
  } catch (e) {
    error.value = '实验环境初始化失败：' + (e.message || e)
  }
}

async function startInstance() {
  error.value = ''
  ElMessage.info('正在创建沙箱容器并预埋故障...')
  instance.value = await api.labStart(labId)
  result.value = null
  hintLevel.value = 0
  showSolution.value = false
}

function connect(onFail) {
  if (!instance.value?.id || !instance.value.containerId) return
  ensureTerm()
  term.write('\r\n\u001b[36m[正在连接实验容器...]\u001b[0m\r\n')
  const proto = location.protocol === 'https:' ? 'wss' : 'ws'
  ws = new WebSocket(`${proto}://${location.host}/ws/lab-terminal/${instance.value.id}`)
  ws.binaryType = 'arraybuffer'
  ws.onopen = () => { term.write('\u001b[32m[已连接]\u001b[0m '); term.focus() }
  ws.onmessage = e => {
    if (e.data instanceof ArrayBuffer) term.write(new Uint8Array(e.data))
    else term.write(e.data)
  }
  ws.onerror = () => {}
  ws.onclose = e => {
    if (e.code === 1000) {
      term.write('\r\n\u001b[33m[会话已结束（容器主进程退出），可点击「重新开始」]\u001b[0m\r\n')
      return
    }
    term.write(`\r\n\u001b[31m[连接失败 code=${e.code}] ${e.reason || '终端不可用'}\u001b[0m\r\n`)
    // 实例失效（容器已销毁/后端重启过）→ 自动重建一次
    if ((e.code === 4000 || e.code === 1011) && !recovering) {
      recovering = true
      term.write('\u001b[36m[检测到环境失效，自动重建实验环境...]\u001b[0m\r\n')
      reboot().finally(() => { recovering = false })
    } else if (onFail) {
      onFail(e)
    }
  }
  term.onData(data => {
    if (ws && ws.readyState === WebSocket.OPEN) ws.send(data)
  })
}

function reconnect() {
  try { ws?.close() } catch {}
  connect()
}

/** 销毁旧实例 → 新建 → 重连终端 */
async function reboot() {
  try {
    if (instance.value?.id) { try { await api.labStop(instance.value.id) } catch {} }
    await startInstance()
    reconnect()
  } catch (e) {
    error.value = '重建实验失败：' + (e.message || e)
  }
}

function tick() {
  if (!instance.value?.expiredAt) return
  const ms = new Date(instance.value.expiredAt) - Date.now()
  if (ms <= 0) {
    countdown.value = ''
    if (instance.value.status === 'RUNNING') {
      instance.value.status = 'EXPIRED'
      term?.write('\r\n\u001b[31m[实验已超时，环境已销毁，请「重新开始」]\u001b[0m\r\n')
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
    if (result.value.pass) instance.value.status = 'COMPLETED'
  } catch (e) {
    if (String(e.message).includes('实例')) await reboot()
  } finally {
    checking.value = false
  }
}

async function stop() {
  await ElMessageBox.confirm('销毁实验容器？', '销毁', { type: 'warning' })
  await api.labStop(instance.value.id)
  try { ws?.close() } catch {}
  instance.value.status = 'DESTROYED'
}

onMounted(init)
onBeforeUnmount(() => {
  try { ws?.close() } catch {}
  window.removeEventListener('resize', resizeTerm)
  term?.dispose()
  clearInterval(timer)
})
</script>

<style scoped>
.lab-detail { display: flex; gap: 14px; height: calc(100vh - 32px); }
.panel { width: 42%; overflow-y: auto; }
.terminal-wrap { flex: 1; display: flex; flex-direction: column; background: #1e1e2e; border-radius: 6px; overflow: hidden; }
.term-bar { background: #181825; color: #cdd6f4; padding: 4px 12px; font-size: 13px; font-family: Consolas, monospace; display: flex; justify-content: space-between; align-items: center; }
.term { flex: 1; padding: 8px; }
.term-loading { color: #cdd6f4; margin: auto; font-size: 14px; }
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
