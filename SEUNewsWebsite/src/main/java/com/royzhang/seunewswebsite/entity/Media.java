package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "media")
public class Media {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "media_id")
    private Integer mediaId;

    @Column(name = "file_path")
    private String filePath;

    @Column(name = "article_id")
    private Integer articleId;


    // 构造函数、Getter 和 Setter 方法
    public Media() {}

    public enum FileType {
        image, video, audio
    }
}

