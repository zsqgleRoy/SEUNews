<template>
  <div class="duration-panel">
    <!-- 顶部流光装饰 -->
    <div class="glow-bar top"></div>
    
    <!-- 选项容器 -->
    <div class="options-grid-wrapper">
      <div class="options-grid">
        <div
          v-for="(duration, index) in durations"
          :key="index"
          class="option-card"
          :class="{ 'selected': selectedDuration === parseInt(duration.match(/\d+/)![0]) }"
          @click="selectDuration(duration)"
        >
          <!-- 选中状态装饰 -->
          <div class="selection-indicator"></div>
          
          <!-- 宝石图标 -->
          <svg class="gem-icon" viewBox="0 0 24 24">
            <path fill="currentColor" d="M12 0L3 7l4 10h10l4-10-9-7zm0 2.3l6.3 4.9-3 7.8H8.7l-3-7.8 6.3-4.9z"/>
          </svg>

          <!-- 时长文本 -->
          <span class="duration-text">{{ duration }}</span>

          <!-- 价格换算 -->
          <div class="price-hint">约{{ getMonthlyPrice(duration) }}元/月</div>
        </div>
      </div>
    </div>

    <!-- 底部流光装饰 -->
    <div class="glow-bar bottom"></div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue';
const emit = defineEmits(['duration-change']);

const durations = ['1个月', '3个月', '6个月', '12个月','24个月','48个月'];
const durationsValue = [1, 3, 6, 12, 24, 48];
const selectedDuration = ref(durationsValue[0]);

const priceMap = {
  '1个月': 20,
  '3个月': 50,
  '6个月': 90,
  '12个月': 160,
  '24个月': 300,
  '48个月': 580
};

const getMonthlyPrice = (duration: string) => {
  return (priceMap[duration as keyof typeof priceMap] / parseInt(duration.match(/\d+/)![0])).toFixed(1);
};

const selectDuration = (duration: string) => {
  selectedDuration.value = parseInt(duration.match(/\d+/)![0]);
  emit('duration-change', duration);
};

defineExpose({
  selectedDuration
});
// 初始化时触发事件
onMounted(() => {
  emit('duration-change', selectedDuration.value);
});
</script>

<style scoped lang="scss">
.duration-panel {
  min-width: 70vw;
  position: relative;
  padding: 20px 25px;
  background: 
    radial-gradient(circle at 50% 0%, rgba(255,215,0,0.05) 0%, transparent 30%),
    linear-gradient(45deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 16px;
  border: 1px solid rgba(255,215,0,0.2);
  box-shadow: 0 0 30px rgba(0,0,0,0.5);
  overflow: hidden;

  @media (max-width: 600px) {
    min-width: 90vw;
    padding: 15px;
  }

  &::before {
    content: '';
    position: absolute;
    inset: -2px;
    background: linear-gradient(45deg, 
      rgba(255,215,0,0.3) 0%,
      rgba(255,215,0,0.1) 50%,
      rgba(255,215,0,0.3) 100%);
    z-index: -1;
    animation: rotate 10s linear infinite;
  }
}

.options-grid-wrapper {
  max-height: 50vh;
  overflow-y: auto;
  padding: 10px 0;
}

.options-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(160px, 1fr));
  gap: 18px;
  justify-items: center;

  @media (max-width: 1024px) {
    grid-template-columns: repeat(2, minmax(140px, 1fr));
    gap: 15px;
  }

  @media (max-width: 600px) {
    grid-template-columns: 1fr;
    gap: 12px;
  }
}

.option-card {
  width: 100%;
  min-width: 40px;
  position: relative;
  background: rgba(30,30,30,0.9);
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255,215,0,0.15);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;

  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(255,215,0,0.1);
    background: rgba(40,40,40,0.9);
  }

  &.selected {
    background: linear-gradient(45deg, rgba(255,215,0,0.1), rgba(255,215,0,0.05));
    border: 1px solid rgba(255,215,0,0.6);
    box-shadow: 
      0 0 20px rgba(255,215,0,0.3),
      inset 0 0 12px rgba(255,215,0,0.15);

    .gem-icon {
      color: #ffd700;
      filter: drop-shadow(0 0 6px rgba(255,215,0,0.6));
    }

    .price-hint {
      opacity: 1;
      transform: translateY(0);
    }
  }
}

.gem-icon {
  width: 40px;
  height: 40px;
  color: rgba(255,255,255,0.4);
  transition: all 0.3s ease;
}

.duration-text {
  font-size: 16px;
  font-weight: 600;
  color: #fff;
  letter-spacing: 0.5px;
  text-align: center;
}

.price-hint {
  font-size: 13px;
  color: rgba(255,215,0,0.9);
  opacity: 0.8;
  transition: all 0.3s ease;
  transform: translateY(2px);
}

.glow-bar {
  position: absolute;
  left: 0;
  right: 0;
  height: 2px;
  background: linear-gradient(90deg, 
    transparent 0%, 
    rgba(255,215,0,0.7) 50%, 
    transparent 100%);
  animation: glow-flow 4s infinite;
  filter: blur(1px);
  
  &.top { top: 10px; }
  &.bottom { bottom: 10px; }
}

@keyframes rotate {
  100% { transform: rotate(360deg) }
}

@keyframes glow-flow {
  0% { transform: translateX(-100%); opacity: 0.6 }
  50% { opacity: 1 }
  100% { transform: translateX(100%); opacity: 0.6 }
}
</style>