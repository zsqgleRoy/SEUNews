<template>
  <div v-if="isLoading">
    <el-skeleton style="width: 240px">
      <template #template>
        <el-skeleton-item variant="image" style="width: 240px; height: 240px" />
        <div style="padding: 14px">
          <el-skeleton-item variant="p" style="width: 50%" />
          <div
            style="
              display: flex;
              align-items: center;
              justify-items: space-between;
            "
          >
            <el-skeleton-item variant="text" style="margin-right: 16px" />
            <el-skeleton-item variant="text" style="width: 30%" />
          </div>
        </div>
      </template>
    </el-skeleton>
  </div>
  <div v-else class="file-upload">
    <div class="upload-area" @click="fileInput?.click()">
      <input
        type="file"
        @change="handleFileChange"
        ref="fileInput"
        class="file-input"
      />
      <div v-if="thumbnailUrl" class="thumbnail">
        <img :src="thumbnailUrl" alt="Thumbnail" />
      </div>
      <div v-else class="upload-icon">
        <el-icon :size="50"><UploadFilled /></el-icon>
      </div>
      <div v-if="!selectedFile && !headImageUrl" class="upload-text">
        <h3>点击/拖拽以上传</h3>
        <p>支持格式: PNG, JPG, PDF</p>
      </div>
    </div>
    <div v-if="selectedFileName" class="selected-file">
      {{ displayFileName }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { ElMessage } from 'element-plus';
import { ref, computed, watch, nextTick } from 'vue';
import { apiUploadHeadImage } from "@/api/media"

const props = defineProps({
  headImageUrl: {
    type: String,
    default: ''
  }
});

const isLoading = ref(true); // 新增加载状态

const fileInput = ref<HTMLInputElement | null>(null);
const loading = ref(false);
const error = ref('');
const success = ref(false);
const selectedFile = ref<File | null>(null);
const selectedFileName = ref('');
const thumbnailUrl = ref(props.headImageUrl);
const emits = defineEmits(["sendParam"])

// 模拟加载完成
setTimeout(() => {
  isLoading.value = false;
}, 2000);

// 计算属性，处理文件名的显示
const displayFileName = computed(() => {
  if (selectedFileName.value.length > 15) {
    return selectedFileName.value.slice(0, 15) + '...';
  }
  return selectedFileName.value;
});

const handleFileChange = async (e: Event) => {
  const target = e.target as HTMLInputElement;
  const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/webp']; // 允许的图片类型
  selectedFile.value = target.files?.[0] || null;
  if (selectedFile.value) {
    if (!allowedTypes.includes(selectedFile.value.type)) {
      ElMessage.error('文件类型不正确，请您重试!');
      selectedFile.value = null;
      return;
    }
    selectedFileName.value = selectedFile.value.name;
    if (selectedFile.value.type.indexOf('image')!== -1) {
      try {
        const response = await apiUploadHeadImage(selectedFile.value);
        if (response.data.data.error === 0) {
          // 直接更新本地状态
          thumbnailUrl.value = response.data.data.data.url;
          emits("sendParam", thumbnailUrl.value);

          // 强制刷新视图
          await nextTick();
          const imgContainer = document.querySelector('.thumbnail');
          if (imgContainer) {
            imgContainer.innerHTML = `<img src="${thumbnailUrl.value}" alt="Thumbnail" />`;
          }
        }
      } catch (err: any) {
        if (err.response) {
          // 后端返回了错误响应
          ElMessage.error(`上传失败，错误信息: ${err.response.data.message || '意外错误'}`);
        } else {
          // 网络错误或其他异常
          ElMessage.error(`网络错误: ${err.message || '意外错误'}`);
        }
      }
    } else {
      thumbnailUrl.value = '';
    }
  } else {
    selectedFileName.value = '';
    thumbnailUrl.value = '';
  }
};

watch(
  () => props.headImageUrl,
  (newVal) => {
    if (newVal) {
      thumbnailUrl.value = newVal;
      // 立即更新 DOM
      nextTick(() => {
        const img = document.querySelector('.thumbnail img');
        if (img) img.src = newVal;
      });
    }
  },
  { immediate: true } // 确保组件创建时处理初始值
);
</script>

<style scoped>
.file-upload {
  max-width: 250px;
  max-height: 260px;
  padding: 0.5rem;
  border: 2px dashed #e0e0e0;
  border-radius: 12px;
  background: #f8f9fa;
  box-shadow: 0 4px 16px rgba(0,0,0,0.05);
  overflow: hidden; /* 防止内容溢出 */
}

.thumbnail {
  position: relative;
  overflow: hidden;
}

.upload-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0.5rem;
  max-width: 150px;
  max-height: 150px;
  border: 2px dashed #d0d0d0;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  overflow: hidden; /* 防止内容溢出 */
}

.upload-area:hover {
  background-color: #f0f2f5;
  border-color: #c0c0c0;
}

.upload-icon {
  min-width: 40px;
  min-height: 40px;
  color: #666;
}

.upload-text {
  text-align: center;
  max-width: 100%; /* 确保文本不超出区域 */
  overflow: hidden; /* 防止内容溢出 */
  text-overflow: ellipsis; /* 超出部分显示省略号 */
  white-space: nowrap; /* 文本不换行 */
  margin-bottom: 0;
}

.upload-text h3 {
  font-size: 1rem;
  font-weight: 500;
  color: #333;
}

.upload-text p {
  font-size: 0.9rem;
  color: #666;
}

.button-group {
  margin-top: 0;
  max-width: 40%; /* 确保按钮不超出区域 */
  overflow: hidden; /* 防止内容溢出 */
}

.upload-btn {
  padding: 0.5rem 0.5em;
  background: linear-gradient(135deg, #3b82f6, #059669);
  color: white;
  border: none;
  border-radius: 24px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.2);
  transition: all 0.3s ease;
  width: auto; /* 按钮宽度占满父容器 */
}

.upload-btn:hover {
  background: linear-gradient(135deg, #2563eb, #047857);
  box-shadow: 0 6px 18px rgba(59, 130, 246, 0.3);
}

.upload-btn:disabled {
  background: #e0e0e0;
  color: #666;
  cursor: not-allowed;
  box-shadow: none;
}

.error-tip {
  color: #dc2626;
  font-size: 0.9rem;
  margin-top: 1rem;
  max-width: 100%; /* 确保错误提示不超出区域 */
  overflow: hidden; /* 防止内容溢出 */
  text-overflow: ellipsis; /* 超出部分显示省略号 */
  white-space: nowrap; /* 文本不换行 */
}

.success-tip {
  color: #059669;
  font-size: 0.9rem;
  margin-top: 1rem;
  max-width: 100%; /* 确保成功提示不超出区域 */
  overflow: hidden; /* 防止内容溢出 */
  text-overflow: ellipsis; /* 超出部分显示省略号 */
  white-space: nowrap; /* 文本不换行 */
}

.file-input {
  display: none;
}

.selected-file {
  margin-top: 1rem;
  color: #333;
  max-width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 0.9rem; /* 调整字体大小 */
  padding: 0.25rem 0.5rem; /* 添加内边距 */
  border-radius: 4px; /* 添加圆角 */
}

.thumbnail {
  margin-bottom: 1rem;
  max-width: 100%;
  max-height: 200px;
  overflow: hidden; /* 防止内容溢出 */
}

.thumbnail img {
  max-width: 100%;
  max-height: 200px;
  object-fit: contain;
}

@media (max-width: 768px) {
  .file-upload {
    padding: 1rem;
  }

  .upload-area {
    padding: 1.5rem;
  }

  .upload-text h3 {
    font-size: 1.1rem;
  }

  .upload-text p {
    font-size: 0.8rem;
  }

  .upload-btn {
    padding: 0.6rem 1.2rem;
  }
}
</style>    