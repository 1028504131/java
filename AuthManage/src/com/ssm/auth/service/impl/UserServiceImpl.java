package com.ssm.auth.service.impl;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.auth.dao.UserInfoMapper;
import com.ssm.auth.service.UserService;
import com.ssm.auth.vo.AuthInfo;
import com.ssm.auth.vo.UserInfo;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserInfoMapper userInfoMapper;
	
	@Override
	public UserInfo fandUser(UserInfo user) {
		return   userInfoMapper.fandUser(user);
	}

	@Override
	public List<AuthInfo> findUserAuth(Map<String, Object> map) {
		return userInfoMapper.findUserAuth(map);
	}

	@Override
	public List<UserInfo> findAllUser() {		
		return userInfoMapper.fandAllUser();
	}

	@Override
	public List<UserInfo> selectUserAndrole(Map<String, Object> map) {
		return userInfoMapper.selectUserAndrole( map);
	}

	@Override
	public Integer deleteUserById(Integer UserId) {
	
		return userInfoMapper.deleteUserById(UserId);
	}

	@Override
	public Integer disabledUserById(Integer userId) {
		return userInfoMapper.disabledUserById(userId);
	}

	@Override
	public Integer startUserById(Integer userId) {
		return userInfoMapper.startUserById(userId);
	}

	@Override
	public Integer insertUser(UserInfo user) {
		return insertUser(user);	
	}

	@Override
	public Integer insertuser(UserInfo userInfo) {
		
		return userInfoMapper.insertUser(userInfo);
	}

	@Override
	public Integer UpdateUserData(UserInfo user) {
		return userInfoMapper.UpdateUserData(user);
	}

	@Override
	public List<UserInfo> FandUserAndrole(UserInfo user) {
		return userInfoMapper.FandUserAndrole(user);
	}

	@Override
	public UserInfo SelectUserByName(String userCode) {
		
		return userInfoMapper.SelectUserByName(userCode);
	}

	@Override
	public Integer ResetUserPwd(Integer userId) {
		return userInfoMapper.ResetUserPwd(userId);
	}
	
}
