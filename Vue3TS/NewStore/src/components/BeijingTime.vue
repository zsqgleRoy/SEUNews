<template>
  <div class="beijing-time">
    <div class="time-container">
      <h3>北京时间</h3>
      <div class="date">{{ currentDate }} {{ currentWeekday }}</div>
      <div class="time">{{ currentTime }}</div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';

const currentTime = ref<string>('');
const currentDate = ref<string>('');
const currentWeekday = ref<string>('');

const updateTime = () => {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  const weekdayArray = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
  const weekday = weekdayArray[now.getDay()];

  currentTime.value = `${hours}:${minutes}:${seconds}`;
  currentDate.value = `${year}-${month}-${day}`;
  currentWeekday.value = weekday;
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
  background: linear-gradient(to bottom right, #3498db, #2c3e50);
  padding: 20px;
  border-radius: 16px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
  text-align: center;
  color: white;
  animation: fadeIn 0.5s ease-out;
  margin: 0px 0 0px 0;
}

.time-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.beijing-time h3 {
  font-size: 1.5em;
  text-transform: uppercase;
  letter-spacing: 2px;
}

.date {
  font-size: 1.2em;
  margin-bottom: 5px;
  opacity: 0.8;
}

.time {
  font-size: 2.5em;
  font-weight: bold;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
  animation: pulse 1s infinite alternate;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes pulse {
  from {
    transform: scale(1);
  }
  to {
    transform: scale(1.02);
  }
}
</style>
