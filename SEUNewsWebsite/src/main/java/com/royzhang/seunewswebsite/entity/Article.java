package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "articles")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 数据库自增
    private Integer articleId;

    @Column(name = "title")
    private String title;

    @Column(columnDefinition = "Text")
    private String content;

    @Column(name = "publish_date")
    private Date publishDate;

    @Column(name = "update_date")
    private Date updateDate;

    @Column(name = "author_id")
    private Integer authorId;

    @Enumerated(EnumType.STRING)
    private ArticleStatus status;

    public enum ArticleStatus {
        DRAFT, PUBLISHED
    }
}
