import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('../views/HomeView.vue'),
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue'),
    },
    {
      path: '/',
      name: 'news',
      component: () => import('../views/NewsView.vue'),
    },
    {
      path: '/:catchAll(.*)', // 通配符路由，匹配所有未定义的路径
      name: '404',
      component: () => import('../views/404.vue')
    },
    
  ],
})

export default router
