// src/composables/useDevice.ts
import { ref, onMounted, onUnmounted } from 'vue';

export const useDevice = () => {
  const isMobile = ref(false);

  const updateDeviceType = () => {
    isMobile.value = window.innerWidth < 768;
  };

  onMounted(() => {
    updateDeviceType();
    window.addEventListener('resize', updateDeviceType);
  });

  onUnmounted(() => {
    window.removeEventListener('resize', updateDeviceType);
  });

  return {
    isMobile
  };
};