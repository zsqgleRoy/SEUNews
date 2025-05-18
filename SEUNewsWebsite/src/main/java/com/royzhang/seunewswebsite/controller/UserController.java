package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.dto.user.UserBaseInfoDTO;
import com.royzhang.seunewswebsite.dto.user.UserDTO;
import com.royzhang.seunewswebsite.service.UserService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/user")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @GetMapping
    public ResponseEntity<List<UserDTO>> getAllUsers() {
        try {
            List<UserDTO> users = userService.getAllUsers();
            return new ResponseEntity<>(users, HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Error getting all users: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> getUserById(@PathVariable Integer id) {
        try {
            UserDTO user = userService.getUserById(id);
            if (user != null) {
                return new ResponseEntity<>(user, HttpStatus.OK);
            }
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            logger.error("Error getting user by ID: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping
    public ResponseEntity<UserDTO> createUser(@Valid @RequestBody UserDTO userDTO) {
        UserDTO createdUser = userService.createUser(userDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdUser);
    }

    @PutMapping("/{id}")
    public ResponseEntity<UserDTO> updateUser(@PathVariable Integer id, @Valid @RequestBody UserDTO userDTO) {
        try {
            UserDTO updatedUser = userService.updateUser(id, userDTO);
            if (updatedUser != null) {
                return new ResponseEntity<>(updatedUser, HttpStatus.OK);
            }
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            logger.error("Error updating user: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Integer id) {
        try {
            userService.deleteUser(id);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Error deleting user: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/username/{username}")
    public ResponseEntity<UserBaseInfoDTO> findUserByUsername(@PathVariable String username) {
        try {
            Optional<UserBaseInfoDTO> userOptional = userService.findUserByUsername(username);
            return userOptional.map(userDTO -> new ResponseEntity<>(userDTO, HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
        } catch (Exception e) {
            logger.error("Error finding user by username: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/setusername/{username}")
    public ResponseEntity<Boolean> findUserExistByUsername(@PathVariable String username) {
        try {
            Optional<UserBaseInfoDTO> userBaseInfoDTOOptional = userService.findUserByUsername(username);
            if (userBaseInfoDTOOptional.isPresent()) {
                return new ResponseEntity<>(true, HttpStatus.OK);
            }
            else {
                return new ResponseEntity<>(false, HttpStatus.OK);
            }
        } catch (Exception e) {
            logger.error("Error finding user by username: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 修改控制器方法
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody UserDTO userDTO) {
        try {
            Optional<UserBaseInfoDTO> userBaseInfoDTO = userService.findUserByUsernameAndPassword(userDTO.getUsername(), userDTO.getPassword());
            if (userBaseInfoDTO.isPresent()) {
                UserBaseInfoDTO userDto = userBaseInfoDTO.get();
                return new ResponseEntity<>(userDto, HttpStatus.OK);
            } else {
                return new ResponseEntity<>("密码错误", HttpStatus.UNAUTHORIZED);
            }
        } catch (Exception e) {
            logger.error("Error during login: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody UserDTO userDTO) {
        Optional<UserBaseInfoDTO> userBaseInfoDTOOptional = userService.findUserByUsername(userDTO.getUsername());
        if (userBaseInfoDTOOptional.isPresent()) {
            return new ResponseEntity<>("用户名已存在", HttpStatus.CONFLICT);
        }
        try {
            if (userService.saveUser(userDTO)) {
                UserBaseInfoDTO userBaseInfoDTO = new UserBaseInfoDTO(userDTO);
                return new ResponseEntity<>(userBaseInfoDTO, HttpStatus.CREATED);
            } else {
                return new ResponseEntity<>("用户注册失败，请稍后重试", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            logger.error("用户注册失败: 发生异常, 用户名: {}", userDTO.getUsername(), e);
            return new ResponseEntity<>("用户注册失败，请稍后重试", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/userInfo/{id}")
    public ResponseEntity<UserDTO> getUserFrontById(@PathVariable Integer id) {
        try {
            UserDTO user = userService.getUserById(id);
            if (user != null) {
                return new ResponseEntity<>(user, HttpStatus.OK);
            }
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            logger.error("Error getting user by ID: {}", e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}

