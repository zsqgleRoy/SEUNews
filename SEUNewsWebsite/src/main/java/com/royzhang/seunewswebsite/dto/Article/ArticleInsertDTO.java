package com.royzhang.seunewswebsite.dto.Article;

import java.util.Date;

import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.Article.ArticleStatus;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ArticleInsertDTO {
    private String title;
    private String content;
    private Date publishDate;
    private Date updateDate;
    private String author;
    private Integer authorId;
    private ArticleStatus status;
    private Integer isDeleted;
    private Integer[] tags;
    private String headImageUrl;

    public ArticleInsertDTO() {}

    public ArticleInsertDTO(Article article) {
        this.authorId = article.getAuthorId();
        this.title = article.getTitle();
        this.content = article.getContent();
        this.publishDate = article.getPublishDate();
        this.updateDate = article.getUpdateDate();
        this.status = article.getStatus();
    }

}

