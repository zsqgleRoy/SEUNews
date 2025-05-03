package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ArticleTag;
import com.royzhang.seunewswebsite.entity.ArticleTagId;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ArticleTagRepository extends JpaRepository<ArticleTag, ArticleTagId> {
    List<ArticleTag> findByArticleId(Integer articleId);
    void deleteByArticleIdAndTagId(Integer articleId, Integer tagId);
}
