<template>
  <nav class="navbar">
    <div class="navbar-logo">
      <router-link to="/">
        <img alt="Logo" src="../components/icons/seuLogo.png">
      </router-link>
    </div>

    <div class="search-wrapper">
      <Search @search="handleSearch" />
    </div>

    <div ref="toggleRef" class="navbar-toggle" @click="toggleMenu" :class="{ 'open': isMenuOpen }">
      <span></span>
      <span></span>
      <span></span>
    </div>

    <!-- 侧边栏菜单 -->
    <div ref="menuRef" class="navbar-sidebar" :class="{ 'active': isMenuOpen }">
      <ul class="navbar-menu">
        <li v-for="menuItem in menuItems" :key="menuItem.path">
          <router-link :to="menuItem.path" :class="{ 'active-link': $route.path === menuItem.path }" @click="closeMenuIfMobile">
            {{ menuItem.label }}
          </router-link>
        </li>
      </ul>
    </div>
    <!-- 大屏幕显示的水平菜单 -->
    <ul class="navbar-menu-desktop">
      <li v-for="menuItem in menuItems" :key="menuItem.path">
        <router-link :to="menuItem.path" :class="{ 'active-link': $route.path === menuItem.path }">
          {{ menuItem.label }}
        </router-link>
      </li>
    </ul>
  </nav>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { useRoute } from 'vue-router';
import Search from '@/components/common/search/Search.vue';
import { getMenuItemList } from "@/api/menu"

const isMenuOpen = ref(false);
const route = useRoute();
const toggleRef = ref<HTMLDivElement | null>(null);
const menuRef = ref<HTMLDivElement | null>(null);
const error = ref("");
const isLoading = ref(true);
const menuItems = ref([]) as any;


// 获取新闻列表的函数
const fetchMenuItems = async () => {
  try {
    const response = await getMenuItemList();
    menuItems.value = response.data;
  } catch (err: any) {
    error.value = err.message || '获取导航栏列表失败';
  } finally {
    isLoading.value = false;
  }
};

const handleSearch = (event: CustomEvent) => {
  event.detail;
};

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value;
  if (toggleRef.value || menuRef.value) {
  }
};

const closeMenuIfMobile = () => {
  if (isMenuOpen.value) {
    isMenuOpen.value = false;
  }
};

const closeMenuOnOutsideClick = (event: MouseEvent) => {
  if (isMenuOpen.value) {
    const target = event.target as HTMLElement;
    if (
      toggleRef.value &&
      menuRef.value &&
      !toggleRef.value.contains(target) &&
      !menuRef.value.contains(target)
    ) {
      isMenuOpen.value = false;
    }
  }
};

onMounted(() => {
  fetchMenuItems();
  window.addEventListener('click', closeMenuOnOutsideClick);
});

onUnmounted(() => {
  window.removeEventListener('click', closeMenuOnOutsideClick);
});
</script>

<style scoped>
.navbar {
  user-select: none;
  -moz-user-select: none;
  position: fixed;
  height: 100px;
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  /* 修改渐变方向为垂直向下，并设置透明度渐变 */
  background-color: #333;
  color: white;
  padding: 10px 20px;
  z-index: 10;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.navbar-logo {
  display: flex;
  align-items: center;
  gap: 10px;
}

.navbar-logo img {
  width: 40px;
  height: 40px;
  object-fit: contain;
  padding-top: 5px;
}

.logo-text {
  font-size: 18px;
  font-weight: bold;
}

.search-wrapper {
  flex: 1;
  max-width: 300px;
  max-height: 50px;
  margin-right: 5px;
}

.navbar-toggle {
  display: none;
  flex-direction: column;
  gap: 5px;
  cursor: pointer;
  transition: transform 0.3s ease;
}

.navbar-toggle span {
  width: 25px;
  height: 3px;
  background-color: white;
  border-radius: 3px;
  transition: transform 0.3s ease, background-color 0.3s ease;
}

.navbar-toggle:hover {
  transform: scale(1.1);
}

.navbar-toggle:hover span {
  background-color: #ffd700;
}

.navbar-toggle.open span:nth-child(1) {
  transform: rotate(45deg) translate(5px, 5px);
}

.navbar-toggle.open span:nth-child(2) {
  opacity: 0;
}

.navbar-toggle.open span:nth-child(3) {
  transform: rotate(-45deg) translate(7px, -6px);
}

/* 侧边栏菜单样式 */
.navbar-sidebar {
  position: fixed;
  top: 0;
  left: -250px; /* 初始隐藏在左侧 */
  width: 250px;
  height: 100%;
  background-color: rgba(185, 0, 8, 0.9);
  transition: left 0.3s ease;
  z-index: 9;
  padding-top: 60px; /* 避免与导航栏重叠 */
  transition: left 0.3s cubic-bezier(0.4, 0, 0.2, 1); /* 添加缓动效果 */
}

.navbar-sidebar.active {
  left: 0; /* 显示侧边栏 */
}

.navbar-menu {
  list-style-type: none;
  display: flex;
  flex-direction: column;
  gap: 20px;
  margin: 0;
  padding: 20px;
  opacity: 0;
  transform: translateX(-20px);
  transition: opacity 0.4s ease, transform 0.4s ease;
}

.navbar-sidebar.active .navbar-menu {
  opacity: 1;
  transform: translateX(0);
}

.navbar-menu li {
  opacity: 0;
  transform: translateX(-30px) scale(0.95);
  transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1), transform 0.3s ease;
  will-change: transform, opacity;
}

.navbar-sidebar.active .navbar-menu li {
  opacity: 1;
  transform: translateX(0) scale(1);
}

.navbar-menu li:hover {
  transform: translateX(20px) scale(1.05);
}

/* 延迟设置 */
.navbar-menu li:nth-child(1) { transition-delay: 0.2s; }
.navbar-menu li:nth-child(2) { transition-delay: 0.4s; }
.navbar-menu li:nth-child(3) { transition-delay: 0.6s; }
.navbar-menu li:nth-child(4) { transition-delay: 0.8s; }
.navbar-menu li:nth-child(5) { transition-delay: 0.10s; }
.navbar-menu li:nth-child(6) { transition-delay: 1.2s; }
.navbar-menu li:nth-child(7) { transition-delay: 1.4s; }
.navbar-menu li:nth-child(8) { transition-delay: 1.6s; }

@media (max-width: 480px) {
  .navbar{
    width: 100%;
  }
  .navbar-menu li {
    transition-duration: 0.6s;
    
  }
  .navbar-menu li:nth-child(n) {
    transition-delay: calc(0.1s * (n - 1));
  }
}

.navbar-menu li a {
  color: white;
  text-decoration: none;
  padding: 8px 15px;
  border-radius: 5px;
  transition: all 0.3s ease;
  display: block;
}

.navbar-menu li a:hover {
  color: #ffd700;
  background-color: rgba(255, 255, 255, 0.1);
}

.active-link {
  color: #ffd700 !important;
  background-color: rgba(255, 255, 255, 0.2) !important;
  transform: translateY(-2px);
}

/* 大屏幕显示的水平菜单 */
.navbar-menu-desktop {
  list-style-type: none;
  display: flex;
  gap: 20px;
  margin: 0;
  padding: 0;
}

img {
    max-width: 100%;
    height: auto;
  }

.navbar-menu-desktop li a {
  color: white;
  text-decoration: none;
  padding: 8px 15px;
  border-radius: 5px;
  transition: all 0.3s ease;
}

.navbar-menu-desktop li a:hover {
  color: #ffd700;
  background-color: rgba(255, 255, 255, 0.1);
}

@media (max-width: 768px) {
  .navbar {
    width: 100%;
  }
  img {
    max-width: 100%;
    height: auto;
  }

  .search-wrapper {
    max-width: 200px;
    margin: 0 10px 10px 10px;
  }

  .navbar-toggle {
    display: flex;
  }

  .navbar-menu-desktop {
    display: none;
  }
}

@media (min-width: 769px) {
  .navbar-sidebar {
    display: none;
  }

  .navbar-toggle {
    display: none;
  }
}
</style>