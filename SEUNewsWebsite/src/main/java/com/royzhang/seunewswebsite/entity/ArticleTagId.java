package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@IdClass(ArticleTagIdPK.class)
@Setter
@Getter
@Table(name = "article_tags")
public class ArticleTagId implements java.io.Serializable {

    @Id
    @Column(name="article_id")
    private Integer articleId;

    @Id
    @Column(name="tag_id")
    private Integer tagId;

    // 构造函数、equals、hashCode（需与 ArticleTagIdPK 一致）
    public ArticleTagId() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ArticleTagId that = (ArticleTagId) o;
        return articleId.equals(that.articleId) && tagId.equals(that.tagId);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(articleId, tagId);
    }
}