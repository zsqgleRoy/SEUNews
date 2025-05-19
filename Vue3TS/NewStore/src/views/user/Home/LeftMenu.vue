<template>
  <nav class="menu-container">
    <div class="user-info">
      <img class="user-avatar" :src="info?.avatar" alt="用户头像">
      <div class="user-details">
        <span class="user-name">{{ info?.username }}</span>
        <span class="user-account">{{ info?.email || "用户编号" }}</span>
      </div>
      <div class="exit-icon" @click="handleLogout">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#fff" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
          <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
          <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
        </svg>
      </div>
    </div>
    <MembershipEntry :is-member="vip_info.isMember" :days="vip_info.days" @subscribe="handleSubscribe" class="VIPPanel"/>
    <ul>
      <li v-for="(route, index) in processedRoutes" :key="index">
        <router-link 
          v-if="!route.children" 
          :to="route.path" 
          class="menu-item"
          :class="{ 'active': isActive(route.path) }"
          @click="handleClick(route.path)"
        >
          <el-icon class="menu-icon"><component :is="route.icon || User" /></el-icon>
          {{ route.name }}
        </router-link>

        <div v-else @click.stop="toggleMenu(index)">
          <span :class="{ 
            'menu-item': true, 
            'active': isActiveParent(route),
            'has-external': hasExternalLink(route)
          }">
            <el-icon class="menu-icon"><component :is="route.icon || Files" /></el-icon>
            {{ route.name }}
            <div class="toggle-icon">
              <el-icon v-if="!isMenuOpen[index]"><ArrowRight /></el-icon>
              <el-icon v-else><ArrowDown /></el-icon>
            </div>
          </span>
          <transition name="slide">
            <ul v-if="isMenuOpen[index]" class="sub-menu">
              <li v-for="(childRoute, childIndex) in route.children" :key="childIndex">
                <router-link
                  v-if="!childRoute.meta?.isExternal"
                  :to="childRoute.path"
                  class="sub-menu-item"
                  :class="{ 'active': isActive(childRoute.path) }"
                  @click="handleClick(childRoute.path)"
                >
                  <el-icon class="submenu-icon"><component :is="childRoute.icon || Document" /></el-icon>
                  {{ childRoute.name }}
                </router-link>

                <!-- 外部链接 -->
                <a v-else
                  :href="childRoute.path"
                  class="sub-menu-item external-link"
                  :target="childRoute.meta?.isPhone ? '_self' : '_blank'"
                  rel="noopener noreferrer"
                  @click.prevent="handleExternalClick(childRoute)"
                >
                <el-icon class="submenu-icon"><component :is="childRoute.icon || Link" /></el-icon>
                  {{ childRoute.name }}
                </a>
              </li>
            </ul>
          </transition>
        </div>
      </li>
    </ul>
  </nav>
</template>

<script setup lang="ts">
import { ref, computed, shallowRef, onMounted } from "vue";

// Check if a route has an external link
const hasExternalLink = (route: any) => {
  return route.children?.some((child: any) => child.meta?.isExternal);
};
import { useRoute, useRouter } from 'vue-router';
import userCache, { type UserInfo } from '@/cache/userCache';
import { useUserStore } from '@/store/userStore';
import MembershipEntry from './MembershipEntry.vue'
import { Paperclip, Management, ChromeFilled, List, Message, HomeFilled, Service, User, Files, Document, ArrowRight, ArrowDown, Phone, Link, Plus } from '@element-plus/icons-vue';
import { ElMessage } from "element-plus";
import { checkUserVipStatus, VIP_STATUS  } from "@/api/vip";
const info = shallowRef<UserInfo | null>(userCache.getUserCache());
const route = useRoute();
const emits = defineEmits(['menuItemClick']);
const router = useRouter();
const userStore = useUserStore();
const isAuthor = ref(false)
const routes = ref(computed(() => !isAuthor.value ?
[
  {
    path: '/index',
    name: '个人中心',
    meta:{
      isExternal: false,
      isPhone: false
    }
  },
  {
    path: '/contact',
    name: '联系我们',
    icon: Paperclip,
    children: [
      { path: '/getService', name: '在线客服', icon: Service,
        meta:{
          isExternal: false,
          isPhone: false
        }
      },
      { path: 'https://mail.qq.com',
        icon: Message,
        name: '邮箱联系',
        meta: {
          isExternal: true,
          isPhone: false
        }
      },
      { path: 'tel:18061209838', name: '电话联系', icon: Phone,
        meta: {
          isExternal: true,
          isPhone: true 
        }
      },
      { path: 'https://res.abeim.cn/api-qq.qun?qun=1036733598', name: 'QQ联系',
        meta: {
          isExternal: true,
          isPhone: false 
        }
      },
    ],
    meta:{
      isExternal: false,
      isPhone: false
    }
  },
  {
    path: '/website',
    name: '关于网站',
    icon: ChromeFilled,
    children: [
      { path: '/news/15', name: '服务条款',
        meta:{
          isExternal: false,
          isPhone: false
        }
      },
      { path: '/news/14', name: '隐私协议',
        meta:{
          isExternal: false,
          isPhone: false
        }
      },
      { path: '/news/16', name: '用户手册',
        meta:{
          isExternal: false,
          isPhone: false
        }
      },
    ],
    meta:{
      isExternal: false,
      isPhone: false
    }
  },
  {
    path: '/', name: '返回首页', icon: HomeFilled,
    meta:{
      isExternal: false,
      isPhone: false
    }
  }
]
:              // 作者路由
[
  {
    path: '/index',
    name: '个人中心',
    meta:{
      isExternal: false,
      isPhone: false
    }
  },
  {
    name: '新闻管理',
    icon: Management,
    children: [
      { path: '/addNews', name: '添加新闻', icon: Plus,
        meta:{
          isExternal: false,
          isPhone: false
        } 
      },
      { path: '/newsManage', name: '新闻列表', icon: List,
          meta:{
          isExternal: false,
          isPhone: false
        } 
      },
    ],
    meta:{
      isExternal: false,
      isPhone: false
    }
  },
  ...(info.value?.user_id===2 ? [{
        path: '/userManage', name: '用户管理',
        icon: List,
        meta:{
          isExternal: false,
          isPhone: false
        } 
      },
      {
        path: '/orderView', name: '订单管理',
        icon: List,
        meta:{
          isExternal: false,
          isPhone: false
        } 
      }
    ] : []),
  {
    path: '/contact',
    name: '联系我们',
    icon: Paperclip,
    children: [
      { path: '/getService', name: '在线客服', icon: Service,
        meta:{
          isExternal: false,
          isPhone: false
        }
      },
      { path: 'https://mail.qq.com',
        icon: Message,
        name: '邮箱联系',
        meta: {
          isExternal: true,
          isPhone: false
        }
      },
      { path: 'tel:18061209838', name: '电话联系', icon: Phone,
        meta: {
          isExternal: true,
          isPhone: true 
        }
      },
      { path: 'https://res.abeim.cn/api-qq.qun?qun=1036733598', name: 'QQ联系',
        meta: {
          isExternal: true,
          isPhone: false 
        }
      },
    ],
    meta:{
      isExternal: false,
      isPhone: false
    }
  },
  {
    path: '/website',
    name: '关于网站',
    icon: ChromeFilled,
    children: [
      { path: '/news/15', name: '服务条款',
        meta:{
          isExternal: false,
          isPhone: false
        }
      },
      { path: '/news/14', name: '隐私协议',
        meta:{
          isExternal: false,
          isPhone: false
        }
      },
      { path: '/news/16', name: '用户手册',
        meta:{
          isExternal: false,
          isPhone: false
        }
      },
    ],
    meta:{
      isExternal: false,
      isPhone: false
    }
  },
  {
    path: '/', name: '返回首页', icon: HomeFilled,
    meta:{
      isExternal: false,
      isPhone: false
    }
  }
]));

const vip_info = ref({
  isMember: true,
  days:0
})

const getVipInfo = async () => {
  if (typeof info.value?.user_id === 'number') {
    const { status, remainingDays } = await checkUserVipStatus(info.value.user_id)
    switch (status) {
      case VIP_STATUS.NOT_SUBSCRIBED:
        vip_info.value.isMember = false;
        break;
      case VIP_STATUS.EXPIRED:
        vip_info.value.isMember = true;
        vip_info.value.days = remainingDays;
        break;
      case VIP_STATUS.ACTIVE:
        vip_info.value.isMember = true;
        vip_info.value.days = remainingDays;
        break;
      case VIP_STATUS.ERROR:
        ElMessage.error('查询 VIP 状态失败');
        break;
    }
  }
}

const processedRoutes = computed(() => routes.value);

function handleSubscribe() {
}

const handlePhoneDial = (phoneNumber: string) => {
  const link = document.createElement('a');
  link.href = `tel:${phoneNumber}`;
  link.style.display = 'none';
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);

  if (!/Mobi|Android/i.test(navigator.userAgent)) {
    navigator.clipboard.writeText(phoneNumber).then(() => {
      ElMessage.success(`已复制号码 ${phoneNumber} 到剪贴板`);
    }).catch(() => {
      ElMessage.info(`联系电话：${phoneNumber}`);
    });
  }
};

function handleExternalClick(ChRoute: any) {
  if (ChRoute.meta?.isPhone) {
    handlePhoneDial(ChRoute.path.replace('tel:', ''));
  } else {
    window.open(ChRoute.path, '_blank', 'noopener,noreferrer');
  }
}

router.afterEach(() => {
  window.scrollTo(0, 0);
});

const isMenuOpen = ref<boolean[]>(new Array(routes.value.length).fill(false));

const toggleMenu = (index: number) => {
  isMenuOpen.value[index] = !isMenuOpen.value[index];
};

const currentPath = computed(() => route.path);
const isActive = (path: string) => currentPath.value === path;
const isActiveParent = (routeItem: any) => {
  return routeItem.children?.some((child: any) => isActive(child.path));
};

const handleClick = (path: string) => {
  emits('menuItemClick', path);
  if (window.innerWidth < 768) {
    const index = routes.value.findIndex(r => r.children?.some(c => c.path === path));
    if (index !== -1) {
      isMenuOpen.value[index] = false;
    }
  }
};

const handleLogout = () => {
  userStore.logout(router);
};

onMounted(()=>{
  getVipInfo()
  isAuthor.value = (info.value?.isAuthor==="TRUE")
})
</script>

<style scoped lang="scss">
$primary-color: #ffd700;
$hover-bg: rgba(255,215,0,0.1);
$active-bg: rgba(255,215,0,0.2);
$border-color: rgba(255,255,255,0.1);

.menu-container {
  background: linear-gradient(195deg, #2d2d2d, #1f1f1f);
  box-shadow: 
    4px 0 12px rgba(0,0,0,0.2),
    inset -1px 0 0 $border-color;
  transition: width 0.3s ease;
  position: relative;
  overflow: hidden;
  height: 100vh;
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(90deg, $primary-color 0%, transparent 100%);
    opacity: 0.3;
  }
}

.user-info {
  padding: 20px;
  background: rgba(0,0,0,0.2);
  border-bottom: 1px solid $border-color;
  backdrop-filter: blur(4px);
  display: none;
}

.user-avatar {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  border: 2px solid $primary-color;
  box-shadow: 0 0 12px rgba(255,215,0,0.2);
  transition: transform 0.3s ease;
  &:hover {
    transform: scale(1.05);
  }
}

.menu-item {
  position: relative;
  padding: 14px 24px;
  color: rgba(255,255,255,0.8);
  font-size: 16px;
  border-radius: 6px;
  margin: 4px 12px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  align-items: center;
  gap: 12px;
  &::before {
    content: '';
    position: absolute;
    left: -8px;
    width: 3px;
    height: 0;
    background: $primary-color;
    border-radius: 2px;
    transition: height 0.3s ease;
  }
  &:hover {
    background: $hover-bg;
    color: #fff;
    transform: translateX(8px);
    &::before {
      height: 60%;
    }
  }
  &.active {
    background: $active-bg !important;
    color: $primary-color !important;
    font-weight: 500;
    &::before {
      height: 100%;
    }
  }
  /* 添加菜单项激活时的移动过渡效果 */
  &.active,
  &:hover {
    transform: translateX(8px);
    transition: transform 0.3s ease;
  }
}

.user-details {
  display: flex;
  flex-direction: column;
  margin-left: 10px;
}

.user-name {
  color: #ccc;
  font-size: 16px;
  font-weight: bold;
}

.user-account {
  font-size: 14px;
  color: #ccc;
}

nav li {
  list-style: none;
  margin: 10px 0;
}

ul {
  padding: 0;
  max-width: 100%;
}

.toggle-icon {
  margin-left: auto;
  transition: transform 0.3s ease;
  .el-icon {
    color: rgba(255,255,255,0.5);
    font-size: 14px;
    transition: color 0.3s ease;
  }
  &:hover .el-icon {
    color: $primary-color;
  }
}

.sub-menu {
  margin: 4px 0 8px 36px;
  position: relative;
  &::before {
    content: '';
    position: absolute;
    left: 12px;
    top: 8px;
    bottom: 8px;
    width: 1px;
    background: $border-color;
  }
  /* 添加子菜单展开和收缩的过渡效果 */
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
}

.sub-menu-item {
  padding: 10px 30px;
  font-size: 14px;
  color: rgba(255,255,255,0.7);
  border-radius: 4px;
  position: relative;
  transition: all 0.2s ease;
  &::before {
    content: '';
    position: absolute;
    left: 8px;
    top: 50%;
    width: 6px;
    height: 6px;
    background: rgba(255,255,255,0.3);
    border-radius: 50%;
    transform: translateY(-50%);
    transition: background 0.3s ease;
  }
  &:hover {
    color: #fff;
    padding-left: 28px;
    background: rgba(255,255,255,0.05);
    &::before {
      background: $primary-color;
    }
    .submenu-icon {
      color: $primary-color;
    }
  }
  &.router-link-exact-active {
    color: $primary-color !important;
    font-weight: 500;
    .submenu-icon {
      color: $primary-color !important;
    }
  }
  /* 添加子菜单项激活时的移动过渡效果 */
  &.router-link-exact-active,
  &:hover {
    transform: translateX(4px);
    transition: transform 0.3s ease;
  }
}

.exit-icon {
  margin-left: auto;
  cursor: pointer;
  transition: transform 0.3s ease;
  padding: 5px;
}

.slide-enter-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
.slide-leave-active {
  transition: all 0.2s cubic-bezier(0.4, 0, 1, 1);
}
.slide-enter-from,
.slide-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

@media (max-width: 768px) {
  .menu-container {
    width: 100%;
    border-radius: 0;
    box-shadow: none;
    height: 100vh;
  }
  .user-name {
    font-size: 20px;
  }
  .user-account {
    font-size: 16px;
  }
  .user-info {
    display: flex;
    border-bottom: none;
  }
  .exit-icon {
    margin-left: 20px;
  }
  .menu-icon {
    font-size: 20px;
    margin-right: 15px;
  }
  .submenu-icon {
    font-size: 16px;
  }
  .menu-item {
    font-size: 18px;
  }
  .sub-menu {
    margin-left: 28px;
    &::before {
      left: 8px;
    }
  }
  .sub-menu-item {
    padding: 12px 60% 12px 10%;
    font-size: 15px;
  }
  nav li {
    list-style: none;
    margin: 15px 0;
    transition: transform 0.3s ease;
  }
}

.options-grid-wrapper::-webkit-scrollbar {
  width: 6px;
  background: rgba(0,0,0,0.2);
}

.options-grid-wrapper::-webkit-scrollbar-thumb {
  background: rgba(255,255,255,0.2);
  border-radius: 4px;
  &:hover {
    background: rgba(255,255,255,0.3);
  }
}

.menu-icon {
  font-size: 18px;
  color: rgba(255,255,255,0.8);
  margin-right: 12px;
  transition: color 0.3s ease;
}

.submenu-icon {
  font-size: 14px;
  color: rgba(255,255,255,0.6);
  margin-right: 8px;
  transition: color 0.3s ease;
}
</style>    