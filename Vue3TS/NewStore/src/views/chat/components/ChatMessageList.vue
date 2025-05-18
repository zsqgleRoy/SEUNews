<template>
  <div class="message-list" ref="listRef">
    <div 
      v-for="message in messages"
      :key="message.id"
      :class="`message-item ${message.type}-msg`"
    >
      <Message :message="message" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { type PropType, ref, onUpdated, watch, nextTick, onBeforeUnmount } from 'vue'
import Message from './Message.vue' // 补充子组件导入
import type { Message as mess } from '../ChatInterface.vue'
const isScrolledToBottom = ref(true)

const props = defineProps({
  messages: {
    type: Array as PropType<mess[]>,
    required: true
  }
})

watch(
  () => props.messages,
  (newMsg, oldMsg) => {
    // 仅在新增消息时滚动（根据消息id判断）
    if (newMsg.length > oldMsg.length && newMsg[newMsg.length - 1]?.id !== oldMsg[oldMsg.length - 1]?.id) {
      nextTick(() => {
        if (!isScrolledToBottom.value) return // 用户不在底部则不滚动
        const lastChild = listRef.value?.lastElementChild
        lastChild?.scrollIntoView({
          behavior: 'smooth',
          block: 'end' // 确保滚动到底部
        })
      })
    }
  },
  { deep: true }
)

const handleScroll = () => {
  if (!listRef.value) return
  const { scrollTop, scrollHeight, clientHeight } = listRef.value;
  isScrolledToBottom.value = scrollTop + clientHeight >= scrollHeight - 0;
}


const listRef = ref<HTMLElement>()

onUpdated(() => {
  listRef.value?.addEventListener('scroll', handleScroll)
})
onBeforeUnmount(() => {
  listRef.value?.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped lang="scss">
.message-list {
  flex: 1;
  overflow-y: auto;
  padding-bottom: 20px;
  max-width: 100vw;
  gap: 10px;

  .message-item {
    max-width: 98vw;
    padding: 10px 10px;
    border-radius: 15px;
    word-wrap: break-word;

    &.user-msg {
      background: none;
      color: white;
      margin-left: auto;
    }

    &.agent-msg {
      background: none;
      color: #333;
      margin-right: auto;
    }
  }
}
@media screen and (max-width: 768px) {
  .message-list {
    padding-bottom: 0px;
    gap: 0px;
    padding-bottom: 3vh;

    .message-item {
      padding: 0px 8px;
      max-width: 100vw;
    }
  }
  
}
</style>
  