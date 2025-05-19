<template>
  <div v-if="order" class="order-panel">
    <el-descriptions title="订单详情" border :column="isMobile ? 1 : 2">
      <el-descriptions-item label="订单号">{{ order.outTradeNo }}</el-descriptions-item>
      <el-descriptions-item label="用户ID">{{ order.uid }}</el-descriptions-item>
      <el-descriptions-item label="金额">¥{{ order.totalAmount.toFixed(2) }}</el-descriptions-item>
      <el-descriptions-item label="状态">
        <el-tag :type="statusTagType(order.status)">
          {{ order.status }}
        </el-tag>
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">{{ order.createTime }}</el-descriptions-item>
    </el-descriptions>
  </div>
</template>

<script setup lang="ts">
import { type Order, OrderStatus } from '@/types/order';
import { ref, computed, onMounted } from 'vue';

defineProps<{
  order: Order;
}>();

const isMobile = ref(false);

const checkScreenSize = () => {
  isMobile.value = window.innerWidth < 768;
};

onMounted(() => {
  checkScreenSize();
  window.addEventListener('resize', checkScreenSize);
});

function statusTagType(status: OrderStatus) {
  switch(status) {
    case OrderStatus.UNPAID: return 'info';
    case OrderStatus.PAID: return 'success';
    case OrderStatus.REFUNDED: return 'danger';
    case 'CANCELLED': return 'warning';
    default: return 'info';
  }
}
</script>

<style lang="scss" scoped>
.order-panel {
  width: 100%;
  padding: 15px;
  
  .el-descriptions {
    // 为移动端优化间距
    --el-descriptions-item-padding: 8px 12px;
    
    // 移动端字体大小调整
    @media (max-width: 767px) {
      font-size: 14px;
    }
  }
  
  // 修复原代码中的嵌套选择器问题
  @media (max-width: 767px) {
    .el-descriptions__body {
      .el-descriptions__cell {
        width: 100vw !important;
      }
    }
  }
}
</style>
