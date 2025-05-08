import axios from 'axios';
import type { Comment, CommentForm } from '@/types/comment';
import { initialURL } from '@/lib/urls';
import userCache from '@/cache/userCache';
import { getIP } from '@/api/getIP';

// 复用已有的axios实例配置
const api = axios.create({
    baseURL: initialURL.SERVER_URL,
    timeout: 15000,
    headers: {
      'Content-Type': 'application/json',
    },
  });

export const CommentService = {
  async getComments(articleId: number): Promise<Comment[]> {
    const { data } = await api.get<Comment[]>(`/api/comments/article/${articleId}`);
    return data.map(c => ({
      ...c,
      publishDate: new Date(c.publishDate)
    }));
  },

  async createComment(form: CommentForm): Promise<Comment> {
    const { data } = await api.post<Comment>(`/api/comments`, {
      ...form,
      userId: userCache.getUserCache()?.user_id || 0, // 根据实际用户系统替换
      publishDate: new Date(),
      ip: await getIP().catch(() => null) // 获取IP地址,
    });
    return {
      ...data,
      publishDate: new Date(data.publishDate)
    };
  },

  async deleteComment(commentId: number): Promise<void> {
    await api.delete(`/api/comments/${commentId}`);
  }
};