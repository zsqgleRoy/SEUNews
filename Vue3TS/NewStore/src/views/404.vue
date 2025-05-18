<template>
  <div class="not-found-container">
    <!-- 背景装饰 -->
    <div class="bg-blur"></div>
    <div class="floating-shapes" :style="{ '--shape-count': 12 }">
      <div v-for="n in 12" :key="n" class="floating-shape"></div>
    </div>

    <!-- 主要内容 -->
    <div class="content-wrapper">
      <div class="glass-card">
        <!-- 动态数字 -->
        <div class="error-code">
          <span>4</span>
          <div class="image-wrapper">
            <img src="/src/assets/imges/seuLogo.png" alt="circle" class="circle-image" />
            <div class="spaceship"></div>
          </div>
          <span>4</span>
        </div>
        
        <h1 class="not-found-title">页面迷失在数字宇宙</h1>
        
        <p class="not-found-description">
          我们派遣了纳米机器人搜寻<br>
          建议您先返回安全区
        </p>
        
        <router-link to="/" class="not-found-button">
          <span>返回基地&nbsp;</span>
          <el-icon :size="20"><HomeFilled /></el-icon>
          <div class="button-hover-effect"></div>
        </router-link>
      </div>
    </div>

    <!-- 星空粒子 -->
    <canvas class="particles-canvas"></canvas>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { initParticles } from '@/utils/particles'
import { size } from 'lodash';

onMounted(() => {
  initParticles('.particles-canvas')
})

// 动态生成浮动形状的样式
const generateFloatingShapesStyles = () => {
  const shapeCount = 12;
  const styleElement = document.createElement('style');
  let styleText = '';
  for (let i = 1; i <= shapeCount; i++) {
    const size = Math.floor(Math.random() * 40) + 20;
    const delay = Math.floor(Math.random() * 2000);
    const duration = Math.floor(Math.random() * 5000) + 5000;
    const left = Math.floor(Math.random() * 100);
    const top = Math.floor(Math.random() * 100);
    styleText += `.floating-shape:nth-child(${i}) {
      --size: ${size}px;
      --delay: ${delay}ms;
      --duration: ${duration}ms;
      left: ${left}%;
      top: ${top}%;
    }`;
  }
  styleElement.textContent = styleText;
  document.head.appendChild(styleElement);
};

// 在挂载时生成样式
onMounted(() => {
  generateFloatingShapesStyles();
});
</script>

<style scoped lang="scss">
.not-found-container {
  --primary: hsl(230, 80%, 60%);
  --accent: hsl(330, 80%, 60%);
  --glass: rgba(255, 255, 255, 0.08);
  --text: rgba(255, 255, 255, 0.9);
  
  min-height: 100vh; /* 修改为 min-height，确保内容能完整显示 */
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(
    135deg,
    hsl(230, 50%, 15%),
    hsl(260, 50%, 15%)
  );
  font-family: 'Inter', system-ui, sans-serif;
  position: relative;
  overflow: hidden;
}

.bg-blur {
  position: absolute;
  inset: 0;
  background: radial-gradient(
    circle at 50% 50%,
    var(--primary) 0%,
    transparent 60%
  );
  opacity: 0.15;
  filter: blur(80px);
}

.floating-shapes {
  --shape-count: 12;
}

.floating-shape {
  position: absolute;
  width: var(--size);
  height: var(--size);
  background: linear-gradient(
    45deg,
    var(--primary),
    var(--accent)
  );
  border-radius: 50%;
  animation: float var(--duration) var(--delay) infinite;
  mix-blend-mode: screen;
  opacity: 0.15;
}

@keyframes float {
  0%, 100% { transform: translate(0, 0); }
  25% { transform: translate(10px, -10px); }
  50% { transform: translate(-5px, 15px); }
  75% { transform: translate(-15px, 5px); }
}

.glass-card {
  background: var(--glass);
  backdrop-filter: blur(12px);
  border-radius: 24px;
  padding: 4rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
  position: relative;
  z-index: 2;
}

.error-code {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  margin-bottom: 3rem;
  font-size: 8rem;
  font-weight: 800;
  color: var(--text);
  position: relative;

  span {
    position: relative;
    z-index: 2;
  }

  .image-wrapper {
    position: relative;
  }

  .circle-image {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
  }

  .spaceship {
    width: 20px;
    height: 20px;
    background-color: var(--accent);
    border-radius: 50%;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    animation: orbit 10s linear infinite;
    box-shadow: 0 0 10px var(--accent);
  }
}

@keyframes orbit {
  from {
    transform: translate(-50%, -50%) rotate(0deg) translateX(70px) rotate(0deg);
  }
  to {
    transform: translate(-50%, -50%) rotate(360deg) translateX(70px) rotate(-360deg);
  }
}

.not-found-title {
  font-size: 2.2rem;
  color: var(--text);
  margin-bottom: 1.5rem;
  line-height: 1.3;
}

.not-found-description {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 3rem;
  line-height: 1.6;
}

.not-found-button {
  display: inline-flex;
  align-items: center;
  padding: 1.2rem 2.5rem;
  border-radius: 50px;
  background: linear-gradient(
    135deg,
    var(--primary),
    var(--accent)
  );
  color: white;
  text-decoration: none;
  position: relative;
  overflow: hidden;
  transition: transform 0.3s ease;

  span {
    position: relative;
    z-index: 2;
  }

  &:hover {
    transform: translateY(-2px);

    .button-hover-effect {
      transform: translate(-50%, -50%) scale(12);
    }
  }
}

.button-hover-effect {
  position: absolute;
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.15);
  border-radius: 50%;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%) scale(0);
  transition: transform 0.6s cubic-bezier(0.23, 1, 0.32, 1);
}

.particles-canvas {
  position: absolute;
  top: 0;
  left: 0;
  pointer-events: none;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .glass-card {
    padding: 2rem;
    margin: 1rem;
  }

  .error-code {
    font-size: 4rem;
    .circle-image {
      width: 80px;
      height: 80px;
    }
    .spaceship {
      width: 15px;
      height: 15px;
      animation: orbit 8s linear infinite;
    }
  }

  .not-found-title {
    font-size: 1.8rem;
  }
}

/* 进一步优化响应式设计，适配小尺寸手机 */
@media (max-width: 480px) {
  .glass-card {
    padding: 1.5rem;
    margin: 0.5rem; /* 减少边距 */
  }

  .error-code {
    font-size: 3rem;
    gap: 0.8rem; /* 减少数字间距 */
    .circle-image {
      width: 50px;
      height: 50px;
    }
    .spaceship {
      width: 10px;
      height: 10px;
      animation: orbit 6s linear infinite;
    }
  }

  .not-found-title {
    font-size: 1.3rem; /* 减小标题字体大小 */
  }

  .not-found-description {
    font-size: 0.9rem; /* 减小描述字体大小 */
    margin-bottom: 2rem; /* 减少描述底部间距 */
  }

  .not-found-button {
    padding: 0.8rem 1.8rem; /* 减小按钮内边距 */
    font-size: 0.9rem; /* 减小按钮字体大小 */
  }
}

/* 适配超小尺寸手机 */
@media (max-width: 320px) {
  .glass-card {
    padding: 1rem;
  }

  .error-code {
    font-size: 2.5rem;
    gap: 0.5rem;
    .circle-image {
      width: 40px;
      height: 40px;
    }
    .spaceship {
      width: 8px;
      height: 8px;
      animation: orbit 5s linear infinite;
    }
  }

  .not-found-title {
    font-size: 1.1rem;
  }

  .not-found-description {
    font-size: 0.8rem;
    margin-bottom: 1.5rem;
  }

  .not-found-button {
    padding: 0.6rem 1.5rem;
    font-size: 0.8rem;
  }
}
</style>    