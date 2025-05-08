// types/comment.ts

export interface Comment {
  commentId: number
  articleId: number
  userId: number
  content: string
  publishDate: Date
  ip?: string
  avatar?: string
  username?: string
  province?: string
  replyCount?: number
  replies?: Comment[]
}

export interface CommentForm {
  articleId: number
  content: string
  parentId?: number
  ip?: string
}


// export interface Comment {
//     commentId: number;
//     articleId: number;
//     userId: number;
//     content: string;
//     publishDate: Date;
//     replies?: Comment[]; // 可选回复功能
//     avatar?: string;     // 前端扩展字段
//     username?: string;   // 前端扩展字段
//     ip?: string;       // 前端扩展字段
//   }
  
//   export interface CommentForm {
//     articleId: number;
//     content: string;
//   }