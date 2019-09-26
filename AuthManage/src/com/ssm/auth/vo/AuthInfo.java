package com.ssm.auth.vo;

import java.util.Date;
import java.util.List;

public class AuthInfo {
    private Integer authId;

    private Integer parentId;

    private String authName;

    private String authDesc;

    private Integer authGrade;

    private Integer authType;

    private String authUrl;

    private String authCode;

    private Integer authOrder;

    private Integer authState;

    private Integer createBy;

    private Date createTime;

    private Integer updateBy;

    private Date updateTime;
    
    private List<AuthInfo> childrenAuth;

    public List<AuthInfo> getChildrenAuth() {
		return childrenAuth;
	}


	public void setChildrenAuth(List<AuthInfo> childrenAuth) {
		this.childrenAuth = childrenAuth;
	}


	public Integer getAuthId() {
        return authId;
    }
    

    public void setAuthId(Integer authId) {
        this.authId = authId;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getAuthName() {
        return authName;
    }

    public void setAuthName(String authName) {
        this.authName = authName == null ? null : authName.trim();
    }

    public String getAuthDesc() {
        return authDesc;
    }

    public void setAuthDesc(String authDesc) {
        this.authDesc = authDesc == null ? null : authDesc.trim();
    }

    public Integer getAuthGrade() {
        return authGrade;
    }

    public void setAuthGrade(Integer authGrade) {
        this.authGrade = authGrade;
    }

    public Integer getAuthType() {
        return authType;
    }

    public void setAuthType(Integer authType) {
        this.authType = authType;
    }

    public String getAuthUrl() {
        return authUrl;
    }

    public void setAuthUrl(String authUrl) {
        this.authUrl = authUrl == null ? null : authUrl.trim();
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode == null ? null : authCode.trim();
    }

    public Integer getAuthOrder() {
        return authOrder;
    }

    public void setAuthOrder(Integer authOrder) {
        this.authOrder = authOrder;
    }

    public Integer getAuthState() {
        return authState;
    }

    public void setAuthState(Integer authState) {
        this.authState = authState;
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }


	@Override
	public String toString() {
		return "AuthInfo [authId=" + authId + ", parentId=" + parentId + ", authName=" + authName + ", authDesc="
				+ authDesc + ", authGrade=" + authGrade + ", authType=" + authType + ", authUrl=" + authUrl
				+ ", authCode=" + authCode + ", authOrder=" + authOrder + ", authState=" + authState + ", createBy="
				+ createBy + ", createTime=" + createTime + ", updateBy=" + updateBy + ", updateTime=" + updateTime
				+ ", childrenAuth=" + childrenAuth + "]";
	}

	
    
    
}