// src/api/articleFavoriteService.ts
import axios from 'axios';
import { initialURL } from '@/lib/urls';
import userCache from '@/cache/userCache';
import newsCache from '@/cache/newsCache';
import type { ArticleFavoriteDTO } from '@/types/article';
import type { ar } from 'element-plus/es/locale/index.mjs';

// 复用已有的axios实例配置
const api = axios.create({
  baseURL: initialURL.SERVER_URL,
  timeout: 15000,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const useArticleFavoriteService = () => {
  // 获取用户所有收藏
  const getAllFavoritesByUserId = async (userId: number): Promise<ArticleFavoriteDTO[]> => {
    try {
      const response = await api.get<ApiResponse<ArticleFavoriteDTO[]>>(
        `/api/article-favorites/user/${userId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('获取用户收藏失败:', error);
      return [];
    }
  };

  const getTotalFavoritesForArticle = async (articleId: number): Promise<number> => {
    const key = newsCache.generateNewsIdKey(articleId);
    return newsCache.getNewsCache(key)?.favourite || 0;
  };

  // 获取单个收藏详情
  const getFavoriteById = async (favoriteId: number): Promise<ArticleFavoriteDTO | null> => {
    try {
      const response = await api.get<ApiResponse<ArticleFavoriteDTO>>(
        `/api/article-favorites/${favoriteId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('获取收藏详情失败:', error);
      return null;
    }
  };

  // 创建收藏
  const createFavorite = async (
    dto: Omit<ArticleFavoriteDTO, 'favoriteId'>
  ): Promise<ArticleFavoriteDTO | null> => {
    try {
      const response = await api.post<ArticleFavoriteDTO>(
        '/api/article-favorites',
        dto
      );
      return response.data;
    } catch (error) {
      console.error('创建收藏失败:', error);
      return null;
    }
  };

  // 删除收藏
  const deleteFavorite = async (
    userId: number,
    articleId: number
  ): Promise<boolean> => {
    try {
      await api.delete(`/api/article-favorites/user/${userId}/article/${articleId}`);
      return true;
    } catch (error) {
      console.error('删除收藏失败:', error);
      return false;
    }
  };

  // 检查用户是否收藏
  const isArticleFavoritedByUser = async (
    userId: number,
    articleId: number
  ): Promise<boolean> => {
    try {
      const response = await api.get<boolean>(
        `/api/article-favorites/user/${userId}/article/${articleId}`
      );
      return response.data;
    } catch (error) {
      console.error('检查收藏状态失败:', error);
      return false;
    }
  };

  // 快捷方法：当前用户收藏状态
  const isCurrentUserFavorited = async (articleId: number): Promise<boolean> => {
    const userId = userCache.getUserCache()?.user_id;
    if (!userId) return false;
    return isArticleFavoritedByUser(userId, articleId);
  };

  return {
    getAllFavoritesByUserId,
    getFavoriteById,
    createFavorite,
    deleteFavorite,
    getTotalFavoritesForArticle,
    isArticleFavoritedByUser,
    isCurrentUserFavorited,
  };
};


interface ApiResponse<T> {
  data: T;
  status: number;
}