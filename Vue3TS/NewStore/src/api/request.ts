import axios, { type AxiosInstance, type AxiosRequestConfig, type AxiosResponse, type InternalAxiosRequestConfig } from 'axios';
import { ElMessage } from 'element-plus'; 
import { initialURL } from "@/lib/urls"

// 创建 Axios 实例
const service: AxiosInstance = axios.create({
    baseURL: initialURL.SERVER_URL, 
    timeout: 5000, 
    withCredentials: true 
});

// 请求拦截器
service.interceptors.request.use(
    (config: InternalAxiosRequestConfig) => {
        const token = localStorage.getItem('token');
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        }
        return config;
    },
    (error: any) => {
        console.error('请求错误:', error);
        return Promise.reject(error);
    }
);

// 响应拦截器
service.interceptors.response.use(
    (response: AxiosResponse) => {
        const res = response;
        // 根据实际接口返回的数据结构调整判断逻辑
        if (res.data && res.data.code && res.data.code !== 200) { 
            ElMessage.error(res.data.message || '请求失败，请稍后重试');
            return Promise.reject(new Error(res.data.message || '请求失败，请稍后重试'));
        }
        return res;
    },
    (error: any) => {
        if (error.response) {
            switch (error.response.status) {
                case 401:
                    ElMessage.error('未授权，请登录');
                    break;
                case 404:
                    ElMessage.error('请求的资源未找到，请检查请求路径');
                    break;
                case 500:
                    ElMessage.error('服务器内部错误，请稍后重试');
                    break;
                default:
                    ElMessage.error('请求失败，请稍后重试');
            }
        } else {
            ElMessage.error('网络连接错误，请检查网络设置');
        }
        return Promise.reject(error);
    }
);

export default service;    