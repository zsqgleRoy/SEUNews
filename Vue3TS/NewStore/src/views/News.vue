<template>
    <div>
        <h2>文章列表</h2>
        <div v-if="isLoading" class="loading">加载中...</div>
        <div v-else-if="errorMessage">{{ errorMessage }}</div>
        <ul v-else>
            <li v-if="articles.length === 0">暂无文章</li>
            <li v-for="article in articles" :key="article.articleId" class="article-item">
                <h3>{{ article.title }}</h3>
                <p> {{ formatDate(article.publishDate) }}</p>
                <p> {{ formatDate(article.updateDate) }}</p>
            </li>
        </ul>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';
import { ArticleStatus, getNewsList as apiGetNewsList } from '@/api/news';
import 'vue3-toastify/dist/index.css';
import newsCache from '@/cache/newsCache';

dayjs.extend(relativeTime);

interface Article {
    articleId: number;
    title: string;
    content: string;
    publishDate: string;
    updateDate: string;
}

// 定义响应式数据
const articles = ref<Article[]>([]);
const isLoading = ref(false);
const errorMessage = ref('');
const error = ref('');
// 日期格式化函数
const formatDate = (date: string) => {
    if (dayjs(date).isValid()) {
        return dayjs(date).format('YYYY年MM月DD日');
    }
    return '无效日期';
};

const fetchNewsList = async (
    page: number = 1,
    pageSize: number = 10,
    status: ArticleStatus = ArticleStatus.PUBLISH
    ) => {
    isLoading.value = true;
    error.value = '';
    console.log("aaaaaaaaaaaaaaaaaaaaaaa");
    const cacheKey = newsCache.generatePageKey({ page, pageSize, status });
    const cachedData = newsCache.getPageCache(cacheKey);
    if (cachedData) {
        articles.value = cachedData;
        isLoading.value = false;
        return;
    }
    try {
        const response = await apiGetNewsList({ page, pageSize, status });
        articles.value = response?.data.content;
        // 保存缓存，有效期2小时
        newsCache.saveCacheData(cacheKey, response?.data.content, 7200000);
    } catch (err: any) {
        error.value = err.message || '获取新闻列表失败';
    } finally {
        isLoading.value = false;
    }
}

onMounted(() => {
    isLoading.value = true;
    fetchNewsList();
});
</script>

<style scoped lang="scss">
.loading {
    text-align: center;
    color: gray;
}

.article-item {
    border-bottom: 1px solid #ccc; /* 添加底部边框来分隔每条新闻 */
    padding: 10px 0; /* 上下添加内边距，让内容不紧贴边框 */
    margin-bottom: 10px;
}

.article-item h3 {
    margin-top: 0;
}
</style>
