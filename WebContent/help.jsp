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

<title>帮助</title>
<link rel="stylesheet" href="layui/css/layui.css" />
<link rel="stylesheet" href="css/style.css" />
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript" src="layui/lay/modules/element.js"></script>
<script type="text/jacascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	layui.use('element', function(){
		var element = layui.element;
	  
	  	//一些事件监听
	  	element.on('nav(test)', function(elem){
		  console.log(elem); //得到当前点击的DOM对象
		  elem.addClass("layui-this");
		});
	});
	function showImg(){
		$("#content img").each(function(index,element){
			var width=$(element).width();
			var bili=1/1;
			$(element).css("height",width*bili);
			})
		}
</script>
<style>#cata:hover{border: solid 2px #78f6f6;}</style>
</head>
<body style="margin:0px;">
<jsp:include page="header.jsp" />

<ul id="nav" class="layui-nav layui-bg-orange" lay-filter="test">
  <li class="layui-nav-item "><a href="index.jsp" class="layui-icon">&#xe68e;主页</a></li>
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
  <li class="layui-nav-item layui-this"><a href="javascript:;" class="layui-icon">&#xe705;帮助</a></li>
  <%if(user.getId() != 0){ 
  MessageDaoImpl messageDao = DaoFactory.getMessageDao();
  List<Message> messages = messageDao.loadWithCondition(user.getId(),Message.UNREAD);
  %>
  <li class="layui-nav-item" style="float:right">
  <a href=""><img src="img/header/<%=user.getHead() %>" class="layui-nav-img"><%=user.getNickname() %></a>
  <dl class="layui-nav-child">
    <dd><a href="center/User.jsp">修改信息</a></dd>
    <dd><a href="center/ShoppingCarts">我的购物车</a></dd>
    <dd><a href="center/message.jsp">
    	消息<%if(messages.size() != 0) {%>
    			<span class="layui-badge"><%=messages.size() %></span></a>
    	   <%} %>
    </dd>
    <dd><a href="courier/courier.jsp">天使快递</a></dd>
    <dd><a href="Logout">退出登录</a></dd>
  </dl>
  </li>
 <%} %>
</ul>
		<!-- 显示帮助信息 -->
 <div style="margin-top:3%">
 	<p style="font-size:50px;font-family:汉仪平安行简;color:purple" colspan="2"align="center">
 		“转赚世界”帮助平台
 	</p>
 </div>
 <div style="margin-top:40px;width: 60%;margin-left: auto;margin-right: auto;">
 	<p style="font-size:25px;font-family:黑体;color:red">
 		<img onload="javascript:showImg()" src='img/arrow1.png' style="width:4%;">
 		<a class="helptitle" name="whatiszhuan">转赚是什么？：</a>
 	</p>	
 	<p class="helpcontent">
 		我们的商品转赚主要是为了解决大学校园二手商品的交易流转问题。在转赚这个世界中，我们可以尽情的挑选自己心仪的物品，同时也可以发布自己所拥有的商品，大家可以在这里放心的进行交易，达到互惠双赢的效果。
 	</p>
 </div>
  <div style="margin-top:40px;width: 60%;margin-left: auto;margin-right: auto;">
 	<p class="helptitle">
 		<img onload="javascript:showImg()" src='img/arrow1.png' style="width:4%;">
 		<a class="helptitle" name="howbuy">转赚购买流程：</a>
 	</p>
 	<p class="helpcontent">
 		点击进入商品详情页面，可以选择购买商品数量，点击立即购买进入支付界面，也可以选择暂时取消支付，之后在订单中及时支付，支付成功后就可以静心等待自己新购置的商品啦。
 	</p>
 </div>
   <div style="margin-top:40px;width: 60%;margin-left: auto;margin-right: auto;">
 	<p class="helptitle">
 		<img onload="javascript:showImg()" src='img/arrow1.png' style="width:4%;">
 		<a class="helptitle" name="qq">关于QQ通讯组件：</a>
 	</p>
 	<p class="helpcontent">
 		为方便买家与卖家之前的交流，根据用户习惯，我们网站采用QQ通讯组件联系作为用户之间在线交流方式。为使您的买家顺利与您取得联系，您只需要进行如下简单配置(否则买家须添加您为QQ好友才可以与您进行对话)：
 	</p>
 	<p class="helpcontent">
 		1.点击进入该链接<a target="_blank" href="http://shang.qq.com/v3/widget.html">http://shang.qq.com/v3/widget.html</a>并使用您在<a target="_blank" href="center/User.jsp">个人资料</a>页填写的QQ号登陆
 	</p>
 	<p class="helpcontent">
 		2.点击“立即免费开通”按钮，即可。
 	</p>
 	<p class="helpcontent" style="text-align:center"><img style="width:75%" alt="图片无法显示" src="img/kaitong.png"></p>
 	<p class="helpcontent">（开通通讯组件后，用户可以点击链接直接与您进行QQ对话，无须添加好友。用户场景如下)</p>
 	<b>用户场景：</b>
 	<p class="helpcontent">
 		在您发布商品后，买家可以进入您商品详情页（如图）通过点击“联系卖家”打开与您的QQ消息对话框。<br/>
 	</p>
 	<p class="helpcontent" style="text-align:center;"><img alt="图片无法显示" src="img/goodpage.png" style="width:75%;margin-left:auto;margin-right:auto;"></p>
 	<p class="helpcontent" style="text-align:center;"><img alt="图片无法显示" src="img/QQmsg.png" style="width:75%;margin-left:auto;margin-right:auto;"></p>
 	<p class="helpcontent">
 		4.如需关闭QQ通讯组件功能，请打开此页面<a target="_blank" href="http://shang.qq.com/v3/widget.html">http://shang.qq.com/v3/widget.html</a>并使用您在<a target="_blank" href="center/User.jsp">个人资料</a>页填写的QQ号登陆，点击左侧“设置”
 	</p>
 	<p class="helpcontent" style="text-align:center;"><img alt="图片无法显示" src="img/QQsetting.png" style="width:75%;margin-left:auto;margin-right:auto;"></p>
 	<p>下拉，找到如图停用服务，点击“停用服务”按钮即可</p>
 	<p class="helpcontent" style="text-align:center;"><img alt="图片无法显示" src="img/QQstop.png" style="width:75%;margin-left:auto;margin-right:auto;"></p>
 </div>
 <hr class="layui-bg-red" style="width:80%;margin-left:auto;margin-right:auto;"/>
   <div style="margin-top:40px;width: 60%;margin-left: auto;margin-right: auto;">
 	<p class="helptitle">
 		<img onload="javascript:showImg()" src='img/arrow1.png' style="width:4%;">
 		<a class="helptitle" name="courier">关于天使快递员：</a>
 	</p>
 	<p class="helpcontent">
 		我们在转赚大世界中设置了天使快递员这一职务，大学生可以申请此职务，方便在校园内兼职锻炼自己，安全可靠。
 	</p>
 </div>
    <div style="margin-top:40px;width: 60%;margin-left: auto;margin-right: auto;">
 	<p class="helptitle">
 		<img onload="javascript:showImg()" src='img/arrow1.png' style="width:4%;">
 		<a class="helptitle" name="feature">系统特点及功能：</a>
 	</p>
 	<p class="helpcontent">
 		我们的产品包含购买商品，发布商品，购物车，修改个人信息，查看个人购买情况，信息在线交流等功能，面向全体大学生，方便快捷，使用简单易操作。
 	</p>
 </div>
   
 	<p style="font-size:25px;font-family:黑体;color:purple;text-align:center;">
 		<img  src='img/arrow4.png' style="width:8%;">
 		官方QQ:1178190996&nbsp;&nbsp;官方电话:18000314340&nbsp;&nbsp;官方邮箱:1178190996@qq.com&nbsp;&nbsp;
 		<a style="position:fixed;right:5px;bottom:10px;" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1178190996&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1178190996:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
 	</p>
 	
 <div class="dir">
 	<p>目录</p>
 	<ul>
 		<a href="#whatiszhuan"><li>什么是转赚</li></a>
 		<a href="#howbuy"><li>如何购买商品</li></a>
 		<a href="#qq"><li>QQ通讯组件</li></a>
 		<a href="#courier"><li>天使快递</li></a>
 		<a href="#feature"><li>系统特点、功能</li></a>
 	</ul>
 </div>
</body>
</html>