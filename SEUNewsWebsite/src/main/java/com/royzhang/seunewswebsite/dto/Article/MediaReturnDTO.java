package com.royzhang.seunewswebsite.dto.Article;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MediaReturnDTO {
    private int error;
    private data data;

    public MediaReturnDTO() {}

    public void setUrl(String url) {
        this.data = new data();
        this.error = 0;
        this.data.setUrl(url);
    }
}
@Getter
@Setter
class data{
    private String url;
    private String alt;
    private String href;
}