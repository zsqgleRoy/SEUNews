package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ArticleCategoryId;
import com.royzhang.seunewswebsite.entity.ArticleCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArticleCategoryRepository extends JpaRepository<ArticleCategory, ArticleCategoryId> {

    /**
     * 根据文章 ID 查找所有相关的文章分类
     * @param articleId 文章 ID
     * @return 文章分类列表
     */
    @Query("SELECT ac FROM ArticleCategory ac WHERE ac.articleId = :articleId")
    List<ArticleCategory> findByArticleId(@Param("articleId") Integer articleId);

    /**
     * 根据文章 ID 和分类 ID 删除特定的文章分类
     * @param articleId 文章 ID
     * @param categoryId 分类 ID
     */
    @Modifying
    @Query("DELETE FROM ArticleCategory ac WHERE ac.articleId = :articleId AND ac.categoryId = :categoryId")
    void deleteByArticleIdAndCategoryId(@Param("articleId") Integer articleId, @Param("categoryId") Integer categoryId);
}
