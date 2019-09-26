package com.ssm.auth.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.auth.service.UserService;
import com.ssm.auth.vo.AuthInfo;
import com.ssm.auth.vo.PageInfo;
import com.ssm.auth.vo.UserInfo;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private	UserService userservice;
	
	
	@RequestMapping("/validCode.action")
	@ResponseBody
	public JSONObject checkAuthCode(HttpServletRequest request,String vCode) {
		System.out.println("*********checkAuthCode***********");
		HttpSession session=request.getSession();
		String authCode =(String)session.getAttribute("rand01");
		JSONObject json =new JSONObject();
		if(vCode.equals(authCode)) {
			json.put("msg", 1);
		}else {
			json.put("msg", 0);
		}
		return json;
	}

	@RequestMapping("/login.action")
	@ResponseBody
	public JSONObject login(UserInfo user,String vCode,HttpServletRequest request) {
		System.out.println("************login************");
		
		JSONObject json =new JSONObject();
		HttpSession session=request.getSession();
		String authCode =(String)session.getAttribute("rand01");
		UserInfo ui=userservice.fandUser(user);
		if(null == ui) {	
			json.put("res", 4);
		}else if(!authCode.equals(vCode)) {
			json.put("res", 0);
		}else if(ui.getIsDelete()!=0) {
			json.put("res", 2);
		}else if(ui.getUserState()!=1) {
			json.put("res", 3);
		}else {
			json.put("res", 1);
			session.setAttribute("USER", ui);
		}
		return json;
	}
	
	
	@RequestMapping("/index.action")
	public void  index (HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("***主页面数据!!!!!!!!!!!!!!");
		
		HttpSession session =request.getSession();
		UserInfo user =(UserInfo)session.getAttribute("USER");
		Map<String, Object> map= new HashMap<String, Object>();
		
		map.put("userId", user.getUserId());
		map.put("parentId", 0);
		map.put("groupId",user.getGroupId());
		
		List<AuthInfo> auths=userservice.findUserAuth(map);
		for (AuthInfo authInfo : auths) {
			map.put("parentId", authInfo.getAuthId());
			authInfo.setChildrenAuth(userservice.findUserAuth(map));
		}
		
		request.getSession().setAttribute("AUTH", auths);
		request.getRequestDispatcher("../pages/index.jsp").forward(request, response);
		
	}
	
	@RequestMapping("/list.action")
	public void userlist (PageInfo pageInfo,UserInfo user,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		int pageSize=5;
		int pageNum=1;
		StringBuffer params = new StringBuffer();
		if(null!=user.getUserCode()){
			params.append("&userCode=").append(user.getUserCode());
		}
		if(null!=user.getUserState()){
			params.append("&userState=").append(user.getUserState());
		}
		 if(null!=user.getUserType()){
			 params.append("&userType=").append(user.getUserType());
		}
		String url="user/list.action";
		if(null!=pageInfo.getPageSize()) {
			pageSize=pageInfo.getPageSize();
		}
		if(null!=pageInfo.getPageNum()) {
			pageNum=pageInfo.getPageNum();
		}
		pageInfo = new PageInfo(pageSize, pageNum);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", pageInfo);
		map.put("user", user);
		List <UserInfo>  users = userservice.FandUserAndrole(user);
		int totalNum=users.size();
		List<?> resultList = userservice.selectUserAndrole(map);
		pageInfo = new PageInfo(pageSize, totalNum, pageNum, resultList, url, params);
		request.setAttribute("page", pageInfo);
		request.getRequestDispatcher("../pages/user-list.jsp").forward(request, response);
	}
	
	
	@RequestMapping("/delete.action")
	@ResponseBody
	public JSONObject DeleteUserById (Integer userId) {
		
		JSONObject json = new JSONObject();
		Integer del = userservice.deleteUserById(userId);
		json.put(del, del);
		return json;
	}
	@RequestMapping("/updateUserState.action")
	public void updateUserState(Integer userId,String state,HttpServletRequest request,HttpServletResponse response) throws IOException {
		if(null == userId||null == state) {
			response.getWriter().println("<script>alert('错误操作');location.href='"+request.getContextPath()+"/user/list.action'</script>");
		}
		Integer num =0;
		if (state.equals("禁用")) {
			num = userservice.disabledUserById(userId);
		}else if(state.equals("启用")) {
			num = userservice.startUserById(userId);
		}
		if(num==1) {
			response.sendRedirect(request.getContextPath()+"/user/list.action");
		}else {
			response.getWriter().println("<script>alert('"+state+"失败');location.href='"+request.getContextPath()+"/user/list.action'</script>");
		}
	}
	
	@RequestMapping("/disabled.action")
	@ResponseBody
	public JSONObject disabledUserById (Integer userId) {
		
		JSONObject json = new JSONObject();
		Integer did = userservice.disabledUserById(userId);
		json.put(did, did);
		return json;
	}
	
	
	@RequestMapping("/start.action")
	@ResponseBody
	public JSONObject startUserById (Integer userId) {
		JSONObject json = new JSONObject();
		Integer sta = userservice.startUserById(userId);
		json.put(sta, sta);
		return json;
	}
	
	@RequestMapping("/logout.action")
	public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		session=request.getSession(true);
		response.sendRedirect("../pages/login.jsp");
	}
	
	@RequestMapping("/download.action")
	public void dataExport(UserInfo user, HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		List <UserInfo>  users = userservice.FandUserAndrole(user);
		request.setAttribute("users", users);
		request.getRequestDispatcher("../pages/user-list-download.jsp").forward(request, response);
	}	
	
	@RequestMapping("/insert.action")
	public void insertUser (UserInfo userInfo,HttpServletRequest request,HttpServletResponse response ) throws IOException {
		UserInfo user =(UserInfo) request.getSession().getAttribute("USER");
		userInfo.setCreateBy(user.getUserId());
		userservice.insertuser(userInfo);
		response.sendRedirect(request.getContextPath()+"/user/list.action");
	}
	@RequestMapping("/updateUserdata.action")
	public void UpdateUserData (UserInfo user,HttpServletRequest request,HttpServletResponse response) throws IOException   {
		System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
		System.out.println(user);
		Integer i=userservice.UpdateUserData(user);
		if(i==1) {
			response.sendRedirect(request.getContextPath()+"/user/list.action");
		}else {
			response.getWriter().println("<script>alert('添加失败');location.href='"+request.getContextPath()+"'/user/list.action'<script>");
		}
	}
	@RequestMapping("/SelectUserByName.action")
	@ResponseBody
	public JSONObject SelectUserByName(String userCode) {
		JSONObject json = new JSONObject();
		UserInfo user=userservice.SelectUserByName(userCode);
		if(null!=user) {
			json.put("i", 1);
		}
		return json;
	}
	@RequestMapping("/ResetUserPwd.action")
	public void ResetUserPwd(Integer userId,HttpServletResponse response,HttpServletRequest request) throws IOException {
		Integer reset = userservice.ResetUserPwd(userId);
		if (reset==1) {
			response.getWriter().println("<script>alert('重置成功,新密码为:123456');location.href='"+request.getContextPath()+"/user/list.action'</script>");
		}else {
			response.getWriter().println("<script>alert('重置失败!!');location.href='"+request.getContextPath()+"/user/list.action'</script>");
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
