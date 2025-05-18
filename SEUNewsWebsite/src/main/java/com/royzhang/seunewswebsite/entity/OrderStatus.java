package com.royzhang.seunewswebsite.entity;

import lombok.Getter;

@Getter
public enum OrderStatus {
    UNPAID("未支付"),
    PAID("已支付"),
    CANCELLED("已取消");

    private String description;

    OrderStatus(String description) {
        this.description = description;
    }

}