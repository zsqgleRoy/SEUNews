package com.royzhang.seunewswebsite.dto.Article;


import lombok.*;

import java.util.Date;

@Builder
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class CommentDTO {
    private Integer commentId;
    private Integer articleId;
    private Integer userId;
    private String content;
    private Date publishDate;
    private String username;
    private String avatar;
    private String ip;
}
