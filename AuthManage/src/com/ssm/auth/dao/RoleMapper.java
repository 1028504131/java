package com.ssm.auth.dao;

import java.util.List;

import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.Role;
import com.ssm.auth.vo.UserRole;

public interface RoleMapper {

	public List<Role> selectAllRole ();
	
	public List<Role> FandAllRole (PageInfo  pageInfo);
	
	public List<Integer> seleRoleIdByuserId (Integer userId);

	public void deleteUserRole(Integer userId);

	public void insertUseRole(UserRole userRole);

}