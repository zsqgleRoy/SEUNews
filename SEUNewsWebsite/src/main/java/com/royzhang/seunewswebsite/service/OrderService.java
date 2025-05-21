package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.entity.Order;
import com.royzhang.seunewswebsite.entity.OrderStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Optional;

public interface OrderService {

    void createOrder(String outTradeNo, BigDecimal totalAmount, String subject, String body, Integer uid, Integer vipId);

    @Transactional(readOnly = true)
    Optional<Order> findByOutTradeNo(String outTradeNo);

    void updateOrderStatus(String outTradeNo, OrderStatus status);

    Page<Order> findOrdersByUid(Integer uid, Pageable pageable);

    Page<Order> findOrdersByUidAndStatus(Integer uid, OrderStatus status, Pageable pageable);

    Page<Order> findAllOrders(Pageable pageable);

    Page<Order> findAllOrders(int page, int size);

    boolean deleteOrderByOutTradeNo(String outTradeNo);
}