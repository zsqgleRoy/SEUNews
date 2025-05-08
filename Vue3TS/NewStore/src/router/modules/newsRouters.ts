import { tr } from 'element-plus/es/locale/index.mjs';
import { type RouteRecordRaw } from 'vue-router';

// 定义新闻相关的路由配置
const newsRoutes: RouteRecordRaw[] = [
  {
    path: '/news',
    name: 'NewsList',
    component: () => import('@/views/news/List.vue'),
    meta: {
      title: '新闻列表',
      requiresAuth: false // 该路由不需要用户认证
    }
  },
  {
    path: '/news/:id',
    name: 'NewsDetail',
    component: () => import('@/views/news/NewsView.vue'),
    meta: {
      title: '新闻详情',
      requiresAuth: false
    },
    props: true
  },
  {
    path: '/newsManage',
    name: 'NewsManage',
    component: () => import('@/views/news/NewsManagement.vue'),
    meta: {
      title: '新闻管理',
      requiresAuth: false
    },
    props: (route) => ({ id: Number(route.params.id) })
  },
  {
    path: '/editNews/:id',
    name: 'EditNews',
    component: () => import('@/views/news/EditNews.vue'),
    meta: {
      title: '新闻管理',
      requiresAuth: false
    },
    props: (route) => ({ id: Number(route.params.id) })
  },

];

export default newsRoutes;
