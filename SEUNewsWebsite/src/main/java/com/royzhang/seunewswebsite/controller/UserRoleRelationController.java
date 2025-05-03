package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.user.UserRoleRelationDTO;
import com.royzhang.seunewswebsite.service.EmailService;
import com.royzhang.seunewswebsite.service.UserRoleRelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user-role-relations")
public class UserRoleRelationController {

    @Autowired
    private UserRoleRelationService userRoleRelationService;

    // 获取用户关联的所有角色
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<UserRoleRelationDTO>> getRolesByUserId(@PathVariable Integer userId) {
        List<UserRoleRelationDTO> relations = userRoleRelationService.getRolesByUserId(userId);
        return new ResponseEntity<>(relations, HttpStatus.OK);
    }

    // 为用户分配角色
    @PostMapping
    public ResponseEntity<Void> assignRoleToUser(@RequestBody UserRoleRelationDTO userRoleRelationDTO) {
        userRoleRelationService.assignRoleToUser(userRoleRelationDTO);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    // 撤销用户的角色
    @DeleteMapping("/user/{userId}/role/{roleId}")
    public ResponseEntity<Void> revokeRoleFromUser(@PathVariable Integer userId, @PathVariable Integer roleId) {
        userRoleRelationService.revokeRoleFromUser(userId, roleId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
