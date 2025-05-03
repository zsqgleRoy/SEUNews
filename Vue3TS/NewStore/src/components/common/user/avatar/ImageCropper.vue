<template>
  <div>
    <el-dialog :title="props.title || '图片裁剪'" v-model="visible" width="1000">
      <div class="cropper-content">
        <div class="cropper-box-container" :style="{flexDirection:isRow?'row':'column'}">
          <div class="cropper-box">
            <div class="cropper">
              <vue-cropper
                  ref="cropper"
                  :img="option.img"
                  :outputSize="option.outputSize"
                  :outputType="option.outputType"
                  :info="option.info"
                  :canScale="option.canScale"
                  :autoCrop="option.autoCrop"
                  :autoCropWidth="option.autoCropWidth"
                  :autoCropHeight="option.autoCropHeight"
                  :fixed="option.fixed"
                  :fixedNumber="option.fixedNumber"
                  :full="option.full"
                  :fixedBox="option.fixedBox"
                  :canMove="option.canMove"
                  :canMoveBox="option.canMoveBox"
                  :original="option.original"
                  :centerBox="option.centerBox"
                  :height="option.height"
                  :infoTrue="option.infoTrue"
                  :maxImgSize="option.maxImgSize"
                  :enlarge="option.enlarge"
                  @realTime="realTime"
                  @imgLoad="imgLoad">
              </vue-cropper>
            </div>
          </div>
          <!--预览效果图-->
          <div class="show-preview" :style="{width:isRow?'40%':'auto',padding:isRow?'0':'20px 0'}">
            <h1 class="tupianyulan" v-if="option.img===''" :style="{height:isRow?'auto':'100px'}">图片预览</h1>
            <div v-if="option.img!==''" :style="previews.div" class="preview">
              <img :src="previews.url" :style="previews.img" alt="">
            </div>
          </div>
        </div>
        <!--底部操作工具按钮-->
        <div class="footer-btn">
          <div class="scope-btn">
            <label class="btn" for="uploads">选择图片</label>
            <input type="file" id="uploads" style="position:absolute; clip:rect(0 0 0 0);" accept="image/png, image/jpeg, image/gif, image/jpg" @change="selectImg($event)">
            <el-button size="small" type="danger" plain icon="plus" @click="changeScale(1)">放大</el-button>
            <el-button size="small" type="danger" plain icon="minus" @click="changeScale(-1)">缩小</el-button>
            <el-button size="small" type="danger" plain @click="rotateLeft">↺ 左旋转</el-button>
            <el-button size="small" type="danger" plain @click="rotateRight">↻ 右旋转</el-button>
            <el-button size="small" type="danger" plain icon="refresh" @click="option.img=''">清除图片</el-button>
            <el-button size="small" link><el-tooltip effect="light" placement="top" :content="tip"><el-icon color="#aaa" size="15"><InfoFilled /></el-icon></el-tooltip></el-button>
          </div>
          <div class="upload-btn">
            <el-button size="small" type="success" @click="uploadImg('blob')">确定图片 <i class="el-icon-upload"></i></el-button>
          </div>
        </div>
      </div>
    </el-dialog>
  </div>
</template>
 
<script setup>
import {onMounted, ref} from "vue";
import {VueCropper} from "vue-cropper";
import 'vue-cropper/dist/index.css';
 
const tip = ref('选择图片后，可移动截图框，拖动遮罩部分可移动图片，也可用滚轮缩放图片')
const cropper = ref(null)
const previews = ref({})
const visible = defineModel({
  type: Boolean,
  default: true
})
const props = defineProps({
  title: {
    type: String,
    default: ''
  },
  outPutSize: {
    type: Number,
    default: 1
  },
  outPutType: {
    type: String,
    default: 'png'
  },
  info: {
    type: Boolean,
    default: true
  },
  canScale: {
    type: Boolean,
    default: true
  },
  width: {
    type: Number,
    default: 200,
  },
  height: {
    type: Number,
    default: 200,
  },
  fixed: {
    type: Boolean,
    default: true
  },
  full: {
    type: Boolean,
    default: true
  },
  fixedBox: {
    type: Boolean,
    default: true
  },
  canMove: {
    type: Boolean,
    default: true
  },
  canMoveBox: {
    type: Boolean,
    default: true
  },
  original: {
    type: Boolean,
    default: false
  },
  centerBox: {
    type: Boolean,
    default: true
  },
  isHeightOut: {
    type: Boolean,
    default: true
  },
  infoTrue: {
    type: Boolean,
    default: false
  },
  maxImgSize: {
    type: Number,
    default: 3000
  },
  enlarge: {
    type: Number,
    default: 1
  },
})
const emit = defineEmits(['imgData'])
const fileName = ref('')              // 图片名称
const option = ref({
  img: '',                            //裁剪图片的地址
  outputSize: props.outPutSize,       //裁剪生成图片的质量(可选0.1 - 1)
  outputType: props.outPutType,       //裁剪生成图片的格式（jpeg || png || webp）
  info: props.info,                   //图片大小信息
  canScale: props.canScale,           //图片是否允许滚轮缩放
  autoCrop: true,                     //是否默认生成截图框
  autoCropWidth: props.width,         //默认生成截图框宽度
  autoCropHeight: props.height,       //默认生成截图框高度
  fixed: props.fixed,                 //是否开启截图框宽高固定比例
  fixedNumber: getRatio(props.width, props.height), //截图框的宽高比例
  full: props.full,               // false按原比例裁切图片，不失真
  fixedBox: props.fixedBox,       // 固定截图框大小，不允许改变
  canMove: props.canMove,         // 上传图片是否可以移动
  canMoveBox: props.canMoveBox,   // 截图框能否拖动
  original: props.original,       // 上传图片按照原始比例渲染
  centerBox: props.centerBox,     // 截图框是否被限制在图片里面
  height: props.isHeightOut,      // 是否按照设备的dpr 输出等比例图片
  infoTrue: props.infoTrue,       // true为展示真实输出图片宽高，false展示看到的截图框宽高
  maxImgSize: props.maxImgSize,   // 限制图片最大宽度和高度
  enlarge: props.enlarge,         // 图片根据截图框输出比例倍数
  mode: '230px 150px',            // 图片默认渲染方式
})
//初始化函数
const imgLoad = (msg) => {
  // cropper.value.goAutoCrop() // 自动生成截图框
}
//图片缩放
function changeScale (num) {
  num = num || 1
  cropper.value.changeScale(num)
}
//向左旋转
function rotateLeft () {
  // console.log(cropper)
  cropper.value.rotateLeft()
}
//向右旋转
function rotateRight () {
  cropper.value.rotateRight()
}
//实时预览函数
function realTime (data) {
  previews.value = data
}
// 判断宽高比决定是否为横向布局
const isRow = ref(false)
const previewIsRow = () => {
  const width = option.value.autoCropWidth
  const height = option.value.autoCropHeight
  isRow.value = width <= height
}
onMounted(() => {
  previewIsRow()
})
 
//选择图片
function selectImg (e) {
  if (e.target.files.length===0){
    return
  }
  let file = e.target.files[0]
  if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG)$/.test(e.target.value)) {
    ElMessage.error('图片类型要求：gif,jpeg,jpg,png,bmp');
    return false
  }
  //转化为blob
  let reader = new FileReader()
  reader.onload = (e) => {
    let data
    if (typeof e.target.result === 'object') {
      data = window.URL.createObjectURL(new Blob([e.target.result]))
    } else {
      data = e.target.result
    }
    fileName.value = file.name
    option.value.img = data
  }
  //转化为base64
  reader.readAsDataURL(file)
  console.log('file', reader)
  // 转化为blob
  // reader.readAsArrayBuffer(file);
}
//上传图片
async function uploadImg (type) {
  await cropper.value.getCropBlob(async (data) => {
    let file = new File([data], fileName.value,{type: data.type})
    // console.log(file)
    emit('imgData', {url: URL.createObjectURL(file), name:fileName.value, raw: file, showOverlay:false})
  })
  visible.value = false
}
 
// 获取截图框的宽高比
function getRatio(a, b) {
  // 确保a和b都不为0
  if (a === 0 || b === 0) {
    throw new Error('Both numbers must be non-zero.');
  }
 
  // 找到a和b中较小的绝对值，并确定比例的顺序
  let smaller = Math.abs(a) < Math.abs(b) ? a : b;
  let larger = Math.abs(a) >= Math.abs(b) ? a : b;
 
  // 通过较小的绝对值来除以较大的数，得到简化后的比例
  let ratio = larger / smaller;
 
  // 如果比例大于1，则顺序为[1, 几]，否则为[几, 1]
  const r = larger === b ? [1, ratio] : [ratio, 1];
  // console.log(r)
  return r;
}
</script>
 
<style lang="scss" scoped>
.cropper-content{
  display: flex;
  display: -webkit-flex;
  flex-direction: column;
  justify-content: flex-end;
 
  .cropper-box-container{
    display: flex;
  }
 
  .cropper-box{
    margin: 15px 0;
    flex: 1;
    width: 100%;
    .cropper{
      width: auto;
      height: 450px;
    }
  }
 
  .show-preview{
    margin: 15px 0;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: center;
    background-color: #ddd;
    .tupianyulan{
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .preview{
      overflow: hidden;
      border:1px solid #67c23a;
      background: #cccccc;
    }
  }
}
.footer-btn{
  display: flex;
  display: -webkit-flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 15px;
 
  .scope-btn{
    display: flex;
    display: -webkit-flex;
    justify-content: space-between;
    align-items: center;
    padding-right: 10px;
  }
  .upload-btn{
    flex: 1;
    -webkit-flex: 1;
    display: flex;
    display: -webkit-flex;
    justify-content: end;
  }
  .btn {
    outline: none;
    display: inline-block;
    line-height: 1;
    white-space: nowrap;
    cursor: pointer;
    -webkit-appearance: none;
    appearance: none;
    text-align: center;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    outline: 0;
    -webkit-transition: .1s;
    transition: .1s;
    font-weight: 500;
    padding: 8px 15px;
    font-size: 12px;
    border-radius: 3px;
    color: #fff;
    background-color: #409EFF;
    border-color: #409EFF;
    margin-right: 10px;
  }
}
@media screen and (max-width: 768px) {
  .cropper-content {
    padding: 10px;
    
    .cropper-box {
      margin: 8px 0;
      
      .cropper {
        height: 50vh;
        max-height: none;
        width: 100%;
      }
    }
    
    .show-preview {
      margin: 8px 0;
      width: 50vw;
      height: 50vh;
    }
  }
  
  .footer-btn {
    flex-wrap: wrap;
    gap: 8px;
    
    .btn {
      padding: 6px 12px;
      margin-right: 5px;
    }
  }
}
</style>