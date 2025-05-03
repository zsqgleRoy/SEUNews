<!-- ChatApp.vue 父组件 -->
<template>
    <div v-if="userId" class="chat-container">
      <div class="top-menu" v-if="isMobile">
          <BackButton/>
          <h1>智能客服</h1>
      </div>
      <WaterMark class="watermarkText" text="东南新闻网" text1="http://seunews.pgrm.cc" />
      <ChatMessageList :messages="messages" />
      <ChatInput @send-message="handleSendMessage" />
    </div>
</template>

<script setup lang="ts">
  import WaterMark from '@/components/common/watermark/WaterMarkBack.vue'
  import { onMounted, ref } from 'vue'
  import ChatMessageList from './components/ChatMessageList.vue'
  import ChatInput from './components/ChatInput.vue'
  import axios from 'axios'
  import { initialURL } from '@/lib/urls'
  import BackButton from '@/components/common/BackButton.vue';
  import userCache from '@/cache/userCache'
  const generateSessionId = () => {
    return Date.now().toString(36) + Math.random().toString(36).substr(2);
  };

  const sessionId = ref(generateSessionId());
  const userId = ref();
  const isMobile = ref(window.innerWidth < 768)
  const api = axios.create({
    baseURL: initialURL.SERVER_URL,
    timeout: 300000
  })

  export interface Message {
    id: number
    content: string
    type: 'user' | 'agent'
    timestamp: Date
    isShowTime?: boolean
    isTemp?: boolean
  }
  
  const getShowTime = (messages: Message[], newMsg: Message) => {
    // 过滤掉临时消息后再进行判断
    const validMessages = messages.filter(m => !m.isTemp)
    const lastMsg = validMessages[validMessages.length - 1]
    
    if (!lastMsg) return true
    if (lastMsg.type !== newMsg.type) return true
    
    const diffMinutes = Math.abs(
      (newMsg.timestamp.getTime() - lastMsg.timestamp.getTime()) / 60000
    )
    
    return diffMinutes > 2
  }

  const messages = ref<Message[]>([
    {
      id: 1,
      content: '欢迎您访问东南新闻 <a href="http://seunews.pgrm.cc" target="_blank" rel="noopener noreferrer" style="color:blue;"> http://seunews.pgrm.cc</a>\n我是东南新闻网基于本地部署的DeepSeek 1.5b蒸馏大模型构建的智能客服，请问有什么可以帮您？',
      type: 'agent',
      timestamp: new Date(),
      isShowTime: true
    }
  ])
  
  const loadChatHistory = async () => {
    try {
        const response = await api.get('/api/history', {
            params: {
                user_id: userCache.getUserCache()?.user_id
            }
        });
        const historyMessages: Message[] = [];
        response.data.forEach((record: any, index: number) => {
            const message: Message = {
                id: record.id,
                content: record.content,
                type: record.role as 'user' | 'agent',
                timestamp: new Date(record.timestamp)
            };
            if (index === 0) {
                message.isShowTime = true;
                historyMessages.push(message);
            }
            else{
              const prevMsg = historyMessages[historyMessages.length - 1];
              const diffMinutes = Math.abs(
                  (message.timestamp.getTime() - prevMsg.timestamp.getTime()) / 60000
              );
              message.isShowTime = diffMinutes > 2;
              historyMessages.push(message);
            }

        });
        
        messages.value = historyMessages;
    } catch (error) {
        console.error('加载历史记录失败:', error);
    }
  };


  const handleSendMessage = async (content: string) => {
    // 加载占位消息
    const loadingMsg: Message = {
      id: Date.now() + 1,
      content: '',
      type: 'agent',
      timestamp: new Date(),
      isShowTime: false,
      isTemp: true
    }
    if (!content.trim()) return

    const userMessage: Message = {
      id: Date.now(),
      content,
      type: 'user',
      timestamp: new Date(),
      isTemp: undefined,  
      isShowTime: getShowTime(
        messages.value.filter(m => m.id !== loadingMsg.id),
        { ...loadingMsg, isTemp: undefined }
      )
    }
    messages.value.push(userMessage)
    
    const loadingMessage: Message = {
      id: Date.now() + 1,
      content: '',
      type: 'agent',
      timestamp: new Date()
    }
    messages.value.push(loadingMessage)

    try {
      const response = await api.get('/api/ask', {
        params: {
          msg: content,
          sessionId: sessionId.value,
          user_id: userId.value
        }
      })
      const loadingIndex = messages.value.findIndex(m => m.id === loadingMessage.id)
      if (loadingIndex !== -1) {
        messages.value[loadingIndex] = {
          ...loadingMessage,
          content: response.data,
          timestamp: new Date()
        }
      }
    } catch (error) {
      console.error('API调用失败:', error)
      const errorIndex = messages.value.findIndex(m => m.id === loadingMessage.id)
      if (errorIndex !== -1) {
        messages.value[errorIndex] = {
          ...loadingMessage,
          content: '服务器繁忙，请稍后再试',
          timestamp: new Date()
        }
      }
    }
  }

  onMounted(() => {
    userId.value = userCache.getUserCache()?.user_id;
    if (localStorage.getItem(userCache.getUserCache()?.username || 'null')) {
      sessionId.value = localStorage.getItem(userCache.getUserCache()?.username || 'null')!;
      loadChatHistory();
    }
    else {
      localStorage.setItem(userCache.getUserCache()?.username || 'null', sessionId.value);
    }
  });
</script>
  
<style scoped lang="scss">

  .chat-container {
    max-width: 100vw;
    margin: 0;
    height: 100vh;
    display: flex;
    flex-direction: column;
    background-color: #f5f5f5;
  }
  .top-menu {
    display: flex;
    align-items: center;
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.3);
    backdrop-filter: blur(10px);
    padding: 10px;
}
.top-menu h1 {
    margin: 0 auto;
    color: transparent;
    background: linear-gradient(135deg, #0055ff, #6b00bc);
    -webkit-background-clip: text;
    background-clip: text;
    border-image: linear-gradient(135deg, #0055ff, #6b00bc) 1;
    text-transform: uppercase;
    font-size: 18px;
}
</style>