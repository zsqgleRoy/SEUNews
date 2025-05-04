// src/api/articleShareService.ts
import axios from 'axios';
import { initialURL } from '@/lib/urls';
import userCache from '@/cache/userCache';
import newsCache from '@/cache/newsCache';

// 复用已有的axios实例配置
const api = axios.create({
  baseURL: initialURL.SERVER_URL,
  timeout: 15000,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const useArticleShareService = () => {
  // 获取用户所有分享
  const getAllShareByUserId = async (userId: number): Promise<ArticleFavoriteDTO[]> => {
    try {
      const response = await api.get<ApiResponse<ArticleFavoriteDTO[]>>(
        `/api/article-Share/user/${userId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('获取用户分享失败:', error);
      return [];
    }
  };

  // 获取单个分享详情
  const getFavoriteById = async (favoriteId: number): Promise<ArticleFavoriteDTO | null> => {
    try {
      const response = await api.get<ApiResponse<ArticleFavoriteDTO>>(
        `/api/article-Share/${favoriteId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('获取分享详情失败:', error);
      return null;
    }
  };

    const getShareNumByArticleId = (articleId: number): Promise<number | null> => {
        const key = newsCache.generateNewsIdKey(articleId);
        return newsCache.getNewsCache(key).share;
    };

  // 创建分享
  const createFavorite = async (
    dto: Omit<ArticleFavoriteDTO, 'favoriteId'>
  ): Promise<ArticleFavoriteDTO | null> => {
    try {
      const response = await api.post<ApiResponse<ArticleFavoriteDTO>>(
        '/api/article-Share',
        dto
      );
      return response.data.data;
    } catch (error) {
      console.error('创建分享失败:', error);
      return null;
    }
  };

  // 删除分享
  const deleteFavorite = async (favoriteId: number): Promise<boolean> => {
    try {
      await api.delete(`/api/article-Share/${favoriteId}`);
      return true;
    } catch (error) {
      console.error('删除分享失败:', error);
      return false;
    }
  };

  // 检查用户是否分享
  const isArticleFavoritedByUser = async (
    userId: number,
    articleId: number
  ): Promise<boolean> => {
    try {
      const response = await api.get<ApiResponse<boolean>>(
        `/api/article-Share/user/${userId}/article/${articleId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('检查分享状态失败:', error);
      return false;
    }
  };

  // 快捷方法：当前用户分享状态
  const isCurrentUserFavorited = async (articleId: number): Promise<boolean> => {
    const userId = userCache.getUserCache()?.user_id;
    if (!userId) return false;
    return isArticleFavoritedByUser(userId, articleId);
  };

  return {
    getAllShareByUserId,
    getShareNumByArticleId,
    getFavoriteById,
    createFavorite,
    deleteFavorite,
    isArticleFavoritedByUser,
    isCurrentUserFavorited,
  };
};

// 类型扩展（src/types/article.d.ts）
export interface ArticleFavoriteDTO {
  favoriteId: number;
  userId: number;
  articleId: number;
  createdAt: string;
  // 其他可能的字段
}

interface ApiResponse<T> {
  data: T;
  status: number;
}