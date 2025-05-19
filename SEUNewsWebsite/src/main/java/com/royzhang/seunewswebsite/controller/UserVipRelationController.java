package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.user.UserVipRelationDTO;
import com.royzhang.seunewswebsite.entity.UserVipRelation;
import com.royzhang.seunewswebsite.repository.VipRepository;
import com.royzhang.seunewswebsite.service.UserVipRelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/user-vip-relations")
public class UserVipRelationController {

    private final UserVipRelationService relationService;
    private final VipRepository vipRepository;

    @Autowired
    public UserVipRelationController(UserVipRelationService relationService, VipRepository vipRepository) {
        this.relationService = relationService;
        this.vipRepository = vipRepository;
    }

    // 开通VIP
    @PostMapping
    public ResponseEntity<UserVipRelation> activateVip(
            @RequestParam Integer userId,
            @RequestParam Integer vipId
    ) {
        UserVipRelation relation = relationService.activateVip(userId, vipId);
        return new ResponseEntity<>(relation, HttpStatus.CREATED);
    }

    @GetMapping("/user/{userId}")
    public List<UserVipRelationDTO> getUserVipRelations(@PathVariable Integer userId) {
        return relationService.getUserVipRelations(userId);
    }

    // 删除VIP记录
    @DeleteMapping
    public ResponseEntity<Void> deleteRelation(
            @RequestParam Integer userId,
            @RequestParam Integer vipId,
            @RequestParam LocalDateTime relationId
    ) {
        relationService.deleteRelation(userId, vipId, relationId);
        return ResponseEntity.noContent().build();
    }
}