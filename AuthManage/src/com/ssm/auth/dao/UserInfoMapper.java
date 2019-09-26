package com.ssm.auth.dao;


import java.util.List;
import java.util.Map;

import com.ssm.auth.vo.AuthInfo;
import com.ssm.auth.vo.UserInfo;

public interface UserInfoMapper {

	public  UserInfo fandUser (UserInfo user);
    
	public List<AuthInfo> findUserAuth (Map<String, Object> map);
	
	public List<UserInfo> fandAllUser ();
    
	public List<UserInfo> selectUserAndrole (Map<String,Object> map);
	
	public List<UserInfo> FandUserAndrole(UserInfo user);
	
	public Integer deleteUserById (Integer UserId);
	
	public Integer disabledUserById (Integer userId);
	
	public Integer startUserById (Integer userId);
	
	public Integer insertUser(UserInfo user);

	public Integer UpdateUserData(UserInfo user);

	public UserInfo SelectUserByName(String userCode);

	public Integer ResetUserPwd(Integer userId);
	
}