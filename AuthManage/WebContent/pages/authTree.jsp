<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>权限管理 - 权限列表</title>
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/static/css/layout.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/zTree/css/demo.css"
	type="text/css">
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript">
	var setting = {
		check:{
		   enable:true,
		   chkStyle: "radio",  //单选框
		   radioType: "all"   //对所有节点设置单选
		},   
		data : {
			simpleData : {//是否使用简单数据模式
				enable : true
			}
		},
		callback : {
			onCheck : onCheck
		},
		view: {
			fontCss: setFontCss
		}
	};
	//id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中
	
	function setFontCss(treeId, treeNode) {
		return treeNode.state == 0 ? {color:"gray"} : {};
	};
	
	
	var zNodes = ${jsonArray}	
	$(document).ready(function() {
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	});
	//选中复选框后触发事件
	
	function onCheck(e, treeId, treeNode) {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo"), 
		nodes = treeObj.getCheckedNodes(true), v = "";
		//获取选中的复选框的值
		for (var i = 0; i < nodes.length; i++) {
			v += nodes[i].id;
			//alert(nodes[i].id); //获取选中节点的值
			/* $("#authIdInput").val(v); */
		}
		 /* alert(v); */
		return v;
	}
	var fig = true;
	var fig1 = true;

	//请求添加权限        
	function addAuth1() {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo"), 
		nodes = treeObj.getCheckedNodes(true), v="";
		if(null!=nodes[0]){
			v=nodes[0].id
		}else{
			v= "0";
		}
		var an = $("#authNameInput1").val();
		var gd = $("#grade").val();
		$("#parentId").val(v);
		$("#authType").val(gd);
		 if (!!an && fig && fig1) {
			 $("#addauth").submit();
		} else {
			alert("请正确填写");
		} 
	}

	function updateAuth() {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo"), 
		nodes = treeObj.getCheckedNodes(true), v = "";
		for (var i = 0; i < nodes.length; i++) {
			v += nodes[i].id;
		}
		var an = $("#authNameInput").val();
		var ad = $("#descInput").val();
		var authId = v;
		if (!!authId ) {
			$.ajax({
				url : "${pageContext.request.contextPath}/auth/updateAuth.action",
				type : "POST",
				data : {
					authDesc : ad,
					authId : authId,
				},
				success : function() {
					alert("修改成功！");
					window.location.href = "${pageContext.request.contextPath}/auth/list.action";

				},
				error : function() {
					alert("执行异常");
					window.location.href = "${pageContext.request.contextPath}/auth/list.action";
				},
			});
		} else {
			alert("请选择要修改的权限");
		}
	}
	
	/*删除权限
			 */
			function deleteAuth() {
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo"), nodes = treeObj
						.getCheckedNodes(true), v = "";
				for (var i = 0; i < nodes.length; i++) {
					v += nodes[i].id;
				}
				var authId = v;
				if (!!authId) {
					$.ajax({
						url : "${pageContext.request.contextPath}/auth/deleteAuth.action",
						type : "POST",
						data : {
							authId : authId,
						},
						success : function() {
							alert("删除成功！");
							window.location.href = "${pageContext.request.contextPath}/auth/list.action";

						},
						error : function() {
							alert("执行异常");
							window.location.href = "${pageContext.request.contextPath}/auth/list.action";
						},
					});
				} else {
					alert("请选择要删除的权限");
				}
			}
			/*禁用权限
			 */
			function disabledAuth() {
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo"), 
				nodes = treeObj.getCheckedNodes(true);
				if(nodes[0]==null){
					alert("请选择你要禁用的权限");
					return;
				}
				var authId = nodes[0].id;
				if(nodes[0].state!=1){
					alert("权限没有被启用");
				
				}else{
					$.ajax({
						url : "${pageContext.request.contextPath}/auth/disabledAuth.action",
						type : "POST",
						data : {
							authId : authId,
						},
						success : function() {
							alert("禁用成功");
							window.location.href = "${pageContext.request.contextPath}/auth/list.action";
						},
						error:function(){
						alert("!!????");
						}
					});
				}
			}
			/*恢复权限
			 */
			function reinAuth() {
				
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo"), 
				nodes = treeObj.getCheckedNodes(true);
				if(nodes[0]==null){
					alert("请选择你要回复的权限");
					return;
				}
				var authId = nodes[0].id;
				var pId = nodes[0].pId;
				var node = treeObj.getNodeByParam("id",pId,null);
				if(nodes[0].state!=0){
					alert("权限没有被禁用");
				}else if( node!=null && node.state==0 ){
					alert("上级权限被禁用");
				}else{
					$.ajax({
						url : "${pageContext.request.contextPath}/auth/reinAuth.action",
						type : "POST",
						data : {
							authId : authId,
						},
						success : function() {
							alert("恢复成功");
							window.location.href = "${pageContext.request.contextPath}/auth/list.action";
						},
						error:function(){
						alert("恢复????");
						}
					});
				}
			}
			$(document).ready(function(){
				$(".show-add-form").click(function(){
					$(this).attr("data-target","#role-form-div");
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo"), 
					nodes = treeObj.getCheckedNodes(true);
					if(null==nodes[0]){
						$(".grade1").hide();
						$("#grade option:gt(0)").prop("disabled","disabled");
						$("#grade option").eq(0).prop("selected","selected").removeAttr("disabled");
					}else{
						var grade = nodes[0].grade;
						if(grade == 1){
							$(".grade1").show();					
							$("#grade option:gt(1)").prop("disabled","disabled");
							$("#grade option:lt(1)").prop("disabled","disabled");
							$("#grade option").eq(1).prop("selected","selected").removeAttr("disabled");
						}else if(grade == 2){
							$(".grade1").show();
							$("#grade option:lt(2)").prop("disabled","disabled");
							$("#grade option").eq(2).prop("selected","selected").removeAttr("disabled");
						}else if(grade == 3){
							alert("无法为该权限添加子权限");
							$(this).removeAttr("data-target");
						}
					}
				});
				
				$("#authNameInput1").blur(function (){
					var AuthName =$("#authNameInput1").val();
					if(null == AuthName||AuthName==""){

						$(this).next().html("AuthName不能为空！").css("color", "red");
					}else{
						$(this).next().html(null);
						$.ajax({  
			                type:"POST", 
			                url:"${pageContext.request.contextPath}/auth/selectauthByName.action",
			                dataType:"json", //返回数据类型
			                data:{//请求参数
			               		authName:AuthName
			                },
			                success:function(data){ //请求成功后
			                	if(data.msg == 1){
			                		fig=false;
		                    	   $("#authNameInput1").next().html("AuthName被占用！").css("color", "red");
		                       }else {
		                    	   fig=true;
		                    	   $("#authNameInput1").next().html(null);
		                       }
			                	
			                },
			            	error:function (){
			                	alert("系统出现异常！");
			            	}    
				        }); 
					}
					
				});
				
				$("#urlInput1").blur(function (){
					var url =$(this).val();
					if(null ==url||url==""){
						$(this).next().html("url不能为空！").css("color", "red");
						fig1=false;
					}else{
						$(this).next().html(null);
						$.ajax({  
			                type:"POST", 
			                url:"${pageContext.request.contextPath}/auth/selectauthByUrl.action",
			                dataType:"json", //返回数据类型
			                data:{//请求参数
			                	authUrl:url
			                },
			                success:function(data){ //请求成功后
			                	if(data.msg==1){
			                		fig1=false;
		                    	   $("#urlInput1").next().html("url已存在！").css("color", "red");
		                       }else{
		                    	   alert("Conssdd");
		                    	   fig1=true;
		                    	   $("#urlInput1").next().html(null);
		                       }
			                },
			            	error:function (){
			                	alert("系统出现异常！");
			            	}    
				        }); 
					}
				
				});
				
				$(".update-auth-form-div").click(function(){
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo"), 
					nodes = treeObj.getCheckedNodes(true);
					if(null==nodes[0]){
						alert("请选择你要修改的权限")
						$(this).removeAttr("data-target");
					}else{
						$("#authNameInput").val(nodes[0].name);
						$("#descInput").val(nodes[0].desc);
						$(this).attr("data-target","#update-auth-form-div");
					}
				});
			});

</script>
</head>

<body>

	<!-- 头部 -->
	<jsp:include page="header.jsp" />

	<div class="container-fluid" style="margin-top: 30px;">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<jsp:include page="navibar.jsp" />
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">权限列表</h1>
				<div class="row placeholders">
					<!--添加权限表单 start-->
					<div>
						<button type="button" class="btn btn-default update-auth-form-div"
							style="width: 100px;" data-toggle="modal"
							data-target="#update-auth-form-div">修改权限</button>
						<button type="button" class="btn btn-default show-add-form"
							data-toggle="modal" data-target="#role-form-div"
							style="width: 100px;">添加权限</button>
						<button type="button" style="width: 100px;"
							class="btn btn-primary" onclick="reinAuth()">恢复权限</button>
						<button type="button" class="btn btn-primary"
						onclick="disabledAuth()">禁用权限</button>
					</div>
				</div>

				<!--添加权限表单 end-->
				<div class="space-div"></div>

				<div class="zTreeDemoBackground left">
					<ul id="treeDemo" class="ztree" style="width: 1024px;"></ul>
				</div>
				<div class="space-div"></div>
				<div>
					
					<button type="button" style="width: 100px;" class="btn btn-primary"
						onclick="deleteAuth()">删除权限</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 提示框 -->
	<div class="modal fade" id="op-tips-dialog" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">提示信息</h4>
				</div>
				<div class="modal-body" id="op-tips-content"></div>
			</div>
		</div>
	</div>
	<div class="modal fade " id="update-auth-form-div" tabindex="-1"
		role="dialog" aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-md" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="role-form-title">修改权限</h4>
				</div>
				<div class="modal-body">
					<form class="role-form">

						<div class="form-group">
							<label for="authNameInput">名称</label> <input type="text"
								name="authName" class="form-control" id="authNameInput"
								disabled="disabled">
						</div>
						<div class="form-group">
							<label for="descInput">权限描述</label> <input type="text"
								name="authGrade" class="form-control" id="descInput"
								placeholder="要修改的权限描述">
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary role-submit"
						id="checkon" onclick="updateAuth()">提交</button>
				</div>
			</div>
		</div>
	</div>




	<div class="modal fade " id="role-form-div" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-md" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="role-form-title">添加权限</h4>
				</div>
				<div class="modal-body">
					<form id ="addauth" action="${pageContext.request.contextPath}/auth/insertAuth.action"
					 method="post" class="role-form">
						<input type="hidden" name="parentId" id="parentId">
						
						<div class="form-group ">
							<label for="authNameInput1">名称</label> 
							<input type="text" name="authName" class="form-control" id="authNameInput1"
							placeholder="权限名称">
							<label></label>
						</div>
						<div class="form-group grade1">
							<label for="codeInput1">权限code</label> <input type="text"
								name="authCode" class="form-control" id="codeInput1"
								placeholder="权限代码">
						</div>
						<div class="form-group authDesc">
							<label for="descInput1">权限描述</label> <input type="text"
								name="authDesc" class="form-control" id="descInput1"
								placeholder="权限描述">
						</div>
						<div class="form-group grade1">
							<label for="descInput1">权限url</label> <input type="text"
							name="authUrl" class="form-control" id="urlInput1"
							placeholder="权限url">
							<label></label>
						</div>
						<div class="form-group">
							<label for="gradeInput1">权限等级</label>
						<input type="hidden" name="authType" id="authType">
						<select  id="grade" name="authGrade">
							<option value="1">模块</option>
							<option value="2">列表</option>
							<option value="3">按钮</option>
						</select>
						</div> 
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary role-submit"
						id="checkon" onclick="addAuth1()">提交</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->

	<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
	<script >
		
	</script>
</body>
</html>
