package com.royzhang.seunewswebsite.dto.user;

import com.royzhang.seunewswebsite.entity.UserVipRelation;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserVipRelationDTO {
    private Integer vipId;
    private LocalDateTime activationTime;
    private LocalDateTime expireTime; // 新增字段

    public UserVipRelationDTO(UserVipRelation relation) {
        this.vipId = relation.getVipId();
        this.activationTime = relation.getActivationTime();
        this.expireTime = relation.getExpireTime();
    }
}
