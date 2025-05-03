package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.user.UserRoleDTO;
import com.royzhang.seunewswebsite.service.UserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user-roles")
public class UserRoleController {

    @Autowired
    private UserRoleService userRoleService;

    // 获取所有用户角色
    @GetMapping
    public ResponseEntity<List<UserRoleDTO>> getAllRoles() {
        List<UserRoleDTO> roles = userRoleService.getAllRoles();
        return new ResponseEntity<>(roles, HttpStatus.OK);
    }

    // 根据角色 ID 获取用户角色
    @GetMapping("/{roleId}")
    public ResponseEntity<UserRoleDTO> getRoleById(@PathVariable Integer roleId) {
        UserRoleDTO role = userRoleService.getRoleById(roleId);
        if (role != null) {
            return new ResponseEntity<>(role, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    // 创建用户角色
    @PostMapping
    public ResponseEntity<UserRoleDTO> createRole(@RequestBody UserRoleDTO userRoleDTO) {
        UserRoleDTO createdRole = userRoleService.createRole(userRoleDTO);
        return new ResponseEntity<>(createdRole, HttpStatus.CREATED);
    }

    // 更新用户角色
    @PutMapping("/{roleId}")
    public ResponseEntity<UserRoleDTO> updateRole(@PathVariable Integer roleId, @RequestBody UserRoleDTO userRoleDTO) {
        UserRoleDTO updatedRole = userRoleService.updateRole(roleId, userRoleDTO);
        if (updatedRole != null) {
            return new ResponseEntity<>(updatedRole, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    // 删除用户角色
    @DeleteMapping("/{roleId}")
    public ResponseEntity<Void> deleteRole(@PathVariable Integer roleId) {
        userRoleService.deleteRole(roleId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
