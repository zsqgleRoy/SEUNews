// stores/user.ts
import { ref, computed } from 'vue';
interface UserInfo {
    username: string;
    email: string;
    registerDate: string;
    avatar:string;
    isAuthor:string;
}



const useUserInfo = () => {
    // 从 localStorage 中获取用户信息
    const storedUserInfo = localStorage.getItem('userInfo');
    // 解析用户信息
    const userStore = ref(storedUserInfo ? JSON.parse(storedUserInfo) : null);

    // 创建计算属性
    const userInfo = computed<UserInfo | null>(() => userStore.value as UserInfo | null);

    const info = ref({
        username: computed(() => userInfo.value?.username),
        email: computed(() => userInfo.value?.email),
        phone: '',
        address: '',
        avatar: computed(() => userInfo.value?.avatar),
    });

    return {
        userInfo,
        info
    };
};

export default useUserInfo;