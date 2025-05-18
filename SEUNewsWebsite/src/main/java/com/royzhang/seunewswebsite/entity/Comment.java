package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Setter
@Getter
@Entity
@Table(name = "comments")
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private Integer commentId;

    @Column(name = "article_id")
    private Integer articleId;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "content")
    private String content;

    @Column(name = "publish_date")
    private Date publishDate;

    @Column(name = "ip")
    private String ip;

    @Column(name = "is_deleted")
    private Integer isDeleted;

    // 添加实体关联（推荐）
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private User user;

    // 构造函数、Getter 和 Setter 方法
    public Comment() {}

}

