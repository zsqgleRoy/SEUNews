<template>
    <div ref="watermarkContainer" class="watermark-container"></div>
  </template>
  
  <script setup lang="ts">
  import { ref, watch, onMounted } from 'vue'
  
  interface Props {
    text: string          // 水印文本
    fontSize?: number     // 字体大小（默认14）
    color?: string        // 字体颜色（默认rgba(0, 0, 0, 0.15)）
    rotate?: number       // 旋转角度（默认-20）
    gap?: number          // 水印间距（默认100）
  }
  
  const props = withDefaults(defineProps<Props>(), {
    fontSize: 14,
    color: 'rgba(0, 0, 0, 0.15)',
    rotate: -20,
    gap: 100
  })
  
  const watermarkContainer = ref<HTMLElement | null>(null)
  
  // 生成水印背景图
  const generateWatermark = () => {
    const canvas = document.createElement('canvas')
    const ctx = canvas.getContext('2d')!
    
    // 计算画布尺寸（根据间距调整）
    canvas.width = props.gap * 2
    canvas.height = props.gap * 2
  
    // 设置绘制样式
    ctx.font = `${props.fontSize}px Arial`
    ctx.fillStyle = props.color
    ctx.textAlign = 'center'
    ctx.textBaseline = 'middle'
  
    // 旋转画布
    ctx.translate(canvas.width / 2, canvas.height / 2)
    ctx.rotate((Math.PI / 180) * props.rotate)
    ctx.translate(-canvas.width / 2, -canvas.height / 2)
  
    // 绘制水印文本
    ctx.fillText(props.text, canvas.width / 2, canvas.height / 2)
  
    return canvas.toDataURL('image/png')
  }
  
  // 应用水印样式
  const applyWatermark = () => {
    if (!watermarkContainer.value) return
    
    const bgUrl = generateWatermark()
    watermarkContainer.value.style.backgroundImage = `url(${bgUrl})`
  }
  
  // 监听props变化
  watch(props, () => {
    applyWatermark()
  })
  
  onMounted(() => {
    applyWatermark()
  })
  </script>
  
  <style scoped>
  .watermark-container {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none; /* 防止水印阻挡页面交互 */
    background-repeat: repeat;
    z-index: 9999;
  }
  </style>