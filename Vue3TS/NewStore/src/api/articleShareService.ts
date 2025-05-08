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
  // const getAllShareByUserId = async (userId: number): Promise<ArticleShareDTO[]> => {
  //   try {
  //     const response = await api.get<ApiResponse<ArticleShareDTO[]>>(
  //       `/api/article-Share/user/${userId}`
  //     );
  //     return response.data.data;
  //   } catch (error) {
  //     console.error('获取用户分享失败:', error);
  //     return [];
  //   }
  // };

  // 获取单个分享详情
  // const getShareById = async (ShareId: number): Promise<ArticleShareDTO | null> => {
  //   try {
  //     const response = await api.get<ApiResponse<ArticleShareDTO>>(
  //       `/api/article-Share/${ShareId}`
  //     );
  //     return response.data.data;
  //   } catch (error) {
  //     console.error('获取分享详情失败:', error);
  //     return null;
  //   }
  // };

    const getShareNumByArticleId = (articleId: number): number => {
        const key = newsCache.generateNewsIdKey(articleId);
        return newsCache.getNewsCache(key)?.share || 0;
    };

  // 创建分享
  const createShare = async (
    article_id:number
  ) => {
    try {
      const response = await api.post(
        `/api/articles/article-Share/${article_id}`,
      );
      return response.data;
    } catch (error) {
      console.error('创建分享失败:', error);
      return null;
    }
  };

  // 删除分享
  const deleteShare = async (ShareId: number): Promise<boolean> => {
    try {
      await api.delete(`/api/article-Share/${ShareId}`);
      return true;
    } catch (error) {
      console.error('删除分享失败:', error);
      return false;
    }
  };

  // 检查用户是否分享
  const isArticleSharedByUser = async (
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
  const isCurrentUserShared = async (articleId: number): Promise<boolean> => {
    const userId = userCache.getUserCache()?.user_id;
    if (!userId) return false;
    return isArticleSharedByUser(userId, articleId);
  };

  return {
    // getAllShareByUserId,
    getShareNumByArticleId,
    // getShareById,
    createShare,
    deleteShare,
    isArticleSharedByUser,
    isCurrentUserShared,
  };
};

// 类型扩展（src/types/article.d.ts）


interface ApiResponse<T> {
  data: T;
  status: number;
}