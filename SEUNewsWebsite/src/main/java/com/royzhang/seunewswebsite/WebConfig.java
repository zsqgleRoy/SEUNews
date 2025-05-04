package com.royzhang.seunewswebsite;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/news-images/**","/static/news-videos/**", "/static/news-music/**")
                .addResourceLocations("file:D:/uploads/NewsImg/", "file:D:/uploads/NewsVideo/", "file:D:/uploads/NewsMusic/");
    }
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:/index.html");
        registry.addViewController("/{x:[\\w\\-]+}").setViewName("forward:/index.html");
        registry.addViewController("/{x:^(?!api|admin|static|favicon.ico).*$}").setViewName("forward:/index.html");
    }
}

