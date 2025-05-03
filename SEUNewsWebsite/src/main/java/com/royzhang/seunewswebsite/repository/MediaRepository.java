package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Media;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface MediaRepository extends JpaRepository<Media, Integer> {
    List<Media> findByArticleId(Integer article_id);
}
