<template>
  <form class="auth-form" @submit.prevent="handleSubmit">
    <div class="form-container">
      <div class="form-header">
        <h4>立即注册</h4>
        <p>知<strong>天下</strong>事</p>
      </div>

      <div class="form-group">
        <div class="input-wrapper">
          <input v-model="username" type="text" placeholder="工号" required>
          <span class="underline"></span>
        </div>
      </div>

      <div class="form-group">
        <div class="input-wrapper">
          <input v-model="email" type="email" placeholder="邮箱" required>
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
        立即注册
        <div class="button-effect"></div>
      </button>
    </div>
  </form>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import axios from 'axios'

const emit = defineEmits<{
  (e: 'submit-register', userInfo: {
    name: string;
    email: string;
    password: string;
    captcha: string;
  }): void
}>()

const username = ref('')
const email = ref('')
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

const validatePassword = (value: string) => {
  return /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test(value)
}

const handleSubmit = async () => {
  try {
    // 验证输入
    if (!username.value || !email.value || !password.value || !captchaInput.value) {
      alert('请填写所有字段');
      return;
    }

    if (!validatePassword(password.value)) {
      alert('密码必须包含字母和数字，且长度至少为 8 位');
      return;
    }

    if (captchaInput.value!== captchaCode.value) {
      alert('验证码错误，请重新输入');
      refreshCaptcha();
      return;
    }

    // 发送注册请求
    const response = await axios.post('http://192.168.124.5:8080/api/authors', {
      name: username.value, // 注意这里将 username 改为 name
      email: email.value,
      password: password.value,
      contact: email.value // 保持与后端字段一致
    });

    if (response.status === 201) {
      alert('注册成功');
      // 跳转到登录页面
      // router.push('/login');
    } else {
      alert('注册失败');
    }
  } catch (error: unknown) {
    if (axios.isAxiosError(error)) {
      // 如果是 Axios 错误
      console.error('注册请求失败:', error.message);
      if (error.response) {
        alert(`错误信息: ${error.response.data.message}`);
      } else {
        alert('网络连接失败，请检查网络');
      }
    } else {
      // 其他类型的错误
      console.error('发生未知错误:', error);
      alert('发生未知错误，请稍后重试');
    }
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

.form-group label {
  position: absolute;
  top: 1.2rem;
  left: 1rem;
  color: #7f8c8d;
  transition: all 0.3s ease;
  pointer-events: none;
}

.form-group input:focus ~ label,
.form-group input:not(:placeholder-shown) ~ label {
  top: 0.2rem;
  font-size: 0.8rem;
  color: #3498db;
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
