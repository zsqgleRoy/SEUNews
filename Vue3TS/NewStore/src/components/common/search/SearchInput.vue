<template>
    <div class="ep-search-container">
      <el-input
        v-model="keyword"
        :placeholder="placeholder"
        :clearable="clearable"
        :size="size"
        @keyup.enter.native="handleSearch"
        @clear="handleSearch"
        class="ep-search-input"
      >
        <template #prefix>
          <el-icon class="search-icon" @click="handleSearch">
            <Search />
          </el-icon>
        </template>
      </el-input>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, watch, onMounted } from 'vue'
  import { debounce } from 'lodash-es'
  import { ElInput, ElIcon } from 'element-plus'
  import { Search } from '@element-plus/icons-vue'
  
  interface Props {
    modelValue?: string
    placeholder?: string
    debounceTime?: number
    clearable?: boolean
    size?: 'large' | 'default' | 'small'
  }
  
  const props = withDefaults(defineProps<Props>(), {
    modelValue: '',
    placeholder: '请输入...',
    debounceTime: 300,
    clearable: true,
    size: 'default'
  })
  
  const emit = defineEmits<{
    (e: 'update:modelValue', value: string): void
    (e: 'search', value: string): void
  }>()
  
  const keyword = ref(props.modelValue)
  
  // 防抖处理
  const debouncedSearch = debounce((value: string) => {
    emit('search', value)
  }, props.debounceTime)
  
  watch(keyword, (newVal) => {
    emit('update:modelValue', newVal)
    debouncedSearch(newVal)
  })
  
  const handleSearch = () => {
    debouncedSearch.flush()
  }
  
  // 组件卸载时取消防抖
  onMounted(() => {
    return () => debouncedSearch.cancel()
  })
  </script>
  
  <style scoped>
  .ep-search-container {
    --ep-search-primary: var(--el-color-primary);
    --ep-search-hover: var(--el-color-primary-light-3);
  }
  
  .ep-search-input {
    max-width: 400px;
    transition: all 0.3s ease;
  
    :deep(.el-input__wrapper) {
      padding-left: 10px;
      border-radius: 20px;
      box-shadow: 0 2px 8px var(--el-box-shadow-light);
      
      &:hover {
        box-shadow: 0 2px 12px var(--el-color-primary-light-5);
      }
      
      &.is-focus {
        box-shadow: 0 0 0 2px var(--el-color-primary-light-3);
      }
    }
  }
  
  .search-icon {
    margin-right: 8px;
    cursor: pointer;
    transition: color 0.3s;
  
    &:hover {
      color: var(--ep-search-hover);
    }
  }
  </style>