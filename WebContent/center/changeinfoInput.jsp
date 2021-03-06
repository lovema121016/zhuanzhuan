<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更改资料</title>
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<script>
	$(document).ready(function(){
		checkPhone();
		checkDormitory();
		checkRoomnumber();
	});
	var phoneRight = false;
	var dormitoryRight = false;
	var roomRight = false;
	function checkPhone(){
		var str = $("#phone").val();
		var patt = /^1[3|4|5|8][0-9]\d{4,8}$/;
		if(!patt.test(str))
		{
			$(".tip").eq(0).html("×");
			$(".tip").eq(0).css({"color":"red"});
			$(".tip").eq(0).attr("title",'手机号码格式不正确');
		}
		else{
			phoneRight = true;
			$(".tip").eq(0).html("√");
			$(".tip").eq(0).css({"color":"green"});
		}
		checkAll();
	}
	function checkDormitory(){
		var num = parseInt($("#dormitory").val());
		if($("#dormitory").val()==null||$("#dormitory").val()==""){
			$(".tip").eq(1).html("×");
			$(".tip").eq(1).css({"color":"red"});
			$(".tip").eq(1).attr("title",'楼号不能为空');
		}else if(isNaN(num)){
			$(".tip").eq(1).html("×");
			$(".tip").eq(1).css({"color":"red"});
			$(".tip").eq(1).attr("title",'输入格式错误！');
		}else if(num > 25 || num <1){
			$(".tip").eq(1).html("×");
			$(".tip").eq(1).css({"color":"red"});
			$(".tip").eq(1).attr("title",'没有此号楼');
		}else{
			dormitoryRight = true;
			$(".tip").eq(1).html("√");
			$(".tip").eq(1).css({"color":"green"});
			$(".tip").eq(1).attr("title",'');
		}
		checkAll();
	}
	function checkRoomnumber(){
		var num = parseInt($("#room").val());
		if($("#room").val()==null||$("#room").val()==""){
			$(".tip").eq(2).html("×");
			$(".tip").eq(2).css({"color":"red"});
			$(".tip").eq(2).attr("title",'宿舍号不能为空');
		}else if(isNaN(num)){
			$(".tip").eq(1).html("×");
			$(".tip").eq(1).css({"color":"red"});
			$(".tip").eq(1).attr("title",'输入格式错误！');
		}
		else if(num > 700 || num <100){
			$(".tip").eq(2).html("×");
			$(".tip").eq(2).css({"color":"red"});
			$(".tip").eq(2).attr("title",'没有此号宿舍');
		}else{
			roomRight = true;
			$(".tip").eq(2).html("√");
			$(".tip").eq(2).css({"color":"green"});
			$(".tip").eq(2).attr("title",'');
		}
		checkAll();
	}
	function checkAll() {
		var flag = roomRight+dormitoryRight+phoneRight;
		if(flag == 3){
			$("#btn").removeAttr("disabled");
		}else{
			$("#btn").attr("disabled");
		}
	}
</script>
</head>
<body>
	<form action="changeinfo.jsp">
		<table border="0" align="center" style="font-family:'楷体';font-size:30px">
			<tr>
				<td>昵称:
					<input style="width:100px;height:30px;font-size:28px;font-family:'楷体'" type="text" name="nickname" value="<%=user.getNickname() %>"/>
					性别:
    				<select name="sex" style="width:50px;height:35px;font-size:28px;font-family:楷体;">
    				<%if(user.getSex()){%>
    					<option selected>女</option>
    					<option>男</option>
    				<%}else{ %>
    					<option selected>男</option>
    					<option>女</option>
    				<%} %>
    				</select>
				</td>
    		</tr>
    		<tr height="10px"></tr>
    		<tr>
    			<td>
    				手机号码:
    				<input id="phone" oninput="checkPhone()" style="font-family:'楷体';width:200px;height:30px;font-size:28px" type="text" name="phone" value="<%=user.getMobilephone() %>" />
    			</td>
    			<td class="tip">&nbsp;&nbsp;</td>
    		</tr>
    		<tr height="10px"></tr>
    		<tr>
    			<td>
    				宿舍楼号:
    				<input id="dormitory" oninput="checkDormitory()" style="font-family:'楷体';width:200px;height:30px;font-size:28px" type="text" name="dormitory" value="<%=user.getDormitory() %>" />
    			</td>
    			<td class="tip">&nbsp;&nbsp;</td>
    		</tr>
    		<tr height="10px"></tr>
    		<tr>
    			<td>
    				宿舍号:&nbsp;&nbsp;
    				<input id="room" oninput="checkRoomnumber()" style="font-family:'楷体';width:200px;height:30px;font-size:28px" type="text" name="room" value="<%=user.getRoom() %>" />
    			</td>
    			<td class="tip">&nbsp;&nbsp;</td>
    		</tr>
    		<tr height="10px"></tr>
		</table>
		<div align="center"><input id="btn" disabled="disabled" type="submit" value="提交" style="font-family:'楷体';font-size:25px"></div>
	</form>
</body>
</html>