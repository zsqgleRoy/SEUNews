import { ref, onMounted } from 'vue';
import axios, { type AxiosRequestConfig } from 'axios';

export const useFetch = <T>(url: string, options: AxiosRequestConfig = {}) => {
    // 定义响应数据
    const data = ref<T | null>(null);
    // 定义加载状态
    const isLoading = ref<boolean>(true);
    // 定义错误信息
    const error = ref<string | null>(null);

    const fetchData = async () => {
        try {
            const response = await axios(url, options);
            data.value = response.data;
        } catch (err: any) {
            error.value = err.message;
        } finally {
            isLoading.value = false;
        }
    };

    onMounted(() => {
        fetchData();
    });

    return {
        data,
        isLoading,
        error,
        refetch: fetchData
    };
};
