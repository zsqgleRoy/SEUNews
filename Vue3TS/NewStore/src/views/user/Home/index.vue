<template>
  <div class="container">
    <template v-if="isDesktop">
      <LongBanner />
      <div class="main-layout">
        <div 
          class="menu-wrapper"
          :style="{ width: menuWidth }"
        >
          <div class="menu-container" v-if="isMenuVisible">
            <Menu @menuItemClick="handleMenuItemClick" />
          </div>
          <div 
            class="collapse-handle"
            @click="toggleMenu"
            :style="{ left: handlePosition }"
          >
            <span class="collapse-icon">
              {{ isMenuCollapsed ? '▶' : '◀' }}
            </span>
          </div>
        </div>

        <!-- 主要内容区域 -->
        <div 
          class="content-wrapper"
          :style="{ 'margin-left': 0 }"
        >
          <router-view :key="$route.fullPath" />
        </div>
      </div>
    </template>

    <template v-else>
      <!-- 移动端布局 -->
      <Menu 
        v-if="showMobileMenu" 
        @menuItemClick="handleMobileMenuItemClick" />
      <div 
        v-else
        class="mobile-content"
      >
        <router-view :key="$route.fullPath" />
      </div>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, computed, toDisplayString, onActivated, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import LongBanner from './LongBanner.vue'
import Menu from "./LeftMenu.vue"

const router = useRouter()
const route = useRoute()

// 响应式状态
const isDesktop = ref(true)
const showMobileMenu = ref(true)
const isMenuCollapsed = ref(false)
const menuWidth = ref('250px')
const isMenuVisible = ref(true)
// 计算属性样式
const handlePosition = computed(() => isMenuCollapsed.value ? '0' : '250px')

// 切换菜单状态
const toggleMenu = () => {
  isMenuCollapsed.value = !isMenuCollapsed.value
  menuWidth.value = isMenuCollapsed.value ? '0' : '250px'
  isMenuVisible.value = !isMenuCollapsed.value
}

// 路由处理
const handleMenuItemClick = (path: string) => {
  router.push(path)
  if (!isDesktop.value) showMobileMenu.value = false
}

const handleMobileMenuItemClick = (path: string) => {
  router.push(path)
  showMobileMenu.value = false
}

// 响应式布局处理
const updateLayout = () => {
  const isDesktopMode = window.innerWidth >= 768
  isDesktop.value = isDesktopMode
  
  if (isDesktopMode) {
    // 桌面端重置菜单状态
    isMenuCollapsed.value = false
    menuWidth.value = '250px'
    showMobileMenu.value = false
  } else {
    // 移动端处理
    showMobileMenu.value = route.path === '/myHome'
  }
}

// 生命周期和事件监听
onMounted(() => {
  window.addEventListener('resize', updateLayout)
  updateLayout()
})

onUnmounted(()=>{
  if (!isDesktop.value && route.path !== '/') {
    showMobileMenu.value = false
  }
})

onActivated(()=>{
  window.removeEventListener('resize', updateLayout)
})
</script>

<style scoped lang="scss">
.container {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background: #f5f6fa;
}

.main-layout {
  flex: 1;
  display: flex;
  position: relative;
  overflow: hidden;
}

.menu-wrapper {
  position: relative;
  height: 100%;
  transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  background: white;
  box-shadow: 2px 0 8px rgba(0,0,0,0.1);
  
  .menu-container {
    width: 250px;
    height: 100%;
    overflow-y: auto;
  }
}

.collapse-handle {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 20px;
  height: 50px;
  background: white;
  border: 1px solid #e8e8e8;
  border-left: none;
  border-radius: 0 6px 6px 0;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
  transition: 
    left 0.3s cubic-bezier(0.4, 0, 0.2, 1),
    background 0.2s;

  &:hover {
    background: #f8f9fa;
    box-shadow: 1px 1px 4px rgba(0,0,0,0.1);
  }

  .collapse-icon {
    font-size: 12px;
    color: #666;
  }
}

.content-wrapper {
  flex: 1;
  min-height: calc(100vh - 60px);
  background: white;
  transition: margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow-y: auto;
}

.mobile-content {
  flex: 1;
  overflow-y: auto;
}

@media (max-width: 767px) {
  .container {
    height: auto;
    min-height: 100vh;
  }
}
</style>