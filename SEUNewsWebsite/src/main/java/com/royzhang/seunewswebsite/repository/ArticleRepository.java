package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Article;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

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
     * @param isDeleted
     * @param pageable 分页信息
     * @return 分页的文章列表
     */
    @Query(value = "SELECT a FROM Article a LEFT JOIN FETCH a.tags WHERE a.status = :status AND a.isDeleted = :isDeleted ORDER BY a.publishDate DESC",
            countQuery = "SELECT COUNT(a) FROM Article a WHERE a.status = :status AND a.isDeleted = :isDeleted")
    Page<Article> findByStatusAndIsDeleted(
            @Param("status") Article.ArticleStatus status,
            @Param("isDeleted") Integer isDeleted,
            Pageable pageable
    );

    /**
     * 根据作者 ID 和文章状态查询文章列表（示例复合查询）。
     *
     * @param authorId 作者 ID
     * @param status   文章状态
     * @return 文章列表
     */
    @Query("SELECT a FROM Article a WHERE a.authorId = :authorId AND a.status = :status")
    List<Article> findByAuthorIdAndStatus(Integer authorId, Article.ArticleStatus status);

    @Query("SELECT a " +
            "FROM Article a" +
            " LEFT JOIN FETCH a.tags" +
            " WHERE" +
            " a.status = :status AND" +
            " a.title LIKE %:title%")
    Page<Article> findByTitleAndStatus(
            @Param("title") String title,
            @Param("status") Article.ArticleStatus status,
            Pageable pageable
    );

    @Transactional
    @Modifying
    @Query(
            "UPDATE Article a " +
                "SET a.shareNum=a.shareNum+1 " +
                "WHERE a.articleId=:articleId"
    )
    Integer increaseShare(Integer articleId);


    @Query("SELECT a FROM Article a WHERE a.authorId = :authorId")
    List<Article> findArticlesWithMediasByAuthorId(@Param("authorId") Integer authorId);

    @Modifying
    @Transactional
    @Query("UPDATE Article a SET a.lastOperatorId = :lastOperatorId, a.isDeleted = CASE WHEN a.isDeleted = 1 THEN 0 ELSE 1 END WHERE a.articleId IN :ids")
    void deleteByIds(List<Integer> ids, Integer lastOperatorId);

    /**
     * 根据文章状态分页查询文章列表。
     *
     * @param isDeleted
     * @param pageable 分页信息
     * @return 分页的文章列表
     */
    @Query(value = "SELECT a FROM Article a LEFT JOIN FETCH a.tags WHERE a.isDeleted = :isDeleted ORDER BY a.publishDate DESC",
            countQuery = "SELECT COUNT(a) FROM Article a WHERE a.isDeleted = :isDeleted")
    Page<Article> findByIsDeleted(
            @Param("isDeleted") Integer isDeleted,
            Pageable pageable
    );

    @Query(value = """
    SELECT a FROM Article a
    LEFT JOIN FETCH a.tags t
    WHERE a.articleId IN (
        SELECT aInner.articleId FROM Article aInner
        JOIN aInner.tags tInner
        WHERE aInner.status = :status
        AND aInner.isDeleted = :isDeleted
        AND tInner.tagId = :tagId
        ORDER BY aInner.publishDate DESC
    )
""",
            countQuery = """
    SELECT COUNT(DISTINCT a) FROM Article a
    JOIN a.tags t
    WHERE a.status = :status
    AND a.isDeleted = :isDeleted
    AND t.tagId = :tagId
""")
    Page<Article> findByStatusAndTag(
            @Param("status") Article.ArticleStatus status,
            @Param("isDeleted") Integer isDeleted,
            @Param("tagId") Integer tagId,
            Pageable pageable
    );

    @Query("SELECT a FROM Article a LEFT JOIN FETCH a.tags WHERE a.articleId = :id")
    Optional<Article> findByIdWithTags(@Param("id") Integer id);
}