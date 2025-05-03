<template>
    <div class="news-list-container">
        <div class="top-menu" v-if="isMobile">
            <BackButton/>
            <h1>新闻列表</h1>
        </div>
        <!-- 顶部菜单行，仅在手机模式显示 -->
        <el-button type="danger" @click="handleDeleteSelected" :disabled="selectedNews.length === 0">
            <el-icon>
                <Delete />
            </el-icon>
            删除
        </el-button>
        <el-table
            :data="newsList"
            @row-click="handleRowClick"
            @selection-change="handleSelectionChange"
            row-key="id"
            border
        >
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column prop="title" label="标题">
                <template #default="scope">
                    <div class="single-line-title">{{ scope.row.title }}</div>
                </template>
            </el-table-column>
            <el-table-column label="发布日期">
                <template #default="scope">
                    {{ formatDate(scope.row.publishDate) }}
                </template>
            </el-table-column>
            <el-table-column label="状态">
                <template #default="scope">
                    {{ formatStatus(scope.row.status) }}
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="currentPage"
            :page-sizes="[10, 20, 50]"
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total"
        >
        </el-pagination>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { getNewsList, ArticleStatus, type SaveData } from '@/api/news';
import { ElMessage } from 'element-plus';
import { useRouter } from 'vue-router';
import { deleteNewsByIds } from '@/api/news';
import { formatDate, formatStatus } from "@/utils/format"
import BackButton from '@/components/common/BackButton.vue';

const isMobile = ref(window.innerWidth < 768);
const router = useRouter();
const newsList = ref<SaveData[]>([]);
const total = ref(0);
const currentPage = ref(1);
const pageSize = ref(10);
const selectedNews = ref<SaveData[]>([]);

const fetchNewsList = async () => {
    try {
        const response = await getNewsList({
            page: currentPage.value,
            pageSize: pageSize.value,
            status: ArticleStatus.PUBLISH
        });
        newsList.value = response?.data.content;
        total.value = response?.data.totalElements;
    } catch (error) {
        // 错误处理在请求封装中已完成
    }
};

onMounted(() => {
    fetchNewsList();
});

const handleRowClick = (row: SaveData) => {
    router.push(`/editNews/${row.id}`);
};

const handleSelectionChange = (val: SaveData[]) => {
    selectedNews.value = val;
};

const handleDeleteSelected = async () => {
    if (selectedNews.value.length === 0) {
        ElMessage.warning('请选择要删除的新闻');
        return;
    }
    const idsToDelete = selectedNews.value.map(item => item.id);
    try {
        await deleteNewsByIds(idsToDelete); // 调用实际的删除接口
        newsList.value = newsList.value.filter(item => !idsToDelete.includes(item.id));
        total.value -= idsToDelete.length;
        selectedNews.value = [];
        ElMessage.success('删除成功');
    } catch (error) {
        ElMessage.error('删除失败，请稍后重试');
    }
};

const handleSizeChange = (newSize: number) => {
    pageSize.value = newSize;
    fetchNewsList();
};

const handleCurrentChange = (newPage: number) => {
    currentPage.value = newPage;
    fetchNewsList();
};
</script>

<style scoped lang="scss">
/* 整体容器样式 */
.news-list-container {
    user-select: none;
    padding:2%;
    max-width: 99vw;
    height: 100vh;
    background-color: #f9f9f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* 删除按钮样式 */
.el-button--danger {
    margin-bottom: 15px;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.el-button--danger:hover {
    background-color: #d32f2f;
    border-color: #d32f2f;
}

/* 表格样式 */
.el-table {
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    max-width: 1030px;
    overflow-x: auto;
}

.el-table th {
    background-color: #f5f5f5;
    color: #333;
    font-weight: 600;
}

.el-table td,
.el-table th {
    padding: 12px 15px;
    border-bottom: 1px solid #e0e0e0;
}

.el-table__body tr:hover > td {
    background-color: #f0f8ff;
}

/* 单行标题样式 */
.single-line-title {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* 分页器样式 */
.el-pagination {
    margin-top: 20px;
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

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
</style>    