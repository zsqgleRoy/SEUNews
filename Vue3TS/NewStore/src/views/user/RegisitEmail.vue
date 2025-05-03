<template>
  <div class="email-verification">
    <!-- 邮箱输入框 -->
    <div class="input-group">
      <input
        type="email"
        v-model="email"
        placeholder="请输入邮箱地址"
        class="input-field"
        :disabled="isSending"
      />
      <button
        type="button"
        @click.stop="sendVerificationCode"
        :disabled="!isEmailValid || isSending || countdown > 0"
      >
        {{ isSending ? '正在发送' : countdown > 0 ? `${countdown}s后重发` : '获取验证码' }}
      </button>
    </div>

    <div class="code-input"> 
      <input
        type="text"
        v-model="inputCode"
        placeholder="请输入6位验证码"
        maxlength="6"
        class="input-field"
      />
      <button 
        type="button"
        @click.stop="validateCode"
        :disabled="!hasSentCode || inputCode.length !== 6 || validated"
      >
        验证
      </button>
    </div>

    <div v-if="message" class="message" :class="messageType">
      {{ message }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'
import { initialURL } from '@/lib/urls';

const emits = defineEmits(['emailChanged']);
const email = ref('')
const inputCode = ref('')
const isSending = ref(false)
const countdown = ref(0)
const message = ref('')
const messageType = ref<'success' | 'error'>('success')
const response = ref();
const hasSentCode = ref(false)
const validated = ref(false)

// 邮箱格式验证
const isEmailValid = computed(() => {
  const pattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  return pattern.test(email.value)
})

// 发送验证码（新增重置validated逻辑）
const sendVerificationCode = async () => {
  if (!isEmailValid.value) return

  isSending.value = true
  message.value = ''
  try {
    response.value = await axios.post(initialURL.SERVER_URL+'/api/send-code', {
      email: email.value
    })
    if (response.value.data) {
      startCountdown()
      hasSentCode.value = true
      validated.value = false
      ElMessage.success('验证码已发送，请查看邮箱');
    } else {
      throw new Error(response.value.data || '发送失败')
    }
  } catch (error) {
    ElMessage.error(response.value.data);
  } finally {
    isSending.value = false
  }
}

// 倒计时逻辑
const startCountdown = () => {
  countdown.value = 60
  const timer = setInterval(() => {
    countdown.value--
    if (countdown.value <= 0) {
      clearInterval(timer)
    }
  }, 1000)
}

// 验证验证码（新增设置validated逻辑）
const validateCode = async () => {
  if (!hasSentCode.value || validated.value) return  // 增加validated判断（虽然按钮已禁用，但防止直接调用）

  try {
    response.value = await axios.post(initialURL.SERVER_URL+'/api/validate-code', {
      email: email.value,
      code: inputCode.value
    })
    if (response.value.data) {
      ElMessage.success('验证成功！')
      validated.value = true
      emits('emailChanged', email.value, true);
    } else {
      ElMessage.error('验证码错误，请重新输入');
    }
  } catch (error) {
    ElMessage.error(response.value.data);
  }
}
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
  .email-verification {
    max-width: 100%;
    padding: 2px;
    border: 1px solid #eee;
    border-radius: 8px;
  }

  .input-group {
    display: flex;
    gap: 10px;
  }

  input {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  button {
    padding: 8px 16px;
    background-color: #409eff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button:disabled {
    background-color: #a0cfff;
    cursor: not-allowed;
  }

  .code-input {
    display: flex;
    gap: 10px;
    margin-top: 15px;
  }

  .message {
    margin-top: 15px;
    padding: 10px;
    border-radius: 4px;
  }

  .success {
    background-color: #f0f9eb;
    color: #67c23a;
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
    font-family: "楷体_GB2312";
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
</style>    