<template>
    <div class="personal-center">
        <!-- 顶部菜单行，仅在手机模式显示 -->
        <div class="top-menu" v-if="isMobile">
            <BackButton/>
            <h1>个人中心</h1>
        </div>
        <!-- 用户信息区域 -->
        <div class="user-info">
            <img :src="info?.avatar || defaultAvatar" alt="用户头像" @click="" class="avatar">
            <div class="user-details">
                <!-- 使用 props.info  -->
                <h2>{{ info?.username || '用户名' }}</h2>
                <CertificationInfo v-if="info?.isAuthor==='TRUE'" ></CertificationInfo>
                <p>邮箱 {{ info?.email || '邮箱' }}</p>
            </div>
            <div class="actions">
                <div @click="handleEditProfile" class="action-item">
                    <el-icon :size="20"><Edit /></el-icon>
                    编辑资料
                </div>
                <div @click="handleSettings" class="action-item">
                    <el-icon><Setting /></el-icon>
                    设置
                </div>
                <div @click="handleLogout" class="action-item">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
                        <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                    </svg>
                    退出登录
                </div>
            </div>
        </div>
        <div class="section">
            <div class="tab-buttons">
                <button :class="{ active: activeTab === 'activities' }" @click="activeTab = 'activities'">动态</button>
                <button :class="{ active: activeTab === 'likes' }" @click="activeTab = 'likes'">点赞</button>
                <button :class="{ active: activeTab === 'collections' }" @click="activeTab = 'collections'">收藏</button>
            </div>
            <div class="subsection">
                <div v-if="activeTab === 'activities'">
                    <div class="inner-tab-buttons">
                        <button :class="{ active: innerActiveTab === 'articles' }" @click="innerActiveTab = 'articles'">文章</button>
                        <button :class="{ active: innerActiveTab === 'comments' }" @click="innerActiveTab = 'comments'">评论</button>
                        <button :class="{ active: innerActiveTab === 'share' }" @click="innerActiveTab = 'share'">转发</button>
                    </div>
                    <ul v-if="innerActiveTab === 'articles'">
                        <li v-if="articles.length === 0">暂无</li>
                        <li v-for="article in articles" :key="article.id">
                        <router-link :to="`/news/${article.id}`" class="article-item">
                            <div class="article-content">
                            <img v-if="article.headImageUrl" 
                                :src="article.headImageUrl" 
                                alt="文章封面" 
                                class="article-image">
                            <div class="article-info">
                                <h3 class="article-title">{{ article.title }}</h3>
                                <time class="article-time">{{ formatDate(article.publishDate) }}</time>
                            </div>
                            </div>
                        </router-link>
                        </li>
                    </ul>

                    <div class="likes-container">
                        <ul v-if="innerActiveTab === 'comments'">
                        <template v-if="comments.length > 0">
                            <li 
                            v-for="comment in comments" 
                            :key="comment.commentId"
                            class="like-item"
                            >
                            <div class="content-wrapper" @click="toArticles(comment.articleId)">
                                <span class="article-id">{{ comment.articleId }}</span>
                                <span class="like-date">{{ formatDate(comment.publishDate) }}</span>
                            </div>
                            <el-button
                                type="danger" 
                                :icon="Delete"
                                circle
                                class="delete-btn"
                                @click.stop="deleteComment(comment.commentId)"
                            />
                            </li>
                        </template>
                        <li v-else class="empty-tip">
                            暂无评论记录
                        </li>
                        </ul>
                    </div>
                </div>
                <div class="likes-container">
                    <ul v-if="activeTab === 'likes'">
                    <template v-if="likes.length > 0">
                        <li 
                        v-for="like in likes" 
                        :key="like.articleId"
                        class="like-item"
                        >
                        <div class="content-wrapper" @click="toArticles(like.articleId)">
                            <span class="article-id">{{ like.articleId }}</span>
                            <span class="like-date">{{ formatDate(like.likeDate) }}</span>
                        </div>
                        <el-button
                            type="danger" 
                            :icon="Delete"
                            circle
                            class="delete-btn"
                            @click.stop="deleteLike(like.articleId)"
                        />
                        </li>
                    </template>
                    <li v-else class="empty-tip">
                        暂无点赞记录
                    </li>
                    </ul>
                </div>

                <div class="likes-container">
                    <ul v-if="activeTab === 'collections'">
                    <template v-if="collections.length > 0">
                        <li 
                        v-for="collection in collections" 
                        :key="collection.articleId"
                        class="like-item"
                        >
                        <div class="content-wrapper" @click="toArticles(collection.articleId)">
                            <span class="article-id">{{ collection.articleId }}</span>
                            <span class="like-date">{{ formatDate(collection.favoriteDate) }}</span>
                        </div>
                        <el-button
                            type="danger" 
                            :icon="Delete"
                            circle
                            class="delete-btn"
                            @click.stop="deleteCollection(collection.articleId)"
                        />
                        </li>
                    </template>
                    <li v-else class="empty-tip">
                        暂无收藏记录
                    </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts" setup>
import BackButton from '@/components/common/BackButton.vue';
import CertificationInfo from "@/components/common/CertificationInfo.vue"
import { useRouter } from 'vue-router';
import { onMounted, ref, onBeforeUnmount } from 'vue';
import { useUserStore } from '@/store/userStore';
import userCache, {type UserInfo} from '@/cache/userCache';
import { type ArticleFontDTO } from "@/types/article"
import axios from 'axios';
import { initialURL } from '@/lib/urls';
import { formatDate } from "@/utils/format"
import { ElMessage, ElMessageBox } from 'element-plus';
import { Delete } from '@element-plus/icons-vue'
const router = useRouter();
const handleEditProfile = () => {
    user.value.email
    router.push('/modifyuserdata');
};

const userStore = useUserStore();
// 默认头像
const defaultAvatar = 'http://seunewsbac.pgrm.cc/static/news-images/20250313204547238_57018fd3.png';
// 用户信息
const user = ref({
    name: '',
    avatar: '',
    email: '',
    bio: ''
});

// 调用 Logout 函数时传递 router
const handleLogout = () => {
    userStore.logout(router);
};

// 个人动态
const activities = ref<{ id: number; content: string; time: string }[]>([]);
// 我的评论
const comments = ref<{
    commentId: number;
    content: string;
    publishDate: string;
    articleId:number;
}[]>([]);
// 我的文章
const articles = ref<ArticleFontDTO[]>([]);
// 点赞
const likes = ref<{ userId: number; articleId: number; likeDate: string }[]>([]);
// 收藏
const collections = ref<{
    userId: number;
    articleId:number;
    favoriteDate: string;
}[]>([]);

// 当前激活的主标签
const activeTab = ref('activities');
// 当前激活的个人动态内标签
const innerActiveTab = ref('articles');

// 设置处理函数
const handleSettings = () => {
    console.log('设置');
};

const deleteLike = async (id:number) => {
    await ElMessageBox.confirm(`确认删除该点赞吗？`, '提示', {
      confirmButtonText: '确认',
      cancelButtonText: '取消',
      type: 'warning'
    })
    const result = await axios.delete(`${initialURL.SERVER_URL}/api/article-likes/user/${userCache.getUserCache()?.user_id}/article/${id}`);
    await loadLikes()
    ElMessage.success("取消点赞成功");
}

const deleteCollection = async (id:number) => {
    await ElMessageBox.confirm(`确认删除该收藏吗？`, '提示', {
      confirmButtonText: '确认',
      cancelButtonText: '取消',
      type: 'warning'
    })
    const result = await axios.delete(`${initialURL.SERVER_URL}/api/article-favorites/user/${userCache.getUserCache()?.user_id}/article/${id}`);
    await loadCollections()
    ElMessage.success("取消收藏成功");
}

const deleteComment = async (id:number) => {
    await ElMessageBox.confirm(`确认删除该评论吗？`, '提示', {
      confirmButtonText: '确认',
      cancelButtonText: '取消',
      type: 'warning'
    })
    const result = await axios.delete(`${initialURL.SERVER_URL}/api/comments/${id}`);
    await loadCommment()
    ElMessage.success("取消评论成功");
}

const toArticles = async (id:number) => {
    console.log(id)
    router.push(`/news/${id}`)
}

const loadArticles = async () => {
  try {
    const result = await axios.get(`${initialURL.SERVER_URL}/api/articles/getArticles/${userCache.getUserCache()?.user_id}`);
    articles.value = result.data;
  } catch (error) {
    console.error('获取文章列表失败:', error);
  }
}

const loadLikes = async () => {
  try {
    const result = await axios.get(`${initialURL.SERVER_URL}/api/article-likes/${userCache.getUserCache()?.user_id}`);
    likes.value = result.data;
  } catch (error) {
    ElMessage.error('获取点赞列表失败:' + error);
  }
}

const loadCollections = async () => {
  try {
    const result = await axios.get(`${initialURL.SERVER_URL}/api/article-favorites/user/${userCache.getUserCache()?.user_id}`);
    collections.value = result.data;
  } catch (error) {
    ElMessage.error('获取收藏列表失败:' + error);
  }
}

const loadCommment = async () => {
  try {
    const result = await axios.get(`${initialURL.SERVER_URL}/api/comments/userId/${userCache.getUserCache()?.user_id}`);
    comments.value = result.data;
  } catch (error) {
    ElMessage.error('获取评论列表失败:' + error);
  }
}

// 判断是否为手机模式
const isMobile = ref(window.innerWidth < 768);

const handleResize = () => {
    isMobile.value = window.innerWidth < 768;
};

const info : UserInfo | null = userCache.getUserCache();
onMounted(() => { 
    loadArticles();
    loadLikes();
    loadCommment();
    loadCollections();
    window.addEventListener('resize', handleResize);
    // 可以在这里处理数据加载完成后的逻辑
});

onBeforeUnmount(() => {
    window.removeEventListener('resize', handleResize);
});

</script>

<style scoped>
.personal-center {
    user-select: none;
    background: linear-gradient(160deg, #f8fafc 0%, #f1f5f9 100%);
    font-family: 'Inter', system-ui, sans-serif;
    min-height: 100vh;
    padding-bottom: 2px;
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

.likes-container {
  padding: 12px;
}

.like-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px;
  margin: 8px 0;
  border-radius: 4px;
  background: #fff;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: all 0.3s;
}

.like-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.content-wrapper {
  flex: 1;
  cursor: pointer;
  display: flex;
  gap: 12px;
  align-items: center;
}

.article-id {
  font-weight: 500;
  color: #409eff;
}

.like-date {
  color: #666;
  font-size: 0.9em;
}

.delete-btn {
  margin-left: auto;
  opacity: 0.7;
  transition: opacity 0.3s;
}

.delete-btn:hover {
  opacity: 1;
}

.empty-tip {
  text-align: center;
  color: #999;
  padding: 20px;
}

.top-menu h1 {
    margin: 0 auto;
    color: transparent;
    background: linear-gradient(135deg, #0055ff, #6b00bc);
    -webkit-background-clip: text;
    background-clip: text;
    border-image: linear-gradient(135deg, #0055ff, #6b00bc) 1;
    text-transform: uppercase;
    font-size: 18px;
}

.user-info {
    display: flex;
    align-items: center;
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.3);
    backdrop-filter: blur(10px);
    justify-content: space-between;
}

.avatar {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    margin-right: 0.5rem; /* 减小头像与用户信息的间距 */
    margin-left: 1rem;
    object-fit: cover;
    border: 3px solid #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.avatar:hover {
    transform: scale(1.05);
}

.user-details {
    flex: 1; /* 让用户信息区域占据剩余空间 */
    display: flex;
    flex-direction: column;
    align-items: flex-start; /* 左对齐 */
}

.user-details h2 {
    font-size: 1rem;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 0.6rem;
}

.user-details p {
    color: #64748b;
    font-size: 0.8rem;
    margin-top: 0rem;
}

.actions {
    display: flex;
    flex-direction: column;
}

.action-item {
    border: none;
    cursor: pointer;
    font-weight: 500;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    color: #818181;
    display: flex;
    align-items: center;
    gap: 0.3rem; /* 添加图标与文字间距 */
}

.action-item svg {
    width: 16px;
    height: 16px;
    fill: #818181;
    transition: fill 0.3s ease; /* 添加过渡效果 */
}

.action-item:hover svg {
    fill: gold; /* 合并到父元素悬停状态 */
}

.action-item:hover {
    transform: translateY(-2px);
    color: gold;
}

.section {
    background: rgba(255, 255, 255, 0.95);
    padding: 1rem;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.3);
    backdrop-filter: blur(10px);
}

.tab-buttons {
    display: flex;
    gap: 1rem;
    margin-bottom: 1rem;
    border-bottom: 1px solid #e2e8f0;
    justify-content: center;
}

.tab-buttons button {
    padding: 0.5rem 0;
    border: none;
    background: transparent;
    cursor: pointer;
    color: #64748b;
    font-weight: 500;
    position: relative;
    transition: all 0.3s ease;
}

.tab-buttons button::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 0;
    height: 3px;
    background: linear-gradient(90deg, #6366f1 0%, #4f46e5 100%);
    transition: width 0.3s ease;
}

.tab-buttons button.active {
    color: #1e293b;
    font-weight: 600;
}

.tab-buttons button.active::after {
    width: 100%;
}

.tab-buttons button:hover {
    color: #475569;
}

.inner-tab-buttons {
    display: flex;
    gap: 1rem;
    margin-bottom: 1rem;
    justify-content: center;
}

.inner-tab-buttons button {
    padding: 0.3rem 0;
    border: none;
    background: transparent;
    cursor: pointer;
    color: #64748b;
    position: relative;
    font-size: 0.9rem;
}

.inner-tab-buttons button.active {
    color: #1e293b;
    font-weight: 500;
}

.inner-tab-buttons button.active::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 3px;
    background: #c7d2fe;
}

.section li {
    padding: 0.8rem 1rem;
    border-radius: 0.75rem;
    margin-bottom: 0.3rem;
    background: white;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    align-items: center;
    gap: 1rem;
}

.section li:hover {
    transform: translateX(8px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
}

.article-image {
    width: 80px;
    height: 60px;
    object-fit: cover;
    border-radius: 0.25rem;
}

.article-info {
    flex: 1;
}

.article-info h3 {
    font-size: 1rem;
    font-weight: 600;
    margin-bottom: 0.2rem;
}

.article-info p {
    font-size: 0.8rem;
    color: #64748b;
}

/* 新增动画效果 */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

.section ul {
    animation: fadeIn 0.4s ease-out;
    padding-left: 2px;
    padding-right: 4px;
}

/* 电脑端样式 */
@media (min-width: 768px) {
    .personal-center {
        max-width: 1200px;
        margin: 0 auto;
    }

    .user-info {
        padding-top: 5px;
        margin-bottom: 0rem;
    }

    .avatar {
        width: 80px;
        height: 80px;
        margin-right: 1rem; /* 电脑端减小头像与用户信息的间距 */
        margin-left: 1rem;
    }

    .user-details h2 {
        font-size: 1.5rem;
    }

    .user-details p {
        font-size: 0.9rem;
        margin-top: 3px;
    }

    .actions {
        margin-bottom: 0;
    }

    .action-item {
        padding: 0.25rem 1.5rem 0.25rem 0;
    }

    .section {
        padding: 0rem;
    }

    .tab-buttons {
        gap: 1.5rem;
    }

    .article-image {
        width: 120px;
        height: 90px;
    }

    .article-info h3 {
        font-size: 1.1rem;
    }

    .article-info p {
        font-size: 0.9rem;
    }
}

.article-item {
  display: block;
  text-decoration: none;
  color: inherit;
  width: 100%;
}

.article-content {
  display: flex;
  gap: 1rem;
  align-items: flex-start;
}

.article-image {
  width: 120px;
  height: 80px;
  border-radius: 8px;
  object-fit: cover;
  flex-shrink: 0;
}

.article-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.article-title {
  font-size: 1rem;
  font-weight: 600;
  margin: 0;
  color: #1e293b;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.article-time {
  font-size: 0.8rem;
  color: #64748b;
  margin-top: 0.5rem;
}

/* 手机端适配 */
@media (max-width: 767px) {
  .article-content {
    flex-direction: column;
  }

  .article-image {
    width: 100%;
    height: 150px;
  }

  .article-title {
    font-size: 0.9rem;
  }
}

/* 电脑端悬停效果 */
@media (min-width: 768px) {
  .article-item:hover .article-title {
    color: #6366f1;
    text-decoration: none;
  }

  .article-item:hover .article-image {
    transform: scale(1.02);
    transition: transform 0.3s ease;
  }
}

/* 保持原有li样式 */
.section li {
  padding: 1rem;
  border-radius: 0.75rem;
  margin-bottom: 0.5rem;
  background: white;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.section li:hover {
  transform: translateX(8px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
}
</style>    