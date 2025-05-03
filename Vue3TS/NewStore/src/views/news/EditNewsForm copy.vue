<template>
    <div class="editor-container">
      <div class="add-news-header">
        <h1>修改新闻</h1>
      </div>
      <div class="input-row">
        <div class="input-group">
          <input
            type="text"
            v-model="newsTitle"
            placeholder="请输入新闻标题"
            class="news-title-input"
          />
          <br/>
          <br/>
          <input
            type="datetime-local"
            v-model="updateTime"
            step="1"
            class="news-time-input"
          />
          <br/>
          <br/>
          <!-- 文章状态选择框 -->
          <select v-model="articleStatus">
            <option value="DRAFT">草稿</option>
            <option value="PUBLISHED">已发布</option>
          </select>
          <button class="button-submit" @click="updateNews">保存修改</button>
        </div>
  
        <div class="button-group">
          <apiUploadHeadImage/>
        </div>
      </div>
  
      <Toolbar
        :editor="editorRef"
        :defaultConfig="toolbarConfig"
        :mode="mode"
      />
      <Editor
        v-model="valueHtml"
        :defaultConfig="editorConfig"
        :mode="mode"
        @onCreated="handleCreated"
      />
    </div>
</template>
  
<script lang="ts">
  import { defineComponent, shallowRef, onBeforeUnmount, ref, computed, toRefs, watch, nextTick } from 'vue'
  import '@wangeditor/editor/dist/css/style.css'
  import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
  import type { IDomEditor, IEditorConfig } from '@wangeditor/editor'
  import { ElMessage } from 'element-plus';
  import apiUploadHeadImage from '../media/Upload.vue';
  import { apiUpdateNews } from '@/api/news';
  
  type InsertFnType = (url: string, alt: string, href: string) => void
  
  interface UserInfo {
    user_id: number;
    username: string;
    email: string;
    registerDate: Date;
  }
  
  export default defineComponent({
    components: { Editor, Toolbar, apiUploadHeadImage },
    props: {
      news: {
        type: Object,
        required: true
      }
    },
    setup(props) {
      
      const { news } = toRefs(props);
      const newsTitle = ref(news.value.title);
      const updateDate = ref(new Date());
      const articleStatus = ref(news.value.status);
      const editorRef = shallowRef<IDomEditor | null>(null)
      const valueHtml = ref(news.value.content);
      // 从 localStorage 中获取用户信息
      const storedUserInfo = localStorage.getItem('userInfo');
      // 解析用户信息
      const userStore = ref(storedUserInfo ? JSON.parse(storedUserInfo) : null);
      // 创建计算属性
      const userInfo = computed<UserInfo | null>(() => userStore.value as UserInfo | null);
      // 编辑器配置
      const toolbarConfig = { excludeKeys: ['fullScreen'] }
      const editorConfig: Partial<IEditorConfig> = { 
        placeholder: '输入内容...',
        MENU_CONF: {
          uploadImage: {
            server: '/api/upload/newsImg',
            fieldName: 'file', // 对应后端 @RequestParam("file")
            headers: {
              Authorization: `1` 
              
            },
            // 自定义插入图片处理
            customInsert(res: any, insertFn: InsertFnType) {
              if (res.code !== 200) {
                ElMessage.error('插入图片失败');
                return
              }
              console.log(res.data.error);
              // 根据你的ApiResponse结构调整
              const url = res.data?.data?.url 
              console.log(res.data?.data?.url)
              if (url) {
                insertFn(url, '', '') 
                ElMessage.success("添加图片成功！");
              }
            },
            // 错误处理
            onError(file: File, err: any, res: any) {
              console.error('上传错误:', err, res)
            }
          }
        }
      }
      
      watch(
      () => props.news,
      (newVal) => {
        newsTitle.value = newVal.title
        updateDate.value = newVal.updateDate
        articleStatus.value = newVal.status
        valueHtml.value = newVal.content
        
        // 更新编辑器内容
        nextTick(() => {
          if (editorRef.value && newVal.content !== editorRef.value.getHtml()) {
            editorRef.value.setHtml(newVal.content)
          }
        })
      },
      { deep: true, immediate: true }
    )

      // 销毁编辑器
      onBeforeUnmount(() => {
        editorRef.value?.destroy()
      })
  
      const handleCreated = (editor: IDomEditor) => {
        editorRef.value = editor
        editorConfig.scroll = true
      }
  
      const updateNews = async () => {
        try {
          const newsData = {
            id: news.value.id,
            title: newsTitle.value,
            updateDate: updateDate.value,
            status: articleStatus.value,
            content: valueHtml.value
          };
          const response = await apiUpdateNews(newsData);
          ElMessage.success('新闻修改成功！');
        } catch (error) {
          console.error('新闻修改失败:', error);
          ElMessage.error('新闻修改失败，请稍后重试！');
        }
      };

      return {
        newsTitle,
        updateDate,
        articleStatus,
        editorRef,
        valueHtml,
        mode: 'default' as const,
        toolbarConfig,
        editorConfig,
        handleCreated,
        updateNews,
        apiUploadHeadImage
      }
    }
  })
</script>
  
  
<style lang="scss">
  /* 新增布局样式 */
  /* 整体容器样式 */
  .add-news {
    width: 100%;;
    border-radius: 20px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
    animation: fadeIn 0.3s ease-out;
  
    &-header {
  
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
  .input-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    padding: 0 2rem;
  }
  
  .input-group {
    flex: 1;
    max-width: 400px;
    margin: 0 1rem;
  }
  
  .button-group {
    flex: 0 0 auto;
    margin-left: 2rem;
  }
  
  select{
    padding: 1rem 1.5rem;
    background: linear-gradient(135deg, #3b82f6, #059669);
    margin-right: 20px;
    transition: all 0.2s ease;
  }
  
  /* 原有样式优化 */
  .news-title-input,
  .news-time-input {
    width: 100%;
    padding: 1rem 1.25rem;
    border: 2px solid #e5e7eb;
    border-radius: 16px;
    font-size: 1.125rem;
    background: hsl(210, 20%, 98%);
  }
  
  .button-submit {
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
  }
  
  /* 响应式设计 */
  @media (max-width: 1024px) {
    .input-row {
      flex-direction: column;
      align-items: stretch;
      padding: 0;
    }
  
    .input-group,
    .button-group {
      min-width: 40%;
    }
  
    .button-group {
      margin-left: 0;
      display: flex;
      justify-content: flex-end;
    }
  }
</style>    