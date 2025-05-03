package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleCategoryDTO;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ArticleCategoryService {
    // 获取文章所属的所有分类
    List<ArticleCategoryDTO> getAllCategoriesByArticleId(Integer articleId);

    // 为文章添加分类
    void addCategoryToArticle(ArticleCategoryDTO articleCategoryDTO);

    // 从文章中移除分类
    @Transactional
    void removeCategoryFromArticle(Integer articleId, Integer categoryId);
}
