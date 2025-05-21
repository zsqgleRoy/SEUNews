package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserBaseInfoDTO;
import com.royzhang.seunewswebsite.dto.user.UserDTO;
import com.royzhang.seunewswebsite.entity.User;
import com.royzhang.seunewswebsite.repository.UserRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import static org.springframework.http.HttpStatus.*;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<UserDTO> getAllUsers() {
        List<User> users = userRepository.findAll();
        return users.stream()
                .map(user -> modelMapper.map(user, UserDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public UserDTO getUserById(Integer id) {
        Optional<User> userOptional = userRepository.findById(id);
        return userOptional.map(user -> modelMapper.map(user, UserDTO.class)).orElse(null);
    }

    @Override
    public UserDTO getUserFrontById(Integer id) {
        User userOptional = userRepository.findUserByUserId(id);
        UserDTO userDTO = modelMapper.map(userOptional, UserDTO.class);
        userDTO.setPassword(null);
        return userDTO;
    }

    @Override
    public UserDTO createUser(UserDTO userDTO) {
        // 验证用户名是否已存在
        if (userRepository.existsByUsername(userDTO.getUsername())) {
            throw new ResponseStatusException(CONFLICT, "用户名已存在");
        }

        // 验证邮箱是否已存在
        if (userRepository.existsByEmail(userDTO.getEmail())) {
            throw new ResponseStatusException(CONFLICT, "邮箱已被注册");
        }

        // 转换DTO到实体
        User user = modelMapper.map(userDTO, User.class);

        try {
            // 保存用户
            User savedUser = userRepository.save(user);
            // 转换实体到DTO
            return modelMapper.map(savedUser, UserDTO.class);
        } catch (DataIntegrityViolationException e) {
            // 处理数据库约束异常
            throw new ResponseStatusException(BAD_REQUEST, "无效的用户数据", e);
        } catch (Exception e) {
            // 处理其他异常
            throw new ResponseStatusException(INTERNAL_SERVER_ERROR, "创建用户失败", e);
        }
    }

    @Override
    public UserDTO updateUser(Integer id, UserDTO userDTO) {
        Optional<User> userOptional = userRepository.findById(id);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.setUsername(userDTO.getUsername());
            if (userDTO.getPassword() != null && !userDTO.getPassword().isEmpty()) {
                user.setPassword(userDTO.getPassword()); // 仅当密码非空时更新
            }
            user.setEmail(userDTO.getEmail());
            user.setAvatar(userDTO.getAvatar());
            user.setIsAuthor(userDTO.getIsAuthor().toString().equals("TRUE")?User.IsAuthor.TRUE:User.IsAuthor.FALSE);
            user.setName(userDTO.getName());
            user.setPhone(userDTO.getPhone());
            user.setBirthday(userDTO.getBirthday());
            User updatedUser = userRepository.save(user);
            return modelMapper.map(updatedUser, UserDTO.class);
        }
        return null;
    }

    @Override
    public void deleteUser(Integer id) {
        userRepository.deleteByIds(id);
    }

    @Override
    public Optional<UserBaseInfoDTO> findUserByUsername(String username) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        return userOptional.map(user -> modelMapper.map(user, UserBaseInfoDTO.class));
    }

    @Override
    public Optional<UserBaseInfoDTO> findUserByUsernameAndPassword(String username, String password) {
        Optional<User> userOptional = userRepository.findByUsernameAndPassword(username, password);
        return userOptional.map(user -> modelMapper.map(user, UserBaseInfoDTO.class));
    }
    @Override
    public Integer findUserIdByUsername(String username) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        return userOptional.map(User::getUser_id).orElse(null);
    }
    @Override
    public boolean authenticateUser(String username, String password) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        return userOptional.filter(user -> Objects.equals(user.getPassword(), password)).isPresent();
    }
    @Override
    public boolean saveUser(UserDTO userDTO) {
        try {
            // 将 UserDTO 映射为 User 实体
            User user = modelMapper.map(userDTO, User.class);
            // 保存 User 实体到数据库
            userRepository.save(user);
            return true;
        } catch (Exception e) {
            // 出现异常，记录日志并返回 false
            e.printStackTrace();
            return false;
        }
    }
}
