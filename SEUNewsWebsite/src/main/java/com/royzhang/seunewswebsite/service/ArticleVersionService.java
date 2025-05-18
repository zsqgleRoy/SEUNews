package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.Article.ArticleVersionDTO;

import java.util.List;

public interface ArticleVersionService {
    // 获取文章的所有版本
    List<ArticleVersionDTO> getAllVersionsByArticleId(Integer articleId);

    // 根据版本 ID 获取文章版本
    ArticleVersionDTO getVersionById(Integer versionId);

    // 创建文章版本
    ArticleVersionDTO createArticleVersion(ArticleVersionDTO articleVersionDTO);

    // 更新文章版本信息
    ArticleVersionDTO updateArticleVersion(Integer versionId, ArticleVersionDTO articleVersionDTO);

    // 删除文章版本
    void deleteArticleVersion(Integer versionId);
}
