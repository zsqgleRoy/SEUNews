package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "tags")
public class Tag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="tag_id")
    private Integer tag_id;

    @Column(name="label")
    private String label;

    @Column(name="path")
    private String path;

    // 构造函数、Getter 和 Setter 方法
    public Tag() {}

}

