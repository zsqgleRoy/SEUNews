package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.entity.Order;
import com.royzhang.seunewswebsite.entity.OrderStatus;
import com.royzhang.seunewswebsite.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Optional;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    // 创建订单
    public Order createOrder(String outTradeNo, BigDecimal totalAmount, String subject, String body, Integer uid) {
        Order order = new Order();
        order.setOutTradeNo(outTradeNo);
        order.setTotalAmount(totalAmount);
        order.setSubject(subject);
        order.setBody(body);
        order.setStatus(OrderStatus.UNPAID.name());
        order.setCreateTime(new Date());
        order.setUpdateTime(new Date());
        order.setUid(uid);

        return orderRepository.save(order);
    }

    // 根据商户订单号查询订单
    public Optional<Order> findByOutTradeNo(String outTradeNo) {
        return orderRepository.findByOutTradeNo(outTradeNo);
    }

    // 更新订单状态
    public void updateOrderStatus(String outTradeNo, OrderStatus status) {
        orderRepository.findByOutTradeNo(outTradeNo).ifPresent(order -> {
            order.setStatus(status.name());
            order.setPaymentTime(new Date());
            order.setUpdateTime(new Date());
            orderRepository.save(order);
        });
    }
}