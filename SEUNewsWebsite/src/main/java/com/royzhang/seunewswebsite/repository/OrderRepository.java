package com.royzhang.seunewswebsite.repository;

import com.royzhang.seunewswebsite.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    // 根据商户订单号查询订单
    Optional<Order> findByOutTradeNo(String outTradeNo);

    // 分页查询用户订单
    Page<Order> findByUid(Integer uid, Pageable pageable);

    // 分页查询用户特定状态的订单
    Page<Order> findByUidAndStatus(Integer uid, String status, Pageable pageable);
}