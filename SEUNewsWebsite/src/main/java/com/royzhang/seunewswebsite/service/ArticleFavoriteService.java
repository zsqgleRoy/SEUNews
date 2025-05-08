package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleFavoriteDTO;

import java.util.List;

public interface ArticleFavoriteService {
    // 获取用户的所有文章收藏记录
    List<ArticleFavoriteDTO> getAllFavoritesByUserId(Integer userId);

    // 创建文章收藏记录
    ArticleFavoriteDTO createFavorite(ArticleFavoriteDTO favoriteDTO);

    // 删除文章收藏记录
    void deleteFavorite(Integer userId, Integer articleId);

    // 检查用户是否已收藏某篇文章
    boolean isArticleFavoritedByUser(Integer userId, Integer articleId);
}
