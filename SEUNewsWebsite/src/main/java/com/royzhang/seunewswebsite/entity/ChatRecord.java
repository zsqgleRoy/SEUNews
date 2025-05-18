package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "chat_records")
@Getter
@Setter
public class ChatRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "user_id")
    private int userId;
    private String sessionId;

    @Column(columnDefinition = "Text")
    private String content;

    private String role; // user/agent
    private LocalDateTime timestamp;
}
