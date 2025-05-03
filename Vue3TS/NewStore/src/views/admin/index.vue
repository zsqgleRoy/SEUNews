<template>
  <div class="bk">
    <div class="auth-container">
      <div class="switch-buttons">
        <button 
          @click="currentView = 'login'"
          :class="{ active: currentView === 'login' }"
        >
          登录
        </button>
        <button 
          @click="currentView = 'register'"
          :class="{ active: currentView === 'register' }"
        >
          注册
        </button>
      </div>
      <component :is="currentComponent"/>
    </div>  
  </div>

</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import Login from './login.vue';
import Register from './register.vue';
import axios from 'axios';

type AuthView = 'login' | 'register';

const isLoading = ref(false);

// 定义登录凭证类型
interface LoginCredentials {
  username: string;
  password: string;
}

// 模拟登录 API
const loginAPI = async (credentials: LoginCredentials) => {
  // 这里可以添加实际的登录请求逻辑，例如使用 axios 发送请求
  return new Promise((resolve) => {
    setTimeout(() => {
      console.log('登录成功:', credentials);
      resolve(true);
    }, 1000);
  });
};

const handleLogin = async (credentials: LoginCredentials) => {
  try {
    isLoading.value = true;
    await loginAPI(credentials);
  } finally {
    isLoading.value = false;
  }
};

const currentView = ref<AuthView>('login');

const currentComponent = computed(() => {
  return currentView.value === 'login' ? Login : Register;
});

const handleRegister = (userInfo: { 
  username: string; 
  email: string;
  password: string 
}) => {
  console.log('执行注册:', userInfo);
  // 这里调用注册 API
  axios.post('http://192.168.124.5:8080/api/authors', userInfo)
    .then(res => {
      console.log('注册成功:', res.data);
    })
    .catch(err => {
      console.error('注册失败:', err);
    });

};
</script>

<style scoped>
.bk {
  width: 100%;
  padding-top: 140px;
  padding-bottom: 30px;
  background-size: 100% auto;
  margin: -140px 0 -10px -10px;
  background-image: url('@/components/icons/03.png');
}

.auth-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: auto;
  margin-top: 70px;
}

.auth-content {
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

.switch-buttons {
  display: flex;
  gap: 1rem;
  margin-bottom: -3.5rem;
  z-index: 999;
}

.switch-buttons button {
  flex: 1;
  padding: 0.8rem;
  border: none;
  background: linear-gradient(to right, #f0f0f0, #e0e0e0);
  cursor: pointer;
  transition: all 0.3s;
  border-radius: 20px;
  color: #2c3e50;
}

.switch-buttons button.active {
  background: linear-gradient(to right, #3498db, #2ecc71);
  color: white;
}

.switch-buttons button:hover {
  background: linear-gradient(to right, #e0e0e0, #d0d0d0);
}

.switch-buttons button.active:hover {
  background: linear-gradient(to right, #2ecc71, #3498db);
}

/* 小屏优化 */
@media (max-width: 768px) {
  .bk {
    padding-top: 80px;
    padding-bottom: 20px;
    background-size: contain; /* 保持图片比例并完整显示 */
    background-position: center top; /* 调整背景位置 */
    margin: -80px 0 -5px -5px;
  }

  .auth-container {
    margin-top: 40px;
  }

  .auth-content {
    padding: 2rem 1.5rem;
    max-width: 90%;
  }

  .switch-buttons {
    margin-bottom: -2.5rem;
    gap: 0.8rem;
  }

  .switch-buttons button {
    padding: 0.6rem;
    font-size: 0.9rem;
  }
}

/* 手机端特别优化 */
@media (max-width: 480px) {
  .bk {
    background-color: dodgerblue;
    background-image: none;
    padding-top: 50px;
    padding-bottom: 15px;
    background-size: 100% auto;
    margin: -60px 0 -10px -3px;
  }

  .auth-content {
    margin-top: 100px;
  }

  .switch-buttons {
    margin-bottom: -2rem;
  }
}
</style>
