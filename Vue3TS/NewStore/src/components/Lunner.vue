<!-- LunarCalendar.vue -->
<template>
  <div class="lunar-card">
    <div class="header">
      <h2>{{ lunar.date }}</h2>
      <div>{{ lunar.year }}</div>
    </div>
    <div class="content">
      <div class="info-group">
        <div class="info-item">
          <span>公历</span>
          <strong>{{ lunar.solar }}</strong>
        </div>
        <div class="info-item">
          <span>星期</span>
          <strong>{{ lunar.week }}</strong>
        </div>
      </div>
      <div class="info-group">
        <div class="info-item">
          <span>生肖</span>
          <strong>{{ lunar.zodiac }}</strong>
        </div>
        <div class="info-item">
          <span>节气</span>
          <strong>{{ lunar.term }}</strong>
        </div>
      </div>
      <div class="info-group">
        <div class="info-item">
          <span>节日</span>
          <strong>{{ lunar.festival }}</strong>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { getLunar } from 'chinese-lunar-calendar';

// 响应式数据
const lunar = ref({
  date: '加载中...',
  year: '—',
  solar: '—',
  week: '—',
  zodiac: '—',
  term: '—',
  festival: '—'
});

// 更新函数
const updateTime = () => {
  try {
    const now = new Date();
    const lunarData = getLunar(
      now.getFullYear(),
      now.getMonth() + 1,
      now.getDate()
    );

    // 公历部分
    lunar.value.solar = `${now.getFullYear()}-${(now.getMonth()+1)
      .toString().padStart(2,'0')}-${now.getDate().toString().padStart(2,'0')}`;
    lunar.value.week = '星期' + ['日','一','二','三','四','五','六'][now.getDay()];

    // 农历部分
    lunar.value.date = lunarData.dateStr || '—';
    lunar.value.year = lunarData.lunarYear || '—';
    lunar.value.zodiac = lunarData.zodiac ? `${lunarData.zodiac}生肖` : '—';
    lunar.value.term = lunarData.solarTerm || '无节气';
    lunar.value.festival = [lunarData.festival, lunarData.lunarFestival]
      .filter(Boolean).join(' / ') || '无节日';
    
  } catch (error) {
    console.error('农历数据获取失败:', error);
    lunar.value = {
      date: '数据错误',
      year: '—',
      solar: '—',
      week: '—',
      zodiac: '—',
      term: '—',
      festival: '—'
    };
  }
};

// 生命周期
onMounted(() => {
  updateTime();
  setInterval(updateTime, 60000);
});
</script>

<style scoped lang="scss">
.lunar-card {
  user-select: none;
  width: min(100vw, 100%);
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  font-family: 'Helvetica Neue', system-ui, sans-serif;
  overflow: hidden;
  transition: transform 0.3s ease;
  
  &:hover {
    transform: translateY(-2px);
  }
}

.header {
  padding: 1.5rem;
  background: linear-gradient(135deg, #3B82F6, #6366F1);
  color: white;
  text-align: center;
  position: relative;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(45deg, 
      rgba(255,255,255,0.1) 25%,
      transparent 25%,
      transparent 50%,
      rgba(255,255,255,0.1) 50%,
      rgba(255,255,255,0.1) 75%,
      transparent 75%);
    background-size: 4px 4px;
    opacity: 0.1;
  }

  h2 {
    margin: 0;
    font-size: 2rem;
    font-weight: 600;
    letter-spacing: 1px;
    position: relative;
    z-index: 1;
  }

  div {
    margin-top: 0.5rem;
    font-size: 1.1rem;
    opacity: 0.9;
  }
}

.content {
  padding: 1.5rem;
  background: linear-gradient(45deg, #f8fafc, #f1f5f9);
}

.info-group {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  margin-bottom: 1rem;

  &:last-child {
    grid-template-columns: 1fr;
  }
}

.info-item {
  background: white;
  padding: 1.2rem;
  border-radius: 12px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  transition: transform 0.2s ease;
  
  &:hover {
    transform: translateY(-2px);
  }

  span {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: #64748b;
    font-size: 0.95rem;
    margin-bottom: 0.6rem;

    &::before {
      content: '';
      display: inline-block;
      width: 20px;
      height: 20px;
      background-size: contain;
    }
  }

  strong {
    color: #1e293b;
    font-size: 1.1rem;
    font-weight: 600;
  }

  // 不同项目的图标
  &:nth-child(1) span::before { background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%2364748b' d='M19 4h-1V2h-2v2H8V2H6v2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V10h14v10zM9 14H7v-2h2v2zm4 0h-2v-2h2v2zm4 0h-2v-2h2v2z'/%3E%3C/svg%3E"); }
  &:nth-child(2) span::before { background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%2364748b' d='M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2zm0 18c-4.4 0-8-3.6-8-8s3.6-8 8-8 8 3.6 8 8-3.6 8-8 8zm.5-13H11v6l5.2 3.2.8-1.3-4.5-2.7V7z'/%3E%3C/svg%3E"); }
  &:nth-child(3) span::before { background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%2364748b' d='M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5'/%3E%3C/svg%3E"); }
  &:nth-child(4) span::before { background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%2364748b' d='M12 2C8.1 2 5 5.1 5 9c0 5.3 7 13 7 13s7-7.7 7-13c0-3.9-3.1-7-7-7zm0 9.5c-1.4 0-2.5-1.1-2.5-2.5s1.1-2.5 2.5-2.5 2.5 1.1 2.5 2.5-1.1 2.5-2.5 2.5z'/%3E%3C/svg%3E"); }
  &:nth-child(5) span::before { background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%2364748b' d='M20 9h-8V4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V9zm-6 6h-4v-2h4v2zm3-4h-7V9h7v2z'/%3E%3C/svg%3E"); }
}

@media (max-width: 480px) {
  .info-group {
    grid-template-columns: 1fr;
    
    &:last-child {
      grid-template-columns: 1fr;
    }
  }

  .header {
    padding: 1rem;
    
    h2 {
      font-size: 1.7rem;
    }
  }
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-4px); }
}
</style>