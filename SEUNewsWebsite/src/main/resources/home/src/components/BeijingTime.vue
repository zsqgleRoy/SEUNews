<template>
    <div class="beijing-time">
      <h3>北京时间</h3>
      <p>{{ currentTime }}</p>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, onMounted, onUnmounted } from 'vue';
  
  const currentTime = ref<string>('');
  
  const updateTime = () => {
    const now = new Date();
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    currentTime.value = `${hours}:${minutes}:${seconds}`;
  };
  
  onMounted(() => {
    updateTime();
    const intervalId = setInterval(updateTime, 1000);
  
    onUnmounted(() => {
      clearInterval(intervalId);
    });
  });
  </script>
  
  <style scoped>
  .beijing-time {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    text-align: center;
  }
  
  .beijing-time h3 {
    margin-bottom: 10px;
    color: #2c3e50;
  }
  
  .beijing-time p {
    font-size: 1.2em;
    color: #3498db;
  }
  </style>
  