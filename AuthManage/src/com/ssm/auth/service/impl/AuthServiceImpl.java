package com.ssm.auth.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.auth.dao.AuthInfoMapper;
import com.ssm.auth.service.AuthService;
import com.ssm.auth.vo.AuthInfo;
import com.ssm.auth.vo.UserAuth;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private AuthInfoMapper authInfoMapper ;
	
	@Override
	public List<AuthInfo> fandAuthinfo() {
		
		return authInfoMapper.fandAuthinfo();
	}

	@Override
	public List<AuthInfo> selectAuthByparentId(Integer authId) {
		return authInfoMapper.selectAuthByparentId(authId);
	}

	@Override
	public Integer disabledAuth(Integer authId) {
		Integer disabledNum=0;
		authInfoMapper.disabledAuth(authId);
		List<AuthInfo> auths =selectAuthByparentId(authId);
		for (AuthInfo auth : auths) {
			disabledNum =disabledAuth(auth.getAuthId());
		}
		return disabledNum;
	}

	@Override
	public Integer startAuth(Integer authId) {
		Integer startNum=0;
		authInfoMapper.startAuth(authId);
		List<AuthInfo> auths =selectAuthByparentId(authId);
		for (AuthInfo auth : auths) {
			startNum =startAuth(auth.getAuthId());
		}
		return startNum;
	}

	@Override
	public int deleteAuth(Integer authId) {
		Integer deleteNum=0;
		deleteNum = authInfoMapper.deleteAuth(authId);
		List<AuthInfo> auths =selectAuthByparentId(authId);
		for (AuthInfo auth : auths) {
			deleteNum =deleteAuth(auth.getAuthId());
		}
		return deleteNum;
	}

	@Override
	public AuthInfo selectauthByUrl(String authUrl) {
		
		return authInfoMapper.selectauthByUrl(authUrl);
	}

	@Override
	public AuthInfo selectauthByName(String authName) {
		
		return authInfoMapper.selectauthByName(authName);
	}

	@Override
	public Integer insertAuth(AuthInfo auth) {
		
		return authInfoMapper.insertAuth(auth);
	}

	@Override
	public void updateAuth(AuthInfo auth) {
		authInfoMapper.updateAuth(auth);
		
	}

	@Override
	public List<Integer> findUserAuth(Integer userId) {
		
		return authInfoMapper.findUserAuth(userId);
	}


	@Override
	public void updateUserAuth(String strUserAuthid, Integer userId) {
		authInfoMapper.deleteUserAuth(userId);
		UserAuth userAuth= new UserAuth();
		String[] authids = strUserAuthid.split(",");
		for (String authid : authids) {
			Integer authId= Integer.parseInt(authid);
			userAuth.setUserId(userId);
			userAuth.setAuthId(authId);
			authInfoMapper.insetUserAuth(userAuth);
		}

	}
	
	
	
	

}
