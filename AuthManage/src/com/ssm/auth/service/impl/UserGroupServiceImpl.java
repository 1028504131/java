package com.ssm.auth.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.auth.dao.UserGroupMapper;
import com.ssm.auth.service.UserGroupService;
import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.UserGroup;
@Service
public class UserGroupServiceImpl implements UserGroupService {
	
	@Autowired
	private UserGroupMapper userGroupMapper;
	
	@Override
	public List<UserGroup> findAlluserGroup() {
		return userGroupMapper.findAlluserGroup();
	}

	

	@Override
	public List<UserGroup> selectUserGroup(PageInfo pageInfo) {
		return userGroupMapper.selectUserGroup(pageInfo);
	}

}
