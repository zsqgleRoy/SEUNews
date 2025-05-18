package com.royzhang.seunewswebsite.service;

import jakarta.annotation.PostConstruct;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.scheduling.annotation.Async;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import freemarker.template.Configuration;
import freemarker.template.Template;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.Executor;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;

@Slf4j
@Service
public class EmailService {
    private static final String CODE_PREFIX = "email_code:";
    private static final long CODE_EXPIRE = 300; // 5分钟（秒）
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    );
    private Template emailTemplate;
    private final JavaMailSender mailSender;
    private final RedisTemplate<String, String> redisTemplate;
    private final Configuration freeMarkerConfig;
    private final Executor emailExecutor;

    @Value("${spring.mail.username}")
    private String senderEmail;

    // 强制依赖注入（避免构造函数冲突）
    @Autowired
    public EmailService(
            JavaMailSender mailSender,
            RedisTemplate<String, String> redisTemplate,
            Configuration freeMarkerConfig,
            @Qualifier("emailExecutor") Executor emailExecutor
    ) {
        this.mailSender = mailSender;
        this.redisTemplate = redisTemplate;
        this.freeMarkerConfig = freeMarkerConfig;
        this.emailExecutor = emailExecutor;
        log.info("EmailService initialized with emailExecutor: {}", emailExecutor);
    }
    @PostConstruct
    public void initTemplate() throws IOException {
        emailTemplate = freeMarkerConfig.getTemplate("email-template.ftl");
    }

    /** 发送验证码主流程（同步快速返回） */
    public ResponseEntity<?> sendVerificationCode(String email) {
        // 1. 邮箱格式校验
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return ResponseEntity.badRequest().body("邮箱格式错误");
        }

        String code = generateCode();

        // 2. 存储Redis（原子操作+超时控制）
        try {
            redisTemplate.opsForValue().set(
                    CODE_PREFIX + email,
                    code,
                    CODE_EXPIRE,
                    TimeUnit.SECONDS
            );
        } catch (Exception e) {
            log.error("Redis存储失败: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body("服务繁忙，请重试");
        }
        // 3. 异步发送邮件（不阻塞主线程）
        sendEmailAsync(email, code);
        return new ResponseEntity<>(true, HttpStatus.OK);
    }

    /** 异步邮件发送（带异常清理） */
    @Async("emailExecutor") // 绑定自定义线程池
    public void sendEmailAsync(String to, String code) {
        long start = System.currentTimeMillis();
        try {
            // 模板存在性校验
            Template template = emailTemplate;
            if (template == null) {
                throw new IOException("邮件模板不存在");
            }

            // 构建邮件
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setFrom(senderEmail, "SEU新闻网");
            helper.setTo(to);
            helper.setSubject("[SEU新闻网] 邮箱验证码");

            // 渲染模板
            Map<String, Object> model = new HashMap<>();
            model.put("code", code);
            String content = FreeMarkerTemplateUtils.processTemplateIntoString(template, model);
            helper.setText(content, true);
            // 发送邮件
            mailSender.send(message);
            log.info("邮件发送成功: {} (耗时{}ms)", to, System.currentTimeMillis() - start);
        } catch (MessagingException | MailAuthenticationException e) {
            log.error("邮件发送失败: {} | 错误类型: {} | 错误信息: {}", to, e.getClass().getSimpleName(), e.getMessage());
            redisTemplate.delete(CODE_PREFIX + to);
        } catch (Exception e) {
            // 其他异常（如连接关闭警告）仅记录不清理验证码
            log.warn("邮件发送过程中出现非关键异常: {} | 错误: {}", to, e.getMessage());
        }
    }

    /** 验证码验证 */
    public ResponseEntity<?> validateCode(String email, String code) {
        String storedCode = redisTemplate.opsForValue().get(CODE_PREFIX + email);
        boolean isValid = storedCode != null && storedCode.equals(code);

        if (isValid) {
            redisTemplate.delete(CODE_PREFIX + email); // 验证成功后删除（防重用）
            return ResponseEntity.ok(true);
        }
        return ResponseEntity.badRequest().body("验证码错误或已过期");
    }

    // 工具方法
    private String generateCode() {
        return String.format("%06d", new Random().nextInt(999999));
    }
}
