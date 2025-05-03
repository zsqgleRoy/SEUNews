// 用户信息类型  UserBaseInfoDTO
export interface UserInfo {
    username: string;
    email: string;
    registerDate: string;
    avatar:string;
    isAuthor:string;
  }
  
  // 用户登录请求参数类型
  export interface LoginParams {
    username: string;
    password: string;
  }
  
  // 用户注册请求参数类型
  export interface RegisterParams {
    username: string;
    password: string;
    email: string;
  }
  