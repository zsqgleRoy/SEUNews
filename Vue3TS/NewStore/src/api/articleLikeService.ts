// src/api/articleLikeService.ts
import axios from 'axios';
import { initialURL } from '@/lib/urls';
import userCache from '@/cache/userCache';
import newsCache from '@/cache/newsCache';
import type { ArticleLikeDTO } from '@/types/article';

// 定义响应类型
interface ApiResponse<T> {
  data: T;
  status: number;
}

// 创建axios实例
const api = axios.create({
  baseURL: initialURL.SERVER_URL,
  timeout: 15000,
  headers: {
    'Content-Type': 'application/json',
  },
});


export const useArticleLikeService = () => {
  // 获取文章所有点赞
  const getAllLikesByArticleId = async (articleId: number): Promise<ArticleLikeDTO[]> => {
    try {
      const response = await api.get<ApiResponse<ArticleLikeDTO[]>>(
        `/api/article-likes/article/${articleId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('Error fetching article likes:', error);
      return [];
    }
  };

  // 获取单个点赞详情
  const getLikeById = async (likeId: number): Promise<ArticleLikeDTO | null> => {
    try {
      const response = await api.get<ApiResponse<ArticleLikeDTO>>(
        `/api/article-likes/${likeId}`
      );
      return response.data.data;
    } catch (error) {
      console.error('Error fetching like by ID:', error);
      return null;
    }
  };

  // 获取单个文章点赞数量
  const getLikeNumByArticleId = (articleId: number): number => {
    const key = newsCache.generateNewsIdKey(articleId);
    return newsCache.getNewsCache(key)?.likes || 0;
  };
  // 创建点赞
  const createLike = async (dto: Omit<ArticleLikeDTO, 'likeId'>): Promise<ArticleLikeDTO | null> => {
    try {
      const response = await api.post<ApiResponse<ArticleLikeDTO>>(
        '/api/article-likes',
        dto
      );
      return response.data.data;
    } catch (error) {
      console.error('Error creating like:', error);
      return null;
    }
  };

  // 删除点赞
  const deleteLike = async (
    userId: number,
    articleId: number
  ): Promise<boolean> => {
    try {
      await api.delete(
        `/api/article-likes/user/${userId}/article/${articleId}`
      );
      return true;
    } catch (error) {
      console.error('Error deleting like:', error);
      return false;
    }
  };

  // 检查用户是否点赞
  const isArticleLikedByUser = async (
    userId: number,
    articleId: number
  ): Promise<boolean> => {
    try {
      const response = await api.get<boolean>(
        `/api/article-likes/user/${userId}/article/${articleId}`
      );
      return response.data;
    } catch (error) {
      console.error('Error checking like status:', error);
      return false;
    }
  };

  // 快捷方法：当前用户是否点赞
  const isCurrentUserLiked = async (articleId: number): Promise<boolean> => {
    const userId = userCache.getUserCache()?.user_id;
    if (!userId) return false;
    return isArticleLikedByUser(userId, articleId);
  };

  return {
    getAllLikesByArticleId,
    getLikeNumByArticleId,
    getLikeById,
    createLike,
    deleteLike,
    isArticleLikedByUser,
    isCurrentUserLiked,
  };
};