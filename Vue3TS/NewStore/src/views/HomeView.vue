<template>
  <div class="home">
    <!-- 主内容区域 -->
    <main class="main-content">
      <!-- 头条新闻和北京时间组件 -->
      <div class="block-headline-and-time">
        <div class="block block-headline">
          <h2 class="section-title">头条新闻</h2>
          <div class="news-list">
            <div class="news-item" v-for="(item, index) in topNews" :key="index">
              <router-link :to="item.path" class="news-link">
                <div class="news-image-container">
                  <img :src="item.image" alt="新闻图片" class="news-image">
                </div>
                <div class="news-content">
                  <h3 class="news-title">{{ item.title }}</h3>
                  <p class="news-description">{{ item.description }}</p>
                </div>
              </router-link>
            </div>
          </div>
        </div>
        <div><BeijingTime /></div>
        <!-- <div><Lunner /></div> -->
      </div>

      <!-- 新闻分类 -->
      <div class="block block-category">
        <h2 class="section-title">新闻分类</h2>
        <div class="category-grid">
          <div class="category-item" v-for="(category, index) in categories" :key="index">
            <router-link :to="category.path" class="category-link">
              <div class="category-icon-container">
                <img :src="category.icon" alt="分类图标" class="category-icon">
              </div>
              <h4 class="category-name">{{ category.name }}</h4>
            </router-link>
          </div>
        </div>
      </div>

      <!-- 热门推荐 -->
      <div class="block block-hot">
        <h2 class="section-title">热门推荐</h2>
        <div class="news-list">
          <div class="news-item" v-for="(item, index) in hotNews" :key="index">
            <router-link :to="item.path" class="news-link">
              <h3 class="news-title">{{ item.title }}</h3>
              <p class="news-description">{{ item.description }}</p>
            </router-link>
          </div>
        </div>
      </div>
    </main>

    <!-- 侧边栏 -->
    <aside class="sidebar">
      <!-- 快速入口 -->
      <div class="quick-links block">
        <h3 class="section-title">快速入口</h3>
        <div v-for="(link, index) in quickLinks" :key="index">
          <router-link 
            :to="link.path" 
            class="link">
            {{ link.title }}
          </router-link>
        </div>
      </div>

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
  </div>
</template>

<script setup lang="ts">
import { onMounted, onUnmounted, ref, reactive } from 'vue';
import BeijingTime from '@/components/BeijingTime.vue'; // 引入北京时间组件
import Lunner from '@/components/Lunner.vue'; // 引入农历组件
import Img2 from "@/components/icons/03.png"; // 引入图标
import { ElDialog, ElMessage } from 'element-plus';

// 模拟数据
const topNews = ref([
  {
    path: '/news/1',
    image: Img2,
    title: '习近平出席二十国集团领导人峰会并发表重要讲话',
    description: '当地时间11月15日，国家主席习近平出席二十国集团领导人第十七次峰会并发表重要讲话...'
  },
  // 其他新闻项...
]);

const categories = ref([
  { path: '/shiSiDa', name: '十四大', icon: 'https://via.placeholder.com/64x64' },
  { path: '/xiYu', name: '习语', icon: 'https://via.placeholder.com/64x64' },
  { path: '/science', name: '科技', icon: 'https://via.placeholder.com/64x64' },
  { path: '/economic', name: '经济', icon: 'https://via.placeholder.com/64x64' },
  { path: '/minSheng', name: '民生', icon: 'https://via.placeholder.com/64x64' },
  { path: '/enthusiastic', name: '娱乐', icon: 'https://via.placeholder.com/64x64' },
  { path: '/News', name: '军事', icon: 'https://via.placeholder.com/64x64' }
  // 其他分类...
]);

const hotNews = ref([
  { path: '/news/2', title: '中国空间站第三次太空授课活动取得圆满成功', description: '10月12日，“天宫课堂”第三课在中国空间站开讲...' },
  // 其他新闻项...
]);

const quickLinks = ref([
  { path: '/login', title: '管理员登录' },
  { path: '/addNews', title: '添加新闻' },
  { path: '/about', title: '关于我们' },
  { path: '/contact', title: '联系我们' },
  // 其他链接...
]);

// 登录对话框相关数据
const isLoginDialogVisible = ref(false);
const loginForm = reactive({
  username: '',
  password: ''
});
const loginFormRef = ref<InstanceType<typeof import('element-plus')['ElForm']>>();

// 表单验证规则
const loginRules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' }
  ]
};

// 打开登录对话框
const handleLoginClick = () => {
  isLoginDialogVisible.value = true;
};

// 登录处理
const handleLogin = () => {
  const form = loginFormRef.value;
  if (form) {
    form.validate((valid) => {
      if (valid) {
        // 这里可以添加实际的登录逻辑
        if (loginForm.username === 'admin' && loginForm.password === 'admin') {
          ElMessage.success('登录成功');
          isLoginDialogVisible.value = false;
          // 登录成功后的跳转或其他操作
        } else {
          ElMessage.error('用户名或密码错误');
        }
      } else {
        ElMessage.error('请填写完整信息');
      }
    });
  }
};

// 关闭对话框
const handleLoginClose = () => {
  isLoginDialogVisible.value = false;
  loginForm.username = '';
  loginForm.password = '';
};

const videos = ref([
  { id: 1, path: '/video/1', thumbnail: 'https://via.placeholder.com/200x150', title: '中国科技发展纪实' },
]);
</script>

<style scoped>
/* 全局样式 */
body {
  font-family: 'Inter', sans-serif;
  background: linear-gradient(135deg, #f4f4f9 0%, #e0e0e0 100%);
  color: #333;
  margin: 0;
  padding: 0;
}

.home {
  max-width: 1200px;
  margin: 2rem auto;
  padding: 2rem;
  display: grid;
  grid-template-columns: 3fr 1fr;
  gap: 2rem;
  animation: fadeIn 0.5s ease-out;
}

.section-title {
  color: #2c3e50;
  font-size: 1.8rem;
  margin-bottom: 1.5rem;
  border-bottom: 3px solid #3498db;
  padding-bottom: 0.8rem;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.block {
  background-color: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
  padding: 2rem;
  margin-bottom: 2rem;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.block:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 36px rgba(0, 0, 0, 0.15);
}

/* 头条新闻和北京时间 */
.block-headline-and-time {
  grid-column: span 2;
  display: grid;
  grid-template-columns: 3fr 1fr;
  gap: 2rem;
}

.news-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.news-item {
  display: flex;
  flex-direction: column;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.news-item:hover {
  transform: translateY(-8px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.news-link {
  text-decoration: none;
  color: inherit;
}

.news-image-container {
  position: relative;
  overflow: hidden;
}

.news-image {
  width: 100%;
  height: auto;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.news-item:hover .news-image {
  transform: scale(1.1);
}

.news-content {
  padding: 1.5rem;
}

.news-title {
  font-size: 1.4rem;
  margin-bottom: 0.8rem;
  color: #2c3e50;
}

.news-description {
  font-size: 1rem;
  color: #777;
  line-height: 1.6;
}

/* 新闻分类 */
.category-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
  gap: 2rem;
}

.category-item {
  text-align: center;
  border-radius: 16px;
  padding: 1.5rem;
  transition: background-color 0.3s ease, transform 0.3s ease;
  background-color: rgba(255, 255, 255, 0.7);
}

.category-item:hover {
  background-color: #ecf0f1;
  transform: translateY(-5px);
}

.category-link {
  text-decoration: none;
  color: inherit;
}

.category-icon-container {
  margin-bottom: 1rem;
}

.category-icon {
  width: 80px;
  height: 80px;
  filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
}

.category-name {
  font-size: 1.2rem;
  color: #3498db;
  font-weight: 600;
}

/* 侧边栏 */
.sidebar {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.quick-links .link {
  border-bottom: 1px solid #eee;
  transition: background-color 0.3s ease;
}

.quick-links .link:last-child {
  border-bottom: none;
}

.quick-links .link:hover {
  background-color: #f9f9f9;
}

.link {
  text-decoration: none;
  color: #333;
  transition: color 0.3s ease;
  font-size: 1.1rem;
}

.link:hover {
  color: #3498db;
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
@media (max-width: 768px) {
  .home {
    grid-template-columns: 1fr;
  }

  .block-headline-and-time {
    grid-template-columns: 1fr;
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
/* 添加媒体查询 */
@media (max-width: 1024px) {
  .home {
    grid-template-columns: 1fr;
  }
  
  .block-headline-and-time {
    grid-template-columns: 1fr;
  }
  
  .video-item {
    flex-direction: column;
    align-items: center;
  }
}
.el-dialog__header {
  background: linear-gradient(135deg, #4fc0d0, #2c3e50);
  color: white;
}

.el-dialog__title {
  color: white;
}

.el-button--primary {
  background-color: #4fc0d0;
  border-color: #4fc0d0;
}

.el-button--primary:hover {
  background-color: #3498db;
  border-color: #3498db;
}
</style>
