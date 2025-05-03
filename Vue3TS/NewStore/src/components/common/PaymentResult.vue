<template>
    <div class="payment-result">
        <div v-if="isLoading" class="loading-spinner">
            <div class="spinner"></div>
            <p>加载中...</p>
        </div>
        <div v-else class="result-container">
            <div v-if="status === 'success'">
                <el-result
                    icon="success"
                    title="支付成功"
                    sub-title="感谢您的支持"
                >
                    <template #extra>
                        <el-button type="primary" @click="goBack">返回</el-button>
                    </template>
                </el-result>
            </div>
            <div v-else-if="status === 'error'">
                <el-result
                    icon="error"
                    title="支付失败"
                    sub-title="请重试或联系客服"
                >
                    <template #extra>
                        <el-button type="primary" @click="goBack">返回</el-button>
                    </template>
                </el-result>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue';
import axios from 'axios';
import { useRouter } from 'vue-router';
import { initialURL } from '@/lib/urls';
import { ElMessage } from 'element-plus';

export default defineComponent({
    setup() {
        const status = ref("error");
        const isLoading = ref(true);
        const router = useRouter();

        const verifyPaymentResult = async (outTradeNo: string | null) => {
            if (!outTradeNo) {
                ElMessage.error('支付结果无效');
                return;
            }
            try {
                const response = await axios.get(`${initialURL.SERVER_URL}/api/pay/verify`, {
                    params: { outTradeNo },
                });
                if (!response.data.success) {
                    ElMessage.error('支付失败，请重试');
                } else {
                    ElMessage.success('支付成功！');
                    status.value = 'success';
                }
            } catch (error) {
                ElMessage.warning('支付结果验证失败，请联系客服');
                if (axios.isAxiosError(error)) {
                    if (error.response) {
                        ElMessage.error(`支付结果验证失败，状态码：${error.response.status}`);
                    } else if (error.request) {
                        ElMessage.error('支付结果验证失败，未收到服务器响应');
                    }
                } else if (error instanceof Error) {
                    ElMessage.error(`支付结果验证失败: ${error.message}`);
                }
            }
        };

        const getHashParams = () => {
            const hash = window.location.hash.split('?')[1];
            return new URLSearchParams(hash);
        };

        onMounted(async () => {
            const params = getHashParams();
            const outTradeNo = params.get('out_trade_no');
            await verifyPaymentResult(outTradeNo);
            isLoading.value = false;
        });

        const goBack = () => {
            router.push('/');
        };

        return {
            isLoading,
            status,
            goBack
        };
    },
});
</script>

<style scoped>
.payment-result {
    text-align: center;
    padding: 50px;
}

.success {
    color: green;
}

.error {
    color: red;
}

.loading-spinner {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.spinner {
    border: 4px solid rgba(0, 0, 0, 0.1);
    border-left-color: #000;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    animation: spin 1s linear infinite;
    margin-bottom: 10px;
}

@keyframes spin {
    to {
        transform: rotate(360deg);
    }
}

.result-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: calc(100vh - 100px); /* 减去上下 padding 的高度 */
}
</style>    