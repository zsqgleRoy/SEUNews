<template>
    <div class="editor-container">
        <!-- 顶部菜单行，仅在手机模式显示 -->
        <div class="top-menu" v-if="isMobile">
            <BackButton/>
            <h1>修改新闻</h1>
        </div>
        <EditNewsForm v-if="news" :news="news"/>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import BackButton from '@/components/common/BackButton.vue';
import EditNewsForm from "./EditNewsForm.vue";
import { getNewsById } from '@/api/news';
import { useRoute } from "vue-router";
import { ElMessage } from 'element-plus';

const route = useRoute();
const isMobile = ref(window.innerWidth < 768);
const news = ref({
    id: 0,
    title: '',
    publishDate: '',
    updateDate: '',
    content: '',
    author: '',
    status: 'DRAFT',
    tag: 0,
    headImageUrl: ''
});
const newsId = Number(route.params.id);

onMounted(async () => {
    try {
        const response = await getNewsById(newsId);
        news.value = response?.data;
        news.value.id = newsId;
    } catch (error) {
        ElMessage.error('获取新闻详情失败，请稍后重试！');
    }
});
</script>

<style scoped lang="scss">
.top-menu {
    display: flex;
    align-items: center;
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.3);
    backdrop-filter: blur(10px);
    padding: 10px;
}

.top-menu h1 {
    margin: 0 auto;
    font-size: 1.2rem;
    color: #1e293b;
}

.editor-container {
    min-height: 100vh;
    border: 1px solid #ddd;
    min-height: 400px;
}

.w-e-text-container {
    min-height: 340px;
}

a {
    color: #0062ff;
}
</style>    