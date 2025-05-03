package com.royzhang.seunewswebsite.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Data
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "uid")
    private int uid;

    // 商户订单号
    private String outTradeNo;

    // 订单金额
    private BigDecimal totalAmount;

    // 订单名称
    private String subject;

    // 商品描述
    private String body;

    // 订单状态
    private String status;

    // 支付时间
    private Date paymentTime;

    // 创建时间
    private Date createTime;

    // 更新时间
    private Date updateTime;
}