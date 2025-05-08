package com.royzhang.seunewswebsite.dto.Article;

import java.util.Date;

import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.Article.ArticleStatus;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ArticleUpdateDTO {
    private int id;
    private String title;
    private String content;
    private Date updateDate;
    private ArticleStatus status;
    private Integer tag;
    private String headImageUrl;
    private Integer authorId;

    public ArticleUpdateDTO() {}

    public ArticleUpdateDTO(Article article) {
        this.title = article.getTitle();
        this.content = article.getContent();
        this.updateDate = article.getUpdateDate();
        this.status = article.getStatus();
        this.authorId = article.getAuthorId();
    }

}

