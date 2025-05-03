package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Setter
@Getter
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer user_id;

    @Column(name = "user_name") // 注意：原字段名可能拼写错误，这里假设是 username
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "email")
    private String email;

    @Column(name = "register_date")
    private Date registerDate;

    /**
     * 头像
    */
    @Column(name = "avatar")
    private String avatar;

    @Column(name = "is_author")
    @Enumerated(EnumType.STRING)
    private IsAuthor isAuthor;

    // 构造函数、Getter 和 Setter 方法
    public User() {}

    public enum IsAuthor {
        TRUE, FALSE
    }
}
