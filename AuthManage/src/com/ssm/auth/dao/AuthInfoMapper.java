package com.ssm.auth.dao;

import java.util.List;

import com.ssm.auth.vo.AuthInfo;
import com.ssm.auth.vo.UserAuth;

public interface AuthInfoMapper {

    public List<AuthInfo> fandAuthinfo ();
    
    public  List<AuthInfo> selectAuthByparentId(Integer authId);
    
    public Integer disabledAuth (Integer authId);
    
    public Integer startAuth(Integer authId);

	public Integer deleteAuth(Integer authId);

	public AuthInfo selectauthByUrl(String authUrl);

	public AuthInfo selectauthByName(String authName);

	public Integer insertAuth(AuthInfo auth);

	public void updateAuth(AuthInfo auth);

	public List<Integer> findUserAuth(Integer userId);

	public Integer insetUserAuth(UserAuth userAuth);

	public Integer deleteUserAuth(Integer userId);
    
}