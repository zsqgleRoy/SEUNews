<template>
    <img src="http://seunewsbac.pgrm.cc/static/news-images/20250330213618432_3aa9c662.png" alt="Logo" class="logo" />
    <div class="search-panel">
      <div class="section-head">
        <el-divider class="section-title"><h2 class="section-title">新闻检索中心</h2></el-divider>
      </div>
      <!-- 搜索栏 -->
      <div class="search-header">
        <el-input
          v-model="keyword"
          @input="debouncedSearch"
          placeholder="请输入关键词..."
          clearable
          @keyup.enter="handleSearch"
          @clear="handleSearch"
          class="search-input"
        >
          <template #append>
            <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
          </template>
        </el-input>
      </div>
  
      <!-- 分类标签 -->
      <div class="category-tabs">
        <el-radio-group v-model="mainCategory" @change="handleCategoryChange">
          <el-radio-button label="新闻" />
          <el-radio-button label="视频" />
          <el-radio-button label="名人" />
        </el-radio-group>
  
        <div class="sub-categories" v-if="subCategories.length">
          <el-tag
            v-for="tag in subCategories"
            :key="tag"
            :type="activeSubCategory === tag ? 'primary' : 'info'"
            effect="plain"
            @click="handleSubCategoryClick(tag)"
          >
            {{ tag }}
          </el-tag>
        </div>
      </div>
  
      <!-- 结果统计 -->
      <div class="result-stats" v-if="showResults">
        <el-text type="info">
            找到 <span style="color: red;">{{ total }}</span> 条相关结果（ 
            <span style="color: red;">{{ searchTime }}ms</span> ）
        </el-text>
      </div>
  
      <!-- 加载状态 -->
      <el-skeleton :rows="5" animated v-if="loading" />
  
      <!-- 结果列表 -->
      <div class="result-list" v-else-if="showResults">
        <div v-for="item in results" :key="item.id" class="result-item">
          <div class="item-media">
            <img :src="item.headImageUrl" alt="新闻图片" class="result-image" v-if="item.headImageUrl" />
            <div class="image-placeholder" v-else>
              <el-icon :size="40" color="#909399"><Picture /></el-icon>
            </div>
          </div>
          
          <div class="item-content">
            <div class="content-header">
              <el-tag size="small" :type="getCategoryType(item.category)" class="category-tag">{{ item.category }}</el-tag>
              <el-text type="info" size="small" class="publish-time">
                {{ formatDate(item.publishDate) }}
              </el-text>
            </div>
            
            <h3 class="item-title">
              <el-text type="primary" tag="strong">{{ item.title }}</el-text>
            </h3>
            
            <section class="item-desc" v-html="item.content"></section>
            
            <div class="item-footer">
              <div class="footer-left">
                <el-text type="info" size="small" class="source-info">
                  <img v-if="item.avatar" alt="a" :src="item.avatar"/><el-icon v-else><User /></el-icon> {{ item.author || '未知作者' }}
                </el-text>
                <el-divider direction="vertical" />
                <el-text type="info" size="small" class="source-info">
                  <el-icon><OfficeBuilding /></el-icon> {{ item.source || item.author || '未知来源' }}
                </el-text>
              </div>
              <div class="item-actions">
                <el-button link type="primary" @click="handlePreview(item)">
                  <el-icon><View /></el-icon> 预览
                </el-button>
                <el-divider direction="vertical" />
                <el-button link type="primary" @click="handleShare(item)">
                  <el-icon><Share /></el-icon> 分享
                </el-button>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <!-- 空状态 -->
      <el-empty v-else-if="showEmpty" :description="emptyText" />
  
      <!-- 分页 -->
      <el-pagination
        v-if="showPagination"
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :total="total"
        :page-sizes="[10, 20, 50]"
        layout="total, sizes, prev, pager, next, jumper"
        background
        @size-change="handlePageChange"
        @current-change="handlePageChange"
      />
    </div>
</template>
  
<script setup lang="ts">
  import { ref, computed, onMounted, watch, nextTick } from 'vue'
  import { Search } from '@element-plus/icons-vue'
  import type { SearchResult, SearchParams } from './types'
  import { debounce } from 'lodash'
  import { getNewsListBySearch, ArticleStatus } from '@/api/news'
  import { useRoute, useRouter } from 'vue-router'
  import { formatDate } from '@/utils/format'
  import { ElMessage } from 'element-plus'
  const route = useRoute()
  const router = useRouter()
  interface Props {
    categories?: CategoryConfig
    initialKeyword?: string
  }
  
  interface CategoryConfig {
    [main: string]: string[]
  }
  
  const props = withDefaults(defineProps<Props>(), {
    categories: () => ({
      '新闻': ['全部', '国内', '国际', '财经'],
      '视频': ['热门', '最新', '原创'],
      '名人': ['演员', '歌手', '作家']
    }),
    initialKeyword: ''
  })
  
  const emit = defineEmits<{
    (e: 'search', params: SearchParams): void
    (e: 'preview', item: SearchResult): void
    (e: 'share', item: SearchResult): void
  }>()
  
  // 响应式数据
  const keyword = ref(props.initialKeyword)
  const mainCategory = ref('新闻')
  const activeSubCategory = ref('')
  const currentPage = ref(1)
  const pageSize = ref(10)
  const total = ref(0)
  const results = ref<SearchResult[]>([])
  const loading = ref(false)
  const searchTime = ref(0)
  
  // 计算属性
  const subCategories = computed(() => props.categories[mainCategory.value] || [])
  const showResults = computed(() => results.value.length > 0)
  const showEmpty = computed(() => !loading.value && !showResults.value)
  const showPagination = computed(() => total.value > pageSize.value)
  const emptyText = computed(() => 
    keyword.value ? `未找到"${keyword.value}"相关结果` : '请输入搜索关键词'
  )
  
  // 分类处理
  const handleCategoryChange = (category: string) => {
    mainCategory.value = category
    activeSubCategory.value = props.categories[category][0] || ''
    triggerSearch()
  }
  
  const handleSubCategoryClick = (category: string) => {
    activeSubCategory.value = category
    triggerSearch()
  }
  
  watch(results, () => {
    nextTick(() => {
      document.querySelectorAll('.item-desc img').forEach(img => img.remove())
    })
  })

  // 搜索处理
  const triggerSearch = async () => {
    if (!keyword.value.trim()) return
    loading.value = true
    const startTime = Date.now(); // 记录开始时间
    const params = {
      keyword: keyword.value,
      tag: mainCategory.value || "",
      subTag: activeSubCategory.value || "",
      page: currentPage.value,
      pageSize: pageSize.value,
      status: ArticleStatus.PUBLISH
    }
  
    emit('search', params)
    try{
      const response = await getNewsListBySearch(params);
      console.log('搜索结果:', response?.data.content);
      results.value = response?.data.content;
      results.value.forEach(item => {
        item.category = params.tag; // 将 tag 映射到 category
      });
      total.value = response?.data.totalElements;

      searchTime.value = Date.now() - startTime; // 计算搜索耗时
    } catch (error) {
      console.error('搜索失败:', error)
    } finally {
      loading.value = false
    }
    }
  
    const handlePreview = (item: SearchResult) => {
      router.push(`/news/${item.article_id}`)
      // emit('preview', item)
    }
    const handleShare = (item: SearchResult) => {
      emit('share', item)
    }
  
  const handlePageChange = () => triggerSearch()
  const handleSearch = () => {
    if (!keyword.value.trim()) {
      ElMessage.warning('请输入搜索关键词')
      return
    }
    currentPage.value = 1
    triggerSearch()
  }
  
  // 类型颜色映射
  const getCategoryType = (category: string) => {
    const types: Record<string, any> = {
      '新闻': 'success',
      '视频': 'warning',
      '名人': 'danger'
    }
    return types[category] || 'info'
  }
  const debouncedSearch = debounce(triggerSearch, 500)
  watch(
    () => route.params.query,
    (newQuery) => {
      if (newQuery) {
        keyword.value = newQuery as string
        handleSearch();
      }
    }
  );

  onMounted(() => {
    const newQuery = route.params.query;
    keyword.value = newQuery as string;
  });
</script>
  
<style scoped lang="scss">
  .logo {
    user-select: none;
    display: block;
    width: 100%;
    height: auto;
  }
  .section-head {
    width: 100%;
    min-height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;;
    margin-bottom: 30px;
  }
  
  .section-title {
    width: 100%;
    height: 100%;
    padding: 0;
    color: transparent;
    font-size: 40px;
    font-family: "楷体_GB2312";
    font-weight: 900;
    background: linear-gradient(135deg, #0055ff, #6b00bc);
    -webkit-background-clip: text;
    background-clip: text;
    border-image: linear-gradient(135deg, #0055ff, #6b00bc) 1;
    border-width: 2.5px;
    text-transform: uppercase;
    letter-spacing: 1px;
    text-align: center;
  }
  .search-panel {
    user-select: none;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.1);
    padding: 5vh;
    min-height: 86vh;
    .search-header {
      margin-bottom: 20px;
      
      .search-input {
        :deep(.el-input-group__append) {
          background-color: var(--el-color-primary);
          .el-button {
            color: #fff;
          }
        }
      }
    }
  
    .category-tabs {
      margin-bottom: 20px;
      
      .el-radio-group {
        margin-bottom: 12px;
      }
  
      .sub-categories {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
  
        .el-tag {
          cursor: pointer;
          transition: all 0.3s;
  
          &:hover {
            transform: translateY(-2px);
          }
        }
      }
    }
  
    .result-stats {
      margin-bottom: 16px;
      border-bottom: 1px solid var(--el-border-color);
      padding-bottom: 12px;
    }
  
    .result-list {
      .result-item {
        display: flex;
        gap: 50px;
        padding: 20px;
        margin-bottom: 16px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        
        &:hover {
          box-shadow: 0 4px 12px rgba(0,0,0,0.12);
          transform: translateY(-2px);
        }

        .item-media {
          flex: 0 0 180px;
          height: 194px;
          border-radius: 4px;
          overflow: hidden;
          
          .result-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
          }
          
          .image-placeholder {
            @extend .result-image;
            background: #f5f7fa;
            display: flex;
            align-items: center;
            justify-content: center;
          }
        }

        .item-content {
          flex: 1;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          
          .content-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 12px;
            
            .category-tag {
              align-self: flex-start;
              border-radius: 4px;
              font-weight: 500;
            }
            
            .publish-time {
              margin-left: auto;
            }
          }

          .item-title {
            margin: 0 0 12px;
            font-size: 18px;
            line-height: 1.4;
            @media (hover: hover) {
              &:hover {
                color: var(--el-color-primary);
                cursor: pointer;
              }
            }
          }

          .item-desc {
            flex: 1;
            margin: 0 0 16px;
            color: var(--el-text-color-secondary);
            line-height: 1.6;
            padding-right: 40px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
          }

          .item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            
            .footer-left {
              display: flex;
              align-items: center;
              gap: 8px;
              
              .source-info {
                display: inline-flex;
                align-items: center;
                gap: 4px;
                flex: 0 0 100px;
                height: 50px;
                border-radius: 50%;
                overflow: hidden;
              }
              .source-info img {
                width: 20px;
                height: 20px;
                border-radius: 50%;
              }
            }

            .item-actions {
              .el-button {
                display: inline-flex;
                align-items: center;
                gap: 4px;
                padding: 0 8px;
                
                .el-icon {
                  font-size: 16px;
                }
              }
            }
          }
        }
      }

      @media screen and (max-width: 768px) {
        .result-item {
          flex-direction: column;
          padding: 16px;
          
          .item-media {
            flex: none;
            height: 180px;
          }
          
          .item-content {
            .item-title {
              font-size: 16px;
            }
            
            .item-desc {
              -webkit-line-clamp: 2;
              line-clamp: 2;
            }
            
            .item-footer {
              flex-direction: column;
              align-items: flex-start;
              gap: 12px;
              
              .item-actions {
                width: 100%;
                justify-content: space-between;
              }
            }
          }
        }
      }
    }
  
    .el-pagination {
      margin-top: 24px;
      justify-content: center;
    }
  }

  @media screen and (max-width: 768px) {
    .search-panel {
      padding: 2vh;
    }
    .section-head {
      margin-bottom: 10px;
    }
    .section-title {
      font-size: 19.5px;
    }
    .result-list {
      .result-item {
        padding: 12px;
      }
      .item-media {
        height: 80px;
      }
    }
    .el-pagination {
      margin-top: 16px;
      display: flex;
      flex-wrap: wrap;
      padding: 0 10px;

      /* 缩小分页按钮字体和间距 */
      .el-pagination__sizes,
      .el-pagination__btn-group,
      .el-pagination__jumper {
        font-size: 12px;
        margin: 4px 0;
      }

      .el-pagination__item,
      .el-pagination__prev,
      .el-pagination__next {
        padding: 4px 8px;
      }
    }
  }
</style>