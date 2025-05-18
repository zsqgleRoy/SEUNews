package com.royzhang.seunewswebsite.dto.Article;

import java.util.Objects;

public class ArticleCategoryDTO {
    private Integer articleId;
    private Integer categoryId;

    // 无参构造函数
    public ArticleCategoryDTO() {
    }

    // 全参构造函数
    public ArticleCategoryDTO(Integer articleId, Integer categoryId) {
        this.articleId = articleId;
        this.categoryId = categoryId;
    }

    // Getter 方法
    public Integer getArticleId() {
        return articleId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    // Setter 方法
    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    // 重写 toString 方法，方便打印对象信息
    @Override
    public String toString() {
        return "ArticleCategoryDTO{" +
                "articleId=" + articleId +
                ", categoryId=" + categoryId +
                '}';
    }

    // 重写 equals 方法，用于比较两个对象是否相等
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ArticleCategoryDTO that = (ArticleCategoryDTO) o;
        return Objects.equals(articleId, that.articleId) &&
                Objects.equals(categoryId, that.categoryId);
    }

    // 重写 hashCode 方法，保证相等的对象具有相同的哈希码
    @Override
    public int hashCode() {
        return Objects.hash(articleId, categoryId);
    }
}
