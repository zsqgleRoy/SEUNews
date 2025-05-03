package com.royzhang.seunewswebsite.dto.Article;

import java.util.Date;
import java.util.Objects;


public class ArticleCoinDTO {
    private Integer coin_id;
    private Integer userId;
    private Integer articleId;
    private Integer coinCount;
    private Date coinDate;

    // 无参构造函数
    public ArticleCoinDTO() {
    }

    // 全参构造函数
    public ArticleCoinDTO(Integer coin_id, Integer userId, Integer articleId, Integer coinCount, Date coinDate) {
        this.coin_id = coin_id;
        this.userId = userId;
        this.articleId = articleId;
        this.coinCount = coinCount;
        this.coinDate = coinDate;
    }

    // Getter 方法
    public Integer getCoin_id() {
        return coin_id;
    }

    public Integer getUserId() {
        return userId;
    }

    public Integer getArticleId() {
        return articleId;
    }

    public Integer getCoinCount() {
        return coinCount;
    }

    public Date getCoinDate() {
        return coinDate;
    }

    // Setter 方法
    public void setCoin_id(Integer coin_id) {
        this.coin_id = coin_id;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public void setCoinCount(Integer coinCount) {
        this.coinCount = coinCount;
    }

    public void setCoinDate(Date coinDate) {
        this.coinDate = coinDate;
    }

    // 重写 toString 方法，方便打印对象信息
    @Override
    public String toString() {
        return "ArticleCoinDTO{" +
                "coin_id=" + coin_id +
                ", userId=" + userId +
                ", articleId=" + articleId +
                ", coinCount=" + coinCount +
                ", coinDate=" + coinDate +
                '}';
    }

    // 重写 equals 方法，用于比较两个对象是否相等
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ArticleCoinDTO that = (ArticleCoinDTO) o;
        return Objects.equals(coin_id, that.coin_id) &&
                Objects.equals(userId, that.userId) &&
                Objects.equals(articleId, that.articleId) &&
                Objects.equals(coinCount, that.coinCount) &&
                Objects.equals(coinDate, that.coinDate);
    }

    // 重写 hashCode 方法，保证相等的对象具有相同的哈希码
    @Override
    public int hashCode() {
        return Objects.hash(coin_id, userId, articleId, coinCount, coinDate);
    }
}
