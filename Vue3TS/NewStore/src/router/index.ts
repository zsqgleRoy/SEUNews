import { createRouter, createWebHashHistory, type RouteRecordRaw } from 'vue-router';
import userRoutes from './modules/userRoutes';
import newsRoutes from './modules/newsRouters';
import { ElMessage } from 'element-plus';
import MobileMenuWrapper from "@/components/common/empty.vue"
import userCache from "../cache/userCache";
const { getUserCache } = userCache; 

// 定义路由记录
const routes: RouteRecordRaw[] = [
  // 根路径重定向到首页
  {
    path: '/',
    redirect: '/home'
  },
  {
    path: '/home',
    name: 'Home',
    component: () => import('@/views/Home.vue'),
    meta: {
      title: '首页',
      requiresAuth: false
    }
  },
  {
    path: "/NewsView/:id",
    name: "NewsDetail",
    component:()=> import('@/views/news/NewsView.vue'),
    meta: {
      title: '新闻详情页',
      requiresAuth: false // 首页通常不需要认证
    }
  },
  {
    path: "/pay",
    name: "PAY",
    component:() => import('@/components/common/Media/TryPlay.vue'),
    meta: {
      title: '支付页面',
      requiresAuth: false // 首页通常不需要认证
    }
  },
  {
    path: "/WeChatPay",
    name: "WeChatPay",
    component:() => import('@/components/common/WeChatPay.vue'),
    meta: {
      title: '微信支付页面',
      requiresAuth: false // 首页通常不需要认证
    }
  },
  {
    path: "/QQPay",
    name: "QQPay",
    component:() => import('@/components/common/QQPay.vue'),
    meta: {
      title: 'QQ支付页面',
      requiresAuth: false // 首页通常不需要认证
    }
  },
  {
    path: "/GSPay",
    name: "GSPay",
    component:() => import('@/components/common/GSPay.vue'),
    meta: {
      title: 'QQ支付页面',
      requiresAuth: false // 首页通常不需要认证
    }
  },
  {
    path: "/SZRMBPay",
    name: "SZRMBPay",
    component:() => import('@/components/common/SZRMBPay.vue'),
    meta: {
      title: '数字人民币支付页面',
      requiresAuth: false // 不需要认证
    }
  },
  {
    path: "/return",
    name: "RETURN",
    component:() => import('@/components/common/PaymentResult.vue'),
    meta: {
      title: '支付页面',
      requiresAuth: false // 不需要认证
    }
  },
  {
    path: "/getService",
    name: "Service",
    component:() => import('@/views/chat/ChatInterface.vue'),
    meta: {
      title: '智能客服',
      requiresAuth: true // 不需要认证
    }
  },
  {
    path: "/searchresult/:query",
    name: "SearchResult",
    component:() => import('@/components/common/search/SearchPanel.vue'),
    meta: {
      title: '搜索结果',
      requiresAuth: false // 不需要认证
    }
  },
  {
    path: "/modifyuserdata",
    name: "ModifyUserData",
    component:() => import('@/views/user/Home/EditUserData.vue'),
    meta: {
      title: '修改信息',
      requiresAuth: false // 不需要认证
    }
  },
  {
    path: "/ErrorState",
    name: "ErrorState",
    component:()=> import('@/components/common/ErrorState.vue'),
    meta: {
      title: '错误页',
      requiresAuth: false // 首页通常不需要认证
    }
  },
  {
    path:"/addNews",
    name:"AddNews",
    component:()=>import("@/views/news/AddNews.vue"),
    meta:{
      title:"添加新闻",
      requiresAuth: true,
      mobileFullPage: true
    }
  },
  {
    path:"/check",
    name:"CheckCode",
    component:()=>import("@/components/common/ImageCode.vue"),
    meta:{
      title:"添加新闻",
      requiresAuth: false
    }
  },
  {
    path: '/mobile-menu',
    component: MobileMenuWrapper // 空组件仅用于显示菜单
  },
  // 引入用户相关路由
  ...userRoutes,
  // 引入新闻相关路由
  ...newsRoutes,
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('@/views/404.vue'),
    meta: {
      title: '未找到页面',
      requiresAuth: false
    }
  },
  {
    path: '/about',
    name: 'AboutUS',
    component: () => import('@/views/AboutView.vue'),
    meta: {
      title: '关于我们',
      requiresAuth: false
    }
  },
];

// 创建路由实例
const router = createRouter({
  // 使用 HTML5 History 模式
  history: createWebHashHistory(),
  routes
});

// 封装路由验证逻辑
const isAuthenticated = () => {
  try {
    // 调用 getUserCache 函数获取用户缓存
    const user = getUserCache();
    // 如果用户缓存为空，说明用户未认证，返回 false；否则返回 true
    return user === null;
  } catch (error) {
    // 出现异常时返回 false
    return true;
  }
};

// 全局前置守卫，可用于路由跳转前的验证等操作
router.beforeEach((to, from, next) => {
  try {
    // 为路由元信息的 requiresAuth 设置默认值为 false
    const requiresAuth = to.meta.requiresAuth || false;

    // 如果路由需要认证，检查用户是否已登录
    if (requiresAuth && isAuthenticated()) {
      ElMessage.info('登录后使用此功能！');
      // ElMessage.success(requiresAuth + " "+ isAuthenticated() + " " + localStorage.getItem(TOKEN_KEY));
      next('/home');
    } else {
      next();
      // ElMessage.info(requiresAuth + " "+ isAuthenticated() + " " + localStorage.getItem(TOKEN_KEY));
    }
  } catch (error) {
    next('/error'); // 跳转到错误页面
  }
});

export default router;
