package com.royzhang.seunewswebsite.dto.Article;

import com.royzhang.seunewswebsite.dto.user.UserDTO;
import com.royzhang.seunewswebsite.entity.Article;
import com.royzhang.seunewswebsite.entity.Article.ArticleStatus;
import com.royzhang.seunewswebsite.entity.Tag;
import lombok.Getter;
import lombok.Setter;

import java.util.*;
import java.util.stream.Collectors;

@Setter
@Getter
public class ArticleDTO {
    private Integer article_id;
    private String title;
    private String content;
    private Date publishDate;
    private Date updateDate;
    private String author;
    private Integer authorId;
    private ArticleStatus status;
    private String headImageUrl;
    private Set<Tag> tags;
    private List<MediaDTO> medias;
    private String avatar;
    private long likes;
    private long coin;
    private long favourite;
    private long share;
    private Integer isDeleted;

    public ArticleDTO() {}

    public ArticleDTO(Article article) {
        this.article_id = article.getArticleId();
        this.authorId = article.getAuthorId();
        this.title = article.getTitle();
        this.content = article.getContent();
        this.publishDate = article.getPublishDate();
        this.updateDate = article.getUpdateDate();
        this.status = article.getStatus();
        this.headImageUrl = article.getHeadImageUrl();
        this.likes = article.getLikeNum();
        this.coin = article.getCoinNum();
        this.favourite = article.getFavoritNum();
        this.share = article.getShareNum();
        System.out.println(article.getTags().getClass());
        this.tags = article.getTags() != null ? article.getTags() : Collections.emptySet();
    }
    public ArticleDTO(Article article, UserDTO author) {
        this.article_id = article.getArticleId();
        this.authorId = article.getAuthorId();
        this.title = article.getTitle();
        this.content = article.getContent();
        this.publishDate = article.getPublishDate();
        this.updateDate = article.getUpdateDate();
        this.headImageUrl = article.getHeadImageUrl();
        this.status = article.getStatus();
        this.author = author.getUsername();
        this.avatar = author.getAvatar();
        this.likes = article.getLikeNum();
        this.coin = article.getCoinNum();
        this.favourite = article.getFavoritNum();
        this.share = article.getShareNum();
        this.tags = article.getTags() != null ? article.getTags() : Collections.emptySet();
    }

}

