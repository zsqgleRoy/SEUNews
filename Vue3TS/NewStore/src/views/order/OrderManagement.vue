<template>
  <div class="order-management">
    <!-- 搜索栏 -->
    <el-row :gutter="20" class="mb-4">
      <el-col :span="6">
        <el-input v-model.number="searchUserId" placeholder="用户ID" type="number" clearable />
      </el-col>
      <el-col :span="6">
        <el-select v-model="searchStatus" placeholder="状态筛选" clearable>
          <el-option
            v-for="status in orderStatusOptions"
            :key="status"
            :label="status"
            :value="status"
          />
        </el-select>
      </el-col>
      <el-col :span="4">
        <el-button type="primary" @click="loadOrders">搜索</el-button>
      </el-col>
    </el-row>

    <!-- 订单表格 -->
    <el-table :data="orders" border stripe>
      <el-table-column prop="outTradeNo" label="订单号"/>
      <el-table-column prop="uid" label="用户ID" width="120" />
      <el-table-column prop="amount" label="金额" width="120" align="right">
        <template #default="{ row }">¥{{ row.totalAmount.toFixed(2) }}</template>
      </el-table-column>
      <el-table-column prop="status" label="状态" width="180">
        <template #default="{ row }">
          <el-tag :type="statusTagType(row.status)">
            {{ row.status }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" />
      <el-table-column label="操作" width="150">
        <template #default="{ row }">
          <el-button size="small" @click="showDetail(row)">详情</el-button>
          <el-button 
            size="small" 
            type="danger" 
            v-if="row.status === OrderStatus.UNPAID"
            @click="updateStatus(row.outTradeNo, OrderStatus.CANCELLED)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="[10, 20, 50]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
    >
    </el-pagination>

    <el-dialog v-model="detailVisible" title="订单详情" width="90%" top="5vh">
      <order-detail :order="selectedOrder" v-if="selectedOrder" />
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { type Order, OrderStatus } from '@/types/order';
import { orderService } from '@/api/order';
import OrderDetail from '@/components/OrderDetail.vue';
import { ElMessage } from 'element-plus';
import userCache from '@/cache/userCache';

const orders = ref<Order[]>([]);
const searchUserId = ref<number | null>(null);
const searchStatus = ref<OrderStatus | null>(null);
const currentPage = ref(1);
const pageSize = ref(10);
const total = ref(0);
const detailVisible = ref(false);
const selectedOrder = ref<Order | null>(null);

const orderStatusOptions = Object.values(OrderStatus);
async function loadOrders() {
  try {
    let response;
    if (searchUserId.value) {
      response = await orderService.getByUserId(userCache.getUserCache()?.user_id||2);
    } else {
      response = await orderService.getAllOrders(
        currentPage.value,
        pageSize.value
      );
    }
    
    orders.value = response.content;
    total.value = response.totalElements;
  } catch (error) {
    ElMessage.error('加载订单失败');
  }
}

const handleSizeChange = (orderSize: number) => {
    pageSize.value = orderSize;
    loadOrders();
};

const handleCurrentChange = (newPage: number) => {
    currentPage.value = newPage;
    loadOrders();
};

async function updateStatus(outTradeNo: string, status: OrderStatus) {
  try {
    const response = await orderService.deleteByOutTradeNo(outTradeNo);
    if (response){
      ElMessage.success('状态更新成功');
      loadOrders();
    }
  } catch (error) {
    ElMessage.error('更新失败');
  }
}

// 显示详情
function showDetail(order: Order) {
  selectedOrder.value = order;
  detailVisible.value = true;
}

// 状态标签样式
function statusTagType(status: OrderStatus) {
  return {
    [OrderStatus.PAID]: 'success',
    [OrderStatus.UNPAID]: 'warning',
    [OrderStatus.CANCELLED]: 'info',
    [OrderStatus.REFUNDED]: 'danger',
  }[status];
}

onMounted(loadOrders);
</script>

<style lang="scss" scoped>
.order-management {
  padding: 20px;
  background: #f5f7fa;
  min-height: calc(100vh - 60px);

  // 搜索栏样式
  .search-bar {
    margin-bottom: 20px;
    background: #fff;
    padding: 20px;
    border-radius: 4px;
    box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);

    .el-col {
      display: flex;
      align-items: center;
      
      + .el-col {
        margin-left: 10px;
      }
    }
  }

  // 表格样式
  :deep(.el-table) {
    box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
    
    th {
      background-color: #f8f9fa;
      font-weight: 600;
    }

    .status-tag {
      font-size: 12px;
      padding: 4px 8px;
      border-radius: 12px;
    }
  }

  // 分页样式
  .el-pagination {
    justify-content: flex-end;
    padding: 20px 0;
    background: #fff;
    margin-top: 20px;
    border-radius: 4px;
    box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
  }

  // 操作按钮组
  .action-buttons {
    display: flex;
    gap: 8px;
  }
}

// 响应式适配
@media (max-width: 768px) {
  .order-management {
    padding: 10px;
    
    .el-col {
      width: 100%;
      margin-bottom: 10px;
      
      + .el-col {
        margin-left: 0;
      }
    }
    
    .el-select {
      width: 100%;
    }
  }
}
</style>