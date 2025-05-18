// src/store/userStore.ts
import { ElMessage } from 'element-plus';
import { defineStore } from 'pinia';
import { ref, computed } from 'vue';
import userCache, { type UserInfo } from '@/cache/userCache';

export const useUserStore = defineStore('user', () => {
  const userInfo = ref<UserInfo | null>(userCache.getUserCache());
  const isLoggedIn = computed(() => !!userInfo.value);

  const login = (user: UserInfo) => {
    userInfo.value = user;
    userCache.saveUserCache(user);
    ElMessage.success('登录成功！');
  };

  const logout = (router: any) => { // 接收 router 参数
    userInfo.value = null;
    userCache.clearUserCache();
    ElMessage.success('退出登录成功！');
    router.push('/home');
  };

  return {
    userInfo,
    isLoggedIn,
    login,
    logout
  };
});