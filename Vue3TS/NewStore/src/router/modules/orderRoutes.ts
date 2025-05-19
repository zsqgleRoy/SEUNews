import { type RouteRecordRaw } from 'vue-router';

const orderRoutes: RouteRecordRaw[] = [
  {
    path: '/orderView',
    name: 'OrderView',
    component: () => import('@/views/order/OrderManagement.vue'),
    meta: {
      title: '订单管理',
      requiresAuth: true
    }
  },
];

export default orderRoutes;
