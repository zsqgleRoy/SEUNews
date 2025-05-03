<template>
  <div class="editor-container">
    <!-- 头部区域 -->
    <div class="add-news-header">
      <h1>添加新闻</h1>
    </div>

    <!-- 输入区域 -->
    <div class="input-row">
      <div class="input-group">
        <div class="form-item">
          <input
            type="text"
            v-model="newsTitle"
            placeholder="请输入新闻标题"
            class="news-title-input"
          />
        </div>
        <div class="form-item">
          <input
            type="datetime-local"
            v-model="newsTime"
            step="1"
            class="news-time-input"
          />
        </div>
        <div class="form-item">
          <div class="select-group">
            <select v-model="articleStatus" class="status-select">
              <option value="DRAFT">草稿</option>
              <option value="PUBLISHED">已发布</option>
            </select>
            <select v-model="selectedMenu" class="menu-select">
              <option v-for="menu in menuItems" :key="menu.tag_id" :value="menu.tag_id">{{ menu.label }}</option>
            </select>
          </div>
        </div>
        <div class="form-item">
          <button class="button-submit" @click="saveNews">保存新闻</button>
        </div>
      </div>

      <div class="button-group">
        <apiUploadHeadImage @send-param="reviewParam"/>
      </div>
    </div>

    <!-- 编辑器区域 -->
    <div class="editor-wrapper">
      <Toolbar
        style="border-bottom: 1px solid #e0e0e0;"
        :editor="editorRef"
        :defaultConfig="toolbarConfig"
        :mode="mode"
      />
      <Editor
        style="height: 500px; overflow-y: auto;"
        v-model="valueHtml"
        :defaultConfig="editorConfig"
        :mode="mode"
        @onCreated="handleCreated"
      />
    </div>
  </div>
</template>

<script lang="ts">
import '@wangeditor/editor/dist/css/style.css' // 引入 css
import { onBeforeUnmount, ref, shallowRef, onMounted, computed } from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import { ElMessage } from 'element-plus';
import type { IDomEditor, IEditorConfig } from '@wangeditor/editor';
import apiUploadHeadImage from '../media/Upload.vue';
import { useRouter } from 'vue-router';
import menuCache from '@/cache/menuCache'; // 引入菜单缓存模块
import { initialURL} from "@/lib/urls"
import { publishNews, type SaveData } from '@/api/news';
import { getMenuItemList } from '@/api/menu';
import userCache from '@/cache/userCache';

type InsertFnType = (
  url: string,
  alt: string,
  href: string
) => void

export default {
  components: { Editor, Toolbar, apiUploadHeadImage },
  setup() {
    const router = useRouter();
    const newsTitle = ref('');
    const now = new Date();
    const newsTime = ref("");
    const articleStatus = ref('DRAFT');
    const headImgUrl = ref();
    // 编辑器实例，必须用 shallowRef
    const editorRef = shallowRef<IDomEditor | null>(null)
    // 内容 HTML
    const valueHtml = ref()

    // 创建计算属性
    const userInfo = ref(userCache.getUserCache());

    // 菜单相关变量
    const menuItems = ref<string[]>([]);
    const selectedMenu = ref(1);
    onMounted(async () => {
      const cacheKey = menuCache.generateCacheKey();
      const cachedMenu = menuCache.getCache(cacheKey);
      if (cachedMenu) {
        menuItems.value = cachedMenu.map((item: { tag_id: any; label: any; }) => ({
          tag_id: item.tag_id,
          label: item.label
        }));
      } else {
        try {
          const response = await getMenuItemList();
          menuItems.value = response.data;
          // 保存缓存，有效期2小时
          menuCache.saveCacheData(cacheKey, response.data, 3600000);
        } catch (err: any) {
        }
      }

      const year = now.getFullYear();
      const month = String(now.getMonth() + 1).padStart(2, '0');
      const day = String(now.getDate()).padStart(2, '0');
      const hours = String(now.getHours()).padStart(2, '0');
      const minutes = String(now.getMinutes()).padStart(2, '0');
      const seconds = String(now.getSeconds()).padStart(2, '0');
      const formattedTime = `${year}-${month}-${day}T${hours}:${minutes}:${seconds}`;
      // 将格式化后的时间赋值给 newsTime
      newsTime.value = formattedTime;
    });

    const toolbarConfig = {}
    const editorConfig: Partial<IEditorConfig> = {
        placeholder: '输入内容...',
        MENU_CONF: {
            uploadImage: {
                server: initialURL.SERVER_URL + '/api/upload/newsImg',
                fieldName: 'file', // 对应后端 @RequestParam("file")
                headers: {
                    Authorization: `1` // 从本地存储获取token
                },
                // 自定义插入图片处理
                customInsert(res: any, insertFn: InsertFnType) {
                    if (res.code !== 200) {
                        console.error('上传失败:', res.msg)
                        return
                    }
                    // 根据你的ApiResponse结构调整
                    const url = res.data?.data?.url
                    if (url) {
                        insertFn(url, '', '') // 插入到编辑器
                        ElMessage.success("添加正文图片成功！");
                    }
                },
                // 错误处理
                onError(file: File, err: any, res: any) {
                  ElMessage.error('上传错误:'+ err + res);
                }
            }
        }
    }

    const reviewParam = (param: string) => {
        if (param) {
            headImgUrl.value = param;
            ElMessage.success("封面缓存成功！");
        } else {
            ElMessage.error("封面缓存失败！");
        }
    }

    const saveNews = async () => {
      if (!(newsTitle.value &&
          userInfo.value?.username &&
          newsTime.value &&
          articleStatus.value &&
          headImgUrl.value &&
          valueHtml.value &&
          selectedMenu.value)
      ) {
          ElMessage.error("新闻信息不完整，请您重试！");
          return;
      }
      const data: SaveData = {
          title: newsTitle.value,
          publishDate: newsTime.value,
          updateDate: newsTime.value,
          content: valueHtml.value,
          author: userInfo.value?.username,
          status: articleStatus.value,
          tag: selectedMenu.value,
          headImageUrl: headImgUrl.value
      };
      try {
          await publishNews(data);
      } catch (error) {
          console.error('保存新闻时出错:', error);
      }
    };

    // 增强的销毁处理
    const destroyEditor = () => {
      if (editorRef.value) {
        try {
          // 清理编辑器事件监听
          editorRef.value.destroy()
          // 手动清理 DOM 引用
          const editorElem = document.querySelector('.editor-content')
          if (editorElem && editorElem.parentNode) {
            editorElem.parentNode.removeChild(editorElem)
          }
        } catch (e) {
          console.error('编辑器销毁错误:', e)
        }
        editorRef.value = null
      }
    }
    // 组件卸载时的清理
    onBeforeUnmount(() => {
      destroyEditor()
      // 清理可能的残留元素
      const toolbars = document.querySelectorAll('.w-e-toolbar')
      toolbars.forEach(toolbar => {
        if (toolbar.parentNode) {
          toolbar.parentNode.removeChild(toolbar)
        }
      })
    })

    const handleCreated = (editor: any) => {
        editorRef.value = editor // 记录 editor 实例，重要！
    }

    return {
        newsTitle,
        newsTime,
        editorRef,
        articleStatus,
        valueHtml,
        mode: 'default', // 或 'simple'
        toolbarConfig,
        editorConfig,
        handleCreated,
        saveNews,
        reviewParam,
        menuItems,
        selectedMenu
      }
  },
}
</script>

<style scoped lang="scss">
/* 整体容器样式 */
.editor-container {
  max-width: 100vw;
  margin: 0 auto;
  padding: 2rem;
  background: #fff;
  box-shadow: 0 16px 40px rgba(0, 0, 0, 0.12);
  animation: fadeInUp 0.4s ease-out;

  @media (max-width: 1024px) {
    padding: 1.5rem;
  }
}

.editor-content {
  height: 500px !important;
  min-height: 300px;
  overflow-y: auto;
}
/* 调整编辑器容器高度 */
.editor-wrapper {
  height: auto;
  min-height: 300px;
}
/* 头部样式 */
.add-news-header {
  text-align: center;
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e0e0e0;

  h1 {
    font-size: 2.25rem;
    font-weight: 700;
    color: #1a202c;
    background: linear-gradient(135deg, #3b82f6, #059669);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    margin-bottom: 0.5rem;
  }

  p {
    font-size: 1.125rem;
    color: #4a5568;
  }
}

/* 输入区域样式 */
.input-row {
  display: flex;
  gap: 2rem;
  margin-bottom: 2rem;

  @media (max-width: 1024px) {
    flex-direction: column;
    gap: 1.5rem;
  }
}

.input-group {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.form-item {
  position: relative;
}

/* 输入框样式 */
.news-title-input,
.news-time-input {
  width: 100%;
  padding: 1rem 1.5rem;
  border: 2px solid #edf2f7;
  border-radius: 16px;
  font-size: 1.125rem;
  color: #1a202c;
  background: #f7fafc;
  transition: all 0.2s ease;

  &:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
  }

  &::placeholder {
    color: #a0aec0;
  }
}

/* 选择框样式 */
.select-group {
  display: flex;
  gap: 1.5rem;
  align-items: center;

  @media (max-width: 1024px) {
    flex-direction: column;
    align-items: stretch;
    gap: 1rem;
  }
}

select {
  flex: 1;
  padding: 1rem 1.5rem;
  background: linear-gradient(135deg, #3b82f6, #059669);
  color: #fff;
  border: none;
  border-radius: 80px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 4px 16px rgba(59, 130, 246, 0.2), 0 4px 16px rgba(5, 150, 105, 0.2);

  &:hover {
    background: linear-gradient(135deg, #059669, #3b82f6);
    box-shadow: 0 6px 24px rgba(59, 130, 246, 0.3), 0 6px 24px rgba(5, 150, 105, 0.3);
  }

  &:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
  }
}

option {
  color: #1a202c;
  background: #fff;
}

/* 按钮样式 */
.button-submit {
  padding: 1rem 3rem;
  background: linear-gradient(135deg, #3b82f6, #059669);
  color: #fff;
  border: none;
  border-radius: 80px;
  font-size: 1.125rem;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 4px 16px rgba(59, 130, 246, 0.2), 0 4px 16px rgba(5, 150, 105, 0.2);

  &:hover {
    background: linear-gradient(135deg, #059669, #3b82f6);
    box-shadow: 0 6px 24px rgba(59, 130, 246, 0.3), 0 6px 24px rgba(5, 150, 105, 0.3);
  }

  &:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
  }
}

/* 编辑器区域样式 */
.editor-wrapper {
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
}

/* 动画效果 */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .editor-container {
    padding: 1rem;
  }

  .add-news-header h1 {
    font-size: 1.75rem;
  }

  .input-row {
    gap: 1rem;
  }

  .select-group {
    gap: 1rem;
  }
}
</style>



