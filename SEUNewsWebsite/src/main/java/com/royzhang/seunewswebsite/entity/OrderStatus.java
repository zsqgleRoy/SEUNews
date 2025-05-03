package com.royzhang.seunewswebsite.entity;

public enum OrderStatus {
    UNPAID("未支付"),
    PAID("已支付"),
    CANCELLED("已取消");

    private String description;

    OrderStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}