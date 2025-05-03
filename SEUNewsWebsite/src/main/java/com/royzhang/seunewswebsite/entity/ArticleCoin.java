package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "article_coins")
public class ArticleCoin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer coin_id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "article_id")
    private Integer articleId;

    @Column(name = "coin_count")
    private Integer coinCount;

    @Column(name = "coin_date")
    private Date coinDate;

    // 构造函数、Getter 和 Setter 方法
    public ArticleCoin() {}

    public Integer getCoin_id() {
        return coin_id;
    }

    public void setCoin_id(Integer coin_id) {
        this.coin_id = coin_id;
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

    public Integer getCoinCount() {
        return coinCount;
    }

    public void setCoinCount(Integer coinCount) {
        this.coinCount = coinCount;
    }

    public Date getCoinDate() {
        return coinDate;
    }

    public void setCoinDate(Date coinDate) {
        this.coinDate = coinDate;
    }
}

