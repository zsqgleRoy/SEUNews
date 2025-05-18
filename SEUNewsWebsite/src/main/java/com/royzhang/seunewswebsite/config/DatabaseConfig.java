package com.royzhang.seunewswebsite.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableJpaRepositories(basePackages = "com.royzhang.seunewswebsite.repository")
public class DatabaseConfig {

}
