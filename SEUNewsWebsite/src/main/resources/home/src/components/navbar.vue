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

    <ul ref="menuRef" :class="{ 'navbar-menu': true, 'active': isMenuOpen }">
      <li v-for="menuItem in menuItems" :key="menuItem.path">
        <router-link :to="menuItem.path" :class="{ 'active-link': $route.path === menuItem.path }" @click="closeMenuIfMobile">
          {{ menuItem.label }}
        </router-link>
      </li>
    </ul>
  </nav>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRoute } from 'vue-router';
import Search from '@/components/Search.vue';

const isMenuOpen = ref(false);
const route = useRoute();
const toggleRef = ref<HTMLDivElement | null>(null);
const menuRef = ref<HTMLUListElement | null>(null);

const menuItems = [
  { path: '/', label: '首页' },
  { path: '/shiSiDa', label: '十四大' },
  { path: '/xiYu', label: '习语' },
  { path: '/science', label: '科技' },
  { path: '/economic', label: '经济' },
  { path: '/minSheng', label: '民生' },
  { path: '/enthusiastic', label: '娱乐' },
  { path: '/junShi', label: '军事' }
];

const handleSearch = (event: CustomEvent) => {
  const query = event.detail;
  console.log('搜索内容:', query);
};

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value;
  if (toggleRef.value && menuRef.value) {
    // 可以添加更多逻辑
  }
};

const closeMenuIfMobile = () => {
  if (isMenuOpen.value) {
    isMenuOpen.value = false;
  }
};
</script>

<style scoped>
.navbar {
  height: 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: linear-gradient(45deg, rgb(185, 0, 8), rgb(220, 0, 10));
  color: white;
  padding: 10px 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  position: relative;
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

.navbar-menu {
  list-style-type: none;
  display: flex;
  gap: 20px;
  margin: 0;
  padding: 0;
}

.navbar-menu li a {
  color: white;
  text-decoration: none;
  padding: 8px 15px;
  border-radius: 5px;
  transition: all 0.3s ease;
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

@media (max-width: 768px) {
  .search-wrapper {
    max-width: 200px;
    margin: 0 10px;
  }

  .navbar-toggle {
    display: flex;
  }

  .navbar-menu {
    display: none;
    position: absolute;
    top: 60px;
    left: 0;
    width: 100%;
    background-color: rgba(185, 0, 8, 0.9);
    flex-direction: column;
    align-items: center;
    gap: 10px;
    padding: 10px 0;
    box-shadow: 0 2px 4px rgba(255, 255, 255, 0.1);
  }

  .navbar-menu.active {
    display: flex;
  }
}

@media (min-width: 769px) {
  .navbar-menu {
    display: flex !important;
  }
}
</style>
