<template>
    <div v-if="!isLoading" class="block block-headline">
      <h2 class="section-title">
        头条新闻
        <More :tagId="1"></More>
      </h2>
      <div class="news-list">
        <div class="news-item" v-for="(item, index) in sliderNewsList" :key="index">
          <router-link :to="`/news/${item.article_id}`" class="news-link">
            <div class="news-image-container">
              <img :src="item.headImageUrl" alt="新闻图片" class="news-image">
            </div>
            <div class="news-content">
              <h4 class="news-title">{{ item.title }}</h4>
              <p class="news-date">{{ formatDate(item.publishDate) }}</p>
            </div>
          </router-link>
        </div>
      </div>
    </div>
</template>
  
<script lang="ts" setup>
  import { formatDate } from '@/utils/format';
  import { onUnmounted } from 'vue';
  import { useRouter } from 'vue-router';
  import More from "@/components/common/button/More.vue"
  interface NewsItem {
    article_id: string;
    headImageUrl: string;
    title: string;
    publishDate: string;
  }
  const router = useRouter();
  const props = defineProps<{
    isLoading: boolean;
    sliderNewsList: NewsItem[];
  }>();

  onUnmounted(() => {
    
  });
</script>
  
<style scoped lang="scss">
  .block {
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 20px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
    padding: 2rem;
    margin-bottom: 1rem;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }
  
  .block:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 36px rgba(0, 0, 0, 0.15);
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
  
  .news-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(calc((100% - 2rem) / 3), 1fr));
    gap: 1rem;
  }
  
  .news-item {
    height: 180px;
    max-width: 100%;
    display: flex;
    flex-direction: column;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }
  
  .news-item:hover {
    transform: translateY(-10px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  }
  
  .news-link {
    text-decoration: none;
    color: inherit;
    height: 100%; 
  }
  
  .news-image-container {
    position: relative;
    overflow: hidden;
    background-color: #f5f5f5;
    height: 120px;
    &::after {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(
        to bottom,
        rgba(255, 255, 255, 0) 60%,
        rgba(0, 0, 0, 0.05)
      );
    }
  }
  
  .news-image {
    width: 100%;
    height: 120px;
    object-fit: cover;
    transition: transform 0.3s ease;
    overflow: hidden;
    background-color: #f5f5f5;
  }
  
  .news-item:hover .news-image {
    transform: scale(1.1);
  }
  
  .news-content {
    padding: 0.5rem;
  }
  
  .news-title {
    font-size: 1rem;
    color: #2c3e50;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    display: block;
    max-width: 100%;
  }
  
  .news-date {
    font-size: 0.7rem;
    color: #666666;
    text-align: right;
    line-height: 1.4;
    opacity: 0.8;
    transition: all 0.3s ease;
    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.9);
  }
  
  .news-date:hover {
    opacity: 1;
    color: #3498db;
    transform: translateX(2px);
  }
</style>    