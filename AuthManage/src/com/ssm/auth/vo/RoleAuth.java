package com.ssm.auth.vo;

public class RoleAuth {
    private Integer roleAuthId;

    private Integer roleId;

    private Integer authId;

    public Integer getRoleAuthId() {
        return roleAuthId;
    }

    public void setRoleAuthId(Integer roleAuthId) {
        this.roleAuthId = roleAuthId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getAuthId() {
        return authId;
    }

    public void setAuthId(Integer authId) {
        this.authId = authId;
    }

	@Override
	public String toString() {
		return "RoleAuth [roleAuthId=" + roleAuthId + ", roleId=" + roleId + ", authId=" + authId + "]";
	}
}