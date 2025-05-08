import { type RouteRecordRaw } from 'vue-router';
import Login from '@/views/user/Login.vue';
import Home from '@/views/user/Home/home.vue';

const userRoutes: RouteRecordRaw[] = [
  {
    path: '/login',
    name: 'Login',
    component: Login,
    meta: {
      title: '用户登录',
      requiresAuth: false // 该路由不需要用户认证
    }
  },
  {
    path:"/myHome",
    name:"myHome",
    component:()=>import("@/views/user/Home/index.vue"),
    meta:{
      title:"添加新闻",
      requiresAuth: true,
      mobileFullPage: true
    }
  },  
  {
    path:"/userInfo/:id",
    name:"PersonInfo",
    component:()=>import("@/views/user/Home/PersonInfo.vue"),
    meta:{
      title:"作者主页",
      requiresAuth: false,
      mobileFullPage: true
    }
  },  
  {
    path:"/userdata/:id",
    name:"userdata",
    component:()=>import("@/views/user/Home/PublicHome.vue"),
    meta:{
      title:"个人资料",
      requiresAuth: true,
      mobileFullPage: true
    }
  },
  {
    path:"/Vip",
    name:"VIP",
    component:()=>import("@/components/common/ParentComponent.vue"),
    meta:{
      title:"购买会员",
      requiresAuth: true,
    }
  },
  {
    path: '/index',
    name: 'index',
    component: Home,
    meta: {
      title: '东南新闻管理终端',
      requiresAuth: false // 注册页面不需要用户认证
    }
  }
];

export default userRoutes;
