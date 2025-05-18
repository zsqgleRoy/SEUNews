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
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "uid")
    private int uid;

    // 商户订单号
    @Column(name = "out_trade_no")
    private String outTradeNo;

    // 订单金额
    @Column(name = "total_amount")
    private BigDecimal totalAmount;

    // 订单名称
    @Column(name = "subject")
    private String subject;

    // 商品描述
    @Column(name = "body")
    private String body;

    // 订单状态
    @Column(name = "status")
    private String status;

    // 支付时间
    @Column(name = "payment_time")
    private Date paymentTime;

    // 创建时间
    @Column(name = "create_time")
    private Date createTime;

    // 更新时间
    @Column(name = "update_time")
    private Date updateTime;
}