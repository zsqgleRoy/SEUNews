// src/cache/newsCache.ts
import { ref, computed } from 'vue';

interface CacheItem {
  data: any;
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

// 生成缓存键
const generateCacheKey = (params: {
  page: number;
  pageSize: number;
  status: string;
}) => {
  return `${params.page}-${params.pageSize}-${params.status}`;
};

// 检查缓存是否有效
const isCacheValid = (cacheItem: CacheItem) => {
  return Date.now() < cacheItem.timestamp + cacheItem.expires;
};

// 获取缓存数据
const getCache = (cacheKey: string) => {
  const cacheItem = newsCacheStorage.value[cacheKey];
  if (!cacheItem) {
    return null;
  }
  return isCacheValid(cacheItem) ? cacheItem.data : null;
};

// 保存缓存数据
const saveCacheData = (cacheKey: string, data: any, expires = 3600000) => { // 默认1小时有效期
  newsCacheStorage.value[cacheKey] = {
    data,
    timestamp: Date.now(),
    expires
  };
  saveCache();
};

// 删除指定缓存
const deleteCache = (cacheKey: string) => {
  if (newsCacheStorage.value[cacheKey]) {
    delete newsCacheStorage.value[cacheKey];
    saveCache();
  }
};

// 清理所有缓存
const clearAllCache = () => {
  newsCacheStorage.value = {};
  localStorage.removeItem(cacheStorageKey);
};

// 初始化缓存
loadCache();

export default {
  getCache,
  saveCacheData,
  deleteCache,
  clearAllCache,
  generateCacheKey,
  cacheStorageKey
};