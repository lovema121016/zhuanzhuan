<%@page import="java.util.Collections"%>
<%@page import="com.zhuanzhuan.model.Courier"%>
<%@page import="com.zhuanzhuan.dao.CourierDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Message"%>
<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Good"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>转赚</title>
<link rel="stylesheet" href="layui/css/layui.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="icon" href="img/favicon.ico">
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript" src="layui/lay/modules/element.js"></script>
<script type="text/javascript" src="js/demo.js"></script>
<script type="text/javascript" src="layer/layer.js"></script>
<script type="text/javascript">
	layui.use('element', function(){
		var element = layui.element;
	  
	  	//一些事件监听
	  	element.on('nav(test)', function(elem){
		  console.log(elem); //得到当前点击的DOM对象
		  elem.addClass("layui-this");
		});
	});
</script>
<style>#cata:hover{border: solid 2px #78f6f6;}</style>
<style type="text/css">
@font-face
{
    font-family: 汉仪平安行简;
    src: url(font-awesome-4.7.0/fonts/汉仪平安行简.woff);
}
@font-face
{
    font-family: 方正粗倩简体;
    src: url('font-awesome-4.7.0/fonts/FZCQJW.woff');
}
</style>
</head>
<body style="margin:0px;" bgcolor="#F8F8F8">
<jsp:include page="header.jsp" />

<ul id="nav" class="layui-nav layui-bg-orange" lay-filter="test">
  <li class="layui-nav-item layui-this"><a href="index.jsp" class="layui-icon">&#xe68e;主页</a></li>
  <li class="layui-nav-item"><a href="release_info-input.jsp" class="layui-icon">&#xe654;发布商品</a></li>
  <li class="layui-nav-item"><a href="center/ShoppingCarts" class="layui-icon">&#xe698;购物车</a></li>
  <li class="layui-nav-item">
    <a href="center/User.jsp" class="layui-icon">&#xe612;个人中心</a>
    <dl class="layui-nav-child"> <!-- 二级菜单 -->
      <dd><a href="center/User.jsp">个人资料</a></dd>
      <dd><a href="center/buyer_orders.jsp">我买到的宝贝</a></dd>
      <dd><a href="center/seller_orders.jsp">我发布的商品</a></dd>
    </dl>
  </li>
  <li class="layui-nav-item"><a href="help.jsp" class="layui-icon">&#xe705;帮助</a></li>
  <%if(user.getId() != 0){ 
  MessageDaoImpl messageDao = DaoFactory.getMessageDao();
  List<Message> messages = messageDao.loadWithCondition(user.getId(), Message.UNREAD);
  System.out.println(messages.size());
  CourierDaoImpl courierDao = DaoFactory.getCourierDao();
  Courier courier = courierDao.load(user.getId());
  %>
  <li class="layui-nav-item" style="float:right">
  <input id="cour" type="hidden" value="<%=courier %>" >
  <a href="center/User.jsp"><img src="img/header/<%=user.getHead() %>" class="layui-nav-img"><%if(messages.size() != 0){ %>
  		<span class="layui-badge-dot" style="position:relative;left:-28px;top:-11px;margin-right: -20px;margin-left: 6px;"></span>
  	<%} %><%=user.getNickname() %></a>
  <dl class="layui-nav-child">
    <dd><a href="center/User.jsp">修改信息</a></dd>
    <dd><a href="center/ShoppingCarts">我的购物车</a></dd>
    <dd><a href='center/message.jsp'>
    	消息<%if(messages.size() != 0) {%>
    			<span class="layui-badge"><%=messages.size() %></span></a>
    	   <%} %>
    </dd>
    <dd><a onclick="check_courier()">天使快递</a></dd>
    <dd><a href="Logout">退出登录</a></dd>
  </dl>
  </li>
 <%} %>
</ul>
<p style="text-align:center;margin-top:10px;font-size: 50px;font-family: 方正粗倩简体;"><img alt="转转" width="150" src="img/fox.png"></p>
<!-- 搜索框 -->
<div align="center" style="margin-top: 27px">
	<form action="select_result.jsp">
	<img alt="" src="img/logo.png" style="width:33px">
	<span style="font-size:30px;font-weight:bold;font-family:汉仪平安行简;color:#FF0000;">爱尚转赚</span>
	    <input name="key" required="" lay-verify="required" placeholder="请输入关键字" autocomplete="off" class="layui-input" style="width: 50%;display:inline-block" type="text">
	    <button class="layui-btn layui-btn-normal" style="width: ;width: ;width: 5;width: 90px;">搜索</button>
	</form>
</div>
<!-- *****搜索框结束****** -->
</br>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;padding-left:3%">
    <legend style="font-weight: bold;color: red;">转赚分类</legend>
</fieldset>
<table bgcolor="white" width="90%" height="100px" align="center" >
	<tr>
		<td colspan="7">
		</td>
	</tr>
	<tr>
		<td align="center"><a href="select_result.jsp?catagory=办公">办公用品</a></td>
		<td align="center"><a href="select_result.jsp?catagory=游戏">游戏设备</a></td>
		<td align="center"><a href="select_result.jsp?catagory=图书">图书音像</a></td>
		<td align="center"><a href="select_result.jsp?catagory=运动">运动户外</a></td>
		<td align="center"><a href="select_result.jsp?catagory=玩具">玩具乐器</a></td>
		<td align="center"><a href="select_result.jsp?catagory=五金">五金工具</a></td>
		<td align="center"><a href="select_result.jsp?catagory=日用">居家日用</a></td>
	</tr>
	<tr>
		<td align="center"><a href="select_result.jsp?catagory=数码">3C数码</a></td>
		<td align="center"><a href="select_result.jsp?catagory=手机">手机</a></td>
		<td align="center"><a href="select_result.jsp?catagory=植物">园艺植物</a></td>
		<td align="center"><a href="select_result.jsp?catagory=服饰">服饰/配件</a></td>
		<td align="center"><a href="select_result.jsp?catagory=电子">电子零件</a></td>
		<td align="center"><a href="select_result.jsp?catagory=工艺">工艺礼品</a></td>
		<td align="center"><a href="select_result.jsp?catagory=其它">其它闲置</a></td>
	</tr>
</table>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;padding-left:3%">
    <legend>手机数码</legend>
</fieldset>
<div id="cata" style="width: 1210px;margin: auto;height:700px;">
	<% GoodDaoImpl goodDao = DaoFactory.getGoodDao();
	   List<Good> goods = goodDao.loadByCatagory("", "数码");
	   Collections.reverse(goods);
	   int i=0;
	   for(Good good:goods)
	   {
		   String imag=good.getImages()[0];
	%>
		   <div style="height:310px;width:200px;float:left;margin:20px;position:relative;">
		    <p><a href="Good?id=<%=good.getId()%>"><img border="0" src="img/goods/<%=imag %>" style="height:220px;width:200px;" ></a></p>
		    <div style="font-size:18px;text-align:center;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;margin:10px"><a href="Good?id=<%=good.getId()%>" title="<%=good.getGoodname() %>"><%=good.getGoodname() %></a></div>
		   	<p style="color:red;font-weight:bold;font-size:20px;float:right;position:absolute;right:10px;bottom:10px;">￥<%=good.getPrice() %></p>
		   </div>
	<%
		i++;
		if(i % 10 == 0)break;
	} %>
</div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;padding-left:3%">
    <legend>图书音像</legend>
</fieldset>
<div id="cata" style="width: 1210px;margin: auto;height:700px;">
	<% goods = goodDao.loadByCatagory("", "图书音像");
	   Collections.reverse(goods);
	   for(Good good:goods)
	   {
		   String imag=good.getImages()[0];
	%>
		   <div style="height:310px;width:200px;float:left;margin:20px;position:relative;">
		    <p><a href="Good?id=<%=good.getId()%>"><img border="0" src="img/goods/<%=imag %>" style="height:220px;width:200px;" ></a></p>
		    <div style="font-size:18px;text-align:center;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;margin:10px"><a href="Good?id=<%=good.getId()%>" title="<%=good.getGoodname() %>"><%=good.getGoodname() %></a></div>
		   	<p style="color:red;font-weight:bold;font-size:20px;float:right;position:absolute;right:10px;bottom:10px;">￥<%=good.getPrice() %></p>
		   </div>
	<%
		i++;
		if(i % 10 == 0)break;
	} %>
</div>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;padding-left:3%">
    <legend>学习办公</legend>
</fieldset>
<div id="cata" style="width: 1210px;margin: auto;height:700px;">
	<% goods = goodDao.loadByCatagory("", "学习");
		Collections.reverse(goods);
	   for(Good good:goods)
	   {
		   String imag=good.getImages()[0];
			%>
			<div style="height:310px;width:200px;float:left;margin:20px;position:relative;">
				<p><a href="Good?id=<%=good.getId()%>"><img border="0" src="img/goods/<%=imag %>" style="height:220px;width:200px;" ></a></p>
				<div style="font-size:18px;text-align:center;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;margin:10px"><a href="Good?id=<%=good.getId()%>" title="<%=good.getGoodname() %>"><%=good.getGoodname() %></a></div>
				<p style="color:red;font-weight:bold;font-size:20px;float:right;position:absolute;right:10px;bottom:10px;">￥<%=good.getPrice() %></p>
			</div>
	<%
		i++;
		if(i % 10 == 0)break;
	} %>
</div>
<div id="cover"></div>
<div id="regist_deliver">
<iframe id="registdeliver" src="">

</iframe>
</div>
<a href="evaluate.jsp" style="position: absolute;right: 20px;">评价我们的网站</a>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>