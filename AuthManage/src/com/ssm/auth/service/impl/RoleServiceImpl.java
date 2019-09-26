package com.ssm.auth.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.auth.dao.RoleMapper;
import com.ssm.auth.service.RoleService;
import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.Role;
import com.ssm.auth.vo.UserRole;

@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	private RoleMapper roleMapper ;
	
	@Override
	public List<Role> selectAllRole() {
		
		return roleMapper.selectAllRole();
	}

	

	@Override
	public List<Role> FandAllRole(PageInfo pageInfo) {
		return roleMapper.FandAllRole(pageInfo);
	}



	@Override
	public List<Integer> seleRoleIdByuserId(Integer userId) {
		return roleMapper.seleRoleIdByuserId(userId);
	}



	@Override
	public void updateUserRole(String roleIds, Integer userId) {
		UserRole userRole= new UserRole();
		userRole.setUserId(userId);
		roleMapper.deleteUserRole(userId);
		String [] strids=roleIds.split(",");
		for (String strid : strids) {
			Integer roleId = Integer.parseInt(strid);
			userRole.setRoleId(roleId);
			roleMapper.insertUseRole(userRole);
		}
	}

}
