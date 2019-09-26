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

import com.ssm.auth.service.AuthService;
import com.ssm.auth.vo.AuthInfo;
import com.ssm.auth.vo.UserInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/auth")
public class AuthController {
	
	@Autowired
	private AuthService authService;
	
	
	@RequestMapping("/list.action")
	public void selectauthList (HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		JSONArray  jsonArray = new JSONArray();
		JSONObject jion = new JSONObject();
		List<AuthInfo> auths= authService.fandAuthinfo();
		for (AuthInfo auth : auths) {
			jion.put("id", auth.getAuthId());
			jion.put("pId", auth.getParentId());
			jion.put("name", auth.getAuthName());
			jion.put("desc", auth.getAuthDesc());
			jion.put("state", auth.getAuthState());
			jion.put("grade", auth.getAuthGrade());
			jsonArray.add(jion);
		}
		request.setAttribute("jsonArray", jsonArray);
		request.getRequestDispatcher("../pages/authTree.jsp").forward(request, response);
	}
	
	@RequestMapping("/reinAuth.action")
	@ResponseBody
	public void reinAuth(Integer authId) {
		authService.startAuth(authId);
	}
	
	@RequestMapping("/disabledAuth.action")
	@ResponseBody
	public void disabledAuth(Integer authId) {
		authService.disabledAuth(authId);
	}
	
	@RequestMapping("/deleteAuth.action")
	@ResponseBody
	public void deleteAuth(Integer authId) {
		authService.deleteAuth( authId);
	}
	
	@RequestMapping("/selectauthByUrl.action")
	@ResponseBody
	public JSONObject selectauthByUrl(String authUrl) {
		
		JSONObject json = new JSONObject();
		AuthInfo auth=authService.selectauthByUrl(authUrl);
		if(null != auth) {
			json.put("msg", 1);
		}
		return json;
		
	}
	
	@RequestMapping("/selectauthByName.action")
	@ResponseBody
	public JSONObject selectauthByName(String authName) {
		JSONObject json = new JSONObject();
		AuthInfo auth=authService.selectauthByName(authName);
		if(null!=auth) {
			json.put("msg", 1);
		}
		return json;
	}
	@RequestMapping("/insertAuth.action")
	public void insertAuth (HttpServletRequest request,HttpServletResponse response,AuthInfo auth) throws IOException {
		System.out.println("tianjia"+auth);
		UserInfo user=(UserInfo)request.getSession().getAttribute("USER");
		auth.setCreateBy(user.getUserId());
		System.out.println("tianjia"+auth);
		Integer addnum =authService.insertAuth(auth);
		if(addnum==1) {
			response.sendRedirect(request.getContextPath()+"/auth/list.action");
		}else {
			response.getWriter().println("<script>alert('添加失败,请重试!');location.href='"+request.getContextPath()+"/auth/list.action'</script>");
		}
		
	} 
	
	@RequestMapping("updateAuth.action")
	@ResponseBody
	public void updateAuth(AuthInfo auth) {
		authService.updateAuth(auth);
	}
	
	@RequestMapping("/userAuth.action")
	public void selecUserAuth (Integer userId ,HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		JSONArray  jsonArray = new JSONArray();
		JSONObject json = new JSONObject();
		List<AuthInfo> auths= authService.fandAuthinfo();
		List<Integer> authIds = authService.findUserAuth(userId);
		for (AuthInfo auth : auths) {
			boolean falg=false;
			json.put("id", auth.getAuthId());
			json.put("pId", auth.getParentId());
			json.put("name", auth.getAuthName());
			json.put("desc", auth.getAuthDesc());
			json.put("state", auth.getAuthState());
			json.put("grade", auth.getAuthGrade());
			for (Integer authId : authIds) {
				if(authId ==auth.getAuthId() ) {
					falg = true;
				}
			}
			json.put("checked", falg);
			jsonArray.add(json);
		}
		request.setAttribute("jsonArray", jsonArray);
		request.setAttribute("userId", userId);
		request.getRequestDispatcher("../pages/user-authTree.jsp").forward(request, response);
	}
	
	@RequestMapping("/updataUserAuth.action")
	public void updateUserAuth (String strUserAuthIds , Integer userId,HttpServletRequest request ,HttpServletResponse response ) throws IOException {
		authService.updateUserAuth(strUserAuthIds, userId);
		response.sendRedirect(request.getContextPath()+"/user/list.action");
	}
	
}
