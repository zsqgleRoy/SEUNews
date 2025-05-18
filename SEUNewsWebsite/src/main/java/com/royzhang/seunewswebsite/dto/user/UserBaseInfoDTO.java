package com.royzhang.seunewswebsite.dto.user;

import java.util.Date;

import com.royzhang.seunewswebsite.entity.User;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserBaseInfoDTO {
    private int user_id;
    private String username;
    private String email;
    private Date registerDate;
    private String avatar;
    private User.IsAuthor isAuthor;

    public UserBaseInfoDTO() {}
    public UserBaseInfoDTO(UserDTO user) {
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.registerDate = user.getRegisterDate();
    }
}
