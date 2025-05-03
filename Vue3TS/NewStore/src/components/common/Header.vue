<template>
  <nav class="navbar">
    <div class="navbar-logo">
      <router-link to="/" class="navbar-logo">
        <img alt="Logo" src="/src/assets/imges/seu.png">
      </router-link>
      <div class="title">
        <SEUNews></SEUNews>        
      </div>

    </div>

    <div class="search-wrapper">
      <Search @search="handleSearch" />
    </div>
    <div @click="openLoginModal">
      <el-avatar
        :icon="userItems?.avatar ? null : UserFilled"
        :src="userItems?.avatar ? userItems.avatar : null"
      />
    </div>
  </nav>
  <div v-if="showLoginModal" class="login-modal">
    <div class="modal-overlay" @click="closeLoginModal"></div>
    <div class="modal-content">
      <Login @close="closeLoginModal" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { useRouter } from 'vue-router';
import Search from '@/components/common/search/Search.vue';
import userCache from '@/cache/userCache';
import Login from "@/views/user/Login.vue";
import { UserFilled } from '@element-plus/icons-vue';
import SEUNews from "./Title.vue"
const isMobile = ref(window.innerWidth < 768);
const router = useRouter();
const userItems = ref([]) as any;
const showLoginModal = ref(false);

const handleSearch = (event: CustomEvent) => {
  const query = event.detail;
  console.log('搜索内容:', query);
};

const closeLoginModal = () => {
  showLoginModal.value = false;
};

// 打开登录弹窗
const openLoginModal = () => {
  if (userItems?.value?.avatar) {
    if (isMobile.value) {
      router.push('/myHome');
    } else {
      router.push('/index');
    }
    return;
  }
  showLoginModal.value = true;
};

// 监听ESC键
const onKeyDown = (event: KeyboardEvent) => {
  if (event.key === 'Escape' && showLoginModal.value) {
    closeLoginModal();
  }
};

// 监听窗口大小变化
const handleResize = () => {
  isMobile.value = window.innerWidth < 768;
};

onMounted(() => {
  userItems.value = userCache.getUserCache();
  window.addEventListener('keydown', onKeyDown);
  window.addEventListener('resize', handleResize);
});

onUnmounted(() => {
  window.removeEventListener('keydown', onKeyDown);
  window.removeEventListener('resize', handleResize);
});
</script>

<style scoped lang="scss">
.navbar {
  user-select: none;
  height: 60px;
  width: 100vw;
  display: flex;
  align-items: center;
  gap: 20px;
  background: linear-gradient(135deg, #174fa9, #6b00bcae);
  padding: 5px 30px;
  position: relative;
  justify-content: space-between;

  .title{
    max-width: 256px;
    max-height: 60px;
  }

  // 移动端适配
  @media (max-width: 768px) {
    padding: 10px 10px;
    gap: 10px;
    .title{
      max-width: 100%;
    }
  }

  // 确保子元素垂直居中
  > * {
    display: flex;
    align-items: center;
  }
}

.navbar-logo {
  flex: 0 0 auto;
  display: flex;
  align-items: center;
  width: auto;
  max-height: 60px;

  img {
    max-width: auto;
    max-height: 50px;
    transition: transform 0.3s ease;
    object-fit: contain;
  }
}

.search-wrapper {
  flex: 0 1 0vw;
  margin-left: auto;
  margin-right: 0px;

  @media (max-width: 768px) {
    margin-right: 0px !important;
  }
}

/* 头像容器样式 */
.el-avatar {
  cursor: pointer;
  transition: all 0.3s ease;

  &:hover {
    transform: scale(1.1);
    box-shadow: 0 0 10px rgba(255,255,255,0.3);
  }
}

/* 头像容器样式 */
div[onclick="openLoginModal"] {
  display: flex;
  align-items: center;
}

/* 登录弹窗样式 */
.login-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1000;
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-overlay {
  position: absolute;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
  position: relative;
  z-index: 1001;
  padding: 0rem;
  border-radius: 0px;
  width: 100%;
  max-width: 400px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
}

@media (max-width: 768px) {
  .navbar {
    width: 100vw;
  }
}
</style>    