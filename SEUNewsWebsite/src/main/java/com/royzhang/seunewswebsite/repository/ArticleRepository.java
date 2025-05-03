package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 文章仓储接口，定义了文章相关的数据库操作方法。
 */
public interface ArticleRepository extends JpaRepository<Article, Integer> {

    /**
     * 根据标题模糊查询文章列表。
     *
     * @param title 标题关键词
     * @return 文章列表
     */
    List<Article> findByTitleContaining(String title);

    /**
     * 根据发布日期范围查询文章列表。
     *
     * @param startDate 起始日期
     * @param endDate   结束日期
     * @return 文章列表
     */
    List<Article> findByPublishDateBetween(LocalDateTime startDate, LocalDateTime endDate);

    /**
     * 根据文章状态分页查询文章列表。
     *
     * @param status   文章状态
     * @param pageable 分页信息
     * @return 分页的文章列表
     */
    Page<Article> findByStatus(Article.ArticleStatus status, Pageable pageable);

    /**
     * 根据作者 ID 和文章状态查询文章列表（示例复合查询）。
     *
     * @param authorId 作者 ID
     * @param status   文章状态
     * @return 文章列表
     */
    @Query("SELECT a FROM Article a WHERE a.authorId = :authorId AND a.status = :status")
    List<Article> findByAuthorIdAndStatus(Integer authorId, Article.ArticleStatus status);

    @Query("SELECT a FROM Article a" +
            " WHERE" +
            " a.status = :status AND" +
            " a.title LIKE %:title%")
    Page<Article> findByTitleAndStatus(
            @Param("title") String title,
            @Param("status") Article.ArticleStatus status,
            Pageable pageable
    );
}