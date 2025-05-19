package com.royzhang.seunewswebsite.entity;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

public class UserVipRelationId implements Serializable {
    private Integer uid;
    private Integer vipId;
    private LocalDateTime activationTime;

    public UserVipRelationId() {}

    public UserVipRelationId(Integer uid, Integer vipId, LocalDateTime activationTime) {
        this.uid = uid;
        this.vipId = vipId;
        this.activationTime = activationTime;
    }

    // 必须实现 equals 和 hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserVipRelationId that = (UserVipRelationId) o;
        return Objects.equals(uid, that.uid) && Objects.equals(vipId, that.vipId) && Objects.equals(activationTime, that.activationTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(uid, vipId, activationTime);
    }
}