package com.ssm.auth.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.Role;

public interface RoleService {
	
	public List<Role> selectAllRole ();
	
	public List<Role> FandAllRole (PageInfo pageInfo);
	
	public List<Integer> seleRoleIdByuserId (Integer userId);
	
	@Transactional(propagation=Propagation.REQUIRED)
	public void updateUserRole(String roleIds, Integer userId);

}
