package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ArticleCoin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

public interface ArticleCoinRepository extends JpaRepository<ArticleCoin, Integer> {

    /**
     * 根据文章 ID 查找所有相关的投币记录
     * @param articleId 文章 ID
     * @return 投币记录列表
     */
    List<ArticleCoin> findByArticleId(Integer articleId);

    boolean existsByUserIdAndArticleId(Integer userId, Integer articleId);

    @Modifying
    @Query(value = "INSERT INTO seunews.article_coins (user_id, article_id, coin_count, coin_date) " +
            "VALUES (:userId, :articleId, :coinCount, :date) " +
            "ON DUPLICATE KEY UPDATE coin_count = coin_count + :coinCount", nativeQuery = true)
    @Transactional
    Integer saveCoins(Integer userId, Integer articleId, Integer coinCount, Date date);
}
