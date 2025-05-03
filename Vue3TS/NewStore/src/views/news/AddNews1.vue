<template>
  <div class="add-news">
    <div class="add-news-header">
      <h1>添加新闻</h1>
    </div>
    <!-- 新闻标题输入框 -->
    <input
      type="text"
      v-model="newsTitle"
      placeholder="请输入新闻标题"
      class="news-title-input"
    />
    <!-- 新闻时间选择器 -->
    <input
      type="datetime-local"
      v-model="newsTime"
      step="1"
      class="news-time-input"
    />
    <!-- 文章状态选择框 -->
    <select v-model="articleStatus">
      <option value="DRAFT">草稿</option>
      <option value="PUBLISHED">已发布</option>
    </select>
    <!-- 富文本编辑器 -->
    <QuillEditor
      ref="quillEditorRef"
      theme="snow"
      v-model:content="editorContent"
      :options="editorOptions"
      contentType="html"
      @update:content="handleContentUpdate"
    />
    <!-- 保存新闻按钮 -->
    <button class="button-submit" @click="saveNews">保存新闻</button>
  </div>
</template>

<script setup lang="ts">
import '@vueup/vue-quill/dist/vue-quill.snow.css'
import "@/assets/styles/quill-fonts.scss"
import "@/assets/styles/quill-custom.scss"
import { computed, onMounted, ref } from 'vue';
import Quill from 'quill';
import { ElMessage } from 'element-plus';
import { publishNews as apiPublishNews } from '@/api/news';
import { apiUploadNewsImage as apiUploadNewsImage } from '@/api/media';
import { useRouter } from 'vue-router';
import { quillConfig } from '../../lib/quill-config'
import '../assets/styles/quill-custom.scss'

// 修改初始化逻辑
const initQuillFonts = () => {
  const Font = Quill.import('formats/font') as any;
  const FontClass = Quill.import('attributors/class/font');
  
  // 关键修改点：保持字体标识符与 CSS 类名一致
  Font.whitelist = [
    'SimSun',        // 对应 .ql-font-SimSun
    'SimHei',        // 对应 .ql-font-SimHei
    'Microsoft-YaHei', // 对应 .ql-font-Microsoft-YaHei（注意中间是连字符）
    'KaiTi',
    'FangSong',
    'Arial',
    'Times-New-Roman', 
    'sans-serif'
  ];
  
  // Quill.register('formats/font', Font, true);
  Quill.register(Font, true);
  // Quill.register(FontStyle, true);
  // 初始化事件监听
 
};

const router = useRouter();
// 类型声明
interface UploadResponse {
  data: string;
}

// 编辑器内容
const editorContent = ref('')
// 新闻标题
const newsTitle = ref('')
// 新闻时间
const newsTime = ref<Date | null>(null)
// 文章状态
const articleStatus = ref('DRAFT')

const imageHandler = () => {
  const input = document.createElement('input');
  input.setAttribute('type', 'file');
  input.setAttribute('accept', 'image/*');
  input.onchange = async () => {
    const file = input.files?.[0];
    if (file) {
      const loading = ElMessage.info('图片上传中...');
      try {
        const response = await apiUploadNewsImage(file);
       
        ElMessage.success('图片上传成功');
      } catch (error) {
        ElMessage.error('图片上传失败');
      } finally {
        loading.close();
      }
    }
  };
  input.click();
};

const fontFamily = [
  'SimSun',
  'SimHei', 
  'Microsoft-YaHei', 
  'KaiTi', 
  'FangSong', 
  'Arial', 
  'pingfang',
  'Times-New-Roman',
  'sans-serif'
];
// 修改编辑器配置
const editorOptions = ref({
  modules: {
    toolbar: {
      container: [
        ['bold', 'italic', 'underline', 'strike'],
        [{ size: ['small', false, 'large', 'huge'] }],
        [{ font: fontFamily }],
        [{ align: [] }],
        [{ list: 'ordered' }, { list: 'bullet' }],
        [{ indent: '-1' }, { indent: '+1' }],
        [{ header: [1, 2] }],
        ["link"], ['image'], ["video"],  // 媒体按钮
        [{ direction: 'rtl' }],
        [{ color: [] }, { background: [] }]
      ],
      handlers: {
        image: imageHandler  // 添加图片处理函数
      }
    }
  },
  placeholder: '请输入新闻内容...'
});

// 内容更新处理
const handleContentUpdate = (content: string) => {
  editorContent.value = content
}
// 定义 UserInfo 类型，移除 password 字段
interface UserInfo {
  userId: number;
  username: string;
  email: string;
  registerDate: Date;
}

// 在组件挂载时调用字体注册函数
onMounted(() => {
  initQuillFonts();
});

const saveNews = async () => {
  const title = newsTitle.value
  const timeValue = newsTime.value;
  const storedUserInfo = localStorage.getItem('userInfo');
  const userStore = ref(storedUserInfo ? JSON.parse(storedUserInfo) : null);
  const userInfo = computed<UserInfo | null>(() => userStore.value as UserInfo | null);
  const info = ref({
    name: userInfo.value?.username || '',
  })
  const content = editorContent.value
  const status = articleStatus.value
  if (!title || !timeValue || !content) {
    ElMessage.error(`新闻标题、时间和正文不能为空！`);
    return
  }
  else if (!userInfo) {
    ElMessage.error(`您不是管理员！`);
  }

  try {
    const response = await apiPublishNews({
      title: title,
      publishDate: timeValue,
      updateDate: timeValue,
      content: content,
      authorId: 1,
      status: status,
    });
    setTimeout(() => {
      router.push('/home');
    }, 2000);
    newsTitle.value = ''
    newsTime.value = null
    editorContent.value = ''
    articleStatus.value = 'DRAFT'
  } catch (error) {
  }
}
</script>


<style scoped lang="scss">
/* 全局样式重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Inter', sans-serif;
}

/* 整体容器样式 */
.add-news {
  width: 100%;;
  margin: 2rem auto;
  padding: 2rem;
  background-color: #fff;
  border-radius: 20px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  animation: fadeIn 0.3s ease-out;

  &-header {
    margin-bottom: 2.5rem;
    border-bottom: 2px solid #e5e7eb;
    padding-bottom: 2rem;

    h1 {
      font-size: 2.5rem;
      font-weight: 700;
      color: #111827;
      text-align: center;
      background: linear-gradient(135deg, #3b82f6, #059669);
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
    }
  }
}

/* 输入框组样式 */
.form-group {
  margin-bottom: 2rem;
  display: grid;
  gap: 1.5rem;

  label {
    font-size: 1.125rem;
    font-weight: 500;
    color: #4b5563;
    margin-bottom: 0.75rem;
    display: block;
  }
  input,
  select {
    margin: 10px;;
    padding: 1.25rem 1.5rem;
    border: 2px solid #e5e7eb;
    border-radius: 16px;
    font-size: 1.125rem;
    color: #111827;
    transition: all 0.2s ease;
    background: #f9fafb;

    &:focus {
      outline: none;
      border-color: #3b82f6;
      box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
    }

    &::placeholder {
      color: #6b7280;
    }

    &:disabled {
      background: #f3f4f6;
      cursor: not-allowed;
    }
  }

  input[type="datetime-local"] {
    padding: 1.25rem;
    display: flex;
    align-items: center;
    gap: 1rem;

    &::-webkit-calendar-picker-indicator {
      filter: invert(40%) sepia(90%) saturate(2000%) hue-rotate(190deg) brightness(100%) contrast(100%);
      margin-right: 1rem;
    }
  }

  select {
    appearance: none;
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%236b7280'%3e%3cpath d='M7.41 7.84l4.59 4.59L16.17 7z'/%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 1.5rem center;
    background-size: 16px;
    padding-right: 3.5rem;
  }
}

/* 富文本编辑器样式 */
.ql-container {
  border-radius: 20px !important;
  border: 2px solid #e5e7eb !important;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04) !important;
  margin-bottom: 2rem;

  .ql-editor {
    min-height: 500px;
    padding: 2rem;
    font-size: 1.125rem;
    line-height: 1.6;
    color: #111827;

    img {
      max-width: 100%;
      height: auto;
      margin: 2rem 0;
      border-radius: 12px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
      transition: transform 0.2s ease;

      &:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
      }
    }
  }

  .ql-toolbar {
    border-radius: 20px 20px 0 0 !important;
    background-color: #f9fafb !important;
    border: none !important;
    box-shadow: none !important;

    button {
      color: #4b5563 !important;
      transition: all 0.2s ease;
      padding: 1rem 1.5rem;
      border-radius: 12px;

      &:hover {
        color: #3b82f6 !important;
        background-color: #e9edff !important;
      }

      &.ql-active {
        color: #059669 !important;
        background-color: #d1fae5 !important;
        font-weight: 600;
      }
    }
  }
}

/* 保存按钮样式 */
button {
  padding: 1.25rem 2.5rem;
  background: linear-gradient(135deg, #3b82f6, #059669);
  color: #fff;
  border: none;
  border-radius: 24px;
  font-size: 1.125rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  width: 100%;
  box-shadow: 0 4px 16px rgba(59, 130, 246, 0.2), 0 4px 16px rgba(5, 150, 105, 0.2);

  &:hover {
    background: linear-gradient(135deg, #2563eb, #047857);
    box-shadow: 0 6px 24px rgba(59, 130, 246, 0.3), 0 6px 24px rgba(5, 150, 105, 0.3);
  }

  &:disabled {
    background: #e5e7eb;
    color: #9ca3af;
    box-shadow: none;
    cursor: not-allowed;
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .add-news {
    margin: 1rem;
    padding: 1.5rem;
  }

  .form-group {
    gap: 1.25rem;
  }

  input, select {
    padding: 1rem 1.25rem;
    font-size: 1rem;
  }
}

/* 动画效果 */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
.button-submit{
  margin-top: 20px;
}
</style>


