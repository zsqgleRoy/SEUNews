package com.royzhang.seunewswebsite.utils;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import lombok.Getter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class AlipayUtils {

    private static final Logger logger = LoggerFactory.getLogger(AlipayUtils.class);

    @Value("${alipay.app-id}")
    private String appId;

    @Value("${alipay.merchant-private-key}")
    private String merchantPrivateKey;

    @Getter
    @Value("${alipay.alipay-public-key}")
    private String alipayPublicKey;

    @Value("${alipay.notify-url}")
    private String notifyUrl;

    @Value("${alipay.return-url}")
    private String returnUrl;

    @Value("${alipay.SIGN_TYPE}")
    public String SIGN_TYPE;

    @Value("${alipay.CHARSET}")
    public String CHARSET;

    @Value("${alipay.GATEWAY_URL}")
    private String GATEWAY_URL;

    public String generatePayUrl(String outTradeNo, String totalAmount, String subject, String body) {
        try {
            AlipayClient alipayClient = new DefaultAlipayClient(
                    GATEWAY_URL,
                    appId,
                    merchantPrivateKey,
                    "json",
                    CHARSET,
                    alipayPublicKey,
                    SIGN_TYPE
            );

            AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
            alipayRequest.setReturnUrl(returnUrl);
            alipayRequest.setNotifyUrl(notifyUrl);

            alipayRequest.setBizContent(String.format(
                    "{" +
                            "\"out_trade_no\":\"%s\"," +
                            "\"total_amount\":\"%s\"," +
                            "\"subject\":\"%s\"," +
                            "\"body\":\"%s\"," +
                            "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"" +
                            "}",
                    outTradeNo, totalAmount, subject, body
            ));

            return alipayClient.pageExecute(alipayRequest).getBody();
        } catch (AlipayApiException e) {
            logger.error("生成支付宝支付链接失败", e);
            return null;
        }
    }
}