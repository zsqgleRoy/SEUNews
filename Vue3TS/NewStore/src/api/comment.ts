import request from './request';

// 获取新闻评论列表接口
export const getCommentList = (newsId: number, params: { page: number; pageSize: number }) => {
  return request.get(`/api/comment/list/${newsId}`, { params });
};

// 发表评论接口
export const postComment = (data: { newsId: number; userId: number; content: string }) => {
  return request.post('/api/comment/post', data);
};
