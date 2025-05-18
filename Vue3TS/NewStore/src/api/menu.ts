import request from './request';

// 获取新闻列表接口
export const getMenuItemList = () => {
    // 假设 request 是一个封装好的请求工具，这里添加错误处理
    try {
        return request.get('/api/tags/list');
    } catch (error) {
        console.error('获取导航栏菜单列表时出错:', error);
        throw error;
    }
  }; 