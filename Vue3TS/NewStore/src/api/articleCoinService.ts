// src/api/articleCoinService.ts
import axios from 'axios';
import { initialURL } from '@/lib/urls';
// import type { ArticleCoinDTO } from '@/types/article';
import userCache from '@/cache/userCache';
import newsCache from '@/cache/newsCache';
import type { ArticleCoinDTO } from '@/types/article';

const api = axios.create({
  baseURL: initialURL.SERVER_URL,
  timeout: 15000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// api.interceptors.request.use(config => {
//   const token = userCache.getToken();
//   if (token) {
//     config.headers.Authorization = `Bearer ${token}`;
//   }
//   return config;
// });

export const useArticleCoinService = () => {
  // 获取文章投币记录
  const getAllCoinsByArticleId = async (articleId: number): Promise<ArticleCoinDTO[]> => {
    try {
      const response = await api.get<ApiResponse<ArticleCoinDTO[]>>(
        `/article-coins/article/${articleId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('获取投币记录失败:', error);
      return [];
    }
  };

  // 获取单个投币记录
  const getCoinById = async (coinId: number): Promise<ArticleCoinDTO | null> => {
    try {
      const response = await api.get<ApiResponse<ArticleCoinDTO>>(
        `/article-coins/${coinId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('获取投币详情失败:', error);
      return null;
    }
  };

  // 检查用户是否收藏
  const isArticleCoinedByUser = async (
    articleId: number
  ): Promise<boolean> => {
    try {
      const userId = userCache.getUserCache()?.user_id;
      if (!userId) return false;
      const response = await api.get<boolean>(
        `/api/article-coins/user/${userId}/article/${articleId}`
      );
      return response.data;
    } catch (error) {
      console.error('检查投币状态失败:', error);
      return false;
    }
  };

  // 创建投币记录
  const createCoin = async (dto: Omit<ArticleCoinDTO, 'coinId'>): Promise<ArticleCoinDTO | null> => {
    try {
      const response = await api.post<ApiResponse<ArticleCoinDTO>>(
        '/api/article-coins',
        dto
      );
      return response.data.data;
    } catch (error) {
      console.error('创建投币失败:', error);
      return null;
    }
  };

  // 删除投币记录
  const deleteCoin = async (coinId: number): Promise<boolean> => {
    try {
      await api.delete(`/article-coins/${coinId}`);
      return true;
    } catch (error) {
      console.error('删除投币失败:', error);
      return false;
    }
  };

  // 获取文章总投币数（带缓存）
  const getTotalCoinsCache = new Map<number, number>();
  const getTotalCoinsForArticle = async (articleId: number): Promise<number> => {
    const key = newsCache.generateNewsIdKey(articleId);
    return newsCache.getNewsCache(key)?.coin || 0;
  };

  // 快捷方法：用户今日剩余投币数
  const getRemainingCoinsToday = async (): Promise<number> => {
    try {
      const response = await api.get<ApiResponse<number>>(
        '/user/coins/remaining'
      );
      return response.data.data;
    } catch (error) {
      console.error('获取剩余投币数失败:', error);
      return 0;
    }
  };

  // 带验证的投币操作
  const safeCreateCoin = async (
    articleId: number,
    coins: number
  ): Promise<{ success: boolean; remaining?: number }> => {
    const user = userCache.getUserCache();
    if (!user) return { success: false };

    try {
      // 检查剩余投币数
      const remaining = await getRemainingCoinsToday();
      if (remaining < coins) {
        return { success: false, remaining };
      }

      // 执行投币
      const result = await createCoin({
          userId: user.user_id,
          articleId,
          coinCount: coins,
          coinDate: ''
      });

      // 更新缓存
      if (result) {
        const currentTotal = getTotalCoinsCache.get(articleId) || 0;
        getTotalCoinsCache.set(articleId, currentTotal + coins);
        return { success: true, remaining: remaining - coins };
      }
      return { success: false };
    } catch (error) {
      console.error('安全投币失败:', error);
      return { success: false };
    }
  };

  return {
    getAllCoinsByArticleId,
    isArticleCoinedByUser,
    getCoinById,
    createCoin,
    deleteCoin,
    getTotalCoinsForArticle,
    getRemainingCoinsToday,
    safeCreateCoin
  };
};

// 类型定义扩展 (src/types/article.d.ts)


interface ApiResponse<T> {
  data: T;
  status: number;
}