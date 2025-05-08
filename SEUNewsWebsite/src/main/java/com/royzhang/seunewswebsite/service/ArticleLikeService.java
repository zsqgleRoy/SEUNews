package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleLikeDTO;

import java.util.List;

public interface ArticleLikeService {
    // 获取文章的所有点赞记录
    List<ArticleLikeDTO> getAllLikesByArticleId(Integer articleId);

    // 创建点赞记录
    ArticleLikeDTO createLike(ArticleLikeDTO likeDTO);

    // 删除点赞记录
    void deleteLike(Integer userId, Integer likeId);

    // 根据用户 ID 和文章 ID 检查是否已点赞
    boolean isArticleLikedByUser(Integer userId, Integer articleId);
}
