<template>
  <!-- 应用根容器 -->
  <div id="app">
    <el-affix :offset="0" v-if="isShow">
      <Header></Header>
    </el-affix>
    <navbar v-if="isShow" />
    <Menu v-else-if="!is404" @menuItemClick="handleMenuItemClick" ></Menu>
    <MainImg v-if="isMain"></MainImg>
    <!-- 路由视图容器，在显示头部或 404 页面时显示 -->
    <div class="view" v-if="isShow || is404">
      <template v-if="isLoading">
        <LoadingComponent :loading="isLoading" />
      </template>
      <router-view v-slot="{ Component }">
        <keep-alive :max="5">
          <component :is="Component" />
        </keep-alive>
      </router-view>
    </div>
    <el-backtop :right="10" :bottom="100" />
    <Footer v-if="isShow && noFooter" ></Footer>
    <Footer2 v-if="isShow && !noFooter" />
  </div>
  <BottomNavbar v-if="!isDesktop && noFooter && isShow" />
</template>

<script lang="ts" setup>
import MainImg from "@/components/common/MainImg.vue";
import { onMounted, onBeforeUnmount, ref, computed } from 'vue';
import Header from '@/components/common/Header.vue';
import Footer from '@/components/common/Footer.vue';
import Footer2 from '@/components/common/FooterSample.vue';
import Menu from '@/views/user/Home/index.vue';
import { useRoute, useRouter } from 'vue-router';
import navbar from "./components/common/navbar.vue";
import LoadingComponent from "@/components/common/LoadingComponent.vue";
import BottomNavbar from "./components/foMobile/BottomNavbar.vue";

const row = ref(0);
// 定义不需要显示 Header 的路由名称
const excludeRoutes = new Set([
  'AddNews', 'myHome', 'index',
  'VIP', 'NewsManage', 'EditNews',
  'Service','ModifyUserData', 'addUser',
  'userManage'
]);
// 定义不需要显示 Footer 的路由名称
const noFootRoutes = new Set([
  'NewsDetail', 'NewsList', 'SearchResult'
]);

const route = useRoute();
const router = useRouter();
const isDesktop = ref(window.innerWidth >= 768);
const isLoading = ref(true);

// 判断是否为 404 页面
const is404 = computed(() => {
  return route.name === 'NotFound'
    || route.name === 'ErrorState'
    || route.name === 'RETURN'
    || route.name === 'AboutUS'
    || route.name === 'PAY'
    || route.name === 'WeChatPay'
    || route.name === 'QQPay'
    || route.name === 'GSPay'
    || route.name === 'SZRMBPay'
    || route.name === 'PersonInfo'
    ;
});

// 判断是否为首页
const isMain = computed(() => {
  return route.name === 'Home';
});

// 根据当前路由动态计算是否显示 Header
const isShow = computed(() => {
  return !excludeRoutes.has(route.name as string) && !is404.value;
});

const noFooter = computed(() => {
  return !noFootRoutes.has(route.name as string);
});

// 处理菜单点击事件
const handleMenuItemClick = (routePath: string) => {
  if (!isDesktop.value) {
    router.push(routePath);
  }
};

// 防抖函数
const debounce = (func: Function, delay: number) => {
  let timer: number | null = null;
  return () => {
    if (timer) {
      clearTimeout(timer);
    }
    timer = setTimeout(() => {
      func();
      timer = null;
    }, delay);
  };
};

// 封装监听窗口大小变化的函数
const useWindowResize = () => {
  const handleResize = () => {
    isDesktop.value = window.innerWidth >= 768;
  };

  row.value = isDesktop.value ? 14 : 18;

  const debouncedHandleResize = debounce(handleResize, 200);

  onMounted(() => {
    window.addEventListener('resize', debouncedHandleResize);
  });

  onBeforeUnmount(() => {
    window.removeEventListener('resize', debouncedHandleResize);
  });
};

const loadStartTime = ref();
// 路由切换开始
router.beforeEach((to, from, next) => {
  isLoading.value = true;
  loadStartTime.value = Date.now(); // 记录开始时间
  next();
});

// 路由切换结束
router.afterEach(() => {
  const minDisplayTime = 2500;
  const elapsed = Date.now() - loadStartTime.value;
  const remaining = Math.max(minDisplayTime - elapsed, 0);

  // 剩余时间后关闭loading
  setTimeout(() => {
    isLoading.value = false;
    // 滚动到页面顶部
    window.scrollTo(0, 0);
  }, remaining);
});

// 使用封装的窗口大小变化监听函数
useWindowResize();
</script>

<style scoped lang="scss">
  #app {
    font-family: 'Inter', sans-serif;
    line-height: 1.6;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }

  .view {
    max-width: 100vw;
  }

  /* 合并媒体查询 */
  @media (min-width: 480px) {
    .view {
      padding-top: 60px;
      padding: 0;
      max-width: 100vw;
    }
  }

  @media (min-width: 768px) {
    .view {
      padding: 0;
    }
  }

  @media (min-width: 1024px) {
    .view {
      max-width: 100vw;
      margin: 0 0 0 0;
    }
  }

  /* 全局元素样式 */
  button,
  a {
    transition: all 0.2s ease;
  }

  button:hover,
  a:hover {
    opacity: 0.9;
  }

  /* 暗黑模式支持 */
  :root {
    --bg-color: #FFFFFF;
    --text-color: #2D3748;
  }

  .dark {
    --bg-color: #1A202C;
    --text-color: #E2E8F0;
  }

  body {
    background-color: var(--bg-color);
    color: var(--text-color);
  }

  ::-moz-selection {
    background: transparent;
  }

  /* 禁用长按菜单 (移动端) */
  @media (hover: none) {
    * {
      -webkit-touch-callout: none;
      -webkit-tap-highlight-color: transparent;
    }
  }
</style>