package com.ssm.auth.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.auth.service.RoleService;
import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.Role;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/role")
public class Rolecontroller {
	
	@Autowired
	private RoleService roleService;
	@RequestMapping("/list.action")
	public void  fandallRole (HttpServletRequest request ,HttpServletResponse response ,PageInfo pageInfo) throws ServletException, IOException {
		
		List<Role> roles = roleService.selectAllRole();
		int totalNum=roles.size();
		int pageSize=0;
		int pageNum=0;
		StringBuffer params = new StringBuffer();
		params.append("");
		String url="role/list.action";
		
		if(null==pageInfo.getPageSize()) {
			pageSize=5;
		}else {
			pageSize=pageInfo.getPageSize();
		}
		if(null==pageInfo.getPageNum()) {
			pageNum=1;
		}else {
			pageNum=pageInfo.getPageNum();
		}
		pageInfo = new PageInfo(pageSize, pageNum);
		List<?> resultList = roleService.FandAllRole(pageInfo);
		pageInfo = new PageInfo(pageSize, totalNum, pageNum, resultList, url, params);
		System.out.println("*********************"+"&&&&&&&&&&&&&&&&&&&&&&&");
		request.setAttribute("page", pageInfo);
		request.getRequestDispatcher("../pages/role-list.jsp").forward(request, response);
		
	}
	
	@RequestMapping("/FandAllRole.action")
	@ResponseBody
	public JSONArray FandAllRole(Integer userId) {
		System.out.println("*********JSONArray*************");
		JSONArray jsonArray=new JSONArray();
		JSONObject json= new JSONObject();
		List<Integer> roleIds=roleService.seleRoleIdByuserId(userId) ;
		List<Role> roles=roleService.selectAllRole();
		System.out.println(roles);
		
		for (Role role : roles) {
			boolean falg=false;
			json.put("roleId", role.getRoleId());
			json.put("roleName", role.getRoleName());
			for (Integer roleId : roleIds) {
				if(roleId == role.getRoleId()) {
					falg= true;
				}
			}
			json.put("checked", falg);
			jsonArray.add(json);
		}
		return jsonArray;
		
	}
	
	
	@RequestMapping("/getAllRoles.action")
	@ResponseBody
	public JSONArray getAllRoles(){
		JSONArray jsonArray=new JSONArray();
		JSONObject json= new JSONObject();
		List<Role> roles=roleService.selectAllRole();
		System.out.println(roles);
		for (Role role : roles) {
			json.put("roleId", role.getRoleId());
			json.put("roleName", role.getRoleName());
			jsonArray.add(json);
		}
		return jsonArray;
	}
	@RequestMapping("/updateUserRole.action")
	public void updateUserRole(String roleIds,Integer userId,HttpServletRequest request ,HttpServletResponse response) throws IOException {
		if(null==roleIds||null==userId) {
			response.getWriter().println("<script>alert('请选择你分配的角色!');location.href='"+request.getContextPath()+"/user/list.action'</script>");
		}
		roleService.updateUserRole(roleIds,userId);
		response.sendRedirect(request.getContextPath()+"/user/list.action");
	}
	
	
}