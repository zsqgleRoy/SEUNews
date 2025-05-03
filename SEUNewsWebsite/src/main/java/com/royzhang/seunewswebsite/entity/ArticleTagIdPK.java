package com.royzhang.seunewswebsite.entity;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class ArticleTagIdPK implements Serializable {
    private Integer articleId;
    private Integer tagId;
}
