<%@ page language="java" pageEncoding="gbk"%>
<%@ page contentType="application/msword" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<%-- 
Wordֻ��Ҫ��contentType="application/msexcel"��ΪcontentType="application/msword" 
--%>
<%   
  //������excel���   
 //response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");   
  
//Ƕ����ie���excel   
  
response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.doc");   
%>  
<html>  
<head>  
<title>���Ե���Excel��Word</title>  
</head>  
<body>  
<table width="500" border="1" align="center">  
  	<tr>  
    	<td colspan="7" align="center">�û��б�</td>  
  	</tr>  
  	<tr>
		<td>ID</td>
		<td>�û���</td>
		<td>�ǳ�</td>
		<td>����</td>
		<td>�û�����</td>
		<td>�û�״̬</td>
		<td>����ʱ��</td>
	</tr>
<c:forEach items="${users}" var="user">
	<tr>
		<td class="userid">${user.userId }</td>
		<td class="username">${user.userCode }</td>
		<td class="nickName">${user.nickName }</td>
		<td class="roleDesc">${user.userGroup.groupName }</td>
		<td class="roleName">${user.role.roleName}</td>
		<td class="userState">${user.userState eq 0?'����':'����'}</td>
		<td class="createTime"><fmt:formatDate
				value="${user.createTime}" type="date"
				pattern="yyyy-MM-dd HH:mm" /></td>
	</tr>
</c:forEach>  
</table>  
</body>  
</html>  
