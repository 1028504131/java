<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>用户管理 - 用户列表</title>
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/static/css/layout.css"
	rel="stylesheet">
<style>
.float {
	float: right;
	width: 110px;
	margin: 0px 5px;
}
</style>

</head>
<body>
	<!-- 头部 -->
	<jsp:include page="header.jsp" />
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<jsp:include page="navibar.jsp" />
			</div>
		</div>
		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<h1 class="page-header">用户列表</h1>
			<div class="row placeholders">
			<form method="post" class="selectUserlist"
			action="${pageContext.request.contextPath}/${page.url}">
				<div>
					<a href="${pageContext.request.contextPath}/user/download.action?${page.params}">
					<button type="button" class="btn btn-warning ">导出数据</button></a>
					<button type="button" class="btn btn-primary show-user-form"
						data-toggle="modal" data-target="#add-user-form">添加新用户</button>
					<button type="button" class="btn btn-primary float selectuser" >确定查询</button>
					
					<div class="float ">
						<select class="form-control" name="userState" id="UserState">
							<option style="display: none;" value="">用户状态</option>
							<option value="1">启用</option>
							<option value="0">禁用</option>
							<option value="">全部</option>
						</select>
					</div>
					<div class="float" id="userType">
						<select class="form-control" name="userType" id="select_userType">
						</select>
					</div>
					<div class=" float">
						<input type="text" name="userCode" class="form-control"
							placeholder="用户名" value="${param.userCode}">
					</div>
				</div>
			</form>
				<div class="space-div"></div>
				<table class="table table-hover table-bordered user-list">
					<tr>
						<td><input type="checkbox" class="select-all-btn" /></td>
						<td>ID</td>
						<td>用户名</td>
						<td>昵称</td>
						<td>部门</td>
						<td>用户类型</td>
						<td>用户状态</td>
						<td>创建时间</td>
						<td>操作</td>
					</tr>

					<c:forEach items="${page.resultList}" var="user">
						<tr>
							<td><input type="checkbox" name="userIds"
								value="${user.userId }" /></td>
							<td class="userid">${user.userId }</td>
							<td class="username">${user.userCode }</td>
							<td class="nickName">${user.nickName }</td>
							<td class="groupName">${user.userGroup.groupName }</td>
							<td class="roleName">${user.role.roleName}</td>
							<td class="userState">${user.userState eq 0?'禁用':'启用'}</td>
							<td class="createTime"><fmt:formatDate
									value="${user.createTime}" type="date"
									pattern="yyyy-MM-dd HH:mm" /></td>
							<td class="operation">
							<c:if test="${user.userCode != USER.userCode or  user.userCode eq'admin' }">
								<a class="glyphicon glyphicon-wrench update-userdata-dialog"
								aria-hidden="true" title="修改所有用户"
								data-toggle="modal" data-target="#update-userdata-dialog" ></a>
								<a class="glyphicon glyphicon-remove delete-this-user"
								aria-hidden="true" title="删除用户"></a>
								<button type="button" class="btn btn-warning changeState">${user.userState eq 0?'启用':'禁用'}</button>
								<c:if test="${user.userState eq 1}">
									<button type="button" class="btn btn-primary ResetUserPwd">重置密码</button>
									<button type="button" class="btn btn-primary update-userrole-dialog"
										data-toggle="modal" data-target="#update-userrole-dialog">分配角色</button>
									<a href="${pageContext.request.contextPath}/auth/userAuth.action?userId=${user.userId}">
										<button type="button" class="btn btn-primary" id="updateAuth" >更改权限</button>
									</a>
								</c:if>
							</c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
				<jsp:include page="standard.jsp" />
			</div>
		</div>
	</div>
	

	<!--修改用户角色表单-->
	<div class="modal fade " id="update-userrole-dialog" tabindex="-1"
		role="dialog" aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">分配角色</h4>
				</div>
				<div class="modal-body">
					<form class="update-userrole-form" method="post"
					action="${pageContext.request.contextPath}/role/updateUserRole.action">
						<div class="form-group">
							<input type="hidden" name="userId" >
							<label for="userName">用户名</label> <input type="text"
								name="userName" class="form-control" disabled="disabled">
						</div>
						角色:
						<div class="form-group role"></div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button"
						class="btn btn-primary update-userrole-submit">提交</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade " id="update-userdata-dialog" tabindex="-1"
		role="dialog" aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改信息</h4>
				</div>
				<div class="modal-body">
					<form class="update-userdata-form" method="post" 
					action="${pageContext.request.contextPath}/user/updateUserdata.action">
						<input type="hidden" name ="userId"  id="updateUserId" >
						<div class="form-group">
							<label for="userName">用户名</label> <input type="text"
								name="userCode" class="form-control" disabled="disabled"
								id="updateUserName">
						</div>
						<div class="form-group">
							<label for="nickName">昵称</label> <input type="text"
								name="nickName" class="form-control" id="updateNickName">
						</div>
						<div class="form-group" id="update-Group">
							<label for="group">部门</label> 
							<select class="form-control UpdateuserGroup" name="groupId" id="userGroupInput">
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button"
						class="btn btn-primary update-userdata-submit">提交</button>
				</div>
			</div>
		</div>
	</div>
	

	<div class="modal fade " id="add-user-form" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加新用户</h4>
				</div>
				<div class="modal-body">
					<form class="user-form" method="post"
					action="${pageContext.request.contextPath}/user/insert.action" >
						<div class="form-group">
							<label for="userName">用户名</label> <input type="text"
								name="userCode" class="form-control" id="userNameInput"
								placeholder="用户名">
								<label id="userNameError"></label>
						</div>
						<div class="form-group">
							<label for="nickName">昵称</label> <input type="text"
								name="nickName" class="form-control" id="nickNameInput"
								placeholder="昵称">
						</div>
						<div class="form-group" id="userGroup">
							<label for="group">部门</label> 
							<select class="form-control" name="groupId">
								<option style="display: none;">选择部门</option>
							</select>
						</div>

						<div class="form-group">
							<label for="passwordInput1">密码</label> <input type="password"
								name="userPwd" class="form-control" id="passwordInput1"
								placeholder="密码">
							<label id="passwordError"></label>
						</div>
						<div class="form-group">
							<label for="passwordInput2">确认密码</label> <input type="password"
								 class="form-control" id="passwordInput2"
								placeholder="确认密码">
							<label id="confirmPasswordError"></label>	
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary add-user-submit">添加
					</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

	<script>
		
			
		$(document).ready(function(){
			/* 加载角色 */
			$.ajax({
				url : "${pageContext.request.contextPath}/role/getAllRoles.action",
				type : "POST",
				dataType : "json",
				success : function(data) {
					$("#userType select").append("<option style='display: none;'value='' >用户类型</option>");
					 for(var i in data) {
						 
						 $("#userType select").append("<option value='"+data[i].roleId+"'>"+data[i].roleName+"</option>");
						 if(data[i].roleId=="${param.userType}"){
							 $("#userType select").find('option[value="'+data[i].roleId+'"]').prop("selected",true);
						 }
					} 
					$("#userType select").append("<option  value=''>全部</option>");
				}
			});
			
			/* 加载部门 */
			$.ajax({
				url : "${pageContext.request.contextPath}/userGroup/findAlluserGroup.action",
				type : "POST",
				dataType : "json",
				success : function(data) {
					 for(var i in data) {
						 $("#userGroup select").append("<option value='"+data[i].groupId+"'>"+data[i].groupName+"</option>");
						 $("#update-Group select").append("<option name='"+data[i].groupName+"' value='"+data[i].groupId+"'>"+data[i].groupName+"</option>");
					 } 
				}
			});
			console.log("2");
		});
		
		
		
		
		$(function() {
			console.log("1");
			$(".userState:contains('禁用')").css("color", "red");
			$(".userState:contains('启用')").css("color", "green");
			$("#UserState").val("${param.userState}");
			$("#select_userType").val("${param.userType}");
		});
		
		$(".user-list").on("click",".update-userdata-dialog",function(){
			var userid = $(this).parents("tr").find(".userid").html();
			var username = $(this).parents("tr").find(".username").html(); 
			var nickName = $(this).parents("tr").find(".nickName").html(); 
			var groupName = $(this).parents("tr").find(".groupName").html(); 
			$("#updateUserId").val(userid);
			$("#updateUserName").val(username);
			$("#updateNickName").val(nickName); 
			$(".UpdateuserGroup").find("option[name='"+groupName+"']").attr("selected",true); 
		});
		
		$(".user-list").on("click",".update-userrole-dialog",function(){
			var userid =$(this).parents("tr").find(".userid").text();
			var username = $(this).parents("tr").find(".username").html(); 
			$(".update-userrole-form").find("input[name='userName']").val(username);
			$(".update-userrole-form").find("input[name='userId']").val(userid);
			var obj=$(".update-userrole-form").find(".role");
			obj.html("");
			$.ajax({
				url : "${pageContext.request.contextPath}/role/FandAllRole.action",
				type : "POST",
				data :{userId:userid},
				dataType : "json",
				success : function(data) {
					for ( var i in data) {
						obj.append("<input type='checkbox' name='roleIds' value='"+data[i].roleId+"'/>"+ 
						data[i].roleName+"&nbsp;&nbsp;&nbsp;&nbsp;");
						obj.find('input[name=roleIds][value="'+data[i].roleId+'"]').prop("checked",data[i].checked);
					}
				}
			});
		});
		$(".ResetUserPwd").click(function(){
			var userid =$(this).parents("tr").find(".userid").text();
			var username=$(this).parents("tr").find(".username").html(); 
			if(confirm('确认重置用户名为"' + username + '"的用户密码？')){
				location.href="${pageContext.request.contextPath}/user/ResetUserPwd.action?userId="+userid;
			}
		})
		
		$(".update-userrole-submit").click(function(){
			$(".update-userrole-form").submit();
		});
		
		$(".update-userdata-submit").click(function (){
			$(".update-userdata-form").submit();
		});
		
		var userNameFlag = true;
		var passwordFlag = true;
		
		$("#userNameInput").blur(function(){
			
			var userName = $(this).val();
			console.log(userName)
			if(!/^[\u4e00-\u9fa5_a-zA-Z0-9]{4,16}$/.test(userName)){
				$("#userNameError").css("color","red").text("用户名不合法! 4-16位，汉字，字母，数字，下划线");
				userNameFlag = false;
			}else{
				$.ajax({
					url:"${pageContext.request.contextPath}/user/SelectUserByName.action",
					data:{
						userCode: userName
					},
					type:"POST",
					dataType:"json",
					success:function(data){
						if(data.i ==1){
							userNameFlag = false;
							$("#userNameError").css("color","red").text("该用户名已经被占用");
						}else{
							userNameFlag = true;
							$("#userNameError").text("");
						}
					},
					error:function(data){
						userNameFlag = false;
						console.log("出现错误！！！")
					}
				});
			}
		});
		// 添加新用户 密码规则验证
		$("#passwordInput1").blur(function(){
			var psw = $(this).val();
			var confirmPsw = $("#passwordInput12").val();
			if(!/^.{6,16}$/.test(psw)){
				passwordFlag = false;
				$("#passwordError").css("color","red").text("密码长度不符合要求，应该在6-16位");
			}else if(confirmPsw != "" && psw != confirmPsw){
				passwordFlag = false;
			}else if(confirmPsw != "" && psw == confirmPsw){
				passwordFlag = true;
				$("#confirmPasswordError").text("");
			}else{
				passwordFlag = true;
				$("#passwordError").text("");
			}
		});
		// 添加新用户 确认密码规则验证
		$("#passwordInput2").blur(function(){
			var confirmPsw = $(this).val();
			var psw = $("#passwordInput1").val();
			if(psw !="" && confirmPsw != psw){
				passwordFlag = false;
				$("#confirmPasswordError").addClass("red").text("两次密码不一致");
			}else{
				passwordFlag = true;
				$("#confirmPasswordError").text("");
			}
		});
		// 点击添加，添加新用户之前一些基本规则验证
		
		$(".add-user-submit").click(function() {
			var userCode = $("#userNameInput").val().trim();
			var nickName = $("#nickNameInput").val().trim();
			var groupId = $("#userGroupInput").val();
			var userPwd = $("#passwordInput1").val();
			if(userCode!="" && nickName!="" && userPwd!="" && userNameFlag && passwordFlag){
				$(".user-form").submit();
			}else{
				showTips("请正确填写信息!!!");
			}
		});

		$(".selectuser").click(function (){
			console.log("qwewqewqeqweqwe");
			$(".selectUserlist").submit();
		});
	
		
		
		$(".changeState").click(function() {
			var userId = $(this).parents("tr").find(".userid").html();
			var state =$(this).html();
			console.log(userId+"%%%%%%%%%%%"+state);
			location.href="${pageContext.request.contextPath}/user/updateUserState.action?userId="+userId+"&state="+state;
		});
		
		/* $(".changeState").click(function() {
			var userid = $(this).parents("tr").find(".userid").html();
			if ($(this).text() == "禁用") {
				$.ajax({
					type : "POST",
					url : "${pageContext.request.contextPath}/user/disabled.action",
					dataType : "json",
					data : {
						userId : userid
					},
					success : function(data) {
						if (data.did != 0) {
							location.reload();
						} else {
							showTips("禁用失败！");
						}
					},
					error : function() {
						showTips("服务器错误?！");
					}
				});
			} else if ($(this).text() == "启用") {
				$.ajax({
					type : "POST",
					url : "${pageContext.request.contextPath}/user/start.action",
					dataType : "json",
					data : {
						userId : userid
					},
					success : function(data) {
						if (data.did != 0) {
							location.reload();
						} else {
							showTips("启用失败！");
						}
					},
					error : function() {
						showTips("服务器错误?！");
					}
				});
			}

		}); */

		$(".user-list").on("click",".delete-this-user",function() {
			var userTr = $(this).parents("tr");
			var userid = userTr.find(".userid").html();
			if (confirm('确认删除ID为"' + userid + '"的用户吗？')) {
				$.ajax({
					type : "POST",
					url : "${pageContext.request.contextPath}/user/delete.action",
					dataType : "json",
					data : {
						userId : userid
					},
					success : function(data) {
						if (data.del != 0) {
							userTr.remove();
							showTips("删除成功！");
						} else {
							showTips("删除失败！");
						}
					},
					error : function() {
						showTips("服务器错误?！");
					}
				});
			}
		});
	</script>
<body>
</html>
