package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserRoleRelationDTO;

import java.util.List;

public interface UserRoleRelationService {
    // 获取用户关联的所有角色
    List<UserRoleRelationDTO> getRolesByUserId(Integer userId);

    // 为用户分配角色
    void assignRoleToUser(UserRoleRelationDTO userRoleRelationDTO);

    // 撤销用户的角色
    void revokeRoleFromUser(Integer userId, Integer roleId);
}
