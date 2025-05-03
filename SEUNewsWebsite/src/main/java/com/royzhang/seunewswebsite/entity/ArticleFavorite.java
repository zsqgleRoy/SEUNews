package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "article_favorites")
public class ArticleFavorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer favorite_id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "article_id")
    private Integer articleId;

    @Column(name = "favorite_date")
    private Date favoriteDate;

    // 构造函数、Getter 和 Setter 方法
    public ArticleFavorite() {}

    public Integer getFavorite_id() {
        return favorite_id;
    }

    public void setFavorite_id(Integer favorite_id) {
        this.favorite_id = favorite_id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getArticleId() {
        return articleId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public Date getFavoriteDate() {
        return favoriteDate;
    }

    public void setFavoriteDate(Date favoriteDate) {
        this.favoriteDate = favoriteDate;
    }
}

