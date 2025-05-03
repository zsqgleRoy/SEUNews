package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.service.EmailService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class EmailController {
    private final EmailService emailService;

    public EmailController(EmailService emailService) {
        this.emailService = emailService;
    }

    @CrossOrigin(origins = "http://seunews.pgrm.cc")
    @PostMapping("/send-code")
    public ResponseEntity<?> sendCode(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        return emailService.sendVerificationCode(email);
    }

    @CrossOrigin(origins = "http://seunews.pgrm.cc")
    @PostMapping("/validate-code")
    public ResponseEntity<?> validate(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String code = request.get("code");
        return emailService.validateCode(email, code);
    }
}
