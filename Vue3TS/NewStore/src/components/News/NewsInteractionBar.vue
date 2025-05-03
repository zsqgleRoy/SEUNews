<template>
    <div class="cyber-interaction">
        <!-- 互动图标组 -->
        <div class="icon-group">
            <div v-for="(btn, index) in cyberButtons" :key="index" :class="btn.activeClass" @click="btn.action">
                <span class="icon-frame">
                    <img v-if="typeof btn.icon === 'object' && btn.icon.template" :src="btn.icon.setup().likeImage || btn.icon.setup().shareImage" alt="图标" class="neon-icon" />
                    <component v-else :is="btn.icon" class="neon-icon" />
                </span>
                <span class="data-display">{{ btn.count }}</span>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { Coin, Star, MoreFilled } from '@element-plus/icons-vue';
import likeImage from '@/assets/imges/like.png';
import shareImage from '@/assets/imges/share.png';

// 自定义点赞图片组件
const HollowStarSvg = {
    template: `
        <img :src="likeImage" alt="点赞图标" />
    `,
    setup() {
        return {
            likeImage
        };
    }
};

const ShareSvg = {
    template: `
        <img :src="shareImage" alt="转发图标" />
    `,
    setup() {
        return {
            shareImage
        };
    }
};

// 交互数据
const interactionData = ref({
    likes: 1098,
    idlike: false,
    coins: 999999999,
    isCoin: false,
    star: 999999999,
    isStar: false,
    forwards: 99999999
});

const formattedInteractionData = ref({
    likes: '',
    coins: '',
    star: '',
    forwards: ''
});

// 数据格式化函数
const formatNumber = (num: number): string | number => {
    if (num === 0) {
        return 0;
    }
    if (num >= 1000000000) {
        const quotient = Math.floor(num / 100000000) / 10;
        const exactQuotient = num / 1000000000;
        const formattedValue = exactQuotient % 1 === 0 && (num % 1000000000 === 0) ? exactQuotient.toFixed(0) : quotient.toFixed(1);
        return formattedValue + 'B';
    } else if (num >= 1000000) {
        const quotient = Math.floor(num / 100000) / 10;
        const exactQuotient = num / 1000000;
        const formattedValue = exactQuotient % 1 === 0 && (num % 1000000 === 0) ? exactQuotient.toFixed(0) : quotient.toFixed(1);
        return formattedValue + 'M';
    } else if (num >= 1000) {
        const quotient = Math.floor(num / 100) / 10;
        const exactQuotient = num / 1000;
        const formattedValue = exactQuotient % 1 === 0 && (num % 1000 === 0) ? exactQuotient.toFixed(0) : quotient.toFixed(1);
        return formattedValue + 'K';
    }
    return num;
};

// 数据初始化函数
const initInteractionData = () => {
    for (const key in interactionData.value) {
        if (typeof interactionData.value[key as keyof typeof interactionData.value] === 'number') {
            formattedInteractionData.value[key as keyof typeof formattedInteractionData.value] = String(formatNumber(interactionData.value[key as keyof typeof interactionData.value]));
        }
    }
};

// 交互逻辑封装
const handleInteraction = (key: keyof typeof interactionData.value) => {
    let currentValue = typeof interactionData.value[key] === 'number'
       ? interactionData.value[key]
        : parseFloat(formattedInteractionData.value[key].slice(0, -1)) * (formattedInteractionData.value[key].endsWith('K') ? 1000 : formattedInteractionData.value[key].endsWith('M') ? 1000000 : formattedInteractionData.value[key].endsWith('B') ? 1000000000 : 1);
    currentValue++;
    interactionData.value[key] = currentValue;
    formattedInteractionData.value[key] = String(formatNumber(currentValue));
};

// 图标配置
const cyberButtons = computed(() => [
    {
        icon: HollowStarSvg,
        text: '量子点赞赋能',
        count: formattedInteractionData.value.likes,
        action: () => handleInteraction('likes'),
        activeClass: 'pulse-active'
    },
    {
        icon: Coin,
        text: '能量币投送',
        count: formattedInteractionData.value.coins,
        action: () => handleInteraction('coins'),
        activeClass: 'coin-active'
    },
    {
        icon: Star,
        text: interactionData.value.isStar ? '数据已归档' : '核心数据收藏',
        count: formattedInteractionData.value.star,
        action: () => handleInteraction('star'),
        activeClass: 'storage-active'
    },
    {
        icon: ShareSvg,
        text: '超维信息转发',
        count: formattedInteractionData.value.forwards,
        action: () => handleInteraction('forwards'),
        activeClass: 'forward-active'
    },
    {
        icon: MoreFilled,
        text: '上报问题',
        action: () => console.log('启动自检程序'),
        activeClass: 'diagnose-active'
    }
]);

// 初始化调用
initInteractionData();
</script>

<style scoped lang="scss">
$cyber-purple: #000000;
$cyber-yellow: #ffff00;

.cyber-interaction {
    margin: 30px auto;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 10px;
    max-width: 100vw;
}

.icon-group {
    display: flex;
    gap: 2rem;
    align-items: center;
}

.icon-group > div {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    flex-direction: row;
    gap: 0.5rem;
    padding: 0;
    border-radius: 8px;
    transition: all 0.3s ease;
    position: relative;
    width: 15vw;
    min-width: 115px;
    box-sizing: border-box;
}

.icon-frame {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 2.5rem;
    height: 2.5rem;
}

.neon-icon {
    width: 1.8em;
    height: 1.8em;
    object-fit: contain;
    vertical-align: middle;
    color: $cyber-purple;
    transition: transform 0.3s ease;
}

.data-display {
    font-family: 'Courier New', monospace;
    font-size: 1.2em;
    color: $cyber-purple;
    line-height: 1;
    display: inline-block;
    vertical-align: middle;
    white-space: nowrap; /* 防止数字换行 */
    overflow: hidden; /* 隐藏溢出内容 */
    text-overflow: ellipsis; /* 溢出内容显示省略号 */
}

@keyframes pulse-glow {
    0%, 100% { transform: scale(1) }
    50% { transform: scale(1.15) }
}

@keyframes shake {
    0% { transform: rotate(0deg); }
    25% { transform: rotate(5deg); }
    50% { transform: rotate(0deg); }
    75% { transform: rotate(-5deg); }
    100% { transform: rotate(0deg); }
}

.icon-group > div:hover .neon-icon {
    animation: shake 0.5s ease-in-out, pulse-glow 0.5s ease-in-out forwards;
}

// 取消 el-dropdown 触发元素点击时可能出现的边框
.el-dropdown .neon-icon:focus,
.el-dropdown .neon-icon:focus-visible {
    outline: none;
    box-shadow: none;
}

// 取消 el-dropdown 点击时可能出现的边框
.el-dropdown-menu__item:focus,
.el-dropdown-menu__item:focus-visible {
    outline: none;
    box-shadow: none;
}

/* 手机端样式优化 */
@media (max-width: 768px) {
   .icon-group {
        gap: 0.5rem;
    }

   .icon-group > div {
        padding: 0.2rem;
        gap: 0.2rem;
        flex-direction: column;
        width: 50px;
        min-width: 40px;
    }

   .icon-frame {
        width: 2rem;
        height:2rem;
    } 

   .neon-icon {
        width: 2em;
        height: 2em;
    }

   .data-display {
        font-size: 12px;
        line-height: 1;
        font-family: 'Times New Roman', Times, serif;
    }
}
</style>    