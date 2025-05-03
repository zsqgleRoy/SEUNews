import request from './request';
import { ElMessage } from 'element-plus';

// 定义保存新闻的数据结构
export interface SaveData {
    title: string;
    publishDate: string;
    updateDate: string;
    content: string;
    author: string;
    status: string;
    tag: number;
    headImageUrl: string;
}

// 定义更新新闻的数据结构
export interface UpdateData {
    id: number;
    title: string;
    updateDate: string;
    content: string;
    status: ArticleStatus;
    tag: number;
    headImageUrl: string;
}

// 定义文章状态枚举
export enum ArticleStatus {
    PUBLISH = 'PUBLISHED',
    DRAFT = 'DRAFT'
}

// 定义新闻列表响应数据类型
export interface NewsListResponse {
    data: {
            title: string;
            publishDate: string;
            updateDate: string;
            content: string;
            author: string;
            status: string;
            tag: number;
            headImageUrl: string;
            avatar?: string;
        total: number;
    };
}

// 定义新闻分类列表响应数据类型
export interface TagsListResponse {
    data: {
        list: {
            id: number;
            name: string;
        }[];
    };
}

// 定义新闻详情响应数据类型
export interface NewsDetailResponse {
    data: {
        id: number;
        title: string;
        publishDate: string;
        updateDate: string;
        content: string;
        author: string;
        status: string;
        tag: number;
        headImageUrl: string;
    };
}

// 统一错误处理函数
const handleError = (error: any) => {
    ElMessage.error('请求新闻时出错，请稍后重试！');
    throw error;
};

// 通用请求函数
const makeRequest = async <T>(
    method: 'get' | 'post' | 'put' | 'delete',
    url: string,
    params?: any,
    data?: any
) => {
    try {
        let response;
        if (method === 'get') {
            response = await request.get<T>(url, { params });
        } else if (method === 'post') {
            response = await request.post<T>(url, data);
        } else if (method === 'put') {
            response = await request.put<T>(url, data);
        } else if (method === 'delete') {
            response = await request.delete<T>(url, { params });
        }
        return response;
    } catch (error) {
        return handleError(error);
    }
};

// 获取新闻列表接口
export const getNewsList = (params: { page: number; pageSize: number; status: ArticleStatus }) => {
    return makeRequest<NewsListResponse>('get', '/api/articles/list', params);
};

export const getNewsListBySearch = (
    params: {
        keyword: string,
        tag: string,
        subTag: string,
        page: number,
        pageSize: number,
        status: ArticleStatus
    }) => {
    return makeRequest<NewsListResponse>('get', '/api/articles/search', params);
};

// 获取新闻列表接口
export const getNewsListAll = (params: { status: ArticleStatus }) => {
    return makeRequest<NewsListResponse>('get', '/api/articles/all', params);
};

// 获取新闻分类列表接口
export const apiGetTagsList = () => {
    return makeRequest<TagsListResponse>('get', '/api/tags/list');
};

// 发布新闻接口
export const publishNews = (data: SaveData) => {
    return makeRequest<{ status: number; message: string }>('post', '/api/articles/publish', undefined, data);
};

// 根据新闻 ID 获取新闻信息
export const getNewsById = (newsId: number) => {
    return makeRequest<NewsDetailResponse>('get', `/api/articles/${newsId}`);
};

// 更新新闻接口
export const apiUpdateNews = (data: UpdateData) => {
    return makeRequest<{ status: number; message: string }>('put', `/api/articles/update${data.id}`, undefined, data);
};

// 删除新闻接口
export const deleteNewsByIds = (ids: number[]) => {
    return makeRequest<{ status: number; message: string }>('delete', '/api/articles', { params: { ids } });
};
    