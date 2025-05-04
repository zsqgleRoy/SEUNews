package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Setter
@Getter
@Entity
@Table(name = "article_coins")
public class ArticleCoin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long coin_id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "article_id")
    private Integer articleId;

    @Column(name = "coin_count")
    private Integer coinCount;

    @Column(name = "coin_date")
    private Date coinDate;

    // 构造函数、Getter 和 Setter 方法
    public ArticleCoin() {}

}

