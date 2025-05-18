<template>
    <CollapsibleMusicPlayer 
      :music-info="{
        title: '光亮',
        artist: '张涵瑞',
        coverUrl: 'https://t15.baidu.com/it/u=1528866495,2384103240&fm=225&app=113&size=f256,170&n=0&f=JPEG&fmt=auto?s=0813CF145A03E701464CADDF030050A3&sec=1745859600&t=da989de849fb5b6b492dfa83af6f08f5',
        src: 'http://seunewsbac.pgrm.cc/static/news-music/光亮.mp3'
      }"
    />
</template>

<script setup lang="ts">
import CollapsibleMusicPlayer from './MusicPlay.vue';
</script>
