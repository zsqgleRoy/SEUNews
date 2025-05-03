// 通用接口响应类型
export interface ApiResponse<T> {
    code: number;
    message: string;
    data: T;
  }
  
  // 例如，用户登录接口的响应类型
  import { UserInfo } from './user.d.ts';
  export type LoginResponse = ApiResponse<UserInfo>;
  
  // 新闻列表接口的响应类型
  import { NewsListItem } from './news.d.ts';
  export type NewsListResponse = ApiResponse<NewsListItem[]>;
  
  // 新闻详情接口的响应类型
  import { NewsDetail } from './news.d.ts';
  export type NewsDetailResponse = ApiResponse<NewsDetail>;
  