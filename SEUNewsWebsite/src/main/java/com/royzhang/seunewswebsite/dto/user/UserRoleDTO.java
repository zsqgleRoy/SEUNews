package com.royzhang.seunewswebsite.dto.user;

public class UserRoleDTO {
    private Integer role_id;
    private String roleName;
    private String roleDescription;

    // 构造函数、Getter 和 Setter

    public Integer getRole_id() {
        return role_id;
    }

    public void setRole_id(Integer role_id) {
        this.role_id = role_id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDescription() {
        return roleDescription;
    }

    public void setRoleDescription(String roleDescription) {
        this.roleDescription = roleDescription;
    }
}
