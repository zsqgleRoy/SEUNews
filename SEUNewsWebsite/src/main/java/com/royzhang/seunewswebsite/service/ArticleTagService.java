package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleTagDTO;

import java.util.List;

public interface ArticleTagService {
    // 获取文章关联的所有标签
    List<ArticleTagDTO> getTagsByArticleId(Integer articleId);

    // 为文章添加标签
    void addTagToArticle(ArticleTagDTO articleTagDTO);

    // 从文章中移除标签
    void removeTagFromArticle(Integer articleId, Integer tagId);
}
