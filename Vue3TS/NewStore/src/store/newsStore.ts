import { defineStore } from 'pinia';
import { ref } from 'vue';

// 定义新闻状态存储
export const useNewsStore = defineStore('news', () => {
    // 新闻列表，初始为空数组
    const newsList = ref<{ id: number; title: string; content: string; authorId: number }[]>([]);
    // 当前查看的新闻详情，初始为空对象
    const currentNews = ref<{ id: number; title: string; content: string; authorId: number } | null>(null);

    // 获取新闻列表方法
    const fetchNewsList = async () => {
        // 这里模拟异步请求获取新闻列表
        const response = await new Promise<{ id: number; title: string; content: string; authorId: number }[]>(
            (resolve) => {
                setTimeout(() => {
                    resolve([
                        {
                            id: 1,
                            title: '新闻标题1',
                            content: '新闻内容1',
                            authorId: 1
                        },
                        {
                            id: 2,
                            title: '新闻标题2',
                            content: '新闻内容2',
                            authorId: 2
                        }
                    ]);
                }, 1000);
            }
        );
        newsList.value = response;
    };

    // 获取新闻详情方法
    const fetchNewsDetail = async (newsId: number) => {
        // 这里模拟异步请求获取新闻详情
        const response = await new Promise<{ id: number; title: string; content: string; authorId: number }>(
            (resolve) => {
                setTimeout(() => {
                    resolve({
                        id: newsId,
                        title: `新闻标题${newsId}`,
                        content: `新闻内容${newsId}`,
                        authorId: newsId
                    });
                }, 1000);
            }
        );
        currentNews.value = response;
    };

    return {
        newsList,
        currentNews,
        fetchNewsList,
        fetchNewsDetail
    };
});
