<template>
    <button
      :class="['ui-button', { 'ui-button--primary': type === 'primary', 'ui-button--secondary': type === 'secondary' }]"
      :disabled="disabled"
      @click="handleClick"
    >
      <slot></slot>
    </button>
  </template>
  
  <script lang="ts" setup>
  
  // 定义组件的 props
  const props = defineProps({
    type: {
      type: String,
      default: 'primary',
      validator: (value: string) => ['primary', 'secondary'].includes(value)
    },
    disabled: {
      type: Boolean,
      default: false
    }
  });
  
  // 定义组件的事件
  const emits = defineEmits(['click']);
  
  // 处理点击事件
  const handleClick = (event: MouseEvent) => {
    if (!props.disabled) {
      emits('click', event);
    }
  };
  </script>
  
  <style scoped>
  .ui-button {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: background-color 0.3s ease;
  }
  
  .ui-button--primary {
    background-color: #007bff;
    color: white;
  }
  
  .ui-button--primary:hover {
    background-color: #0056b3;
  }
  
  .ui-button--secondary {
    background-color: #6c757d;
    color: white;
  }
  
  .ui-button--secondary:hover {
    background-color: #545b62;
  }
  
  .ui-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }
  </style>
  