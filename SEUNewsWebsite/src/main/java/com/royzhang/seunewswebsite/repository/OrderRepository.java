package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    // 根据商户订单号查询订单
    Optional<Order> findByOutTradeNo(String outTradeNo);
}