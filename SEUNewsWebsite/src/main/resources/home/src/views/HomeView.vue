<template>
  <div class="home">
    <!-- 顶部轮播图 -->
    <div class="banner">
    </div>

    <!-- 主内容区域 -->
    <main class="main-content">
      <!-- 头条新闻和北京时间组件 -->
      <div class="block-headline-and-time">
        <div class="block头条新闻">
          <h2>头条新闻</h2>
          <div class="news-list">
            <div class="news-item" v-for="(item, index) in topNews" :key="index">
              <router-link :to="item.path">
                <img :src="item.image" alt="新闻图片">
                <div class="news-content">
                  <h3>{{ item.title }}</h3>
                  <p>{{ item.description }}</p>
                </div>
              </router-link>
            </div>
          </div>
        </div>
        <BeijingTime />
      </div>

      <!-- 新闻分类 -->
      <div class="block分类新闻">
        <h2>新闻分类</h2>
        <div class="category-grid">
          <div class="category-item" v-for="(category, index) in categories" :key="index">
            <router-link :to="category.path">
              <img :src="category.icon" alt="分类图标">
              <h4>{{ category.name }}</h4>
            </router-link>
          </div>
        </div>
      </div>

      <!-- 热门推荐 -->
      <div class="block热门推荐">
        <h2>热门推荐</h2>
        <div class="news-list">
          <div class="news-item" v-for="(item, index) in hotNews" :key="index">
            <router-link :to="item.path">
              <h3>{{ item.title }}</h3>
              <p>{{ item.description }}</p>
            </router-link>
          </div>
        </div>
      </div>
    </main>

    <!-- 侧边栏 -->
    <aside class="sidebar">
      <!-- 快速入口 -->
      <div class="quick-links">
        <h3>快速入口</h3>
        <div class="link-item" v-for="link in quickLinks" :key="link.title">
          <router-link :to="link.path">{{ link.title }}</router-link>
        </div>
      </div>

      <!-- 视频专区 -->
      <div class="video-section">
        <h3>视频专区</h3>
        <div class="video-item" v-for="video in videos" :key="video.id">
          <router-link :to="video.path">
            <img :src="video.thumbnail" alt="视频缩略图">
            <h4>{{ video.title }}</h4>
          </router-link>
        </div>
      </div>
    </aside>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import BeijingTime from '@/components/BeijingTime.vue'; // 引入北京时间组件

// 模拟数据
const topNews = ref([
  {
    path: '/news/1',
    image: 'https://via.placeholder.com/300x200',
    title: '习近平出席二十国集团领导人峰会并发表重要讲话',
    description: '当地时间11月15日，国家主席习近平出席二十国集团领导人第十七次峰会并发表重要讲话...'
  },
  // 其他新闻项...
]);

const categories = ref([
  { path: '/politics', name: '政治', icon: 'https://via.placeholder.com/64x64' },
  { path: '/economy', name: '经济', icon: 'https://via.placeholder.com/64x64' },
  // 其他分类...
]);

const hotNews = ref([
  { path: '/news/2', title: '中国空间站第三次太空授课活动取得圆满成功', description: '10月12日，“天宫课堂”第三课在中国空间站开讲...' },
  // 其他新闻项...
]);

const quickLinks = ref([
  { path: '/about', title: '关于我们' },
  { path: '/contact', title: '联系我们' },
  // 其他链接...
]);

const videos = ref([
  { id: 1, path: '/video/1', thumbnail: 'https://via.placeholder.com/200x150', title: '中国科技发展纪实' },
  // 其他视频...
]);
</script>

<style scoped>
.home {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.banner {
  margin-bottom: 30px;
}

.main-content {
  display: grid;
  grid-template-columns: 3fr 1fr;
  gap: 30px;
  margin-bottom: 30px;
}

.block {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.block-headline-and-time {
  grid-column: span 2;
  display: grid;
  grid-template-columns: 3fr 1fr;
  gap: 30px;
}

.news-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.news-item {
  display: flex;
  gap: 20px;
  padding: 15px;
  border-radius: 5px;
  transition: transform 0.3s ease;
}

.news-item:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.news-item img {
  width: 150px;
  height: 100px;
  object-fit: cover;
  border-radius: 4px;
}

.news-content h3 {
  margin-bottom: 5px;
  color: #2c3e50;
}

.news-content p {
  color: #7f8c8d;
  font-size: 0.9em;
}

.category-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 20px;
  padding-top: 20px;
}

.category-item {
  text-align: center;
  padding: 15px;
  border-radius: 5px;
  transition: transform 0.3s ease;
}

.category-item:hover {
  transform: translateY(-3px);
  background: #ecf0f1;
}

.category-item img {
  width: 64px;
  height: 64px;
  margin-bottom: 10px;
}

.category-item h4 {
  color: #3498db;
}

.sidebar {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.quick-links,
.video-section {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.quick-links .link-item {
  padding: 10px 0;
  border-bottom: 1px solid #eee;
}

.quick-links .link-item:last-child {
  border-bottom: none;
}

.video-item {
  display: flex;
  gap: 15px;
  margin-bottom: 15px;
  padding: 10px;
  transition: transform 0.3s ease;
}

.video-item:hover {
  transform: translateX(5px);
}

.video-item img {
  width: 100px;
  height: 75px;
  object-fit: cover;
  border-radius: 4px;
}

@media (max-width: 768px) {
  .main-content {
    grid-template-columns: 1fr;
  }

  .block-headline-and-time {
    grid-template-columns: 1fr;
  }

  .block-headline-and-time > .block头条新闻 {
    grid-column: span 1;
  }
}
</style>
