package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.entity.Order;
import com.royzhang.seunewswebsite.entity.OrderStatus;
import com.royzhang.seunewswebsite.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Optional;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    public void createOrder(String outTradeNo, BigDecimal totalAmount, String subject, String body, Integer uid, Integer vipId) {
        Order order = new Order();
        order.setOutTradeNo(outTradeNo);
        order.setTotalAmount(totalAmount);
        order.setSubject(subject);
        order.setBody(body);
        order.setStatus(OrderStatus.UNPAID.name());
        order.setCreateTime(new Date());
        order.setUpdateTime(new Date());
        order.setUid(uid);
        order.setVipId(vipId);
        orderRepository.save(order);
    }

    @Transactional(readOnly = true)
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

    public Page<Order> findOrdersByUid(Integer uid, Pageable pageable) {
        return orderRepository.findByUid(uid, pageable);
    }

    public Page<Order> findOrdersByUidAndStatus(Integer uid, OrderStatus status, Pageable pageable) {
        return orderRepository.findByUidAndStatus(uid, status.name(), pageable);
    }

    public Page<Order> findAllOrders(Pageable pageable) {
        return orderRepository.findAll(pageable);
    }
}