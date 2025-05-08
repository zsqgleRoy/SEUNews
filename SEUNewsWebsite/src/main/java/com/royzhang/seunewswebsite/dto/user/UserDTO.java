package com.royzhang.seunewswebsite.dto.user;

import com.royzhang.seunewswebsite.entity.User.IsAuthor;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Setter
@Getter
public class UserDTO {
    private Integer user_id;
    private String username;
    private String password;
    private String email;
    private Date registerDate;
    private String avatar;
    private IsAuthor isAuthor;
    private String phone;
    private String name;
    private String birthday;

    // 构造函数、Getter 和 Setter

}