package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserDTO;
import com.royzhang.seunewswebsite.dto.user.UserBaseInfoDTO;

import java.util.List;
import java.util.Optional;

public interface UserService {
    // 获取所有用户
    List<UserDTO> getAllUsers();

    // 根据 ID 获取用户
    UserDTO getUserById(Integer id);

    UserDTO getUserFrontById(Integer id);

    // 创建用户
    UserDTO createUser(UserDTO userDTO);

    // 更新用户信息
    UserDTO updateUser(Integer id, UserDTO userDTO);

    // 删除用户
    void deleteUser(Integer id);

    // 根据用户名查找用户
    Optional<UserBaseInfoDTO> findUserByUsername(String username);

    Integer findUserIdByUsername(String username);

    Optional<UserBaseInfoDTO> findUserByUsernameAndPassword(String username, String password);

    boolean authenticateUser(String username, String password);

    boolean saveUser(UserDTO userDTO);
}
