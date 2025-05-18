package com.royzhang.seunewswebsite.dto.Article;

import java.util.Date;

public class ArticleVersionDTO {
    private Integer version_id;
    private Integer articleId;
    private Integer versionNumber;
    private String content;
    private Date createDate;

    public Integer getVersion_id() {
        return version_id;
    }

    public void setVersion_id(Integer version_id) {
        this.version_id = version_id;
    }

    public Integer getVersionNumber() {
        return versionNumber;
    }

    public void setVersionNumber(Integer versionNumber) {
        this.versionNumber = versionNumber;
    }

    public Integer getArticleId() {
        return articleId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
