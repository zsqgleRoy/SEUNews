<!-- LoadingOverlay.vue -->
<template>
  <transition name="fade">
    <div 
      v-if="loading"
      class="loading-mask"
      :class="{ 'low-performance': isLowPerf }"
    >
      <div class="quantum-spinner" />
      <div class="hologram-text">LOADING...</div>
    </div>
  </transition>
</template>

<script setup lang="ts">
import { ref} from 'vue'

defineProps<{
  loading: boolean
}>()

const isLowPerf = ref(
  navigator.hardwareConcurrency < 4 || 
  !CSS.supports('backdrop-filter', 'blur(1px)')
)
</script>

<style scoped lang="scss">
$hologram-blue: #7C4DFF;
$hologram-cyan: #00BCD4;

.loading-mask {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: radial-gradient(
    ellipse at center,
    rgba(darken($hologram-blue, 35%), 0.98),
    rgba(darken($hologram-cyan, 35%), 0.98)
  );
  display: grid;
  place-items: center;
  z-index: 9999;
  backdrop-filter: blur(2px);
  
  &.low-performance {
    background: darken($hologram-blue, 35%);
    backdrop-filter: none;
    
    .quantum-spinner {
      animation: spin 1.2s linear infinite;
    }
  }
}

.quantum-spinner {
  width: 18vmin;
  height: 18vmin;
  border: 4px solid transparent;
  border-top-color: $hologram-cyan;
  border-bottom-color: $hologram-blue;
  border-radius: 50%;
  animation: 
    spin 1.2s cubic-bezier(0.68, 0, 0.32, 1) infinite,
    glow 2s ease-in-out infinite;
  backface-visibility: hidden;
  perspective: 1000px;
}

.hologram-text {
  position: absolute;
  bottom: 20%;
  font-family: 'SF Mono', monospace;
  font-size: clamp(14px, 2vmin, 20px);
  color: mix($hologram-blue, $hologram-cyan, 30%);
  text-shadow: 0 0 8px rgba($hologram-cyan, 0.4);
  animation: text-glow 1.6s ease-in-out infinite;
}

@keyframes spin {
  to { 
    transform: rotate(360deg); 
  }
}

@keyframes glow {
  0%, 100% {
    box-shadow: 0 0 12px rgba($hologram-cyan, 0.3);
  }
  50% {
    box-shadow: 
      0 0 16px rgba($hologram-cyan, 0.6),
      0 0 24px rgba($hologram-blue, 0.4);
  }
}

@keyframes text-glow {
  50% {
    opacity: 0.8;
    text-shadow: 0 0 12px rgba($hologram-cyan, 0.7);
  }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>