<template>
  <div class="news-view">
    <!-- 加载状态 -->
    <template v-if="isLoading">
      <div class="status-container">
        <LoadingComponent :loading="isLoading" />
      </div>
    </template>

    <!-- 空状态 -->
    <template v-else-if="!article">
      <div class="status-container empty-state">
        <el-icon class="empty-icon"><DocumentDelete /></el-icon>
        <h3 class="status-title">暂无文章内容</h3>
        <p class="status-desc">推荐阅读其他新闻资讯</p>
        <router-link to="/news" class="link-btn">
          <el-button type="success">浏览新闻列表</el-button>
        </router-link>
      </div>
    </template>

    <!-- 正常内容 -->
    <template v-else>
      <article class="article-container">
        <header class="article-header">
          <h1 class="article-title">{{ article.title }}</h1>
          <!-- 元信息区域 -->
          <div class="meta-container">
            <!-- 作者信息 -->
            <div class="author-info">
              <el-avatar 
                @click="handlePersonPreview(userInfo.authorId || 0)"
                v-if="userInfo?.avatar" 
                :size="45" 
                :src="userInfo?.avatar"
                class="author-avatar"
              />
              <div class="author-details">
                <div class="author-name">{{ article.author }}</div>
                <div class="publish-info">
                  <time class="publish-date">
                    {{ formatDate(article.publishDate) }}
                  </time>
                  <span v-if="isUpdated" class="update-indicator">
                    （已更新）
                  </span>
                </div>
              </div>
            </div>

            <!-- 字体控制 -->
            <div class="toolbar">
              <el-button-group class="font-controls">
                <el-button 
                  :disabled="fontSize <= 10" 
                  @click="adjustFontSize(-2)"
                  class="font-btn"
                >
                  <el-icon><Remove /></el-icon>
                </el-button>
                <el-tooltip 
                  effect="light" 
                  content="重置字体大小" 
                  placement="top"
                >
                  <el-button 
                    class="font-reset"
                    @click="fontSize = 20"
                  >
                    {{ fontSize }}px
                  </el-button>
                </el-tooltip>
                <el-button 
                  :disabled="fontSize >= 44" 
                  @click="adjustFontSize(2)"
                  class="font-btn"
                >
                  <el-icon><CirclePlus /></el-icon>
                </el-button>
              </el-button-group>
            </div>
          </div>
        </header>

        <!-- 文章内容 -->
        <section 
          class="article-content ql-editor" 
          :style="{ fontSize: fontSize + 'px' }"
          v-html="article.content"
        ></section>

      </article>
        <!-- 互动区域 -->
      <NewsInteractionBar :article_id="id || 0"/>
      <CommentSection :articleId="id || 0" :userInfo="userInfo" />
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, onActivated } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import dayjs from 'dayjs';
import { getNewsById } from '@/api/news';
import LoadingComponent from "@/components/common/LoadingComponent.vue";
import NewsInteractionBar from "@/components/News/NewsInteractionBar.vue";
import type { UserInfo } from '@/cache/userCache';
import newsCache from '@/cache/newsCache';
import CommentSection from '@/components/CommentSection.vue';

const router = useRouter();
const route = useRoute();

const handlePersonPreview = (item: number) => {
  router.push(`/userInfo/${item}`)
  // emit('preview', item)
}

// 类型定义
interface Article {
  article_id: number;
  title: string;
  content: string;
  author: string;
  authorId: number;
  avatar?: string;
  publishDate: string;
  updateDate: string;
}

// 响应式数据初始化
const article = ref<Article | null>(null);
const isLoading = ref(true);
const errorMessage = ref('');
const errorDescription = ref('');
const fontSize = ref(20);
const userInfo = ref<UserInfo | null>(null);
const id = ref<number | null>(0);
const staticNum = ref(0);
// 计算属性
const isUpdated = computed(() => {
  return article.value?.publishDate !== article.value?.updateDate;
});

// 方法
const formatDate = (date: string) => {
  return dayjs(date).isValid() 
    ? dayjs(date).format('YYYY-MM-DD HH:mm')
    : '未知时间';
};

const adjustFontSize = (step: number) => {
  fontSize.value = Math.min(44, Math.max(10, fontSize.value + step));
};

const handleError = (err: any) => {
  errorMessage.value = '内容加载失败';
  errorDescription.value = err.message || '请检查网络连接';
  router.push('/ErrorState');
};
const fetchNews = async () => {
  try {
    isLoading.value = true;
    errorMessage.value = '';
    errorDescription.value = '';
    
    const response = await getNewsById(
      Number(route.params.id)
    );
    article.value = {
      ...response?.data,
      content: response?.data.content.replace(/\n/g, '<br>'),
      publishDate: new Date(response?.data.publishDate).toISOString(),
      updateDate: new Date(response?.data.updateDate).toISOString()
    };
    userInfo.value = response?.data;
  } catch (err) {
    handleError(err);
  } finally {
    isLoading.value = false;
  }
};

onMounted(async () => {
  window.scrollTo(0, 0);
});
onUnmounted(() => {
});

onActivated(()=>{
  id.value = Number(route.params.id);
  const cacheKey = newsCache.generateNewsIdKey(Number(id.value));
  const cachedData = newsCache.getNewsCache(cacheKey);
  if (cachedData?.avatar) {
    article.value = cachedData;        
    userInfo.value = cachedData;
    isLoading.value = false;
  } else {
    fetchNews();
  }
})
</script>

<style lang="scss" scoped>
.news-view {
  user-select: none;
  --content-max-width: 880px;
  --mobile-breakpoint: 768px;
  --base-font-size: 20px;
  --heading-ratio: 1.25;
  --spacing-unit: 1rem;
  min-height: 80vh;
  max-width: 100vw;
  margin: 10px;
}

/* 通用状态容器 */
.status-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 50vh;
  padding: 2rem;
  text-align: center;

  .status-title {
    font-size: calc(var(--base-font-size) * 1.5);
    margin: 1rem 0 0.5rem 0;
  }

  .status-desc {
    color: var(--el-text-color-secondary);
    margin-bottom: 1.5rem;
  }

  .error-icon, .empty-icon {
    font-size: 4rem;
    opacity: 0.8;
  }

  .error-icon {
    color: var(--el-color-error);
  }

  .empty-icon {
    color: var(--el-color-info);
  }
}

/* 文章容器 */
.article-container {
  user-select: none;
  width: 100%;
  max-width: 100vw;
  margin: 0 auto;
  background: var(--el-bg-color);
  border-radius: 12px;
  box-shadow: 0 4px 24px rgba(0, 0, 0, 0.06);
  padding: 2.5rem;
}

.article-header {
  border-bottom: 1px solid var(--el-border-color);
  padding-bottom: 2rem;
  margin-bottom: 2rem;
}

.article-title {
  font-size: calc(var(--base-font-size) * 2);
  line-height: 1.3;
  color: transparent;
  font-size: 2.2rem;
  margin-bottom: 1.5rem;
  border-bottom: 5px solid transparent;
  background: linear-gradient(135deg, #0055ff, #00c587);
  -webkit-background-clip: text;
  background-clip: text;
  margin-bottom: 1.5rem;
}

.meta-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
}

.author-info {
  display: flex;
  align-items: center;
  gap: 1rem;

  .author-avatar {
    flex-shrink: 0;
    background-color: white;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    width: 45px; 
    height: 45px; 
  }

  .author-avatar img {
    max-width: 100%;
    max-height: 100%;
    width: auto;
    height: auto;
    object-fit: contain;
  }

  .author-name {
    font-weight: 500;
    color: var(--el-text-color-primary);
  }

  .publish-info {
    font-size: 0.9em;
    color: var(--el-text-color-secondary);
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .news-view{
    margin: 0 10px;
  }
  .article-container {
    width: 100%;
    padding: 1.5rem 0.5rem 0 0.5rem;
    border-radius: 0;
    box-shadow: none;
  }

  .article-title {
    font-size: calc(var(--base-font-size) * 1.5);
  }

  .toolbar {
    justify-content: flex-end;
  }
}

@media (max-width: 480px) {
  .article-title{
    font-size: 22px;
  }
  .meta-container {
    flex-direction: column;
    align-items: flex-start;
  }

  .author-info {
    flex-direction: row;
    align-items: center;
    width: 100%;
  }

  .font-controls {
    width: 100%;
    justify-content: center;
  }
}
</style>    