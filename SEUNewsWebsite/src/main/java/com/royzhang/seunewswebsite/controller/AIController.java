package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.entity.ChatRecord;
import com.royzhang.seunewswebsite.repository.ChatRecordRepository;
import com.royzhang.seunewswebsite.service.DeepSeekTestService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api")
public class AIController {
    private final DeepSeekTestService deepSeekTestService;
    private final ChatRecordRepository chatRecordRepository;

    @Autowired
    public AIController(DeepSeekTestService deepSeekTestService,
                        ChatRecordRepository chatRecordRepository) {
        this.deepSeekTestService = deepSeekTestService;
        this.chatRecordRepository = chatRecordRepository;
    }

    @GetMapping("/ask")
    public ResponseEntity<String> handleQuery(
            @RequestParam String msg,
            @RequestParam String sessionId,
            @RequestParam Integer user_id
    ) {

        // 保存用户消息
        saveMessage(msg, "user", sessionId, user_id);

        // 获取AI响应
        String response = deepSeekTestService.getResponse(msg);

        // 保存AI回复
        saveMessage(response, "agent", sessionId, user_id);
        return ResponseEntity.ok(response);
    }

    private void saveMessage(String content, String role, String sessionId, int user_id) {
        ChatRecord record = new ChatRecord();
        record.setContent(content);
        record.setRole(role);
        record.setSessionId(sessionId);
        record.setTimestamp(LocalDateTime.now());
        record.setUserId(user_id);
        chatRecordRepository.save(record);
    }

    @GetMapping("/history")
    public ResponseEntity<List<ChatRecord>> getHistory(
            @RequestParam Integer user_id,
            HttpServletRequest request) {
        // 添加简单的IP验证
        String clientIP = request.getRemoteAddr();
        if (!isValidSession(user_id, clientIP)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        return ResponseEntity.ok(
            chatRecordRepository.findByUserId(user_id)
        );
    }

    private boolean isValidSession(int user_id, String clientIP) {
        return true;
    }
}