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
                <p class="instruction-text">请使用手机QQ扫描二维码完成付款</p>
            </div>
            <div class="finish-button" @click="handlePaymentComplete">
                <span class="back-text">我已完成支付</span>
                <span class="next-icon"></span>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ElMessage } from 'element-plus';
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios'; // 引入 axios 用于发送请求

const route = useRoute();
const router = useRouter();
const amount = ref(0.00);
const qrcodeImages = [
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkYnNmvvwYgZEIgODc3NGUzNTE0ZDA0Y2UzZDVjOTc0NDc5NDRmYjU3MDU_3D_xxx_sign.png',
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkY69mvvwYg2ARCIDZjODNiYTFjYmJjOGE3ODFjZDI1ZTcwMTVmODI2M2Q4_xxx_sign.png',
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkYq96vvwYg6AdCIDU1ODk2MGJjY2NjZjdhNTg2YmVhZmJiM2UyNDU3YmJi_xxx_sign.png',
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkYjdqvvwYguBdCIDJlYWM4MzVmZWMyMjY4MTM2NWMwYzdiMWMwZTllN2Uw_xxx_sign.png',
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkYn9qvvwYggDJCIDA3OTE4MDU2ZjYxOTE5YTMxMDA3MzViMGUwOTkzYzQw_xxx_sign.png',
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkYsdqvvwYggGRCIDQzMzRlY2RkZmJhZDFkNWRiNTVhNjIwYWM3YmRjZjQ0_xxx_sign.png',
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkYzdqvvwYgoIMBQiAwMTVjNGQ3MzQxYmU5OGI2NjFmM2VkN2YzY2FlNTcwNg_3D_3D_xxx_sign.png',
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkY99qvvwYgkJYCQiA3OTViYTg4ZTFiZTllMzMxNTUwMzE2NWE1MGFhNzhiZA_3D_3D_xxx_sign.png',
    'src/assets/imges/https___i.qianbao.qq.com_wallet_sqrcode.htm_m=tenpay&f=wallet&a=1&u=2473228344&n=.&ac=CAEQuPCpmwkYjtuvvwYgoI0GQiAyMWRjNjI1ZjE0ZDNlOWQ3NjI3MDhkZDM0MjQwOGJiNQ_3D_3D_xxx_sign.png',
];

const imageLoaded = ref(false);

const handleBack = () => {
    router.go(-1); // 返回上一页
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

onMounted(() => {
    amount.value = parseFloat(route.query.amount as string) || 0.00;
    ElMessage.warning(`请您核对支付金额和订单详情！`)
});
</script>
  
<style scoped lang="scss">
.payment-container {
    background-image: url("http://192.168.124.5:8080/static/news-images/20250401215412988_a5f57d4d.png");
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
            color: #12B6F4;
        }

        .arrow-icon {
            border-color: #12B6F4;
        }
    }
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
            color: #12B6F4;
        }

        .arrow-icon {
            border-color: #12B6F4;
        }
    }
}

.arrow-icon {
    width: 12px;
    height: 12px;
    border: 2px solid #12B6F4;
    border-right: 0;
    border-top: 0;
    transform: rotate(45deg);
    transition: border-color 0.3s;
}

.next-icon {
    width: 12px;
    height: 12px;
    border: 2px solid #12B6F4;
    border-left: 0;
    border-bottom: 0;
    transform: rotate(45deg);
    transition: border-color 0.3s;
}

.back-text {
    color: #12B6F4;
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
    background-image: url("http://192.168.124.5:8080/static/news-images/20250401215452603_fcb1a7fb.png");
    background-size: contain;
    background-position: center;
    background-repeat: no-repeat;
}
  
.amount-container {
    text-align: center;
}
  
.currency {
    color: #12B6F4;
    font-size: 25px;
    font-weight: 500;
    margin-right: 8px;
}
  
.amount {
    color: #12B6F4;
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

.payment-complete-button {
    background-color: #12B6F4;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;

    &:hover {
        background-color: #0e9ad0;
    }
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