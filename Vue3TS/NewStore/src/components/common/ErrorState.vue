<template>
    <div class="error-state-container">
      <!-- 背景元素 -->
      <div class="bg-blur"></div>
      <div class="floating-shapes" :style="{ '--shape-count': 8 }">
        <div v-for="n in 8" :key="n" class="floating-shape"></div>
      </div>
  
      <!-- 主要内容 -->
      <div class="content-wrapper">
        <div class="glass-card">
            <div class="close-button">
                <el-icon @click="closeErrorPage"><CloseBold /></el-icon>
            </div>
          <!-- 错误图标 -->
          <div class="error-icon-container">
            <el-icon class="error-icon"><WarningFilled /></el-icon>
            <div class="spaceship"></div>
          </div>
  
          <h1 class="error-title">{{ errorMessage }}</h1>
          
          <p class="error-description">
            {{ errorDescription }}
          </p>
          
          <el-button 
            v-if="showRetry"
            type="primary" 
            class="error-button"
            @click="retryAction"
          >
            <span>{{ retryText }}&nbsp;</span>
            <el-icon :size="18"><Refresh /></el-icon>
            <div class="button-hover-effect"></div>
          </el-button>
        </div>
      </div>
      <canvas class="particles-canvas"></canvas>
    </div>
</template>
  
<script setup lang="ts">
  import { onMounted, computed, onUnmounted } from 'vue'
  import { initParticles } from '@/utils/particles'
  import { useRoute, useRouter } from 'vue-router';

  const route = useRoute();
  const router = useRouter();

    // 从路由参数获取错误信息
    //   const errorMessage = computed(() => route.query.errorMessage as string || '发生错误');
    //   const errorDescription = computed(() => route.query.errorDescription as string || '请检查网络连接');
    //   const showRetry = computed(() => route.query.showRetry !== 'false');
    //   const retryText = computed(() => route.query.retryText as string || '重新加载');


    const errorMessages = [
    '反物质反应堆过载',
    '曲速引擎熄火',
    '引力场发生器故障',
    '超光速通讯中断',
    '星际地图数据损坏',
    '导航信标失效',
    '生命维持系统故障',
    '护盾能量耗尽',
    '时间旅行悖论',
    '外星信号干扰',
    '能源核心熔毁',
    '虫洞不稳定',
    '引力井捕获',
    '星门连接中断',
    '暗物质电池失效',
    '空间裂缝扩大',
    '量子计算机崩溃',
    '星舰操作系统冻结',
    '反重力装置故障',
    '星舰AI进入休眠',
    '超空间传感器失效',
    '星舰外壳出现裂痕',
    '反物质容器泄漏',
    '引力波通信受阻',
    '星舰厨房复制机故障'
    ];

    const errorDescriptions = [
    '能量输出超出安全阈值',
    '请检查曲速线圈状态',
    '引力波稳定器未响应',
    '尝试切换至备用通讯协议',
    '正在同步最新星图数据',
    '导航系统正在重新校准',
    '氧气循环系统异常',
    '护盾发生器过载',
    '时间线出现分支冲突',
    '检测到未知频率干扰',
    '核心温度突破临界值',
    '虫洞即将发生坍缩',
    '引力井强度持续增加',
    '星门坐标出现偏差',
    '暗物质能量正在流失',
    '空间结构出现异常波动',
    '量子处理器发生退相干',
    '操作系统文件系统损坏',
    '反重力场出现波动',
    'AI核心进入自我修复模式',
    '超空间粒子密度过高',
    '船体材料疲劳度超标',
    '反物质 containment失效',
    '引力波振幅异常',
    '有机物质合成失败'
    ];

    const retryTexts = [
    '重新校准',
    '重启引擎',
    '重置引力场',
    '切换协议',
    '同步数据',
    '重新定位',
    '重启生命维持',
    '充电护盾',
    '时间线修正',
    '屏蔽干扰',
    '紧急冷却',
    '稳定虫洞',
    '脱离引力井',
    '修复星门',
    '更换电池',
    '关闭裂缝',
    '重启计算机',
    '系统恢复',
    '重启反重力',
    '唤醒AI',
    '清洁传感器',
    '维修外壳',
    '密封容器',
    '调整振幅',
    '重启厨房'
    ];

    // 随机组合
    const errorMessage = errorMessages[Math.floor(Math.random() * errorMessages.length)];
    const errorDescription = errorDescriptions[Math.floor(Math.random() * errorDescriptions.length)];
    const retryText = retryTexts[Math.floor(Math.random() * retryTexts.length)];
    const showRetry = 'false';

  const retryAction = () => {
    router.go(-1);
  };
  const closeErrorPage=()=>{
    router.push("/");
  }
  // 动态生成浮动形状样式
  const generateFloatingShapesStyles = () => {
    const styleElement = document.createElement('style');
    let styleText = '';
    for (let i = 1; i <= 8; i++) {
      const size = Math.floor(Math.random() * 30) + 15;
      const delay = Math.floor(Math.random() * 2000);
      const duration = Math.floor(Math.random() * 4000) + 4000;
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

  onMounted(() => {
    generateFloatingShapesStyles();
  });
  let cleanupParticles: (() => void) | null = null

    onMounted(() => {
        cleanupParticles = initParticles('.particles-canvas')
    })

    onUnmounted(() => {
    if (cleanupParticles) {
        cleanupParticles()
        cleanupParticles = null
    }
    })
</script>
  
<style scoped lang="scss">
  .error-state-container {
    --primary: hsl(230, 80%, 60%);
    --accent: hsl(330, 80%, 60%);
    --glass: rgba(255, 255, 255, 0.08);
    --text: rgba(255, 255, 255, 0.9);
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
    display: flex;
    height: 100vh;
    }

    .content-wrapper {
        user-select: none;
        min-width: 100vw;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-left: 0;
    }

    .glass-card {
        background: var(--glass);
        backdrop-filter: blur(12px);
        border-radius: 24px;
        padding: 3rem;
        border: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        text-align: center;
        position: relative;
        z-index: 2;
        margin: 0 auto;
        width: 100vw;
        max-width: 600px;
    }
    .close-button {
        position: absolute;
        top: 1.5rem;
        right: 1.5rem;
        z-index: 10;
        padding: 0.5rem;
        border-radius: 100%;
        transition: transform 0.3s ease;

        &:hover {
            transform: scale(1.1);
        }

        .el-icon {
            color: white;
            font-size: 1.2rem;
            cursor: pointer;
            filter: drop-shadow(0 0 4px rgba(0, 0, 0, 0.3));
        }
    }

        // 响应式调整
        @media (max-width: 768px) {
        .close-button {
            top: 1rem;
            right: 1rem;
            padding: 0.4rem;
        }

        .el-icon {
            font-size: 1rem;
        }
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
    --shape-count: 8;
  }

  .floating-shape {
    position: absolute;
    width: var(--size);
    height: var(--size);
    background: linear-gradient(45deg, var(--primary), var(--accent));
    border-radius: 50%;
    animation: float var(--duration) var(--delay) infinite;
    mix-blend-mode: screen;
    opacity: 0.15;
  }

  .error-icon-container {
    position: relative;
    margin-bottom: 2rem;

    .error-icon {
      font-size: 6rem;
      color: var(--accent);
      filter: drop-shadow(0 0 12px var(--accent));
    }

    .spaceship {
      width: 24px;
      height: 24px;
      background: var(--primary);
      border-radius: 50%;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      animation: orbit 8s linear infinite;
      box-shadow: 0 0 12px var(--primary);
    }
  }

  .error-title {
        background: linear-gradient(135deg, #00c5ff, #ff4747);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        text-shadow: 0 0 12px rgba(254, 28, 47, 0.121);
    }

    .error-description {
        color: rgba(255, 255, 255, 0.6);
        text-shadow: 0 0 8px rgba(0, 0, 0, 0.3);
    }

  .error-button {
    display: inline-flex;
    align-items: center;
    padding: 1rem 2rem;
    border-radius: 50px;
    background: linear-gradient(135deg, var(--primary), var(--accent));
    color: white;
    transition: transform 0.3s ease;
    margin-top: 20px;
    position: relative;
    overflow: hidden;

    &:hover {
      transform: translateY(-2px);
      
      .button-hover-effect {
        transform: translate(-50%, -50%) scale(10);
      }
    }
  }

  .button-hover-effect {
    position: absolute;
    width: 35px;
    height: 35px;
    background: rgba(255, 255, 255, 0.15);
    border-radius: 50%;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%) scale(0);
    transition: transform 0.5s cubic-bezier(0.23, 1, 0.32, 1);
  }

  .particles-canvas {
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1;
    pointer-events: none;
    }

  /* 复用404页面的动画和响应式样式 */
  @keyframes float {
    0%, 100% { transform: translate(0, 0); }
    25% { transform: translate(8px, -8px); }
    50% { transform: translate(-5px, 12px); }
    75% { transform: translate(-12px, 5px); }
  }

  @keyframes orbit {
    from {
      transform: translate(-50%, -50%) rotate(0deg) translateX(90px) rotate(0deg);
    }
    to {
      transform: translate(-50%, -50%) rotate(360deg) translateX(90px) rotate(-360deg);
    }
  }

  @media (max-width: 768px) {
    .glass-card {
      padding: 2rem;
      margin: 0 auto;
    }

    .error-icon {
      font-size: 4rem !important;
    }

    .spaceship {
      width: 18px !important;
      height: 18px !important;
    }

    .error-title {
      font-size: 1.6rem;
    }
  }

  @media (max-width: 480px) {
    .glass-card {
      padding: 1.5rem;
    }

    .error-title {
      font-size: 1.3rem;
    }

    .error-description {
      font-size: 0.9rem;
    }

    .error-button {
      padding: 0.8rem 1.5rem;
    }
  }
</style>