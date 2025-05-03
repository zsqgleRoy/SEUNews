import request from './request';

interface ImgData{
    data: FormData
}
// 类型声明
interface UploadResponse {
    data: string;
  }

// 上传新闻图片接口
export const apiUploadNewsImage = async (file: File) => {
    const formData = new FormData();
    formData.append('file', file);
    
    const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}');
    
    try {
      return await request.post<UploadResponse>('/api/upload/newsImg', formData, {
        headers: {
          'Authorization': `Bearer ${userInfo.token}`,
          'Content-Type': 'multipart/form-data'
        }
      });
    } catch (error) {
      console.error('上传新闻图片失败:', error);
      throw error;
    }
  };
// 缓存封面
export const apiUploadHeadImage = async (file: File) => {
  const formData = new FormData();
  formData.append('file', file);
  
  const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}');
  
  try {
    return await request.post<UploadResponse>('/api/upload/newsImg', formData, {
      headers: {
        'Authorization': `Bearer ${userInfo.token}`,
        'Content-Type': 'multipart/form-data'
      }
    });
  } catch (error) {
    console.error('上传新闻图片失败:', error);
    throw error;
  }
};
// 发布新闻接口
export const apiUploadVideo = (data: string ) => {
    return request.post('/api/articles/publish', data);
};
// 发布新闻接口
export const apiUploadImage = (data: string ) => {
    return request.post('/api/articles/publish', data);
};