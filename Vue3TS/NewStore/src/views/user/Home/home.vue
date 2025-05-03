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
                <p>用户编号 {{ info?.email || '邮箱' }}</p>
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
        <!-- 共用区域 -->
        <div class="section">
            <div class="tab-buttons">
                <button :class="{ active: activeTab === 'activities' }" @click="activeTab = 'activities'">个人动态</button>
                <button :class="{ active: activeTab === 'likes' }" @click="activeTab = 'likes'">点赞</button>
                <button :class="{ active: activeTab === 'collections' }" @click="activeTab = 'collections'">收藏</button>
            </div>
            <div class="subsection">
                <!-- 个人动态内容 -->
                <div v-if="activeTab === 'activities'">
                    <div class="inner-tab-buttons">
                        <button :class="{ active: innerActiveTab === 'articles' }" @click="innerActiveTab = 'articles'">我的文章</button>
                        <button :class="{ active: innerActiveTab === 'comments' }" @click="innerActiveTab = 'comments'">我的评论</button>
                    </div>
                    <ul v-if="innerActiveTab === 'articles'">
                        <li v-if="articles.length === 0">暂无</li>
                        <li v-for="article in articles" :key="article.id">
                            {{ article.title }} - {{ article.time }}
                        </li>
                    </ul>
                    <ul v-if="innerActiveTab === 'comments'">
                        <li v-if="comments.length === 0">暂无</li>
                        <li v-for="comment in comments" :key="comment.id">
                            {{ comment.content }} - {{ comment.time }}
                        </li>
                    </ul>
                </div>
                <!-- 点赞内容 -->
                <ul v-if="activeTab === 'likes'">
                    <li v-if="likes.length === 0">暂无</li>
                    <li v-for="like in likes" :key="like.id">
                        {{ like.content }} - {{ like.time }}
                    </li>
                </ul>
                <!-- 收藏内容 -->
                <ul v-if="activeTab === 'collections'">
                    <li v-if="collections.length === 0">暂无</li>
                    <li v-for="collection in collections" :key="collection.id">
                        {{ collection.title }} - {{ collection.time }}
                    </li>
                </ul>
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
const comments = ref<{ id: number; content: string; time: string }[]>([]);
// 我的文章
const articles = ref<{ id: number; title: string; time: string }[]>([]);
// 点赞
const likes = ref<{ id: number; content: string; time: string }[]>([]);
// 收藏
const collections = ref<{ id: number; title: string; time: string }[]>([]);

// 当前激活的主标签
const activeTab = ref('activities');
// 当前激活的个人动态内标签
const innerActiveTab = ref('articles');

// 设置处理函数
const handleSettings = () => {
    console.log('设置');
};

// 判断是否为手机模式
const isMobile = ref(window.innerWidth < 768);

const handleResize = () => {
    isMobile.value = window.innerWidth < 768;
};

    const info : UserInfo | null = userCache.getUserCache();
onMounted(() => {
    window.addEventListener('resize', handleResize);
    // 可以在这里处理数据加载完成后的逻辑
});

onBeforeUnmount(() => {
    window.removeEventListener('resize', handleResize);
});

</script>

<style scoped>
.personal-center {
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

.top-menu h1 {
    margin: 0 auto;
    font-size: 1.2rem;
    color: #1e293b;
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
    justify-content: space-between;
    align-items: center;
}

.section li:hover {
    transform: translateX(8px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
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
}
</style>    