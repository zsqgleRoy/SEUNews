<template>
    <div v-if="data" class="button-container">
        <el-button 
            :loading="isLoading"
            @click="handlePay"
            class="black-gold-button"
        >
            <div class="button-content" v-if="!isLoading">
                <aliPay class="svglogo"/>
                <span>{{ isLoading ? '支付处理中...' : '支付宝支付' }}</span>
            </div>
        </el-button>

        <el-button 
            :loading="isLoading"
            @click="WeChatPayM"
            class="black-gold-button"
        >
            <div class="button-content" v-if="!isLoading">
                <WeChatPay class="svglogo"/>
                <span>{{ isLoading ? '支付处理中...' : '微信支付' }}</span>
            </div>
        </el-button>

        <el-button 
            :loading="isLoading"
            @click="QQPayM"
            class="black-gold-button"
        >
            <div class="button-content" v-if="!isLoading">
                <QQPay class="svglogo"/>
                <span>{{ isLoading ? '支付处理中...' : 'QQ支付' }}</span>
            </div>
        </el-button>

        <el-button 
            :loading="isLoading"
            @click="GSPayM"
            class="black-gold-button"
        >
            <div class="button-content" v-if="!isLoading">
                <GSPay class="svglogo"/>
                <span>{{ isLoading ? '支付处理中...' : '工商银行' }}</span>
            </div>
        </el-button>

        <el-button 
            :loading="isLoading"
            @click="SZRMBPayM"
            class="black-gold-button"
        >
            <div class="button-content" v-if="!isLoading">
                <SZRMBPay class="svglogo"/>
                <span>{{ isLoading ? '支付处理中...' : '数字人民币' }}</span>
            </div>
        </el-button>
    </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import axios from 'axios';
import { initialURL } from '@/lib/urls';
import { ElMessage } from 'element-plus';
import aliPay from "@/components/svg/alipay.vue"
import WeChatPay from "@/components/svg/WeChat.vue"
import QQPay from "@/components/svg/QQ.vue"
import GSPay from "@/components/svg/GS.vue"
import SZRMBPay from "@/components/svg/SZRMB.vue"
import { useRouter } from 'vue-router';
import userCache, { type UserInfo } from '@/cache/userCache';

const props = defineProps({
    data: {
        type: Number,
        required: true
    }
});

const router = useRouter();
const isLoading = ref(false);
const errorMessage = ref('');

const handlePayment = (path: string) => {
    sessionStorage.setItem('securityMessage', String(props.data));
    router.push({
        path,
        query: { amount: props.data }
    });
};

const handlePay = async () => {
    isLoading.value = true;
    errorMessage.value = '';
    try {
        const response = await axios.post(`${initialURL.SERVER_URL}/api/pay/alipay`, { uid: userCache.getUserCache()?.user_id,amount: props.data });
        const payFormHtml = response.data;

        const parser = new DOMParser();
        const doc = parser.parseFromString(payFormHtml, 'text/html');
        const form = doc.querySelector('form');

        if (form) {
            document.body.appendChild(form);
            form.submit();
            form.remove();
        }
    } catch (error: any) {
        if (error.response) {
            ElMessage.error(`请求失败，状态码: ${error.response.status}，错误信息: ${error.response.data}`);
        } else if (error.request) {
            ElMessage.warning('糟糕，请求已经发送，似乎没有收到响应');
        } else {
            ElMessage.error(`发生错误: ${error.message}`);
        }
    } finally {
        isLoading.value = false;
    }
};

const WeChatPayM = () => handlePayment('/WeChatPay');
const QQPayM = () => handlePayment('/QQPay');
const GSPayM = () => handlePayment('/GSPay');
const SZRMBPayM = () => handlePayment('/SZRMBPay');
</script>

<style scoped lang="scss">
/* 按钮容器样式 */
.button-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 5px;
}


.black-gold-button {
    width: 14vw;
    height: 13vh;
    padding: 15px 30px;
    font-size: 18px;
    box-sizing: border-box;
    background: 
        linear-gradient(45deg, 
            #000 30%,
            #2a2a2a 100%
        );
    color: #dfd288;
    border: 1px solid rgba(183, 176, 96, 0.3);
    border-radius: 8px;
    position: relative;
    overflow: hidden;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 
        0 4px 15px rgba(183, 176, 96, 0.2),
        inset 0 0 12px rgba(183, 176, 96, 0.1);

    /* 金属质感纹理 */
    &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: repeating-linear-gradient(
            -45deg,
            transparent,
            transparent 3px,
            rgba(183, 176, 96, 0.1) 3px,
            rgba(183, 176, 96, 0.1) 6px
        );
        mix-blend-mode: overlay;
        z-index: 1;
    }

    /* 动态光效 */
    &::after {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: linear-gradient(
            45deg,
            transparent 25%,
            rgba(255, 215, 0, 0.2) 50%,
            transparent 75%
        );
        animation: shine 3s infinite;
        z-index: 2;
    }

    /* 文字效果 */
    :deep(.el-button__content) {
        position: relative;
        z-index: 3;
        font-weight: 700;
        text-shadow: 
            0 0 8px rgba(255, 215, 0, 0.5),
            0 2px 2px rgba(0, 0, 0, 0.3);
        display: flex;
        align-items: center;
        gap: 8px;
    }

    /* 加载状态 */
    &.is-loading {
        opacity: 0.9;
        :deep(.el-button__loading) {
            .path {
                stroke: #dfd288;
            }
        }
    }

    /* 悬停效果 */
    &:hover {
        transform: translateY(-1px);
        box-shadow: 
            0 6px 20px rgba(183, 176, 96, 0.3),
            inset 0 0 15px rgba(183, 176, 96, 0.2);
        &::after {
            animation-duration: 2s;
        }
    }

    /* 点击效果 */
    &:active {
        transform: translateY(1px);
        box-shadow: 
            0 2px 10px rgba(183, 176, 96, 0.2),
            inset 0 0 10px rgba(183, 176, 96, 0.3);
    }

    /* 小屏幕适配 */
    @media (max-width: 768px) {
        width: 90%; /* 让按钮宽度充满屏幕 */
        font-size: 16px; /* 减小文字大小 */
        padding: 12px 20px; /* 减小内边距 */
    }
}

@keyframes shine {
    0% { transform: translate(-50%, -50%) rotate(45deg); }
    100% { transform: translate(50%, 50%) rotate(45deg); }
}

/* 调整SVG图标颜色 */
.svglogo {
    :deep(svg) {
        fill: #dfd288;
        filter: drop-shadow(0 0 4px rgba(255, 215, 0, 0.5));
    }
}

/* 新增样式，保证图标和文字垂直居中 */
.button-content {
    display: flex;
    align-items: center;
    gap: 8px;
}
</style>    