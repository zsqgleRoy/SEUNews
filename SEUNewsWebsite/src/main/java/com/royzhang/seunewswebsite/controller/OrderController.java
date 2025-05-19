package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.PageResponse;
import com.royzhang.seunewswebsite.entity.Order;
import com.royzhang.seunewswebsite.entity.OrderStatus;
import com.royzhang.seunewswebsite.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public ResponseEntity<PageResponse<Order>> getAllOrders(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Page<Order> pageResult = orderService.findAllOrders(page, size);

        return ResponseEntity.ok(new PageResponse<>(
                pageResult.getContent(),
                pageResult.getTotalElements(),
                pageResult.getTotalPages(),
                pageResult.getNumber(),
                pageResult.getSize()
        ));
    }

    /**
     * 根据订单号查询订单详情
     */
    @GetMapping("/{outTradeNo}")
    public ResponseEntity<Order> getOrderByOutTradeNo(@PathVariable String outTradeNo) {
        Optional<Order> order = orderService.findByOutTradeNo(outTradeNo);
        return order.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    /**
     * 根据用户ID查询订单列表（未支付/已支付状态）
     */
    @GetMapping("/user/{userId}")
    public ResponseEntity<Page<Order>> getOrdersByUserId(
            @PathVariable Integer userId,
            @RequestParam(required = false) OrderStatus status,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return status != null ?
                ResponseEntity.ok(orderService.findOrdersByUidAndStatus(userId, status, PageRequest.of(page, size))) :
                ResponseEntity.ok(orderService.findOrdersByUid(userId, PageRequest.of(page, size)));
    }

    /**
     * 更新订单状态（仅示例，实际可能由支付回调触发）
     */
    @PutMapping("/{outTradeNo}/status")
    public ResponseEntity<Void> updateOrderStatus(
            @PathVariable String outTradeNo,
            @RequestBody OrderStatus newStatus
    ) {
        orderService.updateOrderStatus(outTradeNo, newStatus);
        return ResponseEntity.noContent().build();
    }
}