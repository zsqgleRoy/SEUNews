package com.royzhang.seunewswebsite.dto.Article;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.Article.ArticleStatus;
import com.royzhang.seunewswebsite.entity.Tag;
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
    private Set<Integer> tags;
    private String headImageUrl;
    private Integer authorId;

    public ArticleUpdateDTO() {}

    public ArticleUpdateDTO(Article article) {
        this.title = article.getTitle();
        this.content = article.getContent();
        this.updateDate = article.getUpdateDate();
        this.status = article.getStatus();
        this.authorId = article.getAuthorId();
        this.headImageUrl = article.getHeadImageUrl();
    }

}

