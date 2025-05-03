<!-- ChatInput.vue -->
<template>
  <div class="input-container">
    <input
      v-model="inputText"
      @keyup.enter="sendMessage"
      placeholder="输入消息..."
    />
    <button @click="sendMessage">发送</button>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const inputText = ref('')

const emit = defineEmits(['send-message'])

const sendMessage = () => {
  if (inputText.value.trim()) {
    emit('send-message', inputText.value.trim())
    inputText.value = ''
  }
}
</script>

<style scoped>
.input-container {
  display: flex;
  padding: 10px 50px 20px 50px;
  background-color: white;
  box-shadow: 0 -1px 10px rgba(0, 0, 0, 0.1);
  margin-left: 0;
  margin-right: 0;
  z-index: 10;
}

input {
  flex: 1;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 25px;
  margin-right: 10px;
  font-size: 16px;
}

button {
  padding: 12px 24px;
  background-color: #0084ff;
  color: white;
  border: none;
  border-radius: 25px;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #0073e6;
}
@media screen and (max-width: 768px) {
  .input-container {
    padding: 10px 8px;
  }

  input {
    padding: 10px;
    font-size: 14px;
  }

  button {
    padding: 10px 20px;
    font-size: 14px;
  }
  
}
</style>