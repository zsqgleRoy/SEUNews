package com.royzhang.seunewswebsite.dto.order;

import java.math.BigDecimal;
import java.util.Date;

public record OrderDTO(
        String outTradeNo,
        String subject,
        BigDecimal totalAmount,
        String status,
        Date createTime
) {}

