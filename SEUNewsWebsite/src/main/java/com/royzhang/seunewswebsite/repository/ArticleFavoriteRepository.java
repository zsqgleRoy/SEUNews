package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ArticleFavorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ArticleFavoriteRepository extends JpaRepository<ArticleFavorite, Integer> {
    List<ArticleFavorite> findByUserId(int userId);

    Boolean existsByUserIdAndArticleId(int userId, int articleId);

    @Modifying
    @Query(
            "DELETE FROM ArticleFavorite a" +
                    " WHERE" +
                    " a.userId = :userId AND" +
                    " a.articleId = :articleId"
    )
    void deleteByUserIdAndArticleId(Integer userId, Integer articleId);
}
