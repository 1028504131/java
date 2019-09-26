package com.ssm.auth.vo;

public class UserRole {
    private Integer userRoleId;

    private Integer roleId;

    private Integer userId;

    public Integer getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(Integer userRoleId) {
        this.userRoleId = userRoleId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

	@Override
	public String toString() {
		return "UserRole [userRoleId=" + userRoleId + ", roleId=" + roleId + ", userId=" + userId + "]";
	}
}