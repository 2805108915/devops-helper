<template>
  <el-container class="layout">
    <el-aside width="210px" class="sidebar">
      <div class="brand">
        <span class="logo">🛠️</span>
        <div>
          <div class="brand-name">DevOpsHelper</div>
          <div class="brand-sub">运维学习与面试备战</div>
        </div>
      </div>
      <el-menu :default-active="$route.path" router background-color="#1d2530"
               text-color="#9aa5b5" active-text-color="#409eff">
        <el-menu-item index="/"><el-icon>📊</el-icon>仪表盘</el-menu-item>
        <el-menu-item index="/questions"><el-icon>📝</el-icon>题库刷题</el-menu-item>
        <el-menu-item index="/review"><el-icon>🔁</el-icon>今日复习</el-menu-item>
        <el-menu-item index="/labs"><el-icon>🧪</el-icon>实操实验室</el-menu-item>
        <el-menu-item index="/knowledge"><el-icon>📚</el-icon>知识库</el-menu-item>
        <el-menu-item index="/positions"><el-icon>🧭</el-icon>岗位路线</el-menu-item>
        <el-menu-item index="/ai"><el-icon>🤖</el-icon>AI 助手</el-menu-item>
      </el-menu>
    </el-aside>
    <el-main class="main">
      <router-view />
    </el-main>
  </el-container>
</template>

<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
html, body, #app { height: 100%; }
.layout { height: 100vh; }
.sidebar { background: #1d2530; display: flex; flex-direction: column; }
.brand { display: flex; gap: 10px; align-items: center; padding: 18px 16px 14px; border-bottom: 1px solid #2c3542; }
.logo { font-size: 26px; }
.brand-name { color: #fff; font-weight: 600; font-size: 15px; }
.brand-sub { color: #7a8798; font-size: 11px; }
.sidebar .el-menu { border-right: none; flex: 1; }
.main { background: #f0f2f5; padding: 16px; overflow-y: auto; }
.page-card { margin-bottom: 14px; }
</style>
