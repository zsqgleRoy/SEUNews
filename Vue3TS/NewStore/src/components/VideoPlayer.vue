<template>
    <div class="video-player">
      <!-- 视频播放器 -->
      <video ref="videoRef" controls width="640" height="360">
        <source :src="videoSrc" type="video/mp4" />
        您的浏览器不支持视频播放。
      </video>
      <!-- 播放控制按钮 -->
      <div class="video-controls">
        <button @click="playVideo">▶</button>
        <button @click="pauseVideo">⏸</button>
        <button @click="toggleMute">🔕</button>
        <input type="range" v-model="volume" min="0" max="1" step="0.1" @input="setVolume" />
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref } from 'vue';
  import VID from '@/video/test.mp4';
  // 定义视频源
  const videoSrc = ref(VID);
  // 获取视频元素的引用
  const videoRef = ref<HTMLVideoElement | null>(null);
  // 定义音量状态
  const volume = ref(0.8);
  
  // 播放视频
  const playVideo = () => {
    if (videoRef.value) {
      videoRef.value.play();
    }
  };
  
  // 暂停视频
  const pauseVideo = () => {
    if (videoRef.value) {
      videoRef.value.pause();
    }
  };
  
  // 切换静音状态
  const toggleMute = () => {
    if (videoRef.value) {
      videoRef.value.muted = !videoRef.value.muted;
    }
  };
  
  // 设置音量
  const setVolume = () => {
    if (videoRef.value) {
      videoRef.value.volume = volume.value;
    }
  };
  </script>
  
  <style scoped>
  .video-player {
    text-align: center;
  }
  
  .video-controls {
    margin-top: 10px;
  }
  
  .video-controls button {
    margin: 0 5px;
    padding: 5px 10px;
  }
  
  .video-controls input[type='range'] {
    width: 100px;
  }
  </style>
  