package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ArticleFavorite;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ArticleFavoriteRepository extends JpaRepository<ArticleFavorite, Integer> {
    List<ArticleFavorite> findByUserId(int userId);

    Boolean existsByUserIdAndArticleId(int userId, int articleId);
}
