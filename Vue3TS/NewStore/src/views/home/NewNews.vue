<template>
    <div class="block block-hot">
        <!-- 标题 -->
        <h2 class="section-title">最新新闻</h2>
        <!-- 加载状态提示 -->
        <div v-if="isLoading" class="loading">加载中...</div>
        <!-- 错误提示 -->
        <div v-if="error" class="error">{{ error }}</div>
        <!-- 新闻列表 -->
        <div v-else class="news-list">
            <div class="news-item" v-for="(item, index) in newsList" :key="index">
                <router-link :to="`/news/${item.id}`" class="news-link">
                    <h3 class="news-title">{{ item.title }}</h3>
                    <div class="news-meta">
                        <p>{{ formatDate(item.publishDate) }}</p>
                    </div>
                </router-link>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { getNewsList as apiGetNewsList, ArticleStatus } from "@/api/news";
import { formatDate } from '@/utils/format';
import newsCache from '@/cache/newsCache';

// 加载状态
const isLoading = ref(true);
// 新闻列表
const newsList = ref<any[]>([]);
// 错误信息
const error = ref('');

// 获取新闻列表的函数
const fetchNewsList = async (
    page: number = 1,
    pageSize: number = 10,
    status: ArticleStatus = ArticleStatus.PUBLISH
) => {
    isLoading.value = true;
    error.value = '';

    const cacheKey = newsCache.generateCacheKey({ page, pageSize, status });
    const cachedData = newsCache.getCache(cacheKey);

    if (cachedData) {
        newsList.value = cachedData;
        isLoading.value = false;
        return;
    }

    try {
        const response = await apiGetNewsList({ page, pageSize, status });
        newsList.value = response?.data.content || [];
        // 保存缓存，有效期2小时
        newsCache.saveCacheData(cacheKey, newsList.value, 7200000);
    } catch (err: any) {
        error.value = err.message || '获取新闻列表失败，请稍后重试';
    } finally {
        isLoading.value = false;
    }
};

onMounted(() => {
    fetchNewsList();
});
</script>

<style scoped lang="scss">
.block {
    user-select: none;
    -moz-user-select: none;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    padding: 24px;
    margin-bottom: 24px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.block:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
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

.loading {
    text-align: center;
    color: #999;
    font-size: 16px;
}

.error {
    text-align: center;
    color: #ff0000;
    font-size: 16px;
}

.news-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 24px;
}

.news-item {
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    background-color: #fff;
}

.news-item:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.news-link {
    text-decoration: none;
    color: inherit;
    display: block;
    padding: 0 20px;
}

.news-title {
    padding: 5px;
    font-size: 18px;
    color: #333;
    margin-bottom: 8px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    display: block;
    font-weight: 500;
}

.news-meta {
    padding: 5px;
    font-size: 0.7rem;
    color: #666666;
    text-align: right;
    line-height: 1.4;
    opacity: 0.8;
    transition: all 0.3s ease;
    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.9);
}

.news-meta:hover {
    opacity: 1;
    color: #3498db;
    transform: translateX(2px);
}
</style>    