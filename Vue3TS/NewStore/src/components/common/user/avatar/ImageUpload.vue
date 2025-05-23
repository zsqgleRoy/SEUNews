<template>
  <el-card shadow="never" class="image-cropper-card" :body-style="{ padding: '0' }">
    <div
      class="image-cropper-container img-uploader"
      :style="{
        '--screenshot-width': props.width + 'px',
        '--screenshot-height': props.height + 'px'
      }"
    >
    <div class="image-cropper-content">
      <el-image
        class=""
        :src="imageData.url"
        @mouseenter="handleMouseEnter"
        @mouseleave="handleMouseLeave"
      >
        <template #error>
          <div @click="imageCropperVisible = true" class="image-upload-button">
            <el-button link>
              <el-icon size="28" color="#999"><Plus /></el-icon><span style="color: #999;font-size: 16px;">选择图片</span>
            </el-button>
          </div>
          
        </template>
      </el-image>
      <transition name="el-fade-in">
        <div
          v-show="imageData.showOverlay"
          class="overlay"
          @mouseenter.stop="handleMouseEnter"
          @mouseleave.stop="handleMouseLeave"
        >
          <el-button link
            ><el-icon color="#fff" size="20" @click.stop="onPreview"><ZoomIn /></el-icon
          ></el-button> 
          <el-button link
            ><el-icon color="#fff" size="20" @click.stop="handleRemove"><Delete /></el-icon
          ></el-button>
        </div>
      </transition>
    </div>
    <ImageCropper
      v-model="imageCropperVisible"
      :title="props.title"
      :info="false"
      :width="props.width"
      :height="props.height"
      :myUrl="props.url"
      @imgData="getImageData"
    />
 
    <el-image-viewer
      v-if="showImageViewer"
      @close="closeImageViewer"
      :url-list="imageViewList"
      :z-index="9999"
      :initial-index="initialIndex"
      :hide-on-click-modal="true"
    >
    <template
        #toolbar="{ actions, reset, activeIndex }"
      >
        <!-- <el-icon @click="prev"><Back /></el-icon>
        <el-icon @click="next"><Right /></el-icon>
        <el-icon @click="setActiveItem(srcList.length - 1)">
          <DArrowRight />
        </el-icon> -->
        <el-icon @click="actions('zoomOut')"><ZoomOut /></el-icon>
        <el-icon
          @click="actions('zoomIn', { enableTransition: false, zoomRate: 2 })"
        >
          <ZoomIn />
        </el-icon>
        <el-icon
          @click="actions('clockwise')">
          <RefreshRight />
        </el-icon>
        <el-icon @click="actions('anticlockwise')"><RefreshLeft /></el-icon>
        <el-icon @click="reset"><Refresh /></el-icon>
        <el-icon @click="download(activeIndex)"><Download /></el-icon>
      </template>
    </el-image-viewer>
  </div>
  </el-card>
</template>
 
<script setup lang="ts">
import ImageCropper from '@/components/common/user/avatar/ImageCropper.vue'
import { onMounted, ref } from 'vue'
const props = defineProps({
  title: {
    type: String,
    default: '上传图片'
  },
  width: {
    type: Number,
    default: 400
  },
  height: {
    type: Number,
    default: 400
  },
  url: {
    type: String
  }
})
const emit = defineEmits(['imgData'])
 
const imageCropperVisible = ref(false)  // 截图组件显示隐藏
const imageData = ref({})               // 图片数据
// 获取图片数据
const getImageData = (data:{ url: string }) => {
  imageData.value = data
  emit('imgData', imageData.value)
}
const handleMouseEnter = (event) => {
  if (imageData.value.showOverlay === false) {
    imageData.value.showOverlay = true
  }
}
const handleMouseLeave = (event) => {
  if (imageData.value.showOverlay === true) {
    imageData.value.showOverlay = false
  }
}
 
// 图片预览
const showImageViewer = ref(false)
const imageViewList = ref([])
const initialIndex = ref(0)
const closeImageViewer = () => {
  showImageViewer.value = false
  imageViewList.value = []
}
const onPreview = () => {
  imageViewList.value = [imageData.value.url]
  showImageViewer.value = true
}
const handleRemove = () => {
  imageViewList.value = []
  imageData.value = {}
}

const download = (index: number) => {
  const url = imageViewList.value[index]
  const suffix = url.slice(url.lastIndexOf('.'))
  const filename = Date.now() + suffix

  fetch(url)
    .then((response) => response.blob())
    .then((blob) => {
      const blobUrl = URL.createObjectURL(new Blob([blob]))
      const link = document.createElement('a')
      link.href = blobUrl
      link.download = filename
      document.body.appendChild(link)
      link.click()
      URL.revokeObjectURL(blobUrl)
      link.remove()
    })
}

onMounted(()=>{
  if(props.url){
    imageData.value.showOverlay = false;
    imageData.value.url = props.url;
  }
})
</script>
 
<style lang="scss" scoped>
.image-cropper-card {
  width: 100%;
  max-height: 100%;
  user-select: none;
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 10px;
}

.img-uploader {
  width: 100px;
  height: 100px;
  display: block;
  border: 1px dashed var(--el-border-color);
  border-radius: 10px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
  background-color: rgba(0, 0, 0, 0.02);
}
 
.img-uploader:hover {
  border-color: var(--el-color-primary);
}
.image-cropper-container {
  width: var(--screenshot-width);
  height: var(--screenshot-height);
  user-select: none;
 
  .image-cropper-content {
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 10px;
    width: var(--screenshot-width);
    height: var(--screenshot-height);
 
    .el-image {
      width: var(--screenshot-width);
      height: var(--screenshot-height);
    }
 
    .image-upload-button {
      width: var(--screenshot-width);
      height: var(--screenshot-height);
      display: flex;
      align-items: center;
      justify-content: center;
    }
 
    .overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: var(--screenshot-width);
      height: var(--screenshot-height);
      background-color: rgba(0, 0, 0, 0.5);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 2000;
    }
  }
}
</style>