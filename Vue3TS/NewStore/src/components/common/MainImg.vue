<template>
    <div class="Main">
        <div class="block text-center">
            <el-carousel :interval="4000" indicator-position="none" type="card" min-height="50px" :cardScale=1 class="demonstration">
                <el-carousel-item v-for="item  in imageList" :key="item" class="demonstration">
                    <router-link 
                        :to="item.route" 
                        class="media-link"
                    >
                        <img v-if="item.type == 'image'" class="small justify-center" :src="item.url" style="width: 100%; height: 100%;" />
                        <video autoplay  v-else class="small justify-center"
                            style="width: 100%; height: 100%;"
                            loop
                            playsinline>
                            <source :src="item.url" type="video/mp4" />
                        </video>
                    </router-link>
                </el-carousel-item>
            </el-carousel>
        </div>
    </div>
</template>

<script lang="ts" setup>
import { initialURL } from '@/lib/urls';
import { ref } from 'vue';
// 定义图片数组
const imageList = ref([
    {
        index: 0,
        url: initialURL.SERVER_URL+'/static/news-images/20250420175132184_b647fac4.png',
        route: '/getService',
        type: 'image'
    },
    {
        index: 1,
        url: initialURL.SERVER_URL+'/static/news-images/20250420174206294_c63c8e1d.png',
        route: '/getService',
        type: 'image'
    },
    {
        index: 2,
        url: initialURL.SERVER_URL+'/static/news-videos/04J58PICYV58PICTpyVqH8Syn.mp4',
        route: '/getService',
        type: 'video'
    },
    {
        index: 3,
        url: initialURL.SERVER_URL+'/static/news-images/20250420155051606_6cdb6627.png',
        route: '/getService',
        type: 'image'
    },
    {
        index: 4,
        url: initialURL.SERVER_URL+'/static/news-images/20250330215814731_34704dbc.jpg',
        route: '/getService',
        type: 'image'
    },
    {
        index: 5,
        url: initialURL.SERVER_URL+'/static/news-images/20250420183348226_95a2ae46.png',
        route: '/getService',
        type: 'image'
    },
]);
</script>

<style scoped lang="scss">
.Main {
    background: linear-gradient(135deg, #174fa9, #6b00bcae);
    position: relative;
}

@media screen and (max-width: 768px) {
    .demonstration {
        height: 90px;
    }
    
}


.el-carousel__item img {
    line-height: 130px;
    margin: 0;
    text-align: center;
}

.el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n + 1) {
    background-color: #d3dce6;
}

/* @media (max-width: 767px) {
    .el-carousel {
        height: 120px;
    }

    .el-carousel__item img {
        line-height: 120px;
    }
} */
</style>    