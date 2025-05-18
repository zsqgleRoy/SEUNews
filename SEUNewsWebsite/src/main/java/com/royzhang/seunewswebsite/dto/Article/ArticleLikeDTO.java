package com.royzhang.seunewswebsite.dto.Article;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class ArticleLikeDTO {
    private Integer userId;
    private Integer articleId;
    private Date likeDate;
}