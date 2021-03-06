<%@page import="com.zhuanzhuan.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<style type="text/css">
	input{
		width:230px;
		height:30px;
		font-size:30px;
		font-family:楷体;
	}
</style>
<%
	String rightpass = user.getPassword();
%>
<script type="text/javascript" src="../js/demo.js"></script>
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<script>
var oldpassword = false;
var newpassword = false;
var newpassword2 = false;
var newpass = null;
function checkOldPass()
{
	var rightp = $("#rightpass").html();
	var oldpass = $("#oldpassword").val();
	if($("#oldpassword").val()==null||$("#oldpassword").val()==""){
		$(".tip").eq(0).html("×");
		$(".tip").eq(0).css({"color":"red"});
		$(".tip").eq(0).attr("title",'请输入原密码');
	}
	else if(oldpass!=rightp){
		$(".tip").eq(0).html("×");
		$(".tip").eq(0).css({"color":"red"});
		$(".tip").eq(0).attr("title",'密码不正确');
	}
	else{
		oldpassword = true;
		$(".tip").eq(0).html("√");
		$(".tip").eq(0).css({"color":"green"});
		$(".tip").eq(0).attr("title",'');
	}
	checkAll();
}
function checkNewPass()
{
	newpass = $("#newpassword").val();
	if($("#newpassword").val()==null||$("#newpassword").val()==""){
		$(".tip").eq(1).html("×");
		$(".tip").eq(1).css({"color":"red"});
		$(".tip").eq(1).attr("title",'请输入新密码');
	}
	else if(newpass.length<6||newpass.length>16){
		$(".tip").eq(1).html("×");
		$(".tip").eq(1).css({"color":"red"});
		$(".tip").eq(1).attr("title",'请输入6-16位密码');
	}
	else{
		newpassword = true;
		$(".tip").eq(1).html("√");
		$(".tip").eq(1).css({"color":"green"});
		$(".tip").eq(1).attr("title",'');
	}
	checkAll();
}
function checkNewPass2()
{
	if(newpassword){
		var newpass2 = $("#newpassword2").val();
		if($("#newpassword2").val()==null||$("#newpassword2").val()==""){
			$(".tip").eq(2).html("×");
			$(".tip").eq(2).css({"color":"red"});
			$(".tip").eq(2).attr("title",'请确认原密码');
		}
		else if(newpass2!=newpass){
			$(".tip").eq(2).html("×");
			$(".tip").eq(2).css({"color":"red"});
			$(".tip").eq(2).attr("title",'两个新密码不一致');
		}
		else{
			newpassword2=true;
			$(".tip").eq(2).html("√");
			$(".tip").eq(2).css({"color":"green"});
			$(".tip").eq(2).attr("title",'');
		}
	}
	else{
		$(".tip").eq(2).html("×");
		$(".tip").eq(2).css({"color":"red"});
		$(".tip").eq(2).attr("title",'请检查新密码的有效性');
	}
	checkAll();
}
function checkAll() {
	var flag = oldpassword+newpassword+newpassword2;
	if(flag == 3){
		$("#chanbtn").removeAttr("disabled");
	}else{
		$("#chanbtn").attr("disabled");
	}
}
</script>
</head>
<body>
		<form action="changepassword.jsp" align="center">
		<table border="0" style="font-family:'楷体';font-size:25px" align="center">
			<tr>
				<td>
					原密码：
				</td>
				<td>
					<input type="password" id="oldpassword" name="oldpassword" oninput="checkOldPass()" placeholder="原密码">
				</td>
				<td class="tip">&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td>
					新密码：
				</td>
				<td>
					<input type="password" id="newpassword" name="newpassword" oninput="checkNewPass()" placeholder="新密码">
				</td>
				<td class="tip">&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td>
					确认密码：
				</td>
				<td>
					<input type="password" id="newpassword2" name="newpassword2" oninput="checkNewPass2()" placeholder="确认密码">
				</td>
				<td class="tip">&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td height="100" colspan="2" align="center"><button id="chanbtn" style="font-family:'楷体';width:70px;height:30px" type="submit" disabled="disabled">提交</button></td>
			</tr>
		</table>
		<br />
	</form>
	<label id="rightpass" style="display:none"><%=rightpass %></label>
</body>
</html>