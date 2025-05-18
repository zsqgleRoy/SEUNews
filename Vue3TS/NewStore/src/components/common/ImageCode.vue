<template>
    <div
      class="slide-verify"
      :style="{ width: w + 'px' }"
      id="slideVerify"
      onselectstart="return false;"
    >
      <!-- 图片加载遮蔽罩 -->
      <div :class="{ 'slider-verify-loading': loadBlock }"></div>
      <canvas :width="w" :height="h" ref="canvasDocm"></canvas>
      <div v-if="show" @click="refresh" class="slide-verify-refresh-icon"></div>
      <canvas
        :width="w"
        :height="h"
        ref="block"
        class="slide-verify-block"
      ></canvas>
      <!-- container -->
      <div
        class="slide-verify-slider"
        :class="{
          'container-active': containerActive,
          'container-success': containerSuccess,
          'container-fail': containerFail,
        }"
      >
        <div class="slide-verify-slider-mask" :style="{ width: sliderMaskWidth }">
          <!-- slider -->
          <div
            @mousedown="sliderDown"
            @touchstart="touchStartEvent"
            @touchmove="touchMoveEvent"
            @touchend="touchEndEvent"
            class="slide-verify-slider-mask-item"
            :style="{ left: sliderLeft }"
          >
            <div class="slide-verify-slider-mask-item-icon"></div>
          </div>
        </div>
        <span class="slide-verify-slider-text">{{ sliderText }}</span>
      </div>
      <div v-if="show" @click="refresh" class="slide-verify-refresh-icon">
      <svg 
        class="refresh-icon"
        viewBox="0 0 24 24"
        :width="iconSize"
        :height="iconSize"
        @click.stop="refresh"
      >
        <path 
          fill="currentColor"
          d="M17.65 6.35C16.2 4.9 14.21 4 12 4c-4.42 0-7.99 3.58-7.99 8s3.57 8 7.99 8c3.73 0 6.84-2.55 7.73-6h-2.08c-.82 2.33-3.04 4-5.65 4-3.31 0-6-2.69-6-6s2.69-6 6-6c1.66 0 3.14.69 4.22 1.78L13 11h7V4l-2.35 2.35z"
        />
      </svg>
    </div>
  </div>
</template>

<script lang="ts">
  import { defineComponent, reactive, ref, onMounted } from "vue";
  import { initialURL } from "@/lib/urls";
  export default defineComponent({
    name: "SlidePuzzleVerification",
    props: {
      l: {
        type: Number,
        default: 42,
      },
      r: {
        type: Number,
        default: 10,
      },
      w: {
        type: Number,
        default: 310,
      },
      h: {
        type: Number,
        default: 155,
      },
      sliderText: {
        type: String,
        default: "滑动以完成验证",
      },
      accuracy: {
        type: Number,
        default: 5,
      },
      show: {
        type: Boolean,
        default: true,
      },
      imgs: {
        type: Array,
        default: () => [],
      },
      iconSize: {
        type: Number,
        default: 24,
      },
    },
    setup(props, {emit, expose}) {
      const containerActive = ref(false);
      const containerSuccess = ref(false);
      const containerFail = ref(false);
      const canvasCtx = ref<CanvasRenderingContext2D | null>(null);
      const blockCtx = ref<CanvasRenderingContext2D | null>(null);
      const block = ref<HTMLCanvasElement | null>(null);
      const canvasDocm = ref<HTMLCanvasElement | null>(null);
      const L = ref(props.l + props.r * 2 + 3);
      const block_x = ref(0);
      const block_y = ref(0);
      const img = ref<HTMLImageElement>();
      const originX = ref(0);
      const originY = ref(0);
      const isMouseDown = ref(false)
      const trail = ref<number[]>([])
      const sliderLeft = ref('0')
      const sliderMaskWidth = ref('0')
      const success = ref(false)
      const loadBlock = ref(true)
      const timestamp = ref(0)
   
      const PI = Math.PI;
   
      const refresh = () => {
        reset();
        // 添加旋转动画
        const icon = document.querySelector('.refresh-icon') as HTMLElement;
        if (icon) {
          icon.style.transform = 'rotate(360deg)';
          setTimeout(() => {
            icon.style.transform = 'rotate(0deg)';
          }, 600);
        }
        emit("refresh");
      };

      const sum = (x:number, y:number) => {
        return x + y;
      }
   
      const square = (x:number) => {
        return x * x;
      }
   
      onMounted(() => {
        init();
      })
      const init = () => {
        initDom();
        initImg();
        bindEvents();
      }
      const initDom = () => {
        canvasCtx.value = canvasDocm.value ? canvasDocm.value.getContext("2d") : null;
        blockCtx.value = block.value ? block.value.getContext("2d") : null;
      }
      const initImg = () => {
        const creImg = createImg(() => {
          // 图片加载完关闭遮蔽罩
          loadBlock.value = false;
          drawBlock();
          canvasCtx.value?.drawImage(creImg, 0, 0, props.w, props.h);
          blockCtx.value?.drawImage(creImg, 0, 0, props.w, props.h);
          // let { block_x: x, block_y: y, r, L } = this;
          let _y = block_y.value - props.r * 2 - 1;
          let ImageData = blockCtx.value?.getImageData(block_x.value, _y, L.value, L.value);
          if(block.value){
            block.value.width = L.value;
          }
          blockCtx.value?.putImageData(ImageData!, 0, _y);
        });
        img.value = creImg;
      }
      const drawBlock = () => {
        block_x.value = getRandomNumberByRange(
          L.value + 10,
          props.w - (L.value + 10)
        );
        block_y.value = getRandomNumberByRange(
          10 + props.r * 2,
          props.h - (L.value + 10)
        );
        draw(canvasCtx.value as CanvasRenderingContext2D, block_x.value, block_y.value, "fill");
        draw(blockCtx.value as CanvasRenderingContext2D, block_x.value, block_y.value, "clip");
      }
      const draw = (ctx:CanvasRenderingContext2D, x:number, y:number, operation:string) => {
        // let { l, r } = this;
        let l = props.l;
        let r = props.r;
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.arc(x + l / 2, y - r + 2, r, 0.72 * PI, 2.26 * PI);
        ctx.lineTo(x + l, y);
        ctx.arc(x + l + r - 2, y + l / 2, r, 1.21 * PI, 2.78 * PI);
        ctx.lineTo(x + l, y + l);
        ctx.lineTo(x, y + l);
        ctx.arc(x + r - 2, y + l / 2, r + 0.4, 2.76 * PI, 1.24 * PI, true);
        ctx.lineTo(x, y);
        ctx.lineWidth = 2;
        ctx.fillStyle = "rgba(255, 255, 255, 0.7)";
        ctx.strokeStyle = "rgba(255, 255, 255, 0.7)";
        ctx.stroke();
        if(operation === 'fill'){
          ctx[operation]();
        }else{
          ctx.clip();
        }
        
        // Bug Fixes 修复了火狐和ie显示问题
        ctx.globalCompositeOperation = "destination-over";
      }
      const createImg = (onload: () => void) => {
        const img = document.createElement("img");
        img.crossOrigin = "Anonymous";
        img.onload = onload;
        img.onerror = () => {
          img.src = getRandomImg();
        };
        img.src = getRandomImg();
        return img;
      }
      // 随机生成img src
      const getRandomImg = ():string => {
        // return require('../assets/img.jpg')
        const len = props.imgs.length;
        return len > 0 ? props.imgs[getRandomNumberByRange(0, len)] as string : initialURL.SERVER_URL+"/static/news-images/picsum/photos/300-150/" + getRandomNumberByRange(0, 1084)+".jpg";
      }
      const getRandomNumberByRange = (start:number, end:number):number => {
        return Math.round(Math.random() * (end - start) + start);
      }
      const sliderDown = (event:any) => {
        if (success.value) return;
        originX.value = event.clientX;
        originY.value = event.clientY;
        isMouseDown.value = true;
        timestamp.value = +new Date();
      }
      const touchStartEvent = (e:any) => {
        if (success.value) return;
        originX.value = e.changedTouches[0].pageX;
        originY.value = e.changedTouches[0].pageY;
        isMouseDown.value = true;
        timestamp.value = +new Date();
      }
      const bindEvents = () => {
        document.addEventListener("mousemove", (e) => {
          if (!isMouseDown.value) return false;
          const moveX = e.clientX - originX.value;
          const moveY = e.clientY - originY.value;
          if (moveX < 0 || moveX + 38 >= props.w) return false;
          sliderLeft.value = moveX + "px";
          let blockLeft = ((props.w - 40 - 20) / (props.w - 40)) * moveX;
          if(block.value){
            block.value.style.left = blockLeft + "px";
          }
          
   
          containerActive.value = true; // add active
          sliderMaskWidth.value = moveX + "px";
          trail.value.push(moveY);
        });
        document.addEventListener("mouseup", (e) => {
          if (!isMouseDown.value) return false;
          isMouseDown.value = false;
          if (e.clientX === originX.value) return false;
          containerActive.value = false; // remove active
          timestamp.value = +new Date() - timestamp.value;
   
          const { spliced, TuringTest } = verify();
          if (spliced) {
            if (props.accuracy === -1) {
              containerSuccess.value = true;
              success.value = true;
              emit("success", timestamp.value);
              return;
            }
            if (TuringTest) {
              // succ
              containerSuccess.value = true;
              success.value = true;
              emit("success", timestamp.value);
            } else {
              containerFail.value = true;
              emit("again");
            }
          } else {
            containerFail.value = true;
            emit("fail");
            setTimeout(() => {
              reset();
            }, 1000);
          }
        });
      }
      const touchMoveEvent = (e:any) => {
        if (!isMouseDown.value) return false;
        const moveX = e.changedTouches[0].pageX - originX.value;
        const moveY = e.changedTouches[0].pageY - originY.value;
        if (moveX < 0 || moveX + 38 >= props.w) return false;
        sliderLeft.value = moveX + "px";
        let blockLeft = ((props.w - 40 - 20) / (props.w - 40)) * moveX;
        if(block.value){
          block.value.style.left = blockLeft + "px";
        }
        
   
        containerActive.value = true;
        sliderMaskWidth.value = moveX + "px";
        trail.value.push(moveY);
      }
      const touchEndEvent = (e:any) => {
        if (!isMouseDown.value) return false;
        isMouseDown.value = false;
        if (e.changedTouches[0].pageX === originX.value) return false;
        containerActive.value = false;
        timestamp.value = +new Date() - timestamp.value;
   
        const { spliced, TuringTest } = verify();
        if (spliced) {
          if (props.accuracy === -1) {
            containerSuccess.value = true;
            success.value = true;
            emit("success", timestamp.value);
            return;
          }
          if (TuringTest) {
            // succ
            containerSuccess.value = true;
            success.value = true;
            emit("success", timestamp.value);
          } else {
            containerFail.value = true;
            emit("again");
          }
        } else {
          containerFail.value = true;
          emit("fail");
          setTimeout(() => {
            reset();
          }, 1000);
        }
      }
      const verify = () => {
        const arr = trail.value;
        const average = arr.reduce(sum);
        const deviations = arr.map((x) => x - average);
        const stddev = Math.sqrt(deviations.map(square).reduce(sum));
        const left = parseInt(block.value?.style.left as string);
        const accuracy =
          props.accuracy <= 1 ? 1 : props.accuracy > 10 ? 10 : props.accuracy;
        return {
          spliced: Math.abs(left - block_x.value) <= accuracy,
          TuringTest: average !== stddev, // equal => not person operate
        };
      }
      const reset = () => {
        success.value = false;
        containerActive.value = false;
        containerSuccess.value = false;
        containerFail.value = false;
        sliderLeft.value = '0';
        if(block.value){
          block.value.style.left = '0';
        }
        
        sliderMaskWidth.value = '0';
        canvasCtx.value?.clearRect(0, 0, props.w, props.h);
        blockCtx.value?.clearRect(0, 0, props.w, props.h);
        if(block.value){
          block.value.width = props.w;
        }
        if(img.value){
          img.value.src = getRandomImg();
        }
        emit("fulfilled");
      }
      // 暴露方法
      expose({ reset });
   
      return {
        containerActive,
        containerSuccess,
        containerFail,
        canvasCtx,
        blockCtx,
        block,
        canvasDocm,
        block_x,
        block_y,
        L,
        img,
        originX,
        originY,
        isMouseDown,
        trail,
        sliderLeft,
        sliderMaskWidth,
        success, 
        loadBlock,
        timestamp,
        touchStartEvent,
        touchMoveEvent,
        touchEndEvent,
        refresh,
        sliderDown
      };
    },
  });
</script>

<style scoped lang="scss">
  .slide-verify {
    position: relative;
    background-color: white;
  }
   
  /* 图片加载样式 */
  .slider-verify-loading {
    position: absolute;
    top: 0;
    right: 0;
    left: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.9);
    z-index: 999;
    animation: loading 1.5s infinite;
  }
   
  @keyframes loading {
    0% {
      opacity: 0.7;
    }
    100% {
      opacity: 9;
    }
  }
   
  .slide-verify-block {
    position: absolute;
    left: 0;
    top: 0;
  }
   
  .slide-verify-refresh-icon {
    position: absolute;
    right: 0;
    top: 0;
    width: 34px;
    height: 34px;
    cursor: pointer;
    background: url("../../assets/icon_light.png") 0 -437px;
    background-size: 34px 471px;
  }
   
  .slide-verify-refresh-icon {
  position: absolute;
  right: 8px;
  top: 8px;
  cursor: pointer;
  z-index: 1000;
  transition: all 0.3s ease;
  
  &:hover {
    transform: rotate(120deg) scale(1.1);
    .refresh-icon {
      fill: #007bff; // 悬停颜色
      transition-timing-function: cubic-bezier(0.68, -0.55, 0.27, 1.55);
    }
  }
  
  &:active {
    transform: scale(0.95);
  }
}

.refresh-icon {
  width: 24px;
  height: 24px;
  fill: #666;
  transition: 
    fill 0.3s ease,
    transform 0.6s cubic-bezier(0.25, 0.8, 0.25, 1);
}

  .slide-verify-slider {
    position: relative;
    text-align: center;
    width: 100%;
    height: 40px;
    line-height: 40px;
    margin-top: 15px;
    background: #f7f9fa;
    color: #45494c;
    border: 1px solid #e4e7eb;
  }
   
  .slide-verify-slider-mask {
    position: absolute;
    left: 0;
    top: 0;
    height: 40px;
    border: 0 solid #1991fa;
    background: #d1e9fe;
  }
   
  .slide-verify-slider-mask-item {
    position: absolute;
    top: 0;
    left: 0;
    width: 40px;
    height: 40px;
    background: #fff;
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);
    cursor: pointer;
    transition: background 0.2s linear;
  }
   
  .slide-verify-slider-mask-item:hover {
    background: #1991fa;
  }
   
  .slide-verify-slider-mask-item:hover .slide-verify-slider-mask-item-icon {
    background-position: 0 -13px;
  }
   
  .slide-verify-slider-mask-item-icon {
    position: absolute;
    top: 15px;
    left: 13px;
    width: 14px;
    height: 12px;
    background: url("../../assets/icon_light.png") 0 -26px;
    background-size: 34px 471px;
  }
  .container-active .slide-verify-slider-mask-item {
    height: 38px;
    top: -1px;
    border: 1px solid #1991fa;
  }
   
  .container-active .slide-verify-slider-mask {
    height: 38px;
    border-width: 1px;
  }
   
  .container-success .slide-verify-slider-mask-item {
    height: 38px;
    top: -1px;
    border: 1px solid #52ccba;
    background-color: #52ccba !important;
  }
   
  .container-success .slide-verify-slider-mask {
    height: 38px;
    border: 1px solid #52ccba;
    background-color: #d2f4ef;
  }
   
  .container-success .slide-verify-slider-mask-item-icon {
    background-position: 0 0 !important;
  }
   
  .container-fail .slide-verify-slider-mask-item {
    height: 38px;
    top: -1px;
    border: 1px solid #f57a7a;
    background-color: #f57a7a !important;
  }
   
  .container-fail .slide-verify-slider-mask {
    height: 38px;
    border: 1px solid #f57a7a;
    background-color: #fce1e1;
  }
   
  .container-fail .slide-verify-slider-mask-item-icon {
    top: 14px;
    background-position: 0 -82px !important;
  }
   
  /* .container-active .slide-verify-slider-text,
  .container-success .slide-verify-slider-text,
  .container-fail .slide-verify-slider-text {
    display: none;
  } */
  .slide-verify-slider-text{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
    z-index: 999;
  }
</style>