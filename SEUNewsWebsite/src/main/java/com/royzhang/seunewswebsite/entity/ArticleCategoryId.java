// ArticleCategoryId.java
package com.royzhang.seunewswebsite.entity;

import java.io.Serializable;

public class ArticleCategoryId implements Serializable {
    private Integer articleId;
    private Integer categoryId;

    // 构造函数、Getter 和 Setter 方法、equals 和 hashCode 方法
    public ArticleCategoryId() {}

    public Integer getArticleId() {
        return articleId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ArticleCategoryId that = (ArticleCategoryId) o;
        return articleId.equals(that.articleId) && categoryId.equals(that.categoryId);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(articleId, categoryId);
    }
}