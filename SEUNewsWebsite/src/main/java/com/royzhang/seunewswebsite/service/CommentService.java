package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.CommentDTO;
import java.util.List;

public interface CommentService {
    // 根据文章 ID 获取评论列表
    List<CommentDTO> getCommentsByArticleId(Integer articleId);

    // 创建评论
    CommentDTO createComment(CommentDTO commentDTO);

    // 根据评论 ID 删除评论
    void deleteComment(Integer commentId);

    // 根据评论 ID 获取评论
    CommentDTO getCommentById(Integer commentId);

    // 更新评论
    CommentDTO updateComment(Integer commentId, CommentDTO commentDTO);

    List<CommentDTO> getCommentsByUserId(Integer userId);
}
