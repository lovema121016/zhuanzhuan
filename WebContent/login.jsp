<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录</title>
<link href="css/login.css" rel="stylesheet" type="text/css">
<link href="layui/css/layui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="js/demo.js" ></script>

<style type="text/css">
body {
	background-image: url(img/index_background.jpg);
	background-repeat:no-repeat;
	background-size:cover;
}
@keyframes slideright
{
	from{left:-100%;}
	to{left:0px;}
}
@keyframes slideleft
{
	from{right: -310%;}
	to{right:0px;}
}
.index{
	position:absolute;
	right:20px;
	top:20px;
	color:white;
	padding:5px;
	border-radius:5px;
}
.index:hover{
	color:white;
	text-decoration:underline;
	background:rgba(243,63,174,0.2);
}
</style>
</head>
<body>
<%
	String number = (String)session.getAttribute("number");
	if(number == null || "".equals(number)){
		number = "";
	}
%>
<div style="position: absolute;top: 36%;left: 20%;">
	<h1 style="font-size: 53px;color: firebrick;position:relative;animation:slideright 0.7s">转赚</h1>
	<h3 style="position:relative;animation:slideleft 0.7s">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;————二手交易平台，铁大专属</h3>
</div>
<a class="index" href="index.jsp">首页</a>
<a href="index.jsp"><img alt="" src="img/logo-login.png" style="width: 100px;position: absolute;left: 20px;top: 20px;"></a>
<!--登录框-->
<div id="login">
<!--表单-->
  <form name="Login" method="post" action="Login">
    <p></p>
    <table width="300" height="175" border="0" align="center">
      <tr>
        <td width="120" align="right">学号： </td>
        <td colspan="2" align="center"><input oninput="check_user()" name="username" type="text" id="user" tabindex="1" placeholder="学号" value="<%=number %>" class="log_input"></td>
      </tr>
      <tr>
        <td align="right">密码：</td>
        <td colspan="2" align="center"><input autocomplete="off" onkeyup="value=value.replace(/[^\u0020-\u007e]/ig,'')" oninput="check_pass()" type="password" name="password" id="password" tabindex="2" placeholder="密码" class="log_input"></td>
      </tr>
      <tr>
        <td align="right">验证码：
        <label for="verify"></label></td>
        <td colspan="2" align="center"><input autocomplete="off" oninput="check_verify()" type="text" name="verify" id="identify" tabindex="3" placeholder="验证码" class="log_input"></td>
      </tr>
      <tr>
        <td align="center" colspan="2"><p><a href="retrieve_password.html"></a><img alt="code..." name="randImage" id="randImage" src="image.jsp" width="60" height="20" border="1" align="absmiddle"></td></p>
        
        </td>
        
        <td width="150" align="left"><a href="javascript::" style="font-size:12px;margin-bottom:1px;text-decoration: none;" onclick="reloadImage();document.getElementById('login_button').disabled=true;document.getElementById('tip3').innerHTML = '验证码错误×';">看不清，换一张</a></td>
      </tr>
    </table>
    <p><label id="tip">&nbsp;</label></p>
    <p><label id="tip2">&nbsp;</label></p>
    <p><label id="tip3">&nbsp;</label></p>
    <p>
    <a href="javascript:;" style="text-decoration:none;"><input disabled="disabled" type="submit" name="login_button" value="登录" id="login_button" tabindex="4"></a></p>
    <p class="tip">还没有账号？点击<a style="text-decoration: none;" href='regist.jsp'>注册</a></p>
  </form>
  <!--表单结束-->
</div><!--登陆框结束-->
<p>&nbsp;</p>
<p>&nbsp;</p>
	<div id="cover"></div>
    <div id="regist" style="background-color:#CCFFFF;width:32%" >
       <a id="userRegist" href="regist.jsp" target="regist" style="float:left;font-size:30px;font-weight:bold;font-family:'汉仪平安行简';color:#FF0000;font-style:italic;height:50px">爱尚转赚用户注册</a>&nbsp;&nbsp;&nbsp;<span><a onClick="closeRegist()" style="float: right;color:black;" href="javascript:;">X</a></span>
       <hr style=" height:2px;border:none;border-top:2px dotted purple;" />
       <iframe name="regist" src="regist.jsp" >
       </iframe>
    </div>
</body>
</html>

