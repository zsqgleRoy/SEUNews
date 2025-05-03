package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "article_tags") // 注意：原表名可能拼写错误，这里假设是 articletags
@IdClass(ArticleTagId.class)
public class ArticleTag {
    @Id
    @Column(name = "article_id")
    private Integer articleId;

    @Id
    @Column(name = "tag_id")
    private Integer tagId;

    // 构造函数、Getter 和 Setter 方法
    public ArticleTag() {}

}

