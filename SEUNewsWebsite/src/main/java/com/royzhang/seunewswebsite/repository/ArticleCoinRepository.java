package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ArticleCoin;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArticleCoinRepository extends JpaRepository<ArticleCoin, Integer> {

    /**
     * 根据文章 ID 查找所有相关的投币记录
     * @param articleId 文章 ID
     * @return 投币记录列表
     */
    List<ArticleCoin> findByArticleId(Integer articleId);
}
