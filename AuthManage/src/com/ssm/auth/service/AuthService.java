package com.ssm.auth.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.auth.vo.AuthInfo;

public interface AuthService {
	
	public List<AuthInfo> fandAuthinfo ();
	
	public Integer disabledAuth (Integer authId);
    
    public Integer startAuth(Integer authId);

    public List<AuthInfo> selectAuthByparentId(Integer authId);

	public int deleteAuth(Integer authId);

	public AuthInfo selectauthByUrl(String authUrl);

	public AuthInfo selectauthByName(String authName);

	public Integer insertAuth(AuthInfo auth);

	public void updateAuth(AuthInfo auth);

	public List<Integer> findUserAuth(Integer userId);
	
	@Transactional(propagation=Propagation.REQUIRED)
	public void updateUserAuth(String strUserAuthid, Integer userId);
	
}
