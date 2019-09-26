
package com.ssm.auth.AuthFilter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class CodoFilter
 */
@WebFilter("*.action")
public class CodeFilter implements Filter {

    /**
     * Default constructor. 
     */
    public CodeFilter() {}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest req, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		req.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		System.out.println("***********CodeFilter**************");
		HttpServletRequest request = (HttpServletRequest)req;
		HttpSession session = request.getSession();
		Object user = session.getAttribute("USER");
		// 白名单
		// /user/verifyCode.action
		// /user/login.action
		// /user/logout.action
		// /user/list.action
		// 获取请求路径
		String url = request.getServletPath();
		System.out.println("请求路径:" + url);
		if(url.endsWith(".action")
				&& !url.endsWith("/user/validCode.action")
				&& !url.endsWith("/user/login.action")
				&& !url.endsWith("/user/logout.action")) {
			if(null == user) {
				response.getWriter().println("<script>alert('未登录');location.href='"+request.getContextPath()+"/pages/login.jsp';</script>");
				return;
			}
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
