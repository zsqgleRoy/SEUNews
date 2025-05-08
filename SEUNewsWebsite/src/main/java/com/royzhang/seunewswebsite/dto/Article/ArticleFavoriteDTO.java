package com.royzhang.seunewswebsite.dto.Article;


import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class ArticleFavoriteDTO {
    private Integer userId;
    private Integer articleId;
    private Date favoriteDate;

    // 构造函数、Getter 和 Setter
}
