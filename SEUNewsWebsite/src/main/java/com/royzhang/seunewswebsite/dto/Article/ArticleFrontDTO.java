package com.royzhang.seunewswebsite.dto.Article;

import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.Article.ArticleStatus;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Setter
@Getter
public class ArticleFrontDTO {
    private Integer id;
    private String title;
    private Date publishDate;
    private String headImageUrl;
    private ArticleStatus status;

    public ArticleFrontDTO() {}

    public ArticleFrontDTO(Article article) {
        this.id = article.getArticleId();
        this.title = article.getTitle();
        this.publishDate = article.getPublishDate();
        this.headImageUrl = article.getHeadImageUrl();
        this.status = article.getStatus();
    }

}


