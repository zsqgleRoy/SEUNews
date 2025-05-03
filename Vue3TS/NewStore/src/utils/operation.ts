import { useRouter } from 'vue-router';
import { ElMessage } from "element-plus";
const router = useRouter();
// 退出登录处理函数
export const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("userInfo");
    ElMessage.success('退出登录成功');
    // 跳转到登录页面
    router.push("/home");
};