<template>
    <div class="mini-member-card" :class="{ 'inactive': !isMember }">
      <div v-if="days && days > 0" class="badge-container" @click="handleUpgrade">
        <span class="crown">👑</span>
        <div class="member-info">
          <div class="title">尊贵的会员</div>
          <div class="days">剩余 {{ days }} 天</div>
        </div>
        <el-icon class="arrow-icon"><ArrowRight /></el-icon>
      </div>
  
      <div v-else-if="isMember" class="upgrade-container" @click="handleUpgrade">
        <span class="sparkle">✨</span>
        <div class="upgrade-info">
          <div class="title">立即恢复特权</div>
          <div class="action">开通会员</div>
        </div>
        <el-icon class="arrow-icon"><ArrowRight /></el-icon>
      </div>

      <div v-else class="upgrade-container" @click="handleUpgrade">
        <span class="sparkle">✨</span>
        <div class="upgrade-info">
          <div class="title">立即解锁特权</div>
          <div class="action">成为会员</div>
        </div>
        <el-icon class="arrow-icon"><ArrowRight /></el-icon>
      </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import { useRouter } from "vue-router"
import { ArrowRight } from '@element-plus/icons-vue';
const router = useRouter();
defineProps<{
    isMember: boolean
    days?: number
  }>()
  
  const emit = defineEmits<{
    (e: 'upgrade'): void
  }>()
  
  const handleUpgrade = () => {
    router.push("/Vip");
    emit('upgrade')
  }
</script>
  
<style scoped lang="scss">
$active-bg: linear-gradient(135deg, #4a3a2a 0%, #3a2a1a 100%);
$inactive-bg: linear-gradient(135deg, #3a3a4a 0%, #2a2a3a 100%);
$gold: #ffd700;
$silver: #c0c0c0;
$hover-scale: 1.05;
$glow-color: rgba(255, 215, 0, 0.6);
$border-radius: 16px;

.mini-member-card {
  background: $active-bg;
  padding: 16px 20px;
  transition: all 0.3s ease;
  cursor: pointer;
  position: relative;
  overflow: hidden;

  &::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.1);
    transform: skewX(-30deg) translateX(-150%);
    transition: transform 0.6s ease;
  }

  &:hover {
    transform: scale($hover-scale);

    &::before {
      transform: skewX(-30deg) translateX(150%);
    }
  }
}

// 非激活状态样式
.mini-member-card.inactive {
  background: $inactive-bg;
  border: 1px solid rgba(192, 192, 192, 0.3);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

// 徽章和升级信息容器样式
.badge-container,
.upgrade-container {
  display: flex;
  align-items: center;
  gap: 12px;
  color: $gold;
  min-height: 48px;
  padding: 8px;
  border-radius: calc($border-radius - 4px);
  transition: background-color 0.3s ease;
}

.upgrade-container {
  color: $silver;
}

// 皇冠图标样式
.crown {
  font-size: 32px;
  filter: drop-shadow(0 4px 8px rgba(255, 215, 0, 0.5));
  animation: float 3s ease-in-out infinite;
}

// 闪烁图标样式
.sparkle {
  font-size: 28px;
  animation: twinkle 1.5s ease-in-out infinite, float 3s ease-in-out infinite;
}

// 会员信息和升级信息样式
.member-info,
.upgrade-info {
  flex: 1;
  line-height: 1.4;
  text-align: left;
}

// 标题样式
.title {
  font-size: 16px;
  font-weight: 700;
  letter-spacing: 1px;
  margin-bottom: 4px;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

// 天数样式
.days {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.9);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

// 操作按钮样式
.action {
  font-size: 14px;
  color: $silver;
  position: relative;
  padding-right: 18px;
  display: inline-block;
  font-weight: 600;
}

// 箭头图标样式
.arrow-icon {
  font-size: 18px;
  color: $gold;
  transition: transform 0.3s ease;
}

.mini-member-card:hover .arrow-icon {
  transform: translateX(5px);
}

// 闪烁动画
@keyframes twinkle {
  0%, 100% {
    opacity: 0.8;
    transform: scale(1);
  }
  50% {
    opacity: 1;
    transform: scale(1.2);
  }
}

// 浮动动画
@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-5px);
  }
}

// 响应式设计
@media (max-width: 480px) {
  .mini-member-card {
    padding: 12px 16px;
  }

  .title {
    font-size: 14px;
  }

  .days,
  .action {
    font-size: 12px;
  }
}
</style>    