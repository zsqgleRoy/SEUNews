<template>
  <div v-if="message.isShowTime" class="timestamp">{{ formattedTime }}</div>
  <div :class="['message-container', message.type]">
    <div class="avatar">
      <template v-if="message.type === 'agent'">
        <servuiceSvg class="svg-icon" />
      </template>
      <el-avatar v-else :src="userAvatar" size="40" />
    </div>
    <div class="message">
      <div v-show="!isLoading" class="content" v-html="renderContent"></div>
      <div v-show="message.content == ''" class="typing-indicator">
          <div class="dot" :style="{ animationDelay: '-0.4s' }"></div>
          <div class="dot" :style="{ animationDelay: '-0.2s' }"></div>
          <div class="dot"></div>
        </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { computed, defineProps, ref } from 'vue'
  import markdownIt from 'markdown-it'
  import servuiceSvg from "@/components/svg/service.vue"
  import userCache from '@/cache/userCache'

  const props = defineProps({
    message: {
      type: Object,
      required: true
    },
    isLoading: {
      type: Boolean,
      default: false
    }
  })

  const md = markdownIt({
    html: true, // 允许 HTML 标签
    typographer: true, // 优化排版
    breaks: true
  })

  const renderContent = computed(() => {
    let content = props.message.content.replace(/<\/think>/g, '').trim()
    content = content.replace(/<think>/g, '').trim()
  
    if (content.includes('*') || content.includes('#')) {
      content = md.render(content)
    }
    return content
  })

  const userAvatar = computed(() => {
    return userCache.getUserCache()?.avatar || 'https://picsum.photos/40/40'
  })

  const formattedTime = computed(() => {
    return props.message.timestamp.toLocaleTimeString([], {
      hour: '2-digit',
      minute: '2-digit'
    })
  })
</script>

<style scoped lang="scss">
/* 基础布局 */
.message-container {
  display: flex;
  align-items: flex-start;
  margin: 12px 0;
  gap: 10px;
  max-width: 100vw;
}

.avatar {
  width: 40px;
  height: 40px;
  flex-shrink: 0;
}

.svg-icon {
  width: 40px;
  height: 40px;
  fill: #666;
}

/* 加载动画 */
.typing-indicator {
  margin-top: 8px;
  display: flex;
  gap: 4px;
}

.dot {
  width: 6px;
  height: 6px;
  background: linear-gradient(135deg, #0055ff, #6b00bc);
  border-radius: 50%;
  animation: typing 1.4s infinite;
}

@keyframes typing {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-4px); }
}

/* 消息气泡 */
.message {
  padding: 10px 18px;
  border-radius: 24px;
  font-size: 16px;
  line-height: 1.6rem;
  position: relative;
  min-height: 30px;
}

.loading-dot {
  width: 6px;
  height: 6px;
  background: #999;
  border-radius: 50%;
  animation: loading-dot 1.2s infinite;
}

@keyframes loading-dot {
  0%, 100% { width: 6px; }
  50% { width: 14px; }
}

.message-container.user {
  flex-direction: row-reverse;
  text-align: right;

  .message {
    background: #007bff;
    color: white;
    margin-left: 5px;
    text-align: left;

    &::after {
      content: '';
      position: absolute;
      right: -12px;
      top: 50%;
      transform: translateY(-50%);
      width: 0;
      height: 0;
      border: 8px solid transparent;
      border-left-color: #007bff;
    }
  }
}

.message-container.agent {
  .message {
    background: #f0f2fe;
    color: #333;
    margin-right: 20px;

    &::after {
      content: '';
      position: absolute;
      left: -12px;
      top: 50%;
      transform: translateY(-50%);
      width: 0;
      height: 0;
      border: 8px solid transparent;
      border-right-color: #f0f2f5;
    }
  }
}

/* 时间戳 */
.timestamp {
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 14px;
  color: #666;
  margin-top: 0;
  opacity: 0.8;
}
/* 新增：富文本样式 */
.content {
  word-break: break-word;
  white-space: pre-line; /* 保留换行 */
  & a {
    color: #007bff;
    text-decoration: underline;
  }
  & pre {
    background: #f8f9fa;
    padding: 12px;
    border-radius: 12px;
    font-size: 14px;
    margin-top: 8px;
  }
  & code {
    font-family: monospace;
    color: #e83e8c;
  }
  & ul, & ol {
    padding-left: 24px;
    margin-top: 8px;
  }
}
.loading-content {
  width: auto;
  padding: 8px 16px;
  border-radius: 20px;
  background: rgba(0, 0, 0, 0.05);
}
@media screen and (max-width: 768px) {
  .message-container {
    margin: 15px 15px 0 0;
    gap: 6px;
  }
  .avatar {
    width: 32px;
    height: 32px;
  }
  .message {
    padding: 8px 12px;
    font-size: 14px;
    line-height: 1.4rem;
    min-height: 24px;
  }
  .message-container.user {
    .message {
      margin-left: 4px;
    }
  }
  .timestamp{
    margin-top: 5px;
    margin-bottom: 0;
  }
}
</style>
