<template>
  <button class="back-button" @click="goBack">
    <svg class="icon" viewBox="0 0 24 24">
      <path fill="currentColor" d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
    </svg>
    <span class="text">返回</span>
  </button>
</template>

<script lang="ts" setup>
import { useRouter } from 'vue-router'
const router = useRouter()

const goBack = () => {
  if (window.history.state.back) {
    router.go(-1)
  } else {
    router.push('/') // 如果没有历史记录则返回首页
  }
}
</script>

<style scoped lang="scss">
.back-button {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  left: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.8rem 1.5rem;
  background: rgba(255, 255, 255, 0.9);
  border: none;
  border-radius: 50px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(8px);
  z-index: 1000;

  &:hover {
    transform: translateY(-50%) translateY(-2px);
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
    background: rgba(255, 255, 255, 1);

    .icon {
      transform: translateX(-3px);
    }
  }

  .icon {
    width: 1.25rem;
    height: 1.25rem;
    transition: transform 0.3s ease;
  }

  .text {
    font-family: system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif;
    font-size: 0.9rem;
    color: #2c3e50;
    font-weight: 500;
  }

  @media (max-width: 768px) {
    bottom: auto;
    right: auto;
    top: 50%;
    transform: translateY(-50%);
    left: 1rem;
    padding: 0.6rem 1.2rem;
    
    .icon {
      width: 1.1rem;
      height: 1.1rem;
    }
    
    .text {
      display: none; // 移动端只显示图标
    }
  }
}
</style>    