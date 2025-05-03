package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ArticleVersion;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ArticleVersionRepository extends JpaRepository<ArticleVersion, Integer> {
    List<ArticleVersion> findByArticleId(Integer articleId);
}
