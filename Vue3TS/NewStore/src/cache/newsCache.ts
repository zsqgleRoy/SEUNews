// src/cache/newsCache.ts
import { ref } from 'vue';

interface CacheItem {
  data: {
    article_id: number;
            title: string;
            publishDate: string;
            updateDate: string;
            content: string;
            author: string;
            status: string;
            tag: number;
            headImageUrl: string;
            avatar?: string;
            likes?: number;
            coin?: number;
            favourite?: number;
            share?: number;
            authorId?: number;
  };
  timestamp: number;
  expires: number; // 缓存有效期（毫秒）
}

const cacheStorageKey = 'seu_news_cache';

// 初始化缓存
const newsCacheStorage = ref<Record<string, CacheItem>>({});

// 从 localStorage 加载缓存
const loadCache = () => {
  try {
    const cachedData = localStorage.getItem(cacheStorageKey);
    if (cachedData) {
      newsCacheStorage.value = JSON.parse(cachedData);
    }
  } catch (error) {
    console.error('缓存加载失败:', error);
    localStorage.removeItem(cacheStorageKey);
  }
};

// 保存缓存到 localStorage
const saveCache = () => {
  try {
    localStorage.setItem(cacheStorageKey, JSON.stringify(newsCacheStorage.value));
  } catch (error) {
    console.error('缓存保存失败:', error);
  }
};

// 生成分页缓存键
const generatePageKey = (params: {
  page: number;
  pageSize: number;
  status: string;
}) => {
  return `p_${params.page}_${params.pageSize}_${params.status}`;
};

// 生成新闻ID缓存键
const generateNewsIdKey = (id: string | number) => {
  return `n_${id}`;
};

// 检查缓存是否有效
const isCacheValid = (cacheItem: CacheItem) => {
  return Date.now() < cacheItem.timestamp + cacheItem.expires;
};

// 获取分页缓存数据
const getPageCache = (pageKey: string) => {
  const cacheItem = newsCacheStorage.value[pageKey];
  if (!cacheItem) return null;
  return isCacheValid(cacheItem) ? cacheItem.data : null;
};

// 获取新闻条目缓存数据
const getNewsCache = (idKey: string) => {
  const cacheItem = newsCacheStorage.value[idKey];
  if (!cacheItem) return null;
  return isCacheValid(cacheItem) ? cacheItem.data : null;
};

// 保存缓存数据（同时处理分页数据和新闻条目）
const saveCacheData = (
  pageKey: string,
  data: any,
  expires = 3600000
) => {
  // 保存分页数据
  newsCacheStorage.value[pageKey] = {
    data,
    timestamp: Date.now(),
    expires
  };

  // 提取并保存新闻条目（假设data为新闻数组）
  if (data && Array.isArray(data)) {
    data.forEach((newsItem: any) => {
      if (newsItem.article_id) {
        const idKey = generateNewsIdKey(newsItem.article_id);
        newsCacheStorage.value[idKey] = {
          data: newsItem,
          timestamp: Date.now(),
          expires
        };
      }
    });
  }

  saveCache();
};

// 删除指定缓存
const deleteCache = (cacheKey: string) => {
  if (newsCacheStorage.value[cacheKey]) {
    delete newsCacheStorage.value[cacheKey];
    saveCache();
  }
};

// 更新新闻缓存中的指定字段
const updateNewsCacheField = (
  articleId: string | number,
  field: keyof CacheItem['data'],
  value: any
): boolean => {
  const idKey = generateNewsIdKey(articleId);
  const cacheItem = newsCacheStorage.value[idKey];
  
  if (cacheItem && field in cacheItem.data) {
    // 更新字段值和时间戳
    (cacheItem.data[field] as any) = value;
    cacheItem.timestamp = Date.now();
    
    // 持久化修改
    saveCache();
    return true;
  }
  return false;
};

// 清理所有缓存
const clearAllCache = () => {
  newsCacheStorage.value = {};
  localStorage.removeItem(cacheStorageKey);
};

// 初始化缓存
loadCache();

export default {
  getPageCache,
  getNewsCache,
  saveCacheData,
  updateNewsCacheField,
  deleteCache,
  clearAllCache,
  generatePageKey,
  generateNewsIdKey,
  cacheStorageKey
};