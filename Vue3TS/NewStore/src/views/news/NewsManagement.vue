<template>
    <div class="news-list-container">
        <!-- 顶部菜单，仅在手机模式显示 -->
        <div class="top-menu" v-if="isMobile">
            <BackButton />
            <h1>新闻列表</h1>
        </div>
        <!-- 操作按钮组 -->
        <div class="button-group">
            <el-button type="danger" @click="handleDeleteSelected" :disabled="selectedNews.length === 0">
                <el-icon>
                    <Delete />
                </el-icon>
                删除
            </el-button>

            <el-radio-group v-model="selected" @change="trangleStatus">
                <el-radio :value="1">已公开</el-radio>
                <el-radio :value="2">草稿</el-radio>
                <el-radio :value="3">已删除</el-radio>
            </el-radio-group>
        </div>
        <!-- 新闻列表表格 -->
        <el-table
            :data="newsList"
            @row-click="handleRowClick"
            @selection-change="handleSelectionChange"
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
        <!-- 分页组件 -->
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
import { ref, onMounted, watch } from 'vue';
import { getNewsList, ArticleStatus, type SaveData, getDeletedNewsList } from '@/api/news';
import { ElMessage } from 'element-plus';
import { useRouter } from 'vue-router';
import { deleteNewsByIds } from '@/api/news';
import { formatDate, formatStatus } from "@/utils/format";
import BackButton from '@/components/common/BackButton.vue';
import { Delete } from '@element-plus/icons-vue';
import useCache from '@/cache/userCache';

// 判断是否为手机模式
const isMobile = ref(window.innerWidth < 768);
const router = useRouter();
// 新闻列表数据
const newsList = ref<SaveData[]>([]);
// 新闻总数
const total = ref(0);
// 当前页码
const currentPage = ref(1);
// 每页显示数量
const pageSize = ref(10);
// 选中的新闻列表
const selectedNews = ref<SaveData[]>([]);
// 当前筛选的新闻状态
const selectType = ref(ArticleStatus.PUBLISH);
const selected = ref(1);

// 监听窗口大小变化，更新是否为手机模式
watch(() => window.innerWidth, (width) => {
    isMobile.value = width < 768;
});

// 获取新闻列表的异步函数
const fetchNewsList = async (type: ArticleStatus) => {
    try {
        const response = await getNewsList({
            page: currentPage.value,
            pageSize: pageSize.value,
            status: type
        });
        newsList.value = response?.data.content;
        total.value = response?.data.totalElements;
    } catch (error) {
        // 错误处理在请求封装中已完成
    }
};

const fetchDeletedNewsList = async () => {
    try {
        const response = await getDeletedNewsList({
            page: currentPage.value,
            pageSize: pageSize.value
        });
        newsList.value = response?.data.content;
        total.value = response?.data.totalElements;
    } catch (error) {
        // 错误处理在请求封装中已完成
    }
};

// 组件挂载时获取新闻列表
onMounted(() => {
    fetchNewsList(selectType.value);
});

// 点击新闻行时跳转到编辑页面
const handleRowClick = (row: SaveData) => {
    router.push(`/editNews/${row.article_id}`);
};

// 表格选择项变化时更新选中的新闻列表
const handleSelectionChange = (val: SaveData[]) => {
    selectedNews.value = val;
};

// 切换新闻状态筛选条件
const trangleStatus = async () => {
    if (selected.value === 1) {
        currentPage.value = 1; // 切换状态时重置页码
        selectType.value = ArticleStatus.PUBLISH;
        await fetchNewsList(selectType.value);
    } else if (selected.value === 2) {
        currentPage.value = 1; // 切换状态时重置页码
        selectType.value = ArticleStatus.DRAFT;
        await fetchNewsList(selectType.value);
    }
     else if (selected.value === 3){
        getDeletedNews();
    }
};

const getDeletedNews = async () => {
    await fetchDeletedNewsList();
};

// 删除选中的新闻
const handleDeleteSelected = async () => {
    if (selectedNews.value.length === 0) {
        ElMessage.warning('请选择要删除的新闻');
        return;
    }
    const userId = useCache.getUserCache()?.user_id;
    const articleIds = selectedNews.value.map(item => item.article_id);
    const idsToDelete = [userId, ...articleIds];
    try {
        await deleteNewsByIds(idsToDelete); // 调用实际的删除接口
        newsList.value = newsList.value.filter(item => !idsToDelete.includes(item.article_id));
        total.value -= idsToDelete.length;
        selectedNews.value = [];
        ElMessage.success('删除成功');
    } catch (error) {
        ElMessage.error('删除失败，请稍后重试');
    }
};

// 每页显示数量变化时重新获取新闻列表
const handleSizeChange = (newSize: number) => {
    pageSize.value = newSize;
    fetchNewsList(selectType.value);
};

// 当前页码变化时重新获取新闻列表
const handleCurrentChange = (newPage: number) => {
    currentPage.value = newPage;
    fetchNewsList(selectType.value);
};
</script>

<style scoped lang="scss">
  .news-list-container {
    user-select: none;
    padding: 4%;
    max-width: 99vw;
    min-height: 100vh;
    background-color: #f9f9f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  
    .button-group {
      margin-bottom: 15px;
      display: flex;
      gap: 10px;
      align-items: center;
    }
  
    .el-button--danger {
      border-radius: 4px;
      transition: background-color 0.3s ease;
  
      &:hover {
        background-color: #d32f2f;
        border-color: #d32f2f;
      }
    }
  
    .el-table {
      border: 1px solid #e0e0e0;
      border-radius: 6px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      max-width: 1030px;
      overflow-x: auto;
  
      th {
        background-color: #f5f5f5;
        color: #333;
        font-weight: 600;
      }
  
      td, th {
        padding: 12px 15px;
        border-bottom: 1px solid #e0e0e0;
      }
  
      tr:hover td {
        background-color: #f0f8ff;
      }
    }
  
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
      margin-bottom: 15px;
  
      h1 {
        margin: 0 auto;
        color: transparent;
        background: linear-gradient(135deg, #0055ff, #6b00bc);
        -webkit-background-clip: text;
        background-clip: text;
        border-image: linear-gradient(135deg, #0055ff, #6b00bc) 1;
        text-transform: uppercase;
        font-size: 18px;
      }
    }
  
    .single-line-title {
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
  }
  
  /* 响应式设计 */
  @media screen and (max-width: 768px) {
    .news-list-container {
      padding: 2%;
  
      .el-table {
        font-size: 14px;
  
        td, th {
          padding: 8px 10px;
        }
      }
  
      .el-pagination {
        flex-wrap: wrap;
        justify-content: center;
      }
    }
  }
  
  /* 打印优化 */
  @media print {
    .news-list-container {
      padding: 0;
      
      .button-group,
      .top-menu {
        display: none;
      }
  
      .el-table {
        box-shadow: none;
        border: 1px solid #ddd;
  
        tr:hover td {
          background-color: transparent;
        }
      }
    }
  }
  </style>