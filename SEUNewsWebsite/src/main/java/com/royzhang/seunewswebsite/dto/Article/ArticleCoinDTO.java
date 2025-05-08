package com.royzhang.seunewswebsite.dto.Article;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.Objects;


@Setter
@Getter
public class ArticleCoinDTO {
    private Integer userId;
    private Integer articleId;
    private Integer coinCount;
    private Date coinDate;

    // 无参构造函数
    public ArticleCoinDTO() {
    }

    // 全参构造函数
    public ArticleCoinDTO(Integer userId, Integer articleId, Integer coinCount, Date coinDate) {
        this.userId = userId;
        this.articleId = articleId;
        this.coinCount = coinCount;
        this.coinDate = coinDate;
    }

    // 重写 toString 方法，方便打印对象信息
    @Override
    public String toString() {
        return "ArticleCoinDTO{" +
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
        return Objects.equals(userId, that.userId) &&
                Objects.equals(articleId, that.articleId) &&
                Objects.equals(coinCount, that.coinCount) &&
                Objects.equals(coinDate, that.coinDate);
    }

    // 重写 hashCode 方法，保证相等的对象具有相同的哈希码
    @Override
    public int hashCode() {
        return Objects.hash(userId, articleId, coinCount, coinDate);
    }
}
