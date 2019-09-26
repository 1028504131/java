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

import com.ssm.auth.service.UserGroupService;
import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.Role;
import com.ssm.auth.vo.UserGroup;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/userGroup")
public class UserGroupController {
	
	@Autowired
	private UserGroupService userGroupService;
	
	@RequestMapping("/findAlluserGroup")
	@ResponseBody
	public JSONArray findAlluserGroup () {
		JSONArray jsonarray = new JSONArray();
		JSONObject json =new JSONObject();
		List<UserGroup> userGroups=userGroupService.findAlluserGroup();
		for (UserGroup userGroup : userGroups) {
			json.put("groupId", userGroup.getGroupId());
			json.put("groupName", userGroup.getGroupName());
			jsonarray.add(json);
		}
		return jsonarray;
	}
	@RequestMapping("/list.action")
	public void userGroupList (PageInfo pageInfo,HttpServletRequest request ,HttpServletResponse response) throws ServletException, IOException {
		List<UserGroup> ugp = userGroupService.findAlluserGroup();
		int totalNum=ugp.size();
		int pageSize=0;
		int pageNum=0;
		StringBuffer params = new StringBuffer();
		params.append("");
		String url="userGroup/list.action";
		
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
		List<?> resultList = userGroupService.selectUserGroup(pageInfo);
		pageInfo = new PageInfo(pageSize, totalNum, pageNum, resultList, url, params);
		System.out.println("*********************"+"&&&&&&&&&&&&&&&&&&&&&&&");
		request.setAttribute("page", pageInfo);
		request.getRequestDispatcher("../pages/role-list.jsp").forward(request, response);
	}
	

}
