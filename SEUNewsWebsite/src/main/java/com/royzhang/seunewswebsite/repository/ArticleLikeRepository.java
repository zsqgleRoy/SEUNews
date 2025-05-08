package com.royzhang.seunewswebsite.repository;

// import com.royzhang.seunewswebsite.entity.ArticleCoin;
import com.royzhang.seunewswebsite.entity.ArticleLike;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ArticleLikeRepository extends JpaRepository<ArticleLike, Integer> {

    /**
     * 根据文章 ID 查找所有相关的投币记录
     * @param articleId 文章 ID
     * @return 投币记录列表
     */
    List<ArticleLike> findByArticleId(Integer articleId);

    // List<ArticleLike> findByArticleCoin(ArticleCoin articleCoin);

    boolean existsByArticleId(Integer articleId);

    /**
     * 根据文章 ID 查找所有相关的投币记录
     * @param articleId  文章 ID
     * @param userId     用户 ID
     * @return 投币记录列表
     */
    Boolean existsByUserIdAndArticleId(Integer userId, Integer articleId);

    ArticleLike findArticleLikeByUserIdAndArticleId(Integer userId, Integer likeId);

    @Modifying
    @Query(
            "DELETE FROM ArticleLike a" +
                    " WHERE" +
                    " a.userId = :userId AND" +
                    " a.articleId = :articleId"
    )
    void deleteByUserIdAndArticleId(Integer userId, Integer articleId);
}
