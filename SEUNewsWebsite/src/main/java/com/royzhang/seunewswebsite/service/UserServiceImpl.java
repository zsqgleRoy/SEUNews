package com.royzhang.seunewswebsite.service;

import com.royzhang.seunewswebsite.dto.user.UserBaseInfoDTO;
import com.royzhang.seunewswebsite.dto.user.UserDTO;
import com.royzhang.seunewswebsite.entity.User;
import com.royzhang.seunewswebsite.repository.UserRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

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
    public UserDTO createUser(UserDTO userDTO) {
        User user = modelMapper.map(userDTO, User.class);
        User savedUser = userRepository.save(user);
        return modelMapper.map(savedUser, UserDTO.class);
    }

    @Override
    public UserDTO updateUser(Integer id, UserDTO userDTO) {
        Optional<User> userOptional = userRepository.findById(id);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.setUsername(userDTO.getUsername());
            user.setPassword(userDTO.getPassword());
            user.setEmail(userDTO.getEmail());
            User updatedUser = userRepository.save(user);
            return modelMapper.map(updatedUser, UserDTO.class);
        }
        return null;
    }

    @Override
    public void deleteUser(Integer id) {
        userRepository.deleteById(id);
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
