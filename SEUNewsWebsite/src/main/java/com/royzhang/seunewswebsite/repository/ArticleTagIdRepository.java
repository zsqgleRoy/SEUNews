package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.ArticleTagId;
import org.springframework.data.jpa.repository.JpaRepository;

// 继承 JpaRepository 接口，指定实体类和主键类型
public interface ArticleTagIdRepository extends JpaRepository<ArticleTagId, ArticleTagId> {
}
