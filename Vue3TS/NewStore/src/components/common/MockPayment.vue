<template>
  <div class="duration-panel">
    <!-- 加载状态 -->
    <div v-if="loading" class="loading-container">
      <el-skeleton :rows="3" animated />
    </div>

    <!-- 错误状态 -->
    <div v-else-if="error" class="error-container">
      <el-empty description="加载失败，请尝试刷新页面">
        <el-button type="primary" @click="fetchVipOptions">重新加载</el-button>
      </el-empty>
    </div>

    <!-- 正常显示 -->
    <template v-else>
      <div class="glow-bar"></div>
      
      <el-row :gutter="20" class="options-grid">
        <el-col
          v-for="(option, index) in vipOptions"
          :key="index"
          :xs="30" :sm="30" :md="20" :lg="20"
        >
          <el-card
            shadow="hover"
            class="option-card"
            :class="{ 'selected-card': selectedOption?.value === option.value }"
            @click="selectOption(option)"
          >
            <div class="card-header">
              <el-tag
                v-if="option.discount && option.discount < 1"
                type="danger"
                effect="dark"
                class="discount-tag"
              >
                {{ (option.discount * 100).toFixed(0) }} 折
              </el-tag>
              
              <div class="gem-icon">
                <svg viewBox="0 0 24 24">
                  <path fill="currentColor" d="M12 0L3 7l4 10h10l4-10-9-7zm0 2.3l6.3 4.9-3 7.8H8.7l-3-7.8 6.3-4.9z"/>
                </svg>
              </div>
            </div>

            <div class="card-content">
              <h3 class="duration-text">{{ option.label }}</h3>
              
              <div class="price-section">
                <span v-if="option.discount" class="original-price">
                  ￥{{ (option.price / option.value).toFixed(1) }}
                </span>
                <span class="current-price">
                  ￥{{ calculateMonthlyPrice(option) }}<small>/月</small>
                </span>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </template>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { ElNotification, ElSkeleton, ElTag } from 'element-plus'
import { useVip } from '@/composables/useVip'
import type { VipDurationOption } from '@/types/vip'

const { loading, error, vipOptions, fetchVipOptions } = useVip()
const selectedOption = ref<VipDurationOption>()

const emit = defineEmits<{
  (e: 'duration-change', value: VipDurationOption): void
}>()

onMounted(async () => {
  try {
    await fetchVipOptions()
    if (vipOptions.value.length > 0) {
      selectOption(vipOptions.value[0])
    }
  } catch (err) {
    ElNotification.error({
      title: '加载失败',
      message: 'VIP套餐信息加载失败，请稍后重试',
      position: 'bottom-right'
    })
  }
})

const selectOption = (option: VipDurationOption) => {
  selectedOption.value = option
  emit('duration-change', option)
}

const calculateMonthlyPrice = (option: VipDurationOption): string => {
  const basePrice = option.price / option.value
  return (option.discount ? basePrice * option.discount : basePrice).toFixed(1)
}
</script>

<style lang="scss" scoped>
.duration-panel {
  position: relative;
  padding: 2rem 0;
  
  .glow-bar {
    position: absolute;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, #409eff, transparent);
    opacity: 0.3;
    
    &.top { top: 0; }
    &.bottom { bottom: 0; }
  }
}

.loading-container {
  padding: 2rem;
  
  :deep(.el-skeleton) {
    --el-skeleton-color: #f5f7fa;
    --el-skeleton-to-color: #e9eef3;
  }
}

.error-container {
  padding: 2rem;
  
  :deep(.el-empty__description) {
    margin-top: 1rem;
  }
}

.options-grid {
  margin: -10px;
  
  .el-col {
    padding: 10px;
  }
}

.option-card {
  position: relative;
  cursor: pointer;
  transition: all 0.3s ease;
  border: 2px solid transparent;
  
  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }
  
  &.selected-card {
    border-color: #409eff;
    background: linear-gradient(145deg, #f8faff, #ebf5ff);
  }
}

.card-header {
  position: relative;
  text-align: center;
  padding: 1rem 0;
  
  .discount-tag {
    position: absolute;
    top: -12px;
    right: -12px;
    font-weight: bold;
    transform: rotate(15deg);
  }
  
  .gem-icon {
    width: 48px;
    height: 48px;
    margin: 0 auto;
    color: #409eff;
  }
}

.card-content {
  text-align: center;
  
  .duration-text {
    font-size: 1.2rem;
    color: #303133;
    margin: 0.5rem 0;
  }
}

.price-section {
  .original-price {
    display: block;
    font-size: 0.9rem;
    color: #909399;
    text-decoration: line-through;
  }
  
  .current-price {
    display: block;
    font-size: 1.5rem;
    color: #409eff;
    font-weight: bold;
    
    small {
      font-size: 0.8em;
      color: #606266;
    }
  }
}
</style>