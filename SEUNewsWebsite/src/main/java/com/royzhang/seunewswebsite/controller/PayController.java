package com.royzhang.seunewswebsite.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
import com.royzhang.seunewswebsite.entity.OrderStatus;
import com.royzhang.seunewswebsite.entity.Vip;
import com.royzhang.seunewswebsite.repository.VipRepository;
import com.royzhang.seunewswebsite.service.OrderService;
import com.royzhang.seunewswebsite.utils.AlipayUtils;
import com.royzhang.seunewswebsite.service.UserVipRelationService;
import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

@RestController
@RequestMapping("/api/pay")
public class PayController {
    private static final Logger logger = LoggerFactory.getLogger(PayController.class);
    private final AlipayUtils alipayUtils;
    private final OrderService orderService;
    private final UserVipRelationService userVipRelationService;
    private final VipRepository vipRepository;

    @Value("${alipay.alipay-public-key}")
    private String alipayPublicKey;

    public PayController(AlipayUtils alipayUtils, OrderService orderService, UserVipRelationService userVipRelationService, VipRepository vipRepository) {
        this.alipayUtils = alipayUtils;
        this.orderService = orderService;
        this.userVipRelationService = userVipRelationService;
        this.vipRepository = vipRepository;
    }

    @Data
    public static class PayRequest {
        private Integer uid;
        private Integer vipId;
        private BigDecimal amount;
        private String timeLong;
        private Integer timeLongValue;
    }String outTradeNo = UUID.randomUUID().toString();

    @PostMapping("/alipay")
    public String alipay(@RequestBody PayRequest payRequest) throws AlipayApiException {
        String outTradeNo = UUID.randomUUID().toString();
        Vip vip = vipRepository.findVipById(payRequest.getVipId());
        payRequest.setAmount(vip.getPrice().multiply(vip.getDiscount()));
        payRequest.setTimeLong(vip.getDurations().getDisplayName());
        payRequest.setTimeLongValue(vip.getDurationsValue());
        BigDecimal totalAmount = new BigDecimal(String.valueOf(payRequest.getAmount())).setScale(2, RoundingMode.HALF_UP);

        Integer uid = payRequest.getUid();
        String subject = payRequest.getTimeLong() + "东南新闻会员" + "（"+ payRequest.getTimeLongValue() + "天）";
        String body = "东南新闻项目组";
        orderService.createOrder(outTradeNo, totalAmount, subject, body, uid, payRequest.getVipId());
        logger.info("生成支付链接，订单号：{}", outTradeNo);
        return alipayUtils.generatePayUrl(outTradeNo, totalAmount.toString(), subject, body);
    }

    @PostMapping("/notify")
    public String alipayNotify(HttpServletRequest request) {
        Map<String, String> params = new HashMap<>();
        request.getParameterMap().forEach((key, values) -> params.put(key, values[0]));

        boolean isVerifySuccess = false;
        try {
            isVerifySuccess = AlipaySignature.rsaCheckV1(
                    params,
                    alipayUtils.getAlipayPublicKey(),
                    alipayUtils.CHARSET,
                    alipayUtils.SIGN_TYPE
            );
        } catch (AlipayApiException e) {
            logger.error("支付宝异步通知签名验证失败", e);
        }

        if (isVerifySuccess && "TRADE_SUCCESS".equals(params.get("trade_status"))) {
            String outTradeNo = params.get("out_trade_no");
            logger.info("收到支付成功通知，订单号：{}", outTradeNo);
            orderService.findByOutTradeNo(outTradeNo)
                    .ifPresent(o -> {
                        orderService.updateOrderStatus(o.getOutTradeNo(), OrderStatus.PAID);
                        userVipRelationService.activateVip(o.getUid(), o.getVipId());
                    });
        }
        return "success";
    }

    @GetMapping("/verify")
    public ResponseEntity<Map<String, Boolean>> verifyPayment(
            @RequestParam String outTradeNo
    ) {
        try {
            boolean isPaymentSuccess = orderService.findByOutTradeNo(outTradeNo)
                    .map(order -> OrderStatus.PAID.name().equals(order.getStatus()))
                    .orElse(false);
            logger.info("支付结果验证，订单号：{}，状态：{}", outTradeNo, isPaymentSuccess);
            return ResponseEntity.ok(Collections.singletonMap("success", isPaymentSuccess));
        } catch (Exception e) {
            logger.error("支付结果验证出错，订单号：{}", outTradeNo, e);
            return ResponseEntity.status(500).body(Collections.singletonMap("success", false));
        }
    }
}