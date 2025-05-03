<template>
    <div class="ui-card">
      <div class="ui-card__header" v-if="title">
        {{ title }}
      </div>
      <div class="ui-card__content">
        <slot></slot>
      </div>
      <div class="ui-card__footer" v-if="footer">
        {{ footer }}
      </div>
    </div>
  </template>
  
  <script lang="ts" setup>
  
  // 定义组件的 props
  const props = defineProps({
    title: {
      type: String,
      default: ''
    },
    footer: {
      type: String,
      default: ''
    }
  });
  </script>
  
  <style scoped>
  .ui-card {
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
  
  .ui-card__header {
    padding: 12px;
    background-color: #f8f9fa;
    font-weight: bold;
  }
  
  .ui-card__content {
    padding: 12px;
  }
  
  .ui-card__footer {
    padding: 12px;
    background-color: #f8f9fa;
    border-top: 1px solid #ddd;
  }
  </style>
  