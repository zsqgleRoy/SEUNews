<template>
    <div class="mobile-tab-bar">
      <div 
        v-for="tab in tabs"
        :key="tab.id"
        class="tab-item"
        :class="{ 'active': activeTab === tab.id }"
        @click="switchTab(tab)"
      >
        <div class="tab-icon">{{ tab.icon }}</div>
        <div class="tab-label">{{ tab.label }}</div>
      </div>
    </div>
</template>
  
<script setup lang="ts">
  import { ref, computed } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  
  type Tab = {
    id: number
    label: string
    icon: string
    routePath: string
  }
  
  const tabs: Tab[] = [
    { id: 1, label: '首页', icon: '🏠', routePath: '/' },
    { id: 2, label: '订单', icon: '📦', routePath: '/orders' },
    { id: 3, label: '我的', icon: '👤', routePath: '/myHome' }
  ]
  
  const router = useRouter()
  const route = useRoute()
  
  const activeTab = computed(() => {
    const currentTab = tabs.find(tab => tab.routePath === route.path)
    return currentTab ? currentTab.id : 1
  })
  
  const switchTab = (tab: Tab) => {
    router.push(tab.routePath)
  }
</script>
  
<style scoped>
  .mobile-tab-bar {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    height: 50px;
    background: #ffffff;
    display: flex;
    justify-content: space-around;
    align-items: center;
    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
    z-index: 1000;
  }
  
  .tab-item {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
    cursor: pointer;
  }
  
  .tab-icon {
    font-size: 20px;
  }
  
  .tab-label {
    font-size: 12px;
    color: #666;
  }
  
  .active .tab-icon {
    color: #007AFF;
  }
  
  .active .tab-label {
    color: #007AFF;
    font-weight: 600;
  }
</style>