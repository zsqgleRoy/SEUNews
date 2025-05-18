<template>
    <div class="payment-container">
        <div class="payment-card">
            <div class="back-button" @click="handleBack">
                <span class="arrow-icon"></span>
                <span class="back-text">返回</span>
            </div>
            <h1 class="icon"></h1>
            <div class="amount-container">
                <span class="currency">¥</span>
                <span class="amount">{{ amount.toFixed(2) }}</span>
            </div>
            <div class="qrcode-container">
                <img 
                    :src="getQrcodeImage()" 
                    alt="支付二维码"
                    class="qrcode-image"
                    @load="handleImageLoad"
                />
                <div v-if="!imageLoaded" class="loading-overlay">
                    <div class="loading-spinner"></div>
                </div>
            </div>
            <div class="instruction-container">
                <p class="instruction-text">请使用手机微信扫描二维码完成支付</p>
            </div>
            <div class="finish-button" @click="handlePaymentComplete">
                <span class="back-text">我已完成支付</span>
                <span class="next-icon"></span>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import axios from 'axios';
import { ElMessage } from 'element-plus';
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
const route = useRoute();
const router = useRouter();
const amount = ref(0);
const qrcodeImages = [
    'src/assets/imges/wxp___f2f1IheiyMwpz-bjJ4akchULPYJymXDhl7gpt7bBW3AXbP0QQjJRfIL2AOdq8c3nPbFD.png',
    'src/assets/imges/wxp___f2f1g_CUK1_hFqZGMX46xJm7CUhDFx8Ew6_Xawy01y1VI2VO3ht42aYmuW4rN-huyq_5.png',
    'src/assets/imges/wxp___f2f1SRtAQ1KVfSNUOazueme_tdwFs75GomzkfpBQG3E-qSXINrKhLWKTesOy3EdFcZdu.png',
    'src/assets/imges/wxp___f2f14YhhLZR7n9ALiS69Wj8S_K_LSdeMdeJl1fEE22iko_qFlsWX1NyDloCVgKXONUNd.png',
    'src/assets/imges/wxp___f2f1lkEh0ZnqJ_rlidjwJqQNsTBRjrCSluyRk09FdQq2m9oYA_ivm6x8Ybdu9vGOZnYH.png',
    'src/assets/imges/wxp___f2f1bfEN-JEqHjLOXl8m68H8vngOzq_aGL3ARhhd7MDSGrQP4IafZDhvH6JJccEVvuu0.png',
    'src/assets/imges/wxp___f2f1jufVsUJOuQrb_Iw3QDYX40YQQTmrpk4U3ey8sj9R9lWlJjregfbu-rDMQO4zfVts.png',
    'src/assets/imges/wxp___f2f1bMW9PEUg4rfiGPSr1CrHqWiU9oNWLGFIuV_mYDvqXsUWSwn3eSmCcpLiK0B2o1aI.png',
    'src/assets/imges/wxp___f2f112-Ct0GNMKSzS3RdXYuocEPUCFa24hiVUyd_9xkUTgdsRV3GLa8WVyzC11LuhSXG.png',
];

const imageLoaded = ref(false);

const handleBack = () => {
    router.go(-1); // 返回上一页
};

const handlePaymentComplete = async () => {
    try {
        // 假设后端接口地址为 /api/payment/complete，你需要根据实际情况修改
        const response = await axios.post('/api/payment/complete', {
            amount: amount.value,
            // 可以根据需要添加其他参数
        });
        if (response.data.success) {
            ElMessage.success('支付完成，感谢您的支持！');
            // 支付成功后可以跳转到相应页面，这里假设跳转到首页
            router.push('/'); 
        } else {
            ElMessage.error('支付状态验证失败，请稍后重试！');
        }
    } catch (error) {
        ElMessage.error('请求出错，请稍后重试！');
        console.error('支付完成请求出错:', error);
    }
};

const handleImageLoad = () => {
    imageLoaded.value = true;
};

const getQrcodeImage = () => {
    const securityMessage = sessionStorage.getItem('securityMessage');
    let index = parseInt(securityMessage || '0');
    if (isNaN(index) || index < 0 || index >= qrcodeImages.length) {
        index = 0;
    }
    return qrcodeImages[index];
};

onMounted(() => {
    amount.value = parseFloat(route.query.amount as string) || 0;
    ElMessage.warning(`请您核对支付金额和订单详情！`)
});
</script>
  
<style scoped lang="scss">
.payment-container {
    background-image: url("http://192.168.124.5:8080/static/news-images/20250401211855154_1bfa8466.jpg");
    user-select: none;
    width: 100vw;
    height: 100vh;
    background-color: #f5f7fa;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 2rem;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
}
  
  .payment-card {
    position: relative;
    background: white;
    border-radius: 16px;
    padding: 40px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
    max-width: 100vw;
    max-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  
    .back-button {
        position: absolute;
        top: 20px;
        left: 20px;
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        padding: 8px 12px;
        border-radius: 8px;

        &:hover {
            transform: translateX(-4px);

            .back-text {
                color: #26c22b;
            }

            .arrow-icon {
                border-color: #26c22b;
            }
        }
    }
    .arrow-icon {
        width: 12px;
        height: 12px;
        border: 2px solid #4caf50;
        border-right: 0;
        border-top: 0;
        transform: rotate(45deg);
        transition: border-color 0.3s;
    }

    .back-text {
        color: #4caf50;
        font-size: 14px;
        font-weight: 500;
        transition: color 0.3s;
    }

  .icon {
    color: #1a237e;
    font-size: 24px;
    font-weight: 600;
    width: 140px;
    min-height: 32px;
    text-align: center;
    background-image: url("http://192.168.124.5:8080/static/news-images/20250401194353813_47c2eb7f.png");
    background-size: contain;
    background-position: center;
}
  
  .amount-container {
    text-align: center;
  }
  
  .currency {
    color: #4caf50;
    font-size: 25px;
    font-weight: 500;
    margin-right: 8px;
  }
  
  .amount {
    color: #4caf50;
    font-size: 36px;
    font-weight: 700;
  }
  
  .qrcode-container {
    position: relative;
    margin: 0 0 0rem 0;
    padding: 16px;
    background: #f8f9fc;
    border-radius: 8px;
    display: flex;
    justify-content: center;
    max-width: 100%;
  }
  
  .qrcode-image {
    width: 100%;
    max-width: 250px;
    height: auto;
    border-radius: 4px;
  }
  
  .loading-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.8);
    display: flex;
    justify-content: center;
    align-items: center;
  }
  
  .loading-spinner {
    width: 40px;
    height: 40px;
    border: 4px solid #f3f3f3;
    border-top: 4px solid #1a237e;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }
  
  .finish-button {
        position: absolute;
        bottom: 4%;
        right: 32%;
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        padding: 8px 12px;
        border-radius: 8px;

        &:hover {
            transform: translateX(-4px);

            .back-text {
                color: #4caf50;
            }

            .arrow-icon {
                border-color: #4caf50;
            }
        }
    }

    .next-icon {
        width: 12px;
        height: 12px;
        border: 2px solid #4caf50;
        border-left: 0;
        border-bottom: 0;
        transform: rotate(45deg);
        transition: border-color 0.3s;
    }
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
  
  .instruction-container {
    text-align: center;
  }
  
  .instruction-text {
    color: #455a64;
    font-size: 16px;
    margin-bottom: 1rem;
  }
  
  @media (max-width: 480px) {
    .payment-card {
      padding: 24px;
    }
    
    .amount {
      font-size: 28px;
    }
  }
</style>