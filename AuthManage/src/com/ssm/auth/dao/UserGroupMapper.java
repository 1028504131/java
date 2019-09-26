package com.ssm.auth.dao;

import java.util.List;

import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.UserGroup;

public interface UserGroupMapper {

	public List <UserGroup> findAlluserGroup();

	public List<UserGroup> selectUserGroup(PageInfo pageInfo);

  
}