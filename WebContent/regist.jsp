<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    	<style type="text/css">
    		td{
    			font-size: x-large;
    			
    		}
    		input{
    			font-size: large;
    			font-family: "黑体";
    		}
    	</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>用户注册</title>
        <link rel="stylesheet" href="css/style.css" />
        <link href="layui/css/layui.css" rel="stylesheet" type="text/css">
       	<script type="text/javascript" src="js/check_regist.js"></script>
       	<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
       	<script src="js/check_regist.js"></script>
       	<script type="text/javascript" src="layer/layer.js"></script>
    </head>
    <!-- 标头 -->
    <p></p>
    	<div style="width: 80%;margin-left: auto;margin-right: auto;display:flex;padding:10px;">
    		<img alt="转赚" src="img/logo-login.png" width="100" style="float:left;">
    		<span style="float:left;font-size: 21px;position: relative;color:orange;border-left: solid;padding: 8px;margin-left: 8px;">注册转赚账号</span>
    		<span style="float:right;position: absolute;right: 24px;top: 23px;color:#666666">已有账号？<a href="login.jsp" style="color:orange">请登录</a></span>
    	</div>
    <p style="box-shadow: 0px 5px 5px -2px;height: 5px;"></p>
    <!-- 标头结束 -->
    <body onload="load()">
    
    	<%
    	if("1".equals(request.getParameter("finish")))
    			out.println("<script type='text/javascript'>layer.msg('注册成功！')</script>");
    	%>
    	<form action="Regist" method="post">
    		<table align="center" border="0" width="80%" style="margin-bottom:20px;">
    			
    			<tr>
    				<td class="reg-item" width="13%">学号：</td>
    				<td><input width="40%" class="reg-input" id="username" type="text" oninput="checkId()" name="username" placeholder="学号"></td>
    				<td width="17%" class="tip">&nbsp;</td>
    				<td width="40%" rowspan="10" width="50%" style="border-left: solid 1px #ececb9;" align="center" valign="center">
    					<img alt="" src="img/logo.png"><br/>
    					<a href="index.jsp" style="font-size:18px;">返回首页</a>
    				</td>
    			</tr>
    			<tr>
    				<td class="reg-item">真实姓名：</td>
    				<td><input class="reg-input" id="realname" type="text" name="realname" placeholder="真实姓名"></td>
    				<td class="tip">&nbsp;&nbsp;</td>
    			</tr>
    			<tr>
    				<td class="reg-item">用户密码：</td>
    				<td><input class="reg-input" id="password" type="password" oninput="checkPass()" name="password" placeholder="密码"></td>
    				<td class="tip">&nbsp;&nbsp;</td>
    			</tr>
    			<tr>
    				<td class="reg-item">确认密码：</td>
    				<td><input class="reg-input" id="spassword" type="password" oninput="checkSPass()" name="spassword" placeholder="确认密码"></td>
    				<td class="tip">&nbsp;&nbsp;</td>
    			</tr>
    			<tr >
    				<td class="reg-item">显示名称：</td>
    				<td><input class="reg-input" id="nickname" type="text" oninput="checkNickName()" name="nickname" placeholder="显示名称"></td>
    				<td class="tip">&nbsp;&nbsp;</td>
    			</tr>
    			
    			<tr>
    				<td class="reg-item">性别：</td>
    				<td class="reg-item" style="text-align:center;">
    					<label id="sex1" style="cursor:pointer;"><input id="sex1" name="sex" type="radio" value="男" checked="true" /><i class="layui-icon" style="font-size:25px">&#xe662;</i></label>
    					<label id="sex2" style="margin-left:15px;cursor:pointer;"><input id="sex2" name="sex" type="radio" value="女" /><i class="layui-icon" style="font-size:25px;">&#xe661;</i></label>
    					<label id="sex3" style="margin-left:15px;cursor:pointer;"><input id="sex2" name="sex" type="radio" value="女" /><i class="layui-icon" style="font-size:25px;">&#xe607;</i></label>
    				</td>
    			</tr>
    			<tr>
    				<td class="reg-item">手机号码：</td>
    				<td ><input class="reg-input" id="phone" type="text" oninput="checkPhone()" name="mobilephone" placeholder="手机号"> </td>
    				<td class="tip">&nbsp;&nbsp;</td>
    			</tr>
    			<tr>
    				<td class="reg-item">宿舍楼号：</td>
    				<td><input class="reg-input" id="dormitory" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="2" onInput="checkDormitory()" type="text" name="dormitory" placeholder="楼号" ></td>
    				<td class="tip">&nbsp;&nbsp;</td>
    			</tr>
    			<tr>
    				<td class="reg-item">宿舍号：</td>
    				<td><input class="reg-input" id="room" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="3" onInput="checkRoomnumber()" type="text" name="room" placeholder="房间号" ></td>
    				<td class="tip">&nbsp;&nbsp;</td>
    			</tr>
    			<tr>
    				<td align="center" colspan="2"  height="50">
    					<input id="regBtn" disabled="disabled" type="submit" value="注册" />
    				</td>
    			</tr>
    		</table>
    	</form>
    	<jsp:include page="foot.jsp"></jsp:include>
 	</body>
</html>