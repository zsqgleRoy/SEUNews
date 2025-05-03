package com.royzhang.seunewswebsite;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {
    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        // 允许指定的源进行跨域调用，这里设置为前端项目的地址
        config.addAllowedOriginPattern("http://localhost:4567");
        config.addAllowedOriginPattern("http://seunews.pgrm.cc");
        config.addAllowedOriginPattern("http://seunewsbac.pgrm.cc");
        config.addAllowedHeader("*"); // 允许任何请求头
        config.addAllowedMethod("*"); // 允许任何方法（POST、GET等）
        config.setAllowCredentials(true); // 允许携带凭证

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config); // 对所有接口都有效

        return new CorsFilter(source);
    }
}

