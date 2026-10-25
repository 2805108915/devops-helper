<template>
  <div class="ai">
    <el-card class="page-card">
      <div class="head" @click="showConfig = !showConfig">
        <span>🤖 AI 助手（OpenAI 兼容接口：GLM / DeepSeek / OpenAI 均可）</span>
        <el-tag :type="config.enabled === 1 ? 'success' : 'info'" size="small">
          {{ config.enabled === 1 ? '已启用' : '未启用' }}
        </el-tag>
        <span class="toggle">{{ showConfig ? '收起 ▲' : '展开配置 ▼' }}</span>
      </div>
      <div v-if="showConfig" class="config">
        <el-form label-width="90px">
          <el-row :gutter="12">
            <el-col :span="10">
              <el-form-item label="Base URL">
                <el-input v-model="config.baseUrl" placeholder="https://open.bigmodel.cn/api/paas/v4" />
              </el-form-item>
            </el-col>
            <el-col :span="7">
              <el-form-item label="模型">
                <el-input v-model="config.model" placeholder="glm-4-flash" />
              </el-form-item>
            </el-col>
            <el-col :span="7">
              <el-form-item label="启用">
                <el-switch v-model="configEnabled" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="API Key">
            <el-input v-model="config.apiKey" placeholder="sk-..." show-password style="width: 460px" />
            <el-button type="primary" style="margin-left: 10px" @click="saveConfig">保存</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>

    <el-card class="page-card">
      <div class="scene-bar">
        <el-radio-group v-model="scene">
          <el-radio-button value="chat">💬 自由提问</el-radio-button>
          <el-radio-button value="interview">🎤 模拟面试</el-radio-button>
          <el-radio-button value="followup">🔍 题目追问</el-radio-button>
          <el-radio-button value="generate">✨ 生成新题</el-radio-button>
        </el-radio-group>

        <template v-if="scene === 'interview'">
          <el-select v-model="ivPosition" placeholder="岗位" style="width: 140px">
            <el-option label="初级运维" value="初级运维工程师" />
            <el-option label="DevOps" value="DevOps工程师" />
            <el-option label="SRE" value="SRE工程师" />
            <el-option label="云计算" value="云计算工程师" />
          </el-select>
          <el-select v-model="ivTopic" placeholder="知识点" clearable style="width: 150px">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.name" />
          </el-select>
        </template>
        <template v-if="scene === 'followup'">
          <el-input v-model="followQuestionId" placeholder="题目ID（在题库详情可见）" style="width: 180px" />
        </template>
        <template v-if="scene === 'generate'">
          <el-select v-model="genTopic" placeholder="知识点" style="width: 150px">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.name" />
          </el-select>
          <el-select v-model="genDifficulty" placeholder="难度" style="width: 110px">
            <el-option label="初级" value="初级" />
            <el-option label="中级" value="中级" />
            <el-option label="高级" value="高级" />
          </el-select>
        </template>
      </div>

      <div ref="chatBox" class="chat">
        <div v-if="messages.length === 0" class="chat-empty">
          选择场景后开始对话。模拟面试会扮演面试官连环追问；生成新题可直接存入题库。
        </div>
        <div v-for="(m, i) in messages" :key="i" class="msg" :class="m.role">
          <div class="bubble">
            <pre>{{ m.content }}<span v-if="m.streaming" class="cursor">▊</span></pre>
          </div>
          <div v-if="m.role === 'assistant' && !m.streaming && scene === 'generate' && i === messages.length - 1" class="gen-actions">
            <el-button type="primary" size="small" @click="saveGenerated(m.content)">📌 存入题库</el-button>
          </div>
        </div>
      </div>

      <div class="input-bar">
        <el-input v-model="input" :placeholder="inputPlaceholder" @keyup.enter="send"
                  :disabled="streaming" />
        <el-button type="primary" :loading="streaming" @click="send">发送</el-button>
        <el-button @click="clearChat" plain>清空</el-button>
      </div>
    </el-card>

    <!-- 生成题目入库 -->
    <el-dialog v-model="saveVisible" title="确认入库（自动预填，可修改）" width="640px">
      <el-form label-width="80px">
        <el-form-item label="知识点">
          <el-select v-model="saveForm.topicId">
            <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="题型">
          <el-radio-group v-model="saveForm.type">
            <el-radio value="QA">问答</el-radio>
            <el-radio value="SCENARIO">场景排障</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="题干">
          <el-input v-model="saveForm.title" type="textarea" :rows="2" />
        </el-form-item>
        <el-form-item label="参考答案">
          <el-input v-model="saveForm.answer" type="textarea" :rows="8" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="saveVisible = false">取消</el-button>
        <el-button type="primary" @click="confirmSave">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, nextTick } from 'vue'
import { ElMessage } from 'element-plus'
import api from '../api'
import { useAppStore } from '../stores/app'

const store = useAppStore()
const topics = ref([])
const config = ref({ baseUrl: '', apiKey: '', model: '', enabled: 0 })
const configEnabled = ref(false)
const showConfig = ref(false)

const scene = ref('chat')
const ivPosition = ref('DevOps工程师')
const ivTopic = ref('')
const followQuestionId = ref('')
const genTopic = ref('')
const genDifficulty = ref('中级')

const messages = ref([])
const input = ref('')
const streaming = ref(false)
const chatBox = ref()

const saveVisible = ref(false)
const saveForm = ref({ topicId: null, type: 'QA', title: '', answer: '' })

const inputPlaceholder = computed(() => ({
  chat: '问任何运维/面试问题...',
  interview: '面试官会先提问，你直接回答即可（或点发送让面试官开始）',
  followup: '针对该题让 AI 继续深挖（先填题目ID）',
  generate: '点发送即可按所选知识点生成一道新题'
}[scene.value]))

async function loadConfig() {
  config.value = await api.aiConfig() || { baseUrl: '', apiKey: '', model: '', enabled: 0 }
  configEnabled.value = config.value.enabled === 1
  showConfig.value = !configEnabled.value
}

async function saveConfig() {
  config.value.enabled = configEnabled.value ? 1 : 0
  config.value = await api.aiSaveConfig(config.value)
  ElMessage.success('已保存')
}

function buildSystemPrompt() {
  if (scene.value === 'interview') {
    return `你是一位资深的${ivPosition.value}技术面试官${ivTopic.value ? `，重点考察${ivTopic.value}方向` : ''}。
规则：1) 每次只问一个问题；2) 根据我的回答质量追问细节或换方向，像真实面试一样循序渐进；3) 我回答得不好时给出简短点评再继续；4) 全程用中文。现在请先做简短开场并抛出第一个问题。`
  }
  if (scene.value === 'followup') {
    return '你是运维面试辅导专家。用户会给出一个题目和他的疑问，请围绕该题深入讲解，并给出面试官可能的追问与理想回答思路。用中文，markdown 格式。'
  }
  if (scene.value === 'generate') {
    return `你是运维面试题出题专家。请出一道${genTopic.value || '运维'}方向的${genDifficulty.value}面试题（优先场景排障类，贴近真实生产）。
严格按以下 markdown 格式输出：
## 题干
（题干内容）
## 背景（场景题必填，非场景题写"无"）
## 参考答案
（分点、含命令示例的答案）
## 可能的追问
- 追问1
- 追问2`
  }
  return '你是运维/DevOps/SRE 学习辅导专家，回答准确、简洁、贴近生产实践，适当给命令示例。用中文回答。'
}

async function send() {
  if (streaming.value) return
  const userText = input.value.trim()
  if (scene.value === 'chat' && !userText) return
  if (scene.value === 'followup' && !followQuestionId.value) {
    ElMessage.warning('请先填题目ID')
    return
  }
  let content = userText
  if (scene.value === 'followup') {
    const d = await api.questionDetail(followQuestionId.value)
    content = `题目：${d.question.title}\n\n${userText || '请针对这道题给出深度讲解和追问方向。'}`
  }
  if (scene.value === 'generate') {
    content = `请按格式生成一道${genTopic.value || '运维'}方向${genDifficulty.value}面试题。`
  }
  if (scene.value === 'interview' && messages.length === 0 && !userText) {
    content = '面试官你好，请开始。'
  } else if (scene.value === 'interview' && messages.length === 0) {
    content = `面试官你好，请开始。我先自我介绍：我熟悉 ${userText}`
  }
  if (!content) return

  messages.value.push({ role: 'user', content })
  input.value = ''
  const aiMsg = { role: 'assistant', content: '', streaming: true }
  messages.value.push(aiMsg)
  streaming.value = true
  scrollToBottom()

  try {
    const chatMessages = [{ role: 'system', content: buildSystemPrompt() },
      ...messages.value.slice(0, -1).map(m => ({ role: m.role, content: m.content }))]

    const res = await fetch('/api/ai/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ messages: chatMessages, temperature: 0.7 })
    })
    const reader = res.body.getReader()
    const decoder = new TextDecoder()
    let buf = ''
    while (true) {
      const { done, value } = await reader.read()
      if (done) break
      buf += decoder.decode(value, { stream: true })
      const parts = buf.split('\n\n')
      buf = parts.pop()
      for (const part of parts) {
        const evLine = part.split('\n').find(l => l.startsWith('event:'))
        const dataLine = part.split('\n').find(l => l.startsWith('data:'))
        if (!dataLine) continue
        const ev = evLine ? evLine.slice(6).trim() : 'message'
        const data = dataLine.slice(5)
        if (ev === 'message') {
          aiMsg.content += data
          scrollToBottom()
        } else if (ev === 'error') {
          ElMessage.error(data)
        }
      }
    }
  } catch (e) {
    ElMessage.error('请求失败：' + e.message)
  } finally {
    aiMsg.streaming = false
    streaming.value = false
  }
}

function saveGenerated(md) {
  const topic = topics.value.find(t => t.name === genTopic.value)
  const titleMatch = md.match(/## 题干\n([\s\S]*?)(\n## |$)/)
  const answerMatch = md.match(/## 参考答案\n([\s\S]*?)(\n## |$)/)
  const contentMatch = md.match(/## 背景[^\n]*\n([\s\S]*?)(\n## |$)/)
  const followMatch = md.match(/## 可能的追问\n([\s\S]*?)$/)
  saveForm.value = {
    topicId: topic?.id || null,
    type: contentMatch && !/^无/.test(contentMatch[1].trim()) ? 'SCENARIO' : 'QA',
    title: (titleMatch ? titleMatch[1] : md).trim().slice(0, 400),
    answer: (answerMatch ? answerMatch[1] : md).trim()
  }
  saveVisible.value = true
}

async function confirmSave() {
  await api.createQuestion({ ...saveForm.value, followUps: [], tags: ['AI生成'], source: '自建' })
  ElMessage.success('已入题库（可在题库页管理）')
  saveVisible.value = false
}

function clearChat() {
  messages.value = []
}

function scrollToBottom() {
  nextTick(() => { if (chatBox.value) chatBox.value.scrollTop = chatBox.value.scrollHeight })
}

onMounted(async () => {
  await store.loadTopics()
  topics.value = store.topics
  loadConfig()
})
</script>

<style scoped>
.head { display: flex; gap: 10px; align-items: center; cursor: pointer; }
.toggle { margin-left: auto; color: #909399; font-size: 12px; }
.chat { height: calc(100vh - 330px); overflow-y: auto; padding: 6px; background: #fafbfc; border-radius: 6px; }
.chat-empty { text-align: center; color: #bbb; padding: 60px 20px; }
.msg { display: flex; margin: 8px 0; }
.msg.user { justify-content: flex-end; }
.bubble { max-width: 78%; padding: 10px 14px; border-radius: 10px; font-size: 14px; }
.msg.user .bubble { background: #409eff; color: #fff; }
.msg.assistant .bubble { background: #fff; border: 1px solid #ebeef5; }
.bubble pre { white-space: pre-wrap; word-break: break-word; font-family: inherit; margin: 0; }
.cursor { animation: blink 1s infinite; color: #409eff; }
@keyframes blink { 50% { opacity: 0; } }
.scene-bar { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 10px; }
.input-bar { display: flex; gap: 10px; margin-top: 10px; }
.gen-actions { margin-top: 6px; }
</style>
