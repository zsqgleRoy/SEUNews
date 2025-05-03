<template>
  <div class="login-wrapper">
    <div class="login-card">
      <div class="toggle-buttons">
        <button :class="{ active: isLogin }" @click="handleButtonClick(true)">登录</button>
        <button :class="{ active: !isLogin }" @click="handleButtonClick(false)">注册</button>
      </div>
      <template v-if="!isLogin">
        <el-steps style="width: 100%; background-color: whitesmoke; margin: 0;" :active=step finish-status="success" simple>
          <el-step title="账号"/>
          <el-step title="邮箱" />
          <el-step title="完成" />
        </el-steps>
        <div class="demo-progress">
          <el-progress :percentage="percentage" :color="customColors" />
        </div>
      </template>
      <form @submit.prevent="handleSubmit" class="form-container">
        <div v-if="step == 0" class="input-group">
          <el-input
            v-model="username"
            placeholder="账号"
            clearable
            class="input-field"
            :style="{ width: '100%' }"
          />
        </div>
        <div v-if="step == 0" class="input-group">
          <el-input
            v-model="password"
            type="password"
            placeholder="密码"
            show-password
            clearable
            class="input-field"
            :style="{ width: '100%' }"
          />
        </div>
        <div v-if="step == 1 && !isLogin" class="input-group">
          <RegisitEmail @emailChanged="handleEmailChange" />
        </div>
        <div v-if="step == 2 && !isLogin" class="input-group">
          <el-result
            icon="success"
            title="注册完成"
            sub-title="欢迎您访问东南新闻"
          >
          </el-result>
        </div>
        <el-checkbox v-if="step == 1 && !isLogin" v-model="checked2" class="checkbox">
          我同意
            <router-link @click.prevent="handleManualClick"
             :to="`/news/${newsId + 2}`">《东南新闻用户手册》</router-link>
          和
          <router-link @click.prevent="handleManualClick"
           :to="`/news/${newsId + 0}`">《隐私政策》</router-link>
        </el-checkbox>
        <div class="button-wrapper">
          <button type="submit" class="login-button">
            {{
              ( !isLogin ?
              ( step == 1 ? '注册' :
              (!isVerified ? '下一步' : "完成" )) :
              ( !isVerified ? '验证登录' : '登录'))
            }}
          </button>
        </div>
      </form>
      <transition name="slide-left">
        <ImageCode 
          v-if="showImageCode"
          @success="handleVerifySuccess"
          @close="showImageCode = false"
          class="image-code-container"
        />
      </transition>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { onUnmounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useUserStore } from '@/store/userStore';
import { login as apiLogin, register as apiRegister, login } from '@/api/user';
import { ElMessage } from 'element-plus';
import { isStringNotEmpty } from '@/composables/non-empty-validation';
import userCache, { type UserInfo } from '@/cache/userCache';
import ImageCode from "@/components/common/ImageCode.vue"
import RegisitEmail from './RegisitEmail.vue';
const newsId = ref(14)
const percentage = ref(34)
const checked2 = ref(false)
const customColors = [
  { color: '#f56c6c', percentage: 34 },
  { color: '#e6a23c', percentage: 68 },
  { color: '#5cb87a', percentage: 60 },
  { color: '#1989fa', percentage: 80 },
  { color: '#6f7ad3', percentage: 100 },
]
const emit = defineEmits(['close']);
const router = useRouter();
const userStore = useUserStore();
const isCodeVerified = ref(false); 
const step = ref(0);
const isLogin = ref(true);
const username = ref('');
const password = ref('');
const email = ref('');
const errorMessage = ref('');
const showImageCode = ref(false);
const isVerified = ref(false);
const isMobile = ref(window.innerWidth < 768);
const standStatic = ref(1);

const handleButtonClick = (isLoginClicked: boolean) => {
  step.value = 0;
  percentage.value = 34;
  showImageCode.value = false;
  isLogin.value = isLoginClicked;
};
const increase = () => {
  percentage.value += 34;
  if (percentage.value > 100) {
    percentage.value = 100
  }
}
const decrease = () => {
  percentage.value -= 10
  if (percentage.value < 0) {
    percentage.value = 0
  }
}
const close = () => {
  emit('close');
  const escapeEvent = new KeyboardEvent('keydown', { key: 'Escape' });
  document.dispatchEvent(escapeEvent);
};
const validateForm = () => {
  if (step.value == 0 && !isStringNotEmpty(username.value) || !isStringNotEmpty(password.value)) {
    showError('用户名和密码不能为空');
    return false;
  }
  return true;
};

const handleEmailChange = (emaill: string, isCodeVerifiedd : boolean) => {
  email.value = emaill;
  isCodeVerified.value = isCodeVerifiedd;
};

// 封装错误处理逻辑
const showError = (message: string) => {
  errorMessage.value = message;
  ElMessage.error(errorMessage.value);
};

const handleSubmit = () => {
  if (!validateForm()) return;  // 账号密码非空
  if (isLogin.value) {
    handleLogin();
    return;
  } else if (step.value == 0) {
    checkEmail();               // step = 1
    return;
  } else if (step.value == 1) {
    handleRegisterOK();         // step = 2
    return;
  } else {
    handleRegister();           // step = 0
    return;
  }
};

const switchToLogin = () => {
  isLogin.value = true;
  errorMessage.value = '';
  showImageCode.value = false;
  step.value = 0;
};

const switchToRegister = () => {
  isLogin.value = false;
  errorMessage.value = '';
};

const handleManualClick = () => {
  close();
  setTimeout(() => {
    router.push(`/news/${newsId.value + 2}`);
  }, 300);
};

const handleLogin = async () => {
  if (!validateForm()) return;
  if (!isVerified.value) {
    standStatic.value = 999;
    
    showImageCode.value = true;
    return;
  }
  try {
    const response = await apiLogin({
      username: username.value,
      password: password.value
    });

    const userData: UserInfo = {
      user_id: response.data.user_id,
      username: response.data.username,
      email: response.data.email,
      registerDate: new Date(response.data.registerDate),
      avatar: response.data.avatar,
      isAuthor: response.data.isAuthor,
      expires: Date.now() + 24 * 60 * 60 * 1000  // 设置24小时有效期
    };

    userCache.saveUserCache(userData);
    const token = response.data.token;
    localStorage.setItem('token', token);

    userStore.login(userData);
    emit('close');
    if (isMobile.value) {
      router.push('/myHome');
      return;
    }
    router.push('/index');
  } catch (error: any) {
    if (error.response) {
      // 后端返回了错误响应
      showError(error.response.data.message || '登录失败，请稍后重试');
    } else {
      // 网络错误或其他异常
      showError(error.message || '登录失败，请稍后重试');
    }
  }
};

// 验证成功回调
const handleVerifySuccess = (token: string) => {
  isVerified.value = true;
  showImageCode.value = false;
  if (standStatic.value === 999) {
    handleLogin();
  } else {
    increase();
    step.value = 2;
    handleRegisterOK();
    return;
  }
};
const checkEmail = () =>{
  increase();
  step.value = 1;
  return;
};
const handleRegister = async () => {
  if (isVerified.value) {
    switchToLogin()
    return;
  }
};
const handleRegisterOK = async () => {
  if (!isCodeVerified.value) {
    ElMessage.warning('请您先验证邮箱！');
    return;
  }
  else if(!isVerified.value) {
    showImageCode.value = true;
    standStatic.value = 1;
  }
  else {
    const response = ref();
    try {
        response.value = await apiRegister({
        username: username.value,
        password: password.value,
        email: email.value,
        registerDate: new Date(),
        isAuthor: "FALSE"
      });
      ElMessage.success('注册成功！');
    } catch (error: any) {
      step.value = 0;
      return;
    }
  }
};
onUnmounted(() => {
});
</script>

<style scoped lang="scss">
  $primary-gradient: linear-gradient(135deg, #0055ff, #00a97cf6);
  $hover-gradient: linear-gradient(135deg, #00a97cf6, #0055ff);
  $text-gradient: linear-gradient(135deg, #0055ff, #6b00bc);

  @mixin text-gradient($gradient) {
    background: $gradient;
    background-clip: text;
    -webkit-background-clip: text;
    color: transparent;
  }

  .login-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #f5f7fa00 0%, #c3cfe200 100%);
    width: 100%;
  }

  .login-card {
    background-color: #ffffff;
    border-radius: 15px;
    box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
    padding: 40px 0;
    width: 100%;
    animation: fadeInUp 0.6s ease-out;
    position: relative;
    overflow: hidden;
    height: 500px;
  }

  .toggle-buttons {
    display: flex;
    justify-content: center;
    border-bottom: 1px solid #e0e0e000;
  }

  .toggle-buttons button {
    padding: 10px 20px;
    border: none;
    background-color: transparent;
    cursor: pointer;
    transition: color 0.3s ease, border-bottom 0.3s ease;
    font-size: 16px;
    font-weight: 500;
    color: #666;
  }

  .checkbox {
    margin-top: 10px;
    font-size: 14px;
    color: #666;
    & a {
      color: #007bff;
      text-decoration: none;
      &:hover {
        text-decoration: underline;
        background: none
      }
    }
  }

  .toggle-buttons button.active {
    @include text-gradient($text-gradient);
    font-weight: 600;
    border-bottom: 2px solid transparent;
    border-image: $text-gradient 1;
  }

  .login-title {
    font-size: 26px;
    font-weight: 600;
    color: #333;
    margin-bottom: 35px;
    text-align: center;
  }

  .form-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: calc(100% - 140px);
  }

  .input-group {
    width: 80%;
    margin-bottom: 25px;
  }

  .input-field {
    @include text-gradient($text-gradient);
    width: 100%;
    padding: 14px;
    border: 1px solid #bebebe;
    border-radius: 8px;
    font-size: 15px;
    transition: border-color 0.3s ease;
    box-sizing: border-box;
  }

  .input-field::placeholder {
    opacity: 1;
    background: none;
    -webkit-background-clip: initial;
    background-clip: initial;
  }

  .input-field:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.2);
  }
  .input-field :deep(.el-input__inner) {
    @include text-gradient($text-gradient);
  }

  .button-wrapper {
    position: absolute;
    bottom: 40px;
    left: 40px;
    right: 40px;
  }

  .login-button {
    width: 100%;
    padding: 15px;
    background: $primary-gradient;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 500;
    transition: background-color 0.3s ease;
    margin-bottom: 10px;
  }

  .login-button:hover {
    background: $hover-gradient;
  }

  .error-message {
    color: red;
    margin-top: 25px;
    text-align: center;
    animation: shake 0.5s ease-in-out;
    font-size: 14px;
  }

  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  @keyframes shake {
    0%,
    100% {
      transform: translateX(0);
    }
    10%,
    30%,
    50%,
    70%,
    90% {
      transform: translateX(-10px);
    }
    20%,
    40%,
    60%,
    80% {
      transform: translateX(10px);
    }
  }

  .slide-left-enter-active,
  .slide-left-leave-active {
    transition: all 0.5s ease;
    position: absolute;
    left: 0;
    right: 0;
  }

  .slide-left-enter-from {
    transform: translateX(-100%);
    opacity: 0;
  }

  .slide-left-leave-to {
    transform: translateX(100%);
    opacity: 0;
  }

  .image-code-container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
    width: 350px;
    height: auto;
    background-color: white;
  }
  .demo-progress {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    box-sizing: border-box;
  }
  .demo-progress .el-progress--line {
    width: 100%;
    height: 10px;
    min-width: none;
  }

  .demo-progress .el-progress__text {
    color: rgb(0, 110, 255);
    font-size: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    min-width: 20px;
  }
  .el-steps {
    margin-top: 10px;
    margin-bottom: 10px;
  }
</style>    