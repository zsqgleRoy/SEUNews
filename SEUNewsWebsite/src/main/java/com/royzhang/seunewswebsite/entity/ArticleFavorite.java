package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

@Setter
@Getter
@Entity
@Table(name = "article_favorites")
@IdClass(ArticleFavorite.ArticleFavoritId.class)
public class ArticleFavorite {

    @Id
    @Column(name = "user_id")
    private Integer userId;

    @Id
    @Column(name = "article_id")
    private Integer articleId;

    @Column(name = "favorite_date")
    private Date favoriteDate;

    // 构造函数、Getter 和 Setter 方法
    public ArticleFavorite() {}

    @Getter
    @Setter
    public static class ArticleFavoritId implements Serializable {
        private Integer userId;
        private Integer articleId;

        // 必须重写 equals 和 hashCode 方法
        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            ArticleFavorite.ArticleFavoritId that = (ArticleFavorite.ArticleFavoritId) o;
            return userId.equals(that.userId) &&
                    articleId.equals(that.articleId);
        }

        @Override
        public int hashCode() {
            return Objects.hash(userId, articleId);
        }
    }
}

