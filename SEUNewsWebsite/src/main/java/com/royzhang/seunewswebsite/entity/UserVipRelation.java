package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_vip_relations")
@IdClass(UserVipRelationId.class) // 指定复合主键类
@Data
public class UserVipRelation {

    @Id
    @Column(name = "uid", nullable = false)
    private Integer uid;

    @Id
    @Column(name = "vip_id", nullable = false)
    private Integer vipId;

    @Id
    @Column(name = "activation_time")
    private LocalDateTime activationTime;

    @Column(name = "expire_time")
    private LocalDateTime expireTime;

    @ManyToOne
    @JoinColumn(name = "uid", referencedColumnName = "user_id", insertable = false, updatable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "vip_id", referencedColumnName = "id", insertable = false, updatable = false)
    private Vip vip;
}