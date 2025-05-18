<template>
  <el-scrollbar>
      <div class="scrollbar-flex-content" @click="closeMenuIfMobile">
          <p v-for="item in menuItems" :key="item.tagId" class="scrollbar-demo-item">
              <!-- <router-link :to="item.path" :class="{ 'active-link': isActiveRoute(item.path) }"> -->
              <router-link :to="`/newsList/${item.tagId}`" :class="{ 'active-link': isActiveRoute(item.path) }">
                  {{ item.label }}
              </router-link>
          </p>
      </div>
  </el-scrollbar>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { getMenuItemList } from "@/api/menu";
import menuCache from '@/cache/menuCache';
import { ElMessage } from 'element-plus';

const route = useRoute();
const isMenuOpen = ref(false);
const error = ref<string>('');
const isLoading = ref<boolean>(true);
const menuItems = ref<any[]>([]);

// 计算当前路由是否激活
const isActiveRoute = computed(() => {
  return (path: string) => route.path === path;
});

const closeMenuIfMobile = () => {
  if (isMenuOpen.value) {
      isMenuOpen.value = false;
  }
};

// 获取导航栏菜单列表的函数
const fetchMenuItems = async () => {
  isLoading.value = true;
  error.value = '';

  const cacheKey = menuCache.generateCacheKey();
  const cachedData = menuCache.getCache(cacheKey);

  if (cachedData) {
      menuItems.value = cachedData;
      isLoading.value = false;
      return;
  }

  try {
      const response = await getMenuItemList();
      menuItems.value = response.data;
      console.log(response.data)
      menuCache.saveCacheData(cacheKey, response.data, 7200000);
  } catch (err: any) {
      error.value = err.message || '获取导航栏列表失败';
      ElMessage.error('获取菜单数据失败:' + err);
  } finally {
      isLoading.value = false;
  }
};

onMounted(() => {
  fetchMenuItems();
});
</script>

<style scoped lang="scss">
/* 基础容器样式 */
.el-scrollbar {
  --menu-bg: linear-gradient(135deg, #174fa9, #6b00bcae);
  --gold-gradient: linear-gradient(45deg, 
    #0062ff 10%,
    #00ddff 50%,
    #00ffaeae 100%
  );
  --glow-effect: 0 4px 20px rgba(255, 215, 0, 0.2);
  --hover-bg: rgba(255, 215, 0, 0.1);
  --active-bg: rgba(255, 215, 0, 0.15);
}

.scrollbar-flex-content {
  display: flex;
  padding: 0.5rem 1rem;
  background: var(--menu-bg);
  backdrop-filter: blur(8px);
  box-shadow: var(--glow-effect);
  width: 100%;
}

/* 菜单项样式 */
.scrollbar-demo-item {
  flex: 0 0 auto;
  margin: 0 0.25rem;
  position: relative;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);

  a {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 60px;
    height: 30px;
    border-radius: 2px;
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(4px);
    color: rgba(224, 231, 255, 1);
    font-weight: 500;
    text-decoration: none;
    transition: all 0.3s ease;
    border: 1px solid transparent;
    
    &::before {
      content: '';
      position: absolute;
      top: -2px;
      left: -2px;
      right: -2px;
      bottom: -2px;
      background: var(--gold-gradient);
      z-index: -1;
      opacity: 0;
      border-radius: 10px;
      transition: opacity 0.3s ease;
    }
  }

  &:hover a {
    transform: translateY(-3px);
    box-shadow: var(--glow-effect);
    background: var(--hover-bg);
    
    &::before {
      opacity: 0.3;
    }
  }
}

/* 激活状态 */
.active-link {
  position: relative;
  background: var(--active-bg) !important;
  color: #ffd700 !important;
  border: 1px solid var(--border-color) !important;

  &::after {
    content: '';
    position: absolute;
    bottom: -8px;
    left: 50%;
    transform: translateX(-50%);
    width: 60%;
    height: 3px;
    background: var(--gold-gradient);
    border-radius: 2px;
    animation: pulse 1.5s infinite;
  }

  &::before {
    opacity: 0.5 !important;
  }
}

@keyframes pulse {
  10% { width: 60%; opacity: 0.8; }
  50% { width: 80%; opacity: 1; }
  100% { width: 60%; opacity: 0.8; }
}

:deep(.el-scrollbar__bar) {
  &.is-horizontal {
    height: 4px;
    
    .el-scrollbar__thumb {
      background: var(--gold-gradient);
      border-radius: 2px;
    }
  }
}

/* 移动端适配 */
@media (max-width: 768px) {
  .scrollbar-flex-content {
    padding: 0.4rem;
    min-width: max-content;
  }

  .scrollbar-demo-item {
    margin: 0.1rem 0.3rem;
    
    a {
      width: 60px;
      height: 30px;
      font-size: 0.9rem;
    }
  }

  .active-link::after {
    bottom: -6px;
    height: 2px;
  }
}
</style>    