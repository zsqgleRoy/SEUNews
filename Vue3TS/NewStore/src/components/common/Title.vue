<template>
    <div class="centered-container">
        <div class="calligraphy-container">
            <p>东南新闻网</p>
        </div>
        <div class="calligraphy-container-en">
            <p>seunews.pgrm.cc</p>
        </div>
    </div>
</template>

<script lang="ts" setup>
</script>

<style scoped>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
}

.centered-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    max-height:60px;
}

.calligraphy-container {
    width: 100%;
    max-height: 35px;
    min-height: 35px;
    padding: 0;
    display: flex;
    align-items: center;
    font-family: 'WangXizhiFont', STXingkai, LiSu, serif;
    font-size: 35px;
    color: #ffffff;
    line-height: 1;
    justify-content: center;
    padding-top: 5px;
}
.calligraphy-container-en {
    text-align: center;
    width: 100%;
    max-height: 17px;
    min-height: 17px;
    padding: 0;
    display: flex;
    align-items: center;
    font-family: 'walkerBold', STXingkai, LiSu, serif;
    font-size: 17.5px;
    color: #ffffff;
    line-height: 1;
    justify-content: center;
    padding-left: 5px;
}

@media (max-width: 768px) {
    .calligraphy-container {
        width: 100%;
        max-height: 27px;
        min-height: 10px;
        padding: 0;
        display: flex;
        align-items: center;
        font-family: 'WangXizhiFont', STXingkai, LiSu, serif;
        font-size: 27px;
        color: #ffffff;
        line-height: 1;
        justify-content: center;
        padding-top: 4px;
    }
    .calligraphy-container-en {
        width: 100%;
        max-height: 13.4px;
        min-height: 10px;
        padding: 0;
        display: flex;
        align-items: center;
        font-family: 'walkerBold', STXingkai, LiSu, serif;
        font-size: 13.4px;
        color: #ffffff;
        line-height: 1;
        justify-content: center;
        padding-top: 2px;
        padding-left: 3px;
    }
}

@font-face {
    font-family: 'WangXizhiFont';
    src: url('@/assets/ttf/wangxizhi_font2.ttf') format('truetype');
}
@font-face {
    font-family: 'walkerBold';
    src: url('@/assets/ttf/楷体_GB2312.ttf') format('truetype');
}
</style>    