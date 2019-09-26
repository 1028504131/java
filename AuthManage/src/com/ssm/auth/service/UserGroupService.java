package com.ssm.auth.service;

import java.util.List;

import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.UserGroup;

public interface UserGroupService {

	public List<UserGroup> findAlluserGroup();

	public List<UserGroup> selectUserGroup(PageInfo pageInfo);

}
