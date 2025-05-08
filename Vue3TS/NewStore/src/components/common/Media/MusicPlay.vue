<template>
  <div class="music-player-container" :class="{ expanded: isExpanded }">
    <!-- 迷你模式 -->
    <div class="mini-player" v-if="!isExpanded">
      <!-- 顶部细进度条 -->
      <div class="mini-progress">
        <input 
          type="range" 
            class="min-progress" 
            v-model="progress"
            min="0"
            :max="duration"
            @input="onProgressChange"
            @mousedown="isDraggingProgress = true"
            @mouseup="isDraggingProgress = false"
        />
      </div>
      
      <div class="mini-content"  @click="toggleExpand" >
        <img class="mini-cover" :src="musicInfo.coverUrl" alt="cover">
        <div class="mini-info">
          <h4 class="mini-title">{{ musicInfo.title }}</h4>
          <p class="mini-artist">{{ musicInfo.artist }}</p>
        </div>
        <div class="mini-controls">
          <button class="play-btn" @click.stop="togglePlay">
            {{ isPlaying ? '⏸' : '▶' }}
          </button>
          <span class="mini-time">{{ formatTime(currentTime) }}</span>
        </div>
      </div>
    </div>

    <!-- 展开模式 -->
    <div v-if="isExpanded" class="expanded-player">
      <div class="header" @click="toggleExpand">
        <span class="collapse-icon">▼</span>
        <h3 class="title">{{ musicInfo.title }}</h3>
      </div>

      <div class="main-content">
        <img class="cover" :src="musicInfo.coverUrl" alt="cover">
        
        <!-- 进度条 -->
        <div class="progress-container">
          <input 
            type="range" 
            class="progress" 
            v-model="progress"
            min="0"
            :max="duration"
            @input="onProgressChange"
            @mousedown="isDraggingProgress = true"
            @mouseup="isDraggingProgress = false"
          >
          <div class="time-display">
            {{ formatTime(currentTime) }} / {{ formatTime(duration) }}
          </div>
        </div>

        <!-- 控制按钮 -->
        <div class="controls">
          <button class="control-btn loop-btn" @click="toggleLoop">
            {{ loopMode === 'single' ? '🔁' : '➡️' }}
          </button>
          <button class="control-btn" @click="togglePlay">
            {{ isPlaying ? '⏸️' : '▶️' }}
          </button>
          <div class="volume-control">
            <button class="mute-btn" @click="toggleMute">
              {{ isMuted ? '🔇' : '🔊' }}
            </button>
            <input 
              type="range" 
              class="volume-slider"
              min="0"
              max="1"
              step="0.1"
              v-model="volume"
            >
          </div>
        </div>
      </div>
    </div>

    <!-- 隐藏的audio元素 -->
    <audio 
      ref="audioRef"
      :src="musicInfo.src"
      @timeupdate="updateTime"
      @loadedmetadata="onLoadedMetadata"
      @ended="handleEnded"
    ></audio>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'

type LoopMode = 'none' | 'single'

interface MusicInfo {
  title: string
  artist: string
  coverUrl: string
  src: string
}

const props = defineProps<{
  musicInfo: MusicInfo
}>()

const audioRef = ref<HTMLAudioElement | null>(null)
const isPlaying = ref(false)
const isExpanded = ref(false)
const currentTime = ref(0)
const duration = ref(0)
const volume = ref(1)
const isMuted = ref(false)
const isDraggingProgress = ref(false)
const loopMode = ref<LoopMode>('none')

// 计算属性
const progress = computed({
  get: () => currentTime.value,
  set: (val) => currentTime.value = val
})

// 格式化时间
const formatTime = (seconds: number) => {
  const minutes = Math.floor(seconds / 60)
  const remainingSeconds = Math.floor(seconds % 60)
  return `${String(minutes).padStart(2, '0')}:${String(remainingSeconds).padStart(2, '0')}`
}

// 播放控制
const togglePlay = () => {
  if (!audioRef.value) return
  isPlaying.value ? audioRef.value.pause() : audioRef.value.play()
  isPlaying.value = !isPlaying.value
}

// 更新时间
const updateTime = () => {
  if (!audioRef.value || isDraggingProgress.value) return
  currentTime.value = audioRef.value.currentTime
}

// 加载元数据
const onLoadedMetadata = () => {
  if (!audioRef.value) return
  duration.value = audioRef.value.duration
}

// 进度条拖动
const onProgressChange = (e: Event) => {
  if (!audioRef.value) return
  const target = e.target as HTMLInputElement
  audioRef.value.currentTime = Number(target.value)
}

// 音量控制
const toggleMute = () => {
  if (!audioRef.value) return
  isMuted.value = !isMuted.value
  audioRef.value.muted = isMuted.value
}

// 切换循环模式
const toggleLoop = () => {
  loopMode.value = loopMode.value === 'single' ? 'none' : 'single'
  if (audioRef.value) {
    audioRef.value.loop = loopMode.value === 'single'
  }
}

// 处理播放结束
const handleEnded = () => {
  if (loopMode.value === 'single' && audioRef.value) {
    audioRef.value.currentTime = 0
    audioRef.value.play()
  }
}

// 切换展开状态
const toggleExpand = () => {
  isExpanded.value = !isExpanded.value
}

// 监听音量变化
watch(volume, (newVal) => {
  if (!audioRef.value) return
  audioRef.value.volume = newVal
  if (newVal > 0) isMuted.value = false
})
</script>

<style scoped lang="scss">
.music-player-container {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 1000;
  transition: all 0.3s ease;
}

.mini-player {
  position: relative;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 15px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  cursor: pointer;
  padding: 15px;
  width: 250px;

  .mini-progress {
    position: absolute;
    top: 1px;
    left: 3%;
    width: 94%;
    height: 3px;
    background: rgba(0,0,0,0.1);
    z-index: 9999;
    &-bar {
      height: 100%;
      background: #007bff;
      transition: width 0.2s linear;
    }
  }
}

.mini-content {
  display: flex;
  align-items: center;
  gap: 12px;
  position: relative;
  z-index: 1;
}

.mini-cover {
  width: 40px;
  height: 40px;
  border-radius: 8px;
}

.mini-info {
  flex: 1;
  min-width: 0;
}

.mini-title {
  margin: 0;
  font-size: 14px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.mini-artist {
  margin: 2px 0 0;
  font-size: 12px;
  color: #666;
}

.mini-controls {
  display: flex;
  align-items: center;
  gap: 8px;
}

.play-btn {
  border: none;
  background: none;
  font-size: 18px;
  cursor: pointer;
  padding: 4px;
}

.mini-time {
  font-size: 12px;
  color: #666;
}

.expanded-player {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0,0,0,0.15);
  width: 320px;
  overflow: hidden;
}

.header {
  display: flex;
  align-items: center;
  padding: 12px;
  background: #f8f9fa;
  cursor: pointer;
  border-bottom: 1px solid #eee;
}

.collapse-icon {
  margin-right: 8px;
  font-size: 12px;
}

.title {
  margin: 0;
  font-size: 16px;
}

.main-content {
  padding: 16px;
}

.cover {
  width: 100%;
  border-radius: 8px;
  margin-bottom: 16px;
}

.progress-container {
  margin: 12px 0;
}

.min-progress {
  display: block;
  position: relative;
  width: 100%;
  height: 4px;
  z-index:9999;
  
  &::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 8px; /* 缩小宽度 */
    height: 8px; /* 缩小高度 */
    border-radius: 50%;
    background: #007bff;
  }
  &::-ms-thumb {
    width: 8px; /* 缩小宽度 */
    height: 8px; /* 缩小高度 */
    border-radius: 50%;
    background: #007bff;
  }
}

.progress {
  width: 100%;
  height: 4px;
  cursor: pointer;
  
  &::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: #007bff;
  }
}

.time-display {
  text-align: center;
  font-size: 12px;
  color: #666;
  margin-top: 4px;
}

.controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 16px;
  
  .control-btn {
    border: none;
    background: #007bff;
    color: white;
    padding: 8px 16px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 16px;
    transition: opacity 0.2s;
    
    &:hover {
      opacity: 0.9;
    }
    
    &.loop-btn {
      background: transparent;
      color: #007bff;
      padding: 8px;
    }
  }
}

.volume-control {
  display: flex;
  align-items: center;
  gap: 8px;
}

.volume-slider {
  width: 80px;
}

.mute-btn {
  border: none;
  background: none;
  cursor: pointer;
  font-size: 16px;
}
</style>    