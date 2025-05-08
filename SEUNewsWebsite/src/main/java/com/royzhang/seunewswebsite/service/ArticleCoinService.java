package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleCoinDTO;

import java.util.List;

public interface ArticleCoinService {
    // 获取文章的所有投币记录
    List<ArticleCoinDTO> getAllCoinsByArticleId(Integer articleId);

    // 根据投币 ID 获取投币记录
    ArticleCoinDTO getCoinById(Integer coinId);

    // 创建投币记录
    ArticleCoinDTO createCoin(ArticleCoinDTO coinDTO);

    // 删除投币记录
    void deleteCoin(Integer coinId);

    // 统计文章的总投币数
    Integer getTotalCoinsForArticle(Integer articleId);

    boolean isArticleCoinedByUser(Integer userId, Integer articleId);
}
