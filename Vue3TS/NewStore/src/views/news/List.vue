<template>
  <div class="news-list-container">
    <div class="news-list-header">
      <svg class="news-icon" viewBox="0 0 24 24">
        <path d="M4 6h16v2H4zm0 5h16v2H4zm0 5h16v2H4z"/>
      </svg>
      <h1 class="news-title">新闻动态</h1>
    </div>

    <div v-if="isLoading" class="loading-state">
      <svg class="spinner" viewBox="0 0 50 50">
        <circle class="path" cx="25" cy="25" r="20" fill="none" stroke-width="5"></circle>
      </svg>
      <div class="loading-text">数据加载中...</div>
    </div>

    <div v-else-if="error" class="error-state">
      <svg class="error-icon" viewBox="0 0 24 24">
        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>
      </svg>
      <div class="error-message">{{ error }}</div>
      <button @click="() => fetchNewsList()" class="retry-button">
        <svg class="refresh-icon" viewBox="0 0 24 24">
          <path d="M17.65 6.35C16.2 4.9 14.21 4 12 4c-4.42 0-7.99 3.58-7.99 8s3.57 8 7.99 8c3.73 0 6.84-2.55 7.73-6h-2.08c-.82 2.33-3.04 4-5.65 4-3.31 0-6-2.69-6-6s2.69-6 6-6c1.66 0 3.14.69 4.22 1.78L13 11h7V4l-2.35 2.35z"/>
        </svg>
        重新加载
      </button>
    </div>

    <ul v-else class="news-items">
      <li v-for="news in newsList" :key="news.id" class="news-item">
        <router-link :to="`/news/${news.id}`" class="news-link">
          <div class="news-meta">
            <svg class="calendar-icon" viewBox="0 0 24 24">
              <path d="M19 4h-1V2h-2v2H8V2H6v2H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V10h14v10zM9 14H7v-2h2v2zm4 0h-2v-2h2v2zm4 0h-2v-2h2v2z"/>
            </svg>
            <time class="news-date">{{ formatDate(news.publishDate) }}</time>
          </div>
          <h2 class="news-headline">{{ news.title }}</h2>
          <p class="news-excerpt">{{ news.summary || '点击查看详细内容' }}</p>
          <div class="news-footer">
            <span class="read-more">
              阅读全文
              <svg class="arrow-icon" viewBox="0 0 24 24">
                <path d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z"/>
              </svg>
            </span>
          </div>
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script lang="ts" setup>
  import { ref, onMounted } from 'vue';
  import { getNewsList as apiGetNewsList, ArticleStatus } from '@/api/news';
  import newsCache from '@/cache/newsCache';
  
  const newsList = ref([]);
  const isLoading = ref(true);
  const error = ref('');
  
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
        newsList.value = cachedData;
        isLoading.value = false;
        return;
    }
    try {
        const response = await apiGetNewsList({ page, pageSize, status });
        newsList.value = response?.data.content;
        // 保存缓存，有效期2小时
        newsCache.saveCacheData(cacheKey, response?.data.content, 7200000);
    } catch (err: any) {
        error.value = err.message || '获取新闻列表失败';
    } finally {
        isLoading.value = false;
    }
}
  
  onMounted(() => {
    fetchNewsList();
  });
const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleDateString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
  });
};
</script>

<style scoped lang="scss">
.news-list-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem 1.5rem;
}

.news-list-header {
  display: flex;
  align-items: center;
  margin-bottom: 3rem;
  padding-bottom: 1.5rem;
  border-bottom: 2px solid #f0f2f5;

  .news-icon {
    width: 32px;
    height: 32px;
    fill: #2c3e50;
    margin-right: 1rem;
  }

  .news-title {
    font-size: 2rem;
    color: #1a202c;
    font-weight: 600;
    letter-spacing: -0.025em;
  }
}

.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 4rem 0;

  .spinner {
    width: 50px;
    height: 50px;
    animation: rotate 2s linear infinite;
    
    .path {
      stroke: #3b82f6;
      stroke-linecap: round;
      animation: dash 1.5s ease-in-out infinite;
    }
  }

  .loading-text {
    margin-top: 1rem;
    color: #64748b;
    font-size: 1.125rem;
  }
}

.error-state {
  text-align: center;
  padding: 4rem 0;

  .error-icon {
    width: 64px;
    height: 64px;
    fill: #ef4444;
    margin-bottom: 1.5rem;
  }

  .error-message {
    font-size: 1.125rem;
    color: #dc2626;
    margin-bottom: 2rem;
  }

  .retry-button {
    display: inline-flex;
    align-items: center;
    padding: 0.75rem 1.5rem;
    background: #3b82f6;
    color: white;
    border-radius: 8px;
    font-weight: 500;
    transition: all 0.2s;

    &:hover {
      background: #2563eb;
      transform: translateY(-1px);
    }

    .refresh-icon {
      width: 20px;
      height: 20px;
      fill: currentColor;
      margin-right: 0.5rem;
    }
  }
}

.news-items {
  display: grid;
  gap: 1.5rem;
  padding: 0;
  margin: 0;
  list-style: none;
}

.news-item {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s, box-shadow 0.2s;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  }
}

.news-link {
  display: block;
  padding: 1.5rem;
  text-decoration: none;
  color: inherit;
}

.news-meta {
  display: flex;
  align-items: center;
  margin-bottom: 1rem;
  color: #64748b;

  .calendar-icon {
    width: 18px;
    height: 18px;
    fill: currentColor;
    margin-right: 0.5rem;
  }

  .news-date {
    font-size: 0.875rem;
  }
}

.news-headline {
  font-size: 1.25rem;
  color: #1e293b;
  margin-bottom: 0.75rem;
  line-height: 1.4;
}

.news-excerpt {
  color: #64748b;
  font-size: 0.975rem;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.news-footer {
  display: flex;
  justify-content: flex-end;

  .read-more {
    display: inline-flex;
    align-items: center;
    color: #3b82f6;
    font-weight: 500;
    transition: color 0.2s;

    &:hover {
      color: #2563eb;
    }

    .arrow-icon {
      width: 18px;
      height: 18px;
      fill: currentColor;
      margin-left: 0.5rem;
    }
  }
}

@keyframes rotate {
  100% { transform: rotate(360deg); }
}

@keyframes dash {
  0% { stroke-dasharray: 1,150; stroke-dashoffset: 0; }
  50% { stroke-dasharray: 90,150; stroke-dashoffset: -35; }
  100% { stroke-dasharray: 90,150; stroke-dashoffset: -124; }
}

@media (max-width: 1024px) {
  .news-list-container {
    padding: 1.5rem;
  }

  .news-title {
    font-size: 1.75rem !important;
  }
}

@media (max-width: 768px) {
  .news-items {
    grid-template-columns: 1fr;
  }

  .news-item {
    margin-bottom: 1rem;
  }

  .news-headline {
    font-size: 1.125rem;
  }
}

@media (max-width: 480px) {
  .news-list-header {
    margin-bottom: 2rem;

    .news-icon {
      width: 28px;
      height: 28px;
    }
  }

  .news-link {
    padding: 1rem;
  }
}
</style>