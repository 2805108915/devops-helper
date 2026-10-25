import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  { path: '/', name: 'dashboard', component: () => import('../views/Dashboard.vue'), meta: { title: '仪表盘' } },
  { path: '/questions', name: 'questions', component: () => import('../views/Questions.vue'), meta: { title: '题库刷题' } },
  { path: '/study/:id', name: 'study', component: () => import('../views/Study.vue'), meta: { title: '刷题' } },
  { path: '/review', name: 'review', component: () => import('../views/Review.vue'), meta: { title: '今日复习' } },
  { path: '/labs', name: 'labs', component: () => import('../views/Labs.vue'), meta: { title: '实操实验室' } },
  { path: '/labs/:id', name: 'labDetail', component: () => import('../views/LabDetail.vue'), meta: { title: '实验' } },
  { path: '/knowledge', name: 'knowledge', component: () => import('../views/Knowledge.vue'), meta: { title: '知识库' } },
  { path: '/positions', name: 'positions', component: () => import('../views/Positions.vue'), meta: { title: '岗位路线' } },
  { path: '/ai', name: 'ai', component: () => import('../views/AiChat.vue'), meta: { title: 'AI 助手' } }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
