<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>天使快递员注册</title>
<link href="../layui/css/layui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="../layui/layui.js"></script>
<script type="text/javascript">layui.use('form',function(){})</script>
<script type="text/javascript" src="../js/demo.js"></script>
</head>
<body style="margin:14px;">
	<div>
		<h5 style="font-weight:bold">特别提示：</h5>
		<span style="font-weight:bold">
			您在使用百度提供的各项服务之前，请您务必审慎阅读、充分理解本协议各条款内容，特别是以粗体标注的部分，包括但不限于免除或者限制责任的条款。如您不同意本服务协议及/或随时对其的修改，您可以主动停止使用百度提供的服务；您一旦使用百度服务，即视为您已了解并完全同意本服务协议各项内容，包括百度对服务协议随时所做的任何修改，并成为百度用户。
		</span>
	</div>
	<form class="layui-form" style="text-align:center" onsubmit="return false;">
		<div class="layui-form-item">
		    <label class="layui-form-label">验证码</label>
		    <div class="layui-input-inline">
		        <input id="verify" type="text" name="text" required lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
		    </div>
		    <input type="button" class="layui-btn" value="发送验证码" onclick="send_valid_code(<%=user.getMobilephone()%>)">
		    <div class="layui-form-mid layui-word-aux" style="margin-left:112px">输入你手机收到的验证码</div>
		    
		</div>
		<input type="checkbox" title="我已充分理解并同意以上内容"/><br/>
		<button class="layui-btn" style="margin-top:30px;" onclick="regist_deliver_do()">立即申请</button>
	</form>
</body>
</html>