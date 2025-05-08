// src/types/article.d.ts
import {type ArticleStatus} from "@/api/news"


export interface ArticleLikeDTO {
    likeId: number;
    userId: number;
    articleId: number;
    likeDate: string;
    // 其他可能的字段
  }

  export interface ArticleFavoriteDTO {
    userId: number;
    articleId: number;
    favoriteDate: string;
    // 其他可能的字段
  }

  export interface ArticleCoinDTO {
    userId: number;
    articleId: number;
    coinCount?: number;
    coinDate: string;
  }

  export interface ArticleFontDTO {
    id: number;
    title: string;
    publishDate: Date;
    headImageUrl: string;
    ArticleStatus: ArticleStatus;
  }