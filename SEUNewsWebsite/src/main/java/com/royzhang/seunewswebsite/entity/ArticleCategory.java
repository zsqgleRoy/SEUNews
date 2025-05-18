// ArticleCategory.java
package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "article_categories")
@IdClass(ArticleCategoryId.class)
public class ArticleCategory {
    @Id
    @Column(name = "article_id")
    private Integer articleId;

    @Id
    @Column(name = "category_id")
    private Integer categoryId;

    // 构造函数、Getter 和 Setter 方法
    public ArticleCategory() {}

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
}