<template>
  <div class="panel">
    <div class="glow-effect"></div>
    <div class="decorative-border top">
      <div class="gold-line"></div>
      <div class="diamond"></div>
      <div class="gold-line"></div>
    </div>

    <div class="title-container">
      <svg class="title-deco left" viewBox="0 0 100 10">
        <path d="M0 5 Q25 0 50 5 T100 5" 
              stroke="rgba(255,215,0,0.3)" 
              fill="none"
              stroke-width="0.5"/>
      </svg>
      <h2 class="main-title">
        <svg class="crown-icon" viewBox="0 0 24 24">
          <path fill="#ffd700" d="M5 16L3 5l5.5 5L12 4l3.5 6L21 5l-2 11H5m14 3H5v2h14v-2z"/>
        </svg>
        加入南瓜会员
        <svg class="star-icon" viewBox="0 0 24 24">
          <path fill="#ffd700" d="M12 1.5l2.3 7.1h7.4l-6 4.3 2.3 7.1-6-4.3-6 4.3 2.3-7.1-6-4.3h7.4z"/>
        </svg>
      </h2>

      <!-- 右侧装饰线 -->
      <svg class="title-deco right" viewBox="0 0 100 10">
        <path d="M100 5 Q75 0 50 5 T0 5" 
              stroke="rgba(255,215,0,0.3)" 
              fill="none"
              stroke-width="0.5"/>
      </svg>
    </div>
    <div class="content-wrapper">
      <div class="options-container">
        <MembershipDurationSelect 
          ref="durationRef"
          @duration-change="onDurationChange"
        />
      </div>
      <div class="payment-container">
        <PayMenu v-if="vipId" :vipId="vipId" :price="price" />
      </div>
    </div>

    <!-- 底部装饰 -->
    <div class="decorative-border bottom">
      <div class="gold-line"></div>
      <div class="diamond"></div>
      <div class="gold-line"></div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { onMounted, ref } from 'vue';
import MembershipDurationSelect from './MockPayment.vue';
import PayMenu from "./pay.vue"
const vipId = ref(1);
type DurationOption = {
  id: number;
  value: number;
  price: number;
  label: string;
  discount?: number;
};
const price = ref(0)
const selectedDuration = ref<DurationOption>();
const durationRef = ref<{
  selectedDuration: DurationOption | undefined;
}>();

  
onMounted(() => {

});
const onDurationChange = (newDuration: DurationOption)=>{
  vipId.value = newDuration.id
  const basePrice = newDuration.price / 30
  selectedDuration.value = newDuration;
  price.value = Number((newDuration.discount ? basePrice * newDuration.discount : basePrice).toFixed(2))
}

</script>

<style scoped lang="scss">
/* 修复后的核心样式 */
.content-wrapper {
  display: flex;
  flex-direction: column;
  gap: 30px;
  padding: 10px 0px;
  width: 100%;
  min-height: 400px;
  align-items: center; /* 新增：使内容水平居中 */

  @media (max-width: 992px) {
    min-height: auto;
    padding: 20px 30px;
  }

  @media (max-width: 576px) {
    padding: 15px;
  }
}

.options-container {
  display: flex;
  justify-content: center;
  width: 100%;
}

.payment-container {
  display: flex;
  justify-content: center;
  min-width: 0;
  width: 100%;
}

/* 加强版垂直分隔线 */
.vertical-divider {
  display: none;
}

.panel {
  justify-content: center;
  user-select: none;
  -moz-user-select: none;
  min-height: 100vh;
  margin: 0;
  max-width: 100vw;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 30px;
  background: 
    radial-gradient(circle at 50% 0%, rgba(255,215,0,0.1) 0%, transparent 30%),
    linear-gradient(45deg, #1a1a1a 0%, #0a0a0a 100%);
  padding: 20px 0px;
  border: 2px solid rgba(255,215,0,0.3);
  position: relative;
  overflow: hidden;
  box-shadow: 0 0 30px rgba(0,0,0,0.5);
  max-height: 100%;
  &::before {
    content: '';
    position: absolute;
    background: linear-gradient(45deg, 
      rgba(255,215,0,0.3) 0%,
      rgba(255,215,0,0.1) 50%,
      rgba(255,215,0,0.3) 100%);
    z-index: -1;
    animation: rotate 10s linear infinite;
  }
}

.qr-code-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  position: relative;
  padding: 20px;
  border-radius: 15px;
  background: rgba(0,0,0,0.4);
  backdrop-filter: blur(8px);
  box-shadow: 
    0 0 20px rgba(255,215,0,0.1),
    inset 0 0 0 1px rgba(255,215,0,0.2);

  .qr-frame {
    border: 2px solid rgba(255,215,0,0.5);
    padding: 10px;
    border-radius: 10px;
    background: white;
  }

  .qr-tip {
    margin-top: 15px;
    color: rgba(255,215,0,0.8);
    font-size: 14px;
    text-align: center;
    text-shadow: 0 1px 2px rgba(0,0,0,0.5);
  }
}

.decorative-border {
  position: absolute;
  left: 20px;
  right: 20px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  z-index: 1;

  &.top { top: -15px }
  &.bottom { bottom: -15px }

  .gold-line {
    flex: 1;
    height: 2px;
    background: linear-gradient(90deg, transparent 0%, #ffd700 50%, transparent 100%);
  }

  .diamond {
    width: 30px;
    height: 30px;
    background: #ffd700;
    clip-path: polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%);
    transform: rotate(45deg);
    margin: 0 10px;
    box-shadow: 0 0 10px rgba(255,215,0,0.5);
  }
}

.glow-effect {
  position: absolute;
  top: 0;
  left: -100%;
  width: 200%;
  height: 100%;
  background: linear-gradient(
    90deg,
    rgba(255,215,0,0) 0%,
    rgba(255,215,0,0.1) 50%,
    rgba(255,215,0,0) 100%
  );
  animation: glow-flow 4s infinite;
  pointer-events: none;
}

@keyframes rotate {
  100% { transform: rotate(360deg) }
}

@keyframes glow-flow {
  0% { transform: translateX(0) }
  100% { transform: translateX(100%) }
}

.title-container {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;

  @media (max-width: 768px) {
    margin: 18px 0 30px;
    padding: 0 20px;
  }

  @media (max-width: 480px) {
    margin: 18px 0 30px;
    padding: 0 15px;
  }
}

.main-title {
  color: #ffd700;
  font-size: 2.2rem;
  text-shadow: 0 0 10px rgba(255,215,0,0.3);
  display: flex;
  align-items: center;
  gap: 15px;
  margin: 0 30px;
  position: relative;
  padding: 0 20px;

  &::before,
  &::after {
    content: '';
    position: absolute;
    top: 50%;
    width: 30px;
    height: 2px;
    background: linear-gradient(90deg, 
      transparent 0%,
      rgba(255,215,0,0.5) 50%,
      transparent 100%);
  }

  &::before {
    left: -30px;
  }

  &::after {
    right: -30px;
  }

  @media (max-width: 768px) {
    font-size: 1.8rem;
    margin: 0 20px;
    gap: 10px;
    
    &::before,
    &::after {
      width: 20px;
    }
  }

  @media (max-width: 480px) {
    font-size: 1rem;
    padding: 0 15px;
  }
}

.title-deco {
  flex: 1;
  max-width: 200px;
  height: 10px;
  opacity: 0.6;

  &.left {
    transform: scaleX(-1);
  }

  @media (max-width: 768px) {
    max-width: 150px;
  }
}

.crown-icon {
  width: 36px;
  height: 36px;
  filter: drop-shadow(0 0 2px rgba(255,215,0,0.5));
  animation: float 3s ease-in-out infinite;

  @media (max-width: 768px) {
    width: 28px;
    height: 28px;
  }
}

.star-icon {
  width: 28px;
  height: 28px;
  filter: drop-shadow(0 0 2px rgba(255,215,0,0.5));
  animation: sparkle 1.5s ease-in-out infinite;

  @media (max-width: 768px) {
    width: 22px;
    height: 22px;
  }
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-3px); }
}

@keyframes sparkle {
  0%, 100% { opacity: 1; transform: scale(1); }
  50% { opacity: 0.6; transform: scale(1.1); }
}
</style>    