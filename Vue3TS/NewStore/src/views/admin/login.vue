<template>
  <form class="auth-form" @submit.prevent="handleSubmit">
    <div class="form-container">
      <div class="form-header">
        <h4>登录</h4>
        <p>欢迎回到您的账户</p>
      </div>

      <div class="form-group">
        <div class="input-wrapper">
          <input v-model="author_id" type="text" placeholder="工号" required>
          <span class="underline"></span>
        </div>
      </div>

      <div class="form-group">
        <div class="input-wrapper">
          <input v-model="password" type="password" placeholder="密码" required>
          <span class="underline"></span>
        </div>
      </div>

      <div class="form-group">
        <div class="input-wrapper captcha-wrapper">
          <input v-model="captchaInput" type="text" placeholder="验证码" required>
          <span class="underline"></span>
          <span class="captcha-code" @click="refreshCaptcha">{{ captchaCode }}</span>
        </div>
      </div>

      <button type="submit" class="submit-button">
        立即登录
        <div class="button-effect"></div>
      </button>
    </div>
  </form>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import axios from 'axios'

const emit = defineEmits<{
  (e: 'submit-login', credentials: { author_id: string; password: string; captcha: string }): void
}>()

const author_id = ref('')
const password = ref('')
const captchaInput = ref('')
const captchaCode = ref('')

// 生成验证码
const generateCaptcha = () => {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
  let code = ''
  for (let i = 0; i < 4; i++) {
    code += characters.charAt(Math.floor(Math.random() * characters.length))
  }
  captchaCode.value = code
}

// 刷新验证码
const refreshCaptcha = () => {
  generateCaptcha()
}

// 页面加载时生成初始验证码
generateCaptcha()

const handleSubmit = async () => {
  if (author_id.value && password.value && captchaInput.value === captchaCode.value && /^\d+$/.test(author_id.value)) {
    try {
      console.log( author_id.value);
      // 修正请求 URL，去掉多余的 author_id 拼接
      const response = await axios.post('http://192.168.124.5:8080/api/authors/login', {
        author_id: author_id.value, // 后端登录接口使用的是 author_id 字段，这里进行对应修改
        password: password.value,
        captcha: captchaInput.value
      });

      // 登录成功处理逻辑
      if (response.status === 200) {
        // 可以在这里进行页面跳转、存储 token 等操作
        alert('登录成功');
      } else {
        alert('登录失败，请检查用户名和密码');
      }
    } catch (error) {
      console.error('登录请求出错:', error);
      alert('登录请求出错，请稍后再试');
    }
  } else {
    alert('请输入有效的工号、密码和验证码');
  }
};
</script>

<style scoped>
.auth-form {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: auto;
}

.form-container {
  background: white;
  border-radius: 20px;
  padding: 2.5rem 3rem;
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(5px);
  -webkit-backdrop-filter: blur(5px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  width: 100%;
  max-width: 450px;
}

.form-header {
  margin-top: 20px;
  text-align: center;
  margin-bottom: 2rem;
}

.form-header h2 {
  color: #2c3e50;
  font-size: 1.8rem;
  margin-bottom: 0.5rem;
}

.form-header p {
  color: #7f8c8d;
  font-size: 0.9rem;
}

.form-group {
  position: relative;
  margin-bottom: 1.5rem;
}

.input-wrapper {
  width: 100%;
  height: 40px;
  border-bottom: 2px solid #ddd;
  position: relative;
}

.input-wrapper input {
  width: 100%;
  height: 100%;
  background: none;
  border: none;
  outline: none;
  font-size: 1rem;
  padding: 0 35px 0 5px;
}

.underline {
  position: absolute;
  left: 0;
  bottom: -2px;
  width: 100%;
  height: 2px;
  background: linear-gradient(to right, #3498db, #2ecc71);
  transform: scaleX(0);
  transition: transform 0.3s ease;
}

.input-wrapper input:focus ~ .underline,
.input-wrapper input:not(:placeholder-shown) ~ .underline {
  transform: scaleX(1);
}

.captcha-wrapper {
  display: flex;
  align-items: center;
}

.captcha-code {
  position: absolute;
  right: 0;
  cursor: pointer;
  padding: 0 10px;
  color: #3498db;
}

.submit-button {
  width: 100%;
  height: 40px;
  background: linear-gradient(to right, #3498db, #2ecc71);
  border: none;
  outline: none;
  border-radius: 20px;
  font-size: 1rem;
  color: white;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.submit-button:hover {
  background: linear-gradient(to right, #2ecc71, #3498db);
}

.button-effect {
  position: absolute;
  width: 100%;
  height: 100%;
  background: rgba(255, 255, 255, 0.1);
  transform: scale(0);
  transition: transform 0.3s ease;
}

.submit-button:hover .button-effect {
  transform: scale(1);
}

@media (max-width: 480px) {
  .form-container {
    padding: 2rem 1.5rem;
  }
  
  .form-header h2 {
    font-size: 1.5rem;
  }
  
  .form-group label {
    font-size: 0.9rem;
  }
}
</style>
