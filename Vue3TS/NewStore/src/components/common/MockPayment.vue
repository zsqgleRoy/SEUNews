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
      <el-row :gutter="8" class="options-grid">
        <el-col
          v-for="(option, index) in vipOptions"
          :key="index"
          :xs="12" :sm="8" :md="6" :lg="6"
        >
          <el-card
            shadow="hover"
            class="option-card"
            :class="{ 'selected-card': selectedOption?.value === option.value }"
            @click="selectOption(option)"
          >
            <div class="card-container">
              <div class="icon-wrapper">
                <el-tag
                  v-if="option.discount && option.discount != 1"
                  type="danger"
                  effect="dark"
                  class="discount-tag"
                >
                  {{ (option.discount * 100).toFixed(0) }}折
                </el-tag>
                <div class="gem-icon">
                  <svg viewBox="0 0 20 20">
                    <path fill="currentColor" d="M12 0L3 7l4 10h10l4-10-9-7zm0 2.3l6.3 4.9-3 7.8H8.7l-3-7.8 6.3-4.9z"/>
                  </svg>
                </div>
              </div>

              <!-- 内容区 -->
              <div class="content-wrapper">
                <h3 class="duration-text">{{ option.label }}</h3>
                <div class="price-wrapper">
                  <div v-if="option.discount" class="original-price">
                    ￥{{ (option.price / option.value).toFixed(1) }}
                  </div>
                  <div class="current-price">
                    <span class="price-number">￥{{ calculateMonthlyPrice(option) }}</span>
                    <span class="price-unit">/月</span>
                  </div>
                </div>
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
  max-width: 100vw;
  margin: 0 auto;
  padding: 0 1rem;
  
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

.duration-panel {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem;
}

.options-grid {
  margin: -8px;
  
  .el-col {
    padding: 8px;
    
    @media (max-width: 768px) {
      &:nth-child(2n+1) {
        clear: left;
      }
    }
  }
}

.option-card {
  height: 100%;
  margin: 0 auto;
  max-width: 260px;
  transition: transform 0.3s ease;
  
  &:hover {
    transform: translateY(-3px);
  }
  
  .card-container {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 12px;
  }
}

.icon-wrapper {
  position: relative;
  flex-shrink: 0;
  
  .discount-tag {
    position: absolute;
    top: -12px;
    right: -8px;
    transform: rotate(15deg);
    font-size: 0.75rem;
    padding: 4px 8px;
  }
  
  .gem-icon {
    width: 48px;
    height: 48px;
    color: #409eff;
    
    @media (max-width: 480px) {
      width: 40px;
      height: 40px;
    }
  }
}

.content-wrapper {
  flex: 1;
  min-width: 0;
  
  .duration-text {
    margin: 0 0 4px;
    font-size: 1.1rem;
    color: #303133;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
}

.price-wrapper {
  .original-price {
    font-size: 0.85rem;
    color: #909399;
    text-decoration: line-through;
  }
  
  .current-price {
    display: flex;
    align-items: baseline;
    gap: 4px;
    
    .price-number {
      font-size: 1.4rem;
      color: #409eff;
      font-weight: 600;
    }
    
    .price-unit {
      font-size: 0.9rem;
      color: #606266;
    }
  }
}

.selected-card {
  border: 2px solid #409eff;
  background: linear-gradient(145deg, #f8faff, #ebf5ff);
  
  .gem-icon {
    color: darken(#409eff, 10%);
  }
}

@media (max-width: 768px) {
  .option-card .card-container {
    flex-direction: column;
    text-align: center;
    gap: 0.5rem;
    padding: 8px;
  }
  
  .icon-wrapper {
    margin-top: 8px;
    
    .gem-icon {
      width: 36px;
      height: 36px;
    }
  }
  
  .content-wrapper {
    width: 100%;
    
    .duration-text {
      font-size: 1rem;
    }
  }
}
</style>