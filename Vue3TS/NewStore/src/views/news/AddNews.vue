<template>
  <div class="editor-container">
    <!-- 顶部菜单行，仅在手机模式显示 -->
    <div class="top-menu" v-if="isMobile">
      <BackButton/>
      <h1>添加新闻</h1>
    </div>
    <addNews></addNews>
  </div>
</template>

<script setup lang="ts">
  import { ref } from "vue";
  import BackButton from '@/components/common/BackButton.vue';
  import addNews from "./wangEditor.vue"
  // 判断是否为手机模式
  const isMobile = ref(window.innerWidth < 768);
</script>

<style scoped lang="scss">
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
    font-size: 1.2rem;
    color: #1e293b;
}
.editor-container {
  border: 1px solid #ddd;
}
.editor-container{
  min-height: 400px;
}
.w-e-text-container{
  min-height: 340px;
}
a{
  color:#0062ff;
}
</style>