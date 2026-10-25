import axios from 'axios'
import { ElMessage } from 'element-plus'

const http = axios.create({ baseURL: '/api', timeout: 60000 })

http.interceptors.response.use(
  res => {
    const body = res.data
    if (body && body.code !== undefined && body.code !== 0) {
      ElMessage.error(body.msg || '请求失败')
      return Promise.reject(new Error(body.msg))
    }
    return body ? body.data : null
  },
  err => {
    ElMessage.error(err.response?.data?.msg || err.message || '网络错误')
    return Promise.reject(err)
  }
)

export default {
  // 题库
  topics: () => http.get('/topics'),
  questions: params => http.get('/questions', { params }),
  questionDetail: id => http.get(`/questions/${id}`),
  createQuestion: data => http.post('/questions', data),
  updateQuestion: (id, data) => http.put(`/questions/${id}`, data),
  deleteQuestion: id => http.delete(`/questions/${id}`),
  // 复习
  review: (questionId, quality) => http.post(`/review/${questionId}`, { quality }),
  reviewToday: limit => http.get('/review/today', { params: { limit } }),
  reviewStats: () => http.get('/review/stats'),
  // 笔记
  getNote: (targetType, targetId) => http.get('/notes', { params: { targetType, targetId } }),
  saveNote: data => http.put('/notes', data),
  // 知识库
  kbList: params => http.get('/kb', { params }),
  kbDetail: id => http.get(`/kb/${id}`),
  kbCreate: data => http.post('/kb', data),
  kbUpdate: (id, data) => http.put(`/kb/${id}`, data),
  kbDelete: id => http.delete(`/kb/${id}`),
  // 岗位
  positions: () => http.get('/positions'),
  // 实验室
  labs: () => http.get('/labs'),
  labDetail: id => http.get(`/labs/${id}`),
  labStart: id => http.post(`/labs/${id}/instances`),
  labDockerStatus: () => http.get('/labs/docker-status'),
  labBuildImage: () => http.post('/labs/build-image'),
  labInstance: id => http.get(`/lab-instances/${id}`),
  labCheck: id => http.post(`/lab-instances/${id}/check`),
  labStop: id => http.post(`/lab-instances/${id}/stop`),
  // AI
  aiConfig: () => http.get('/ai/config'),
  aiSaveConfig: data => http.put('/ai/config', data)
}
