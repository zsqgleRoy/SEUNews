export interface SearchResult {
    article_id: number
    title: string
    content: string
    date: string
    category:string
    publishDate: string;
    updateDate: string;
    author: string;
    status: string;
    tag: number;
    headImageUrl: string;
    avatar:string;
    authorId?:string;
  }
  
  export interface SearchParams {
    keyword: string
    tag:string
    subTag:string
    page: number
    pageSize: number
  }