<template>
  <div class="Home-img-slider">
      <div class="slider-container" :style="sliderStyle">
          <img 
              v-for="(img, index) in images" 
              :key="index" 
              :src="img" 
              alt=""
              class="slider-image"
          >
      </div>
      <div class="slider-indicators">
          <div 
              v-for="(img, index) in images" 
              :key="index" 
              :class="{ 'active': index === currentIndex.valueOf() }" 
              @click="goToImage(index)"
          ></div>
      </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue';

const props = defineProps({
  images: {
      type: Array as () => string[],
      required: true
  },
  interval: {
      type: Number,
      default: 5000
  }
});

const currentIndex = ref(0);
const sliderStyle = ref<{ transform: string; transition: string }>({
  transform: 'translateX(0%)',
  transition: 'transform 0.5s ease'
});

let timer: ReturnType<typeof setInterval> | null = null;

// 计算滑动样式
const calculateSliderStyle = (): void => {
  sliderStyle.value = {
      transform: `translateX(${-currentIndex.value * 100}%)`,
      transition: 'transform 0.5s ease'
  };
};

// 切换图片
const nextImage = (): void => {
  currentIndex.value = (currentIndex.value + 1) % props.images.length;
  calculateSliderStyle();
};

// 跳转到指定图片
const goToImage = (index: number): void => {
  currentIndex.value = index;
  calculateSliderStyle();
  if (timer) {
      clearInterval(timer);
      timer = setInterval(nextImage, props.interval);
  }
};

onMounted(() => {
  calculateSliderStyle();
  timer = setInterval(nextImage, props.interval);
});

onBeforeUnmount(() => {
  if (timer) clearInterval(timer);
});

</script>

<style scoped>
.Home-img-slider {
  width: 100%;
  height: auto; /* 可根据需要调整高度 */
  overflow: hidden;
  position: relative;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  border-radius: 8px;
}

.slider-container {
  display: flex;
  width: 100%;
  height: 100%;
  will-change: transform;
}

.slider-image {
  min-width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.slider-indicators {
  position: absolute;
  bottom: 10px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 5px;
}

.slider-indicators div {
  width: 20px;
  height: 3px;
  background-color: rgba(255, 255, 255, 0.5);
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.slider-indicators div.active {
  background-color: white;
}
</style>
