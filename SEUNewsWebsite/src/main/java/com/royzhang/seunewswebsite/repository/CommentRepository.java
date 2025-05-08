package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Comment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {


    // 基础查询方法
    List<Comment> findByArticleId(Integer articleId);

    // 优化版本（带分页和排序）
    @Query("SELECT c FROM Comment c WHERE c.articleId = :articleId ORDER BY c.publishDate DESC")
    Page<Comment> findByArticleIdWithPagination(@Param("articleId") Integer articleId, Pageable pageable);

    // 联表查询（包含用户信息）
    @Query("SELECT c.commentId, c.content, c.publishDate, c.user.user_id, c.user.username, c.user.avatar, c.ip " +
            "FROM Comment c " +
            "WHERE c.articleId = :articleId " +
            "ORDER BY c.publishDate DESC")
    List<Object[]> findCommentsWithUserInfo(@Param("articleId") Integer articleId);

    // 使用实体图（解决N+1问题）
    @Query("SELECT c FROM Comment c LEFT JOIN FETCH c.userId WHERE c.articleId = :articleId")
    List<Comment> findByArticleIdWithUser(@Param("articleId") Integer articleId);

    // 原生SQL查询（复杂场景）
    @Query(value = """
        SELECT c.*, u.username, u.avatar 
        FROM comment c 
        INNER JOIN user u ON c.user_id = u.user_id 
        WHERE c.article_id = :articleId
        ORDER BY c.publish_date DESC
        """, nativeQuery = true)
    List<Object[]> findFullCommentsByArticleId(@Param("articleId") Integer articleId);
}
