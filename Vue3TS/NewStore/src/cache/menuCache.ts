// src/cache/menuCache.ts
import { ref } from 'vue';

// 定义缓存项的接口
interface CacheItem {
    data: any;
    timestamp: number;
    expires: number; // 缓存有效期（毫秒）
}

interface CacheConfig {
    expires?: number;
    encrypt?: boolean;
    userSpecific?: boolean;
}

// 默认配置
const DEFAULT_CONFIG: Required<CacheConfig> = {
    expires: 3600000, // 1小时
    encrypt: false,
    userSpecific: true
};

// 缓存元数据
const CACHE_META = {
    VERSION: '1.0',
    STORAGE_KEY: 'menu_cache_v2'
};

// 缓存存储对象
const menuCacheStorage = ref<Record<string, CacheItem>>({});

// 从 localStorage 加载缓存
const loadCache = () => {
    try {
        const cachedData = localStorage.getItem('menu_cache');
        if (cachedData) {
            menuCacheStorage.value = JSON.parse(cachedData);
        }
    } catch (error) {
        console.error('菜单缓存加载失败:', error);
        localStorage.removeItem('menu_cache');
    }
};

// 保存缓存到 localStorage
const saveCache = () => {
    try {
        localStorage.setItem('menu_cache', JSON.stringify(menuCacheStorage.value));
    } catch (error) {
        console.error('菜单缓存保存失败:', error);
    }
};

// 生成缓存键
const generateCacheKey = () => {
    return 'menu_items';
};

// 检查缓存是否有效
const isCacheValid = (cacheItem: CacheItem) => {
    return Date.now() < cacheItem.timestamp + cacheItem.expires;
};

// 获取缓存数据
const getCache = (cacheKey: string) => {
    const cacheItem = menuCacheStorage.value[cacheKey];
    if (!cacheItem) {
        return null;
    }
    return isCacheValid(cacheItem) ? cacheItem.data : null;
};

// 保存缓存数据
const saveCacheData = (cacheKey: string, data: any, expires = 3600000) => { // 默认1小时有效期
    menuCacheStorage.value[cacheKey] = {
        data,
        timestamp: Date.now(),
        expires
    };
    saveCache();
};



// 删除指定缓存
const deleteCache = (cacheKey: string) => {
    if (menuCacheStorage.value[cacheKey]) {
        delete menuCacheStorage.value[cacheKey];
        saveCache();
    }
};

// 清理所有缓存
const clearAllCache = () => {
    menuCacheStorage.value = {};
    localStorage.removeItem('menu_cache');
};

// 初始化缓存
loadCache();

export default {
    getCache,
    saveCacheData,
    generateCacheKey,
    deleteCache,
    clearAllCache
};