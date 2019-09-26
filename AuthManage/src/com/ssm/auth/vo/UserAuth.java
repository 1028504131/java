package com.ssm.auth.vo;

public class UserAuth {
    private Integer userAuthId;

    private Integer userId;

    private Integer authId;

    public Integer getUserAuthId() {
        return userAuthId;
    }

    public void setUserAuthId(Integer userAuthId) {
        this.userAuthId = userAuthId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAuthId() {
        return authId;
    }

    public void setAuthId(Integer authId) {
        this.authId = authId;
    }

	@Override
	public String toString() {
		return "UserAuth [userAuthId=" + userAuthId + ", userId=" + userId + ", authId=" + authId + "]";
	}
}