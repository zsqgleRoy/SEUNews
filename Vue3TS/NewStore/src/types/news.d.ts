// 新闻列表项类型
export interface NewsListItem {
    id: number;
    title: string;
    // 新闻摘要，可选字段
    summary?: string;
    authorId: number;
    publishTime: string;
  }
  
  // 新闻详情类型
  export interface NewsDetail {
    id: number;
    title: string;
    content: string;
    authorId: number;
    publishTime: string;
    // 新闻标签，可选字段
    tags?: string[];
  }
  
  // 发布新闻请求参数类型
  export interface PublishNewsParams {
    title: string;
    content: string;
    authorId: number;
    // 新闻标签，可选字段
    tags?: string[];
  }
  