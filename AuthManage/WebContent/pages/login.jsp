<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>登录页面</title>
    <!-- Bootstrap core CSS -->
    
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/login.css" rel="stylesheet">
   <style type="text/css">
   	.red{color:red}
   </style>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.cookie.js"></script>
   
   <script type="text/javascript">	
	 
	$(document).ready(function(){
		$("#inputEmail").blur(function (){	
			var userName=$("#inputEmail").val();//获取用户名
			if(!/^[\u4e00-\u9fa5_a-zA-Z0-9]{4,16}$/.test(userName).test(userName)){
				//alert("用户名不合法! 4-16位，字母，数字，下划线");
				$("#userNameError").addClass("red").text("用户名不合法! 4-16位汉字，字母，数字，下划线");
			}else{
				$("#userNameError").html(null)
			}	
		});
		$("#inputPassword").blur(function (){	
			
			var psw=$("#inputPassword").val();
			if(!/^\w{6,20}$/.test(psw)){
				$("#passwordError").addClass("red").text("密码不合法! 6-16位，字母，数字");	
			}else{
				$("#passwordError").html(null)
			}
		});
		
		
		
		$("#inputCode").blur(function (){	
			var vCode=$("#inputCode").val();
	 	 	if(!!vCode){
		 	 	$.ajax({  
	                type:"POST", //请求方式 
	                url:"${pageContext.request.contextPath}/user/validCode.action",
	                dataType:"json", //返回数据类型
	                data:{//请求参数
	               		vCode:vCode
	                },
	                success:function(data){ //请求成功后
	                	if(data.msg=='1'){
                      	 	$("#error_html").removeClass("red").html("");
                       }else{
                        	//alert("验证码不正确！");
                        	$("#error_html").addClass("red").html("验证码不正确!");
                        	flag=false;
                       }
	                },
	            	error:function (){
	                	alert("系统出现异常！");
	            	}    
		        }); 
			}else{
		           flag=false;
		           alert("验证码不能为空")
		    }
		});
	});
		
	function login(){
		var userName=$("#inputEmail").val();//获取用户名
		var psw=$("#inputPassword").val();
		var vCode=$("#inputCode").val();
		if(!/^[\u4e00-\u9fa5_a-zA-Z0-9]{4,16}$/.test(userName)){
			return false;
		}else if(!/^.{6,16}$/.test(psw)){
			return false;
		}else{
			$.ajax({  
                type:"POST",  
                url:"${pageContext.request.contextPath}/user/login.action",
                dataType:"json",  
                data:{
                	vCode:vCode,
               		userPwd:psw,
                	userCode:userName
                },  
                success:function(data){ 
	               	if( data.res == 1){
	               		
	               		var chc=$("#rememberMe").prop("checked");
	                	if(chc){
	                		$.cookie("userName", userName,{expires:7});
			                $.cookie("userPwd", psw,{expires:7});
	                	}else{
	                		$.cookie("userName", null);
		                  	$.cookie("userPwd", null);
	                	}
						window.location.href="${pageContext.request.contextPath}/user/index.action";
	                }else if(data.res == 0){
	                  		alert("验证码错误！");
					}else if(data.res == 2){
	                	  alert("该账户已被删除！");
	                }else if(data.res == 3){
	                	  alert("该账户已被禁用！");
	                }else if(data.res == 4){
	                	  alert("你输入的账号或密码不正确！");
	                }else{
	                  	alert("登录失败");
	                }
                },
                error:function (){
                   alert("系统错误！");
                }   
        	});
		}
	}

	$(document).ready(function(){
		$(document).keydown(function (){
			if(event.keyCode==13){
				login();
			}
		});	
		var uname=$.cookie("userName");
		var passd=$.cookie("userPwd");
		if(null != uname && null != passd){
			$("#inputEmail").val(uname);
			$("#inputPassword").val(passd);
			$("#rememberMe").prop("checked",true);
			
		}
	}); 
</script>
  </head>
  <body>
    	<form class="form-signin" method="post" action="##">
			<h3 class="form-signin-heading">请登录</h3>
			<label for="inputEmail" class="sr-only">用户名</label>
			<input type="text" id="inputEmail" class="form-control class123456" placeholder="用户名"  name="username" maxlength="20"   >
			<label id="userNameError"></label>
			<label for="inputPassword" class="sr-only">密码</label>
			<input type="password"  id="inputPassword" class="form-control" placeholder="密码" name="password" maxlength="10" />
		   	<label id="passwordError"></label><br/>
			<label for="inputEmail" class="sr-only" >验证码</label>
			<input type="text" id="inputCode" placeholder="验证码" name="code" tabindex="6" style="width:80px;text-transform:uppercase;ime-mode:disabled" maxlength="4">
			<img id="vdimgck"  src="${pageContext.request.contextPath}/pages/image.jsp?d="+new Date()+""   alt="看不清？点击更换"  align="absmiddle" width="75" style="cursor:pointer" onclick="this.src=this.src+'?'" />
			<label id="error_html" style="font-size:18px;"></label>
		   	<div class="checkbox" id="checkboxid" >
			  	<label>
					<input type="checkbox" name="rememberMe" id="rememberMe" /> 记住我&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  	</label>
			</div>
			<p class="bg-warning">${error}</p>
			<button class="btn btn-lg btn-primary btn-block" type="button" onclick="return login()" >登录</button>
     </form>
</body>
</html>
