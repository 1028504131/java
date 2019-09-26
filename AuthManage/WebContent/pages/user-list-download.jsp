<%@ page language="java" pageEncoding="gbk"%>
<%@ page contentType="application/msword" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<%-- 
Word只需要把contentType="application/msexcel"改为contentType="application/msword" 
--%>
<%   
  //独立打开excel软件   
 //response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");   
  
//嵌套在ie里打开excel   
  
response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.doc");   
%>  
<html>  
<head>  
<title>测试导出Excel和Word</title>  
</head>  
<body>  
<table width="500" border="1" align="center">  
  	<tr>  
    	<td colspan="7" align="center">用户列表</td>  
  	</tr>  
  	<tr>
		<td>ID</td>
		<td>用户名</td>
		<td>昵称</td>
		<td>部门</td>
		<td>用户类型</td>
		<td>用户状态</td>
		<td>创建时间</td>
	</tr>
<c:forEach items="${users}" var="user">
	<tr>
		<td class="userid">${user.userId }</td>
		<td class="username">${user.userCode }</td>
		<td class="nickName">${user.nickName }</td>
		<td class="roleDesc">${user.userGroup.groupName }</td>
		<td class="roleName">${user.role.roleName}</td>
		<td class="userState">${user.userState eq 0?'禁用':'启用'}</td>
		<td class="createTime"><fmt:formatDate
				value="${user.createTime}" type="date"
				pattern="yyyy-MM-dd HH:mm" /></td>
	</tr>
</c:forEach>  
</table>  
</body>  
</html>  
