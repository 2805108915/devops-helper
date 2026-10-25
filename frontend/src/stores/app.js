import { defineStore } from 'pinia'
import api from '../api'

export const useAppStore = defineStore('app', {
  state: () => ({
    topics: [],
    topicsLoaded: false,
    // 跨页共享的题库筛选（岗位页跳转用）
    questionFilter: {}
  }),
  actions: {
    async loadTopics(force = false) {
      if (this.topicsLoaded && !force) return
      this.topics = await api.topics()
      this.topicsLoaded = true
    },
    topicName(id) {
      const t = this.topics.find(t => t.id === id)
      return t ? t.name : '未分类'
    },
    setQuestionFilter(f) {
      this.questionFilter = f
    }
  }
})
