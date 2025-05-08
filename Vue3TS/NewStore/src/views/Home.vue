<template>
  <div class="home">
      <!-- 主内容区域 -->
      <main class="main-content">
          <HeadlineNews :isLoading="isLoading" :sliderNewsList="sliderNewsList" />
          <NewsCategory :categories="categories" />
          <!-- 最新新闻 -->
          <NewNews />
      </main>

      <!-- 侧边栏 -->
      <aside class="sidebar">
          <!-- 快速入口 -->
          <div class="quick-links block">
              <h3 class="section-title">快速入口</h3>
              <div v-for="(link, index) in quickLinks" :key="index">
                  <a v-if="!link.path" href="javascript:void(0)" class="link" @click="link.action">
                      {{ link.title }}
                  </a>
                  <!-- 其他路由链接 -->
                  <router-link v-else :to="link.path" class="link">
                      {{ link.title }}
                  </router-link>
              </div>
          </div>
          <BeijingTime />
          <Lunner />

          <!-- 视频专区 -->
          <div class="video-section block">
              <h3 class="section-title">视频专区</h3>
              <div class="video-item" v-for="video in videos" :key="video.id">
                  <router-link :to="video.path" class="video-link">
                      <div class="video-thumbnail-container">
                          <img :src="video.thumbnail" alt="视频缩略图" class="video-thumbnail">
                      </div>
                      <h4 class="video-title">{{ video.title }}</h4>
                  </router-link>
              </div>
          </div>
      </aside>

      <!-- 登录弹窗 -->
      <div v-if="showLoginModal" class="login-modal">
          <div class="modal-overlay" @click="closeLoginModal"></div>
          <div class="modal-content">
              <Login @close="closeLoginModal" />
          </div>
      </div>
  </div>
</template>

<script lang="ts" setup>
  import { ref, onMounted, onUnmounted, watch, toRefs } from 'vue';
  import { useRouter } from 'vue-router';
  import { ArticleStatus, getNewsList as apiGetNewsList } from '@/api/news';
  import BeijingTime from '@/components/BeijingTime.vue';
  import Login from "@/views/user/Login.vue";
  import Lunner from "@/components/Lunner.vue";
  import NewNews from './home/NewNews.vue';
  import HeadlineNews from '@/views/news/HeadlineNews.vue';
  import NewsCategory from '@/views/news/NewsCategory.vue';
  import newsCache from '@/cache/newsCache';
  import userCache from '@/cache/userCache';

  const router = useRouter();
  const showLoginModal = ref(false);
  const tip = ref("登录 / 注册");
  const isMobile = ref(window.innerWidth < 768);

  // 模拟数据
  const categories = ref([
    { path: '/news/society', name: '十四大', icon: 'src/assets/imges/14th.png' },
    { path: '/news/politics', name: '政治', icon: 'src/assets/imges/Political.png' },
    { path: '/news/economy', name: '经济', icon: 'src/assets/imges/Economic.png' },
    { path: '/news/science', name: '科技', icon: 'src/assets/imges/Technology.png' },
    { path: '/news/society', name: '社会', icon: 'src/assets/imges/social.png' },
  ]);

  const videos = ref([
    { id: 1, path: '/src/assets/imges/01.png', thumbnail: '/src/assets/imges/01.png', title: '中国科技发展纪实' },
  ]);

  // 轮播图新闻列表
  const sliderNewsList = ref<any[]>([]);
  const newsList = ref<any[]>([]);
  // 加载状态
  const isLoading = ref(true);
  const error = ref('');

  // 获取新闻列表的函数
  const fetchNewsList = async (
    page: number = 1,
    pageSize: number = 10,
    status: ArticleStatus = ArticleStatus.PUBLISH
  ) => {
    isLoading.value = true;
    error.value = '';

    const cacheKey = newsCache.generatePageKey({ page, pageSize, status });
    const cachedData = newsCache.getPageCache(cacheKey);

    if (cachedData) {
        sliderNewsList.value = cachedData.slice(0, 6);
        newsList.value = cachedData;
        isLoading.value = false;
        return;
    }

    try {
        const response = await apiGetNewsList({ page, pageSize, status });
        newsList.value = Array.isArray(response?.data.content) ? response?.data.content : [];
        sliderNewsList.value = response?.data.content.slice(0, 6);
        newsCache.saveCacheData(cacheKey, response?.data.content, 7200000);
    } catch (err: any) {
    } finally {
        isLoading.value = false;
    }
  };

  // 在用户登录后调用此方法
  const updateTip = () => {
    tip.value = userCache.getUserCache() ? '个人中心' : '登录 / 注册';
    quickLinks.value[0].title = tip.value;
    quickLinks.value = [...quickLinks.value];
  };

  const check = () => {
    const storedUserInfo = userCache.getUserCache();
  };

  // 打开登录弹窗
  const openLoginModal = () => {
    const currentUser = userCache.getUserCache();
    if (currentUser) {
        if (isMobile.value) {
            router.push('/myHome');
        } else {
            router.push('/index');
        }
        return;
    }
    showLoginModal.value = true;
  };
    // 联系客服
    const openServicel = () => {
    const currentUser = userCache.getUserCache();
    if (currentUser) {
        router.push('/getService');
        return;
    }
    showLoginModal.value = true;
  };

  // 关闭登录弹窗
  const closeLoginModal = () => {
    showLoginModal.value = false;
  };

  // 监听ESC键
  const onKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'Escape' && showLoginModal.value) {
        closeLoginModal();
    }
  };

  // 修改快速入口数据，移除路由跳转
  const quickLinks = ref([
    { title: tip.value, action: openLoginModal },
    { path: '/aliPay', title: '开通会员' },
    { path: '/pay', title: '支付' },
    { title: '支持与服务', action: openServicel },
    { path: '/addNews', title: '添加新闻' },
    { path: '/about', title: '关于我们' },
  ]);

  // 监听窗口大小变化
  const handleResize = () => {
    isMobile.value = window.innerWidth < 768;
  };

  onMounted(() => {
    window.addEventListener('keydown', onKeyDown);
    window.addEventListener('resize', handleResize);
    fetchNewsList();
    updateTip();
    window.scrollTo(0, 0);
  });

  onUnmounted(() => {
    window.removeEventListener('keydown', onKeyDown);
    window.removeEventListener('resize', handleResize);
  });

  // 监听用户缓存变化
  watch(() => userCache.getUserCache()?.user_id, () => {
    updateTip();
  });

  // 解构响应式数据
  const { showLoginModal: showLoginModalRef, isLoading: isLoadingRef, tip: tipRef } = toRefs({
    showLoginModal,
    isLoading,
    tip
  });
</script>

<style scoped lang="scss">
/* 全局样式 */
.home {
  user-select: none;
  margin: 1% 1%;
  max-width: 100vw;
  display: grid;
  grid-template-columns: 3fr 1fr;
  gap: 1rem;
  animation: fadeIn 0.5s ease-out;
}

.section-title {
  color: transparent;
  font-size: 1.8rem;
  margin-bottom: 1.5rem;
  border-bottom: 5px solid transparent;
  background: linear-gradient(135deg, #0055ff, #6b00bc);
  -webkit-background-clip: text;
  background-clip: text;
  border-image: linear-gradient(135deg, #0055ff, #6b00bc) 1;
  padding-bottom: 0.8rem;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.el-input__inner {
  color: transparent;
  background: linear-gradient(135deg, #0055ff, #6b00bc);
  -webkit-background-clip: text;
  background-clip: text;
  transition: all 0.3s ease;
  -webkit-text-fill-color: transparent;
}

.el-input__inner:focus {
  background: linear-gradient(135deg, #00a97c, #0055ff);
  -webkit-background-clip: text;
  background-clip: text;
}

.el-input__inner:disabled {
  opacity: 0.6;
  background: linear-gradient(135deg, #e0e0e0, #c3c3c3)!important;
  -webkit-background-clip: text;
  background-clip: text;
}

.block {
  background-color: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
  padding: 2rem;
  margin-bottom: 1rem;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.block:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 36px rgba(0, 0, 0, 0.15);
}

/* 登录弹窗样式 */
.login-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1000;
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-overlay {
  position: absolute;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
  position: relative;
  z-index: 1001;
  padding: 0rem;
  border-radius: 0px;
  width: 100%;
  max-width: 400px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
}

/* 侧边栏 */
.sidebar {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.quick-links .link {
  color: #1890ff;
  position: relative;
  padding-bottom: 4px;
  display: block;
  transition: color 0.3s ease;
}

.quick-links .link::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 2px;
  background-color: #1890ff;
  transition: width 0.3s ease;
}

.quick-links .link:hover {
  color: #1890ff;
}

.quick-links .link:hover::after {
  width: 100%;
}

.video-item {
  display: flex;
  gap: 1.5rem;
  margin-bottom: 2rem;
  border-radius: 16px;
  overflow: hidden;
  transition: transform 0.3s ease;
}

.video-item:hover {
  transform: translateX(8px);
}

.video-link {
  text-decoration: none;
  color: inherit;
  display: flex;
  align-items: center;
}

.video-thumbnail-container {
  position: relative;
  overflow: hidden;
  border-radius: 8px;
}

.video-thumbnail {
  width: 120px;
  height: 90px;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.video-item:hover .video-thumbnail {
  transform: scale(1.1);
}

.video-title {
  font-size: 1rem;
  color: #2c3e50;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .home {
      grid-template-columns: 1fr;
  }

  .video-item {
      flex-direction: column;
      align-items: center;
  }
}

/* 手机端优化 */
@media (max-width: 768px) {
  .home {
      margin: 1% 1% 0 1%;
      grid-template-columns: 1fr;
  }

  .block {
      padding: 1.2rem;
      border-radius: 16px;
  }

  .section-title {
      font-size: 1.3rem;
      margin-bottom: 1rem;
  }

  /* 侧边栏 */
  .sidebar {
      gap: 1.5rem;
  }

  .quick-links {
      padding: 1.2rem;
  }

  .link {
      font-size: 1rem;
      padding: 0.8rem 1rem;
      border-radius: 8px;
      text-align: center;
      background: rgba(240, 240, 240, 0.8);
  }

  /* 视频专区 */
  .video-item {
      flex-direction: column;
      align-items: center;
      gap: 1rem;
      margin-bottom: 1.5rem;
  }

  .video-thumbnail {
      width: 100%;
      height: 150px;
  }

  .video-title {
      font-size: 1.1rem;
  }

  /* 登录弹窗 */
  .modal-content {
      max-width: 90%;
      border-radius: 16px;
  }
}

/* 超小屏幕优化 */
@media (max-width: 480px) {
  .home {
      margin: 2% 1% 0 1%;
  }

  .block {
      padding: 1rem;
      border-radius: 12px;
  }

  .section-title {
      font-size: 1.1rem;
  }

  .quick-links .link {
      padding: 0.6rem 0.8rem;
      font-size: 0.9rem;
  }

  .video-thumbnail {
      height: 120px;
  }

  .video-title {
      font-size: 1rem;
  }
}

/* 动画效果 */
@keyframes fadeIn {
  from {
      opacity: 0;
      transform: translateY(20px);
  }
  to {
      opacity: 1;
      transform: translateY(0);
  }
}
</style>
  