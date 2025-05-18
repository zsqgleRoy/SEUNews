<template>
    <div class="certification-info">
        <svg width="24" height="24" viewBox="0 0 100 100" class="certification-svg">
            <!-- 渐变圆形背景 -->
            <defs>
                <linearGradient id="goldGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" stop-color="#FFD700" />
                    <stop offset="100%" stop-color="#FFA500" />
                </linearGradient>
            </defs>

            <circle cx="50" cy="50" r="45" fill="none" 
                    stroke="url(#goldGradient)"
                    stroke-width="6"
                    stroke-dasharray="8 4"
                    stroke-linecap="round"
                    class="animated-ring"/>
            
            <!-- 精确居中的V标志 -->
            <text x="50%" y="50%" 
                  text-anchor="middle"
                  dominant-baseline="central"
                  fill="url(#goldGradient)"
                  font-size="60"
                  font-family="Arial, sans-serif"
                  font-weight="800">V</text>
        </svg>
        <span class="certification-text">东南新闻记者</span>
    </div>
</template>

<script lang="ts" setup>
// 可以添加需要的逻辑
</script>

<style scoped>
.certification-info {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 0px 1px 0 1px; /* 增加内边距 */
    background: rgba(255, 215, 0, 0.1);
    border: 1px solid rgba(255, 215, 0, 0.3); /* 添加边框 */
    border-radius: 24px;
    /* 设置组件内文字不可复制 */
    user-select: none; 
    -webkit-user-select: none; 
    -moz-user-select: none; 
    -ms-user-select: none; 
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* 添加轻微阴影 */
    transition: all 0.3s ease; /* 添加过渡效果 */
}

.certification-info:hover {
    background: rgba(255, 215, 0, 0.15); /* 悬停时背景颜色加深 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 悬停时阴影加深 */
}

.certification-svg {
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}

.certification-svg:hover {
    transform: scale(1.15) rotate(8deg);
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.15));
}

.certification-text {
    font-family: 'Inter', system-ui, sans-serif;
    font-size: 15px; /* 增大字体大小 */
    font-weight: 600;
    color: #333;
    letter-spacing: 0.5px;
    background: linear-gradient(45deg, #0180ff, #FFA500); /* 修改渐变颜色为更正式的色调 */
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
}
@media (max-width: 768px) { /* 这里的768px可以根据实际情况调整，一般用于匹配手机屏幕宽度 */
  .certification-info {
        transform: scale(0.67); /* 缩小为原来的2/3，即整体缩小1/3 */
        transform-origin: top left; /* 以左上角为原点进行缩放，可根据需求调整 */
    }
}
</style>    