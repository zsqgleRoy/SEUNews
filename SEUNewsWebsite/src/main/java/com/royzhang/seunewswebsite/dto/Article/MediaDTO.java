package com.royzhang.seunewswebsite.dto.Article;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MediaDTO {
    // Getter 和 Setter 方法
    private Integer mediaId;
    private String filePath;
    private Integer articleId;

    // 构造函数
    public MediaDTO() {}

}
