package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserRoleDTO;

import java.util.List;

public interface UserRoleService {
    // 获取所有用户角色
    List<UserRoleDTO> getAllRoles();

    // 根据角色 ID 获取用户角色
    UserRoleDTO getRoleById(Integer roleId);

    // 创建用户角色
    UserRoleDTO createRole(UserRoleDTO userRoleDTO);

    // 更新用户角色
    UserRoleDTO updateRole(Integer roleId, UserRoleDTO userRoleDTO);

    // 删除用户角色
    void deleteRole(Integer roleId);
}
