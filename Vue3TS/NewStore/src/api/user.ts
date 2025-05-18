import request from './request';

// 定义文章状态枚举
export enum IsAuthor {
    TRUE = 'TRUE',
    FALSE = 'FALSE'
}

// 定义登录数据的接口
interface LoginData {
    username: string;
    password: string;
}

// 定义注册数据的接口
interface RegisterData {
    username: string;
    password: string;
    email: string;
    registerDate:Date;
    isAuthor:string;
}

// 用户登录接口
export const login = (data: LoginData) => {
    return request.post('/api/user/login', data)
      .catch((error) => {
            console.error('Login request failed:', error);
            throw error;
        });
};

// 用户注册接口
export const register = (data: RegisterData) => {
    return request.post('/api/user/register', data)
      .catch((error) => {
            throw error;
        });
};

// 获取用户信息接口
export const getUserInfo = (authorId:number) => {
    return request.get('/api/user/' + authorId)
      .catch((error) => {
            console.error('Get user info request failed:', error);
            throw error;
        });
};
