package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "article_versions")
public class ArticleVersion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer version_id;

    @Column(name = "article_id")
    private Integer articleId;

    @Column(name = "version_number")
    private Integer versionNumber;

    @Lob
    private String content;

    @Column(name = "create_date")
    private Date createDate;

    // 构造函数、Getter 和 Setter 方法
    public ArticleVersion() {}

    public Integer getVersion_id() {
        return version_id;
    }

    public void setVersion_id(Integer version_id) {
        this.version_id = version_id;
    }

    public Integer getArticleId() {
        return articleId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public Integer getVersionNumber() {
        return versionNumber;
    }

    public void setVersionNumber(Integer versionNumber) {
        this.versionNumber = versionNumber;
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
