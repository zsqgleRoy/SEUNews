<template>
  <div class="long-banner">
    <!-- 左边显示网站 logo -->
    <img src="@/assets/imges/seuLogo.png" alt="网站 logo" class="banner-logo">
    <!-- 中间的横幅文本 -->
    <span class="banner-text">东南新闻</span>
    <!-- 右边显示回到首页和退出图标 -->
    <div class="banner-actions">
      <router-link to="/home" class="action-link">回到首页</router-link>
      <span @click="handleLogout" class="action-icon">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
          <polyline points="16 17 21 12 16 7"></polyline>
          <line x1="21" y1="12" x2="9" y2="12"></line>
        </svg>
        <span>退出</span>
      </span>
    </div>
    <div class="particles"></div>
  </div>
</template>

<script setup lang="ts">
import { useUserStore  } from '@/store/userStore';
import { ElMessage } from 'element-plus';
import { ref } from 'vue';
import { useRouter } from 'vue-router';
const userStore = useUserStore();
const router = useRouter();
// 调用 Logout 函数时传递 router
const handleLogout = () => {
  userStore.logout(router);
};
</script>

<style scoped>
.long-banner {
  user-select: none;
  height: 80px; /* 固定高度，避免百分比带来的不确定性 */
  background: linear-gradient(135deg, #6b00bc 0%, #0055ff 100%);
  display: flex;
  align-items: center;
  justify-content: space-between; /* 使子元素分散排列 */
  position: relative;
  overflow: hidden;
  padding: 0 20px; /* 添加左右内边距 */
}

.banner-logo {
  width: 50px; /* 设置 logo 宽度 */
  height: 50px; /* 设置 logo 高度 */
  z-index: 1; /* 确保 logo 在粒子效果之上 */
}

.banner-text {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  font-size: 32px; /* 增大字体大小 */
  font-weight: 700; /* 增强字体粗细 */
  color: #fff;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3); /* 增强文字阴影 */
  z-index: 1; /* 确保文字在粒子效果之上 */
  animation: fadeIn 1s ease-in-out; /* 添加淡入动画 */
}

.banner-actions {
  display: flex;
  align-items: center;
  z-index: 1; /* 确保操作按钮在粒子效果之上 */
}

.action-link {
  color: white;
  text-decoration: none;
  margin-right: 25px; /* 设置回到首页和退出图标的间距 */
  transition: color 0.3s ease;
  font-family:Verdana, Geneva, Tahoma, sans-serif;
  font-weight: 500;
  font-size: 16px;
}

.action-link:hover {
  color: #ffbb00;
}

.action-icon {
  color: white;
  cursor: pointer;
  transition: color 0.3s ease;
  display: flex; /* 添加 flex 布局 */
  align-items: center; /* 垂直居中 */
}

.action-icon svg {
  margin-right: 3px; /* 添加图标和文字之间的间距 */
}

.action-icon:hover {
  color: #ffbb00;
}

.particles {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.particles::before,
.particles::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(255, 255, 255, 0.1);
  animation: particleAnimation 10s linear infinite;
}

.particles::after {
  animation-delay: -5s;
}

@keyframes fadeIn {
  from {
      opacity: 0;
      transform: translateY(-20px);
  }
  to {
      opacity: 1;
      transform: translateY(0);
  }
}

@keyframes particleAnimation {
  0% {
      transform: translate(0, 0) rotate(0deg);
  }
  100% {
      transform: translate(100%, 100%) rotate(360deg);
  }
}
</style>