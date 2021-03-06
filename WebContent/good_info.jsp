<%@page import="com.zhuanzhuan.model.Message"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.zhuanzhuan.model.Good"%>
<%@page import="java.util.List"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="good" class="com.zhuanzhuan.model.Good" scope="request" />
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品信息页面</title>
<style type="text/css">
	h3:hover{
		color:red;
		text-decoration:underline;
		position:relative;
		top:1px;
		left1px;	
		}
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

 <link rel="stylesheet" href="./layui/css/layui.css" media="all">
  <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
  <script src="./layui/layui.js"></script>
  <script type="text/javascript" src="js/demo.js"></script>
</head>
<script type="text/javascript" src="layui/lay/modules/element.js"></script>
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
			var bili=2.5/1;
			$(element).css("height",width*bili);
			})
		}
	layui.use('layer',function(){
	});
</script>

</head>
<body style="margin:0px;" bgcolor="#F8F8F8" >
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
  <li class="layui-nav-item "><a href="help.jsp" class="layui-icon">&#xe705;帮助</a></li>
  <%if(user.getId() != 0){ 
  MessageDaoImpl messageDao = DaoFactory.getMessageDao();
  List<Message> messages = messageDao.loadWithCondition(user.getId(),Message.UNREAD);
  System.out.println(messages.size());
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
<!-- 搜索框 -->
<div align="center" style="margin-top:3%">
	<form action="select_result.jsp">
	<span style="font-size:30px;font-weight:bold;font-family:'汉仪平安行简';color:#FF0000;">爱尚转赚</span>
	    <!-- <input name="key" type="text" style="width:600px ; height:30px;" align="center"  placeholder="请输入关键字">-->
	    <input name="key" required="" lay-verify="required" placeholder="请输入关键字" autocomplete="off" class="layui-input" style="width: 50%;display:inline-block" type="text">
	    <button class="layui-btn layui-btn-normal" style="width: ;width: ;width: 5;width: 90px;">搜索</button>
	</form>
</div>

<%
	//接收从客户端传递过来的参数
	String goodname=good.getGoodname();
	double price=good.getPrice();
	String description=good.getDescription();
	int num=good.getNum();
	int goodownerid=good.getGoodownerid();
	double freight=good.getFreight();
	String imag[]=good.getImages();
	//获取该商品卖家信息
	UserDaoImpl userdao=new UserDaoImpl();
	User goodowner=userdao.load(goodownerid);
%>
<div style="width:60%;margin-left:auto;margin-right:auto;margin-top:20px;">
	<div style="float:left;width:45%;">
		<table border="0">
		<tr> 
		<td style="width:20%">
			<div class="layui-carousel" id="test1" style="width:20%;">
  			<div carousel-item id="content">
  		     <%        
  		       for(int i=0;i<imag.length;i++)
  		          {
  		         %>
                 <div > <img onload="javascript:showImg()" src='img/goods/<%=imag[i]%>' style="width:100%;"></div>
              	<%
              	}
              	%>
  				</div>
			</div>
			<script type="text/javascript">
			(function(){
				var p = {
					url:location.href, /*获取URL，可加上来自分享到QQ标识，方便统计*/
					desc:'', /*分享理由(风格应模拟用户对话),支持多分享语随机展现（使用|分隔）*/
					title:'', /*分享标题(可选)*/
					summary:'', /*分享摘要(可选)*/
					pics:'', /*分享图片(可选)*/
					flash: '', /*视频地址(可选)*/
					site:'', /*分享来源(可选) 如：QQ分享*/
					style:'102',
					width:63,
					height:24
				};
				var s = [];
				for(var i in p){
					s.push(i + '=' + encodeURIComponent(p[i]||''));
				}
				document.write(['<a href="http://connect.qq.com/widget/shareqq/index.html?',s.join('&'),'" target="_blank"><i class="fa fa-share"></i>分享到QQ</a>'].join(''));
			})();
			</script>
			<script src="http://connect.qq.com/widget/loader/loader.js" widget="shareqq" charset="utf-8"></script>
			<a style="float:right"><i class="fa fa-exclamation"></i>举报</a>
		</td>
		</tr>
			<tr>
				<td style="font-size:20px;width:20%;">
					<b>宝贝介绍：</b>
				</td>
			</tr>
			<tr>
				<td style="font-size:16px;width:20%;font-family:simsun;">
				 <%=description%>
				</td>
			</tr>
		</table>
	</div>
	<div style="width:5%;float:left;">&nbsp;</div>
	<form action="confirm_order.jsp" >
	<div style="float:left;width:45%;">
		<table border="0">
			<tr>
				<td style="font-family:楷体;font-size:20px; font-weight:bold"  >
					<%=goodname%>
				</td>
			</tr>
			<tr>
				<td style="font-family:simsun;font-size:17px;" height="40">价格:<b style="color:red;font-weight:bold;font-size:24px;"><i class="fa fa-yen"></i><%=price%></b></td>
			</tr>
			<tr>
				<td style="font-family:simsun;font-size:17px;" height="40">
					商品剩余：<%=num%>
				</td>
			</tr>
			<tr>
				<td style="font-family:simsun;font-size:17px;"height="40">
					卖家：<%=goodowner.getNickname()%>
					<a href="http://wpa.qq.com/msgrd?v=3&uin=<%=goodowner.getQq() %>&site=qq&menu=yes" style="font-size:16px;">联系卖家<i class="layui-icon" style="font-size:20px">&#xe63a;</i></a>
				</td>	
			</tr>
			
			<tr>
				<td style="font-family:simsun;font-size:17px;" height="40">
					联系方式：<%=goodowner.getMobilephone() %>
					
				</td>
			</tr>	
			<tr>
				<td style="font-family:simsun;font-size:17px;" height="40" >
					商家地址：<%=goodowner.getDormitory() %>栋<%=goodowner.getRoom() %>宿舍
				</td>
			</tr>

			<tr>
				<td style="font-family:simsun;font-size:17px;" height="30">
					商品邮费:<%=freight%>元
				</td>
			</tr>
			<tr>
				<td style="font-family:simsun;font-size:17px;"height="30">
					配送至:<%if(user.getId() == 0){ %>请<a href="login.jsp">登陆</a><%}else{ %><%=user.getDormitory() %>栋<%=user.getRoom() %>宿舍<%} %>
				</td>
			</tr>	
			<tr>
				<td valign="center" style="font-family:simsun;font-size:17x;"height="50">
					
					<div style="width:50%;">
						<span style="float:left">购买数量:</span>
						<button id="decrease">-</button>
						<input name="num" id="num" value="1">
						<input type="hidden" name="goodnum" value="<%=good.getNum() %>">
						<button id="increase">+</button>
					</div>
				</td>
			</tr>	
			<!-- <tr>
				<td>
				<p style="font-family:楷体;font-size:25px;">交易方式:	
				<select name="select" style="font-size:20px;">
					<option>线上交易</option>
					<option>线下交易</option>						
				</select></p>
				</td>
			</tr>	 -->
			<tr height="20px">
			</tr>			
			<tr >
				<td style="width:30%;">
					<input type="hidden" name="goodid" value="<%=good.getId() %>">
					<%
					//卖家是当前登录用户，禁用购买按钮
					if(user.getId() != goodownerid) {%>
					<button style="border-radius: 2px;border-style:solid;background-color:#FFCC99;border-width: 1px;cursor: pointer;display: inline-table;font-size: 18px;color:red;line-height: 39px;text-align: center;width: 134px;" type="submit" /><i class="layui-icon" id="buy">&#xe65e;</i>立即购买</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a onclick="addshoppingcart(<%=good.getId() %>)" id="addshoppingcart"><img src='img/购物车.png' border="0px"alt="Pulpit rock" width="35px" height="39px" >&nbsp;&nbsp;加入购物车</a>
					<%}else { %>
						<input title="你不能购买自己的商品" style="font-size:25px;" type="submit" disabled="disabled" value="立即购买" />
					<%} %>
				</td>
			</tr>
		</table>
	</div>                   
	</form>
</div>
<jsp:include page="foot.jsp"></jsp:include>
<script>
layui.use('carousel', function(){
  var carousel = layui.carousel;
  //建造实例
  carousel.render({
    elem: '#test1'
    ,width: '100%' //设置容器宽度
    ,arrow: 'hover' //始终显示箭头
    //,anim: 'updown' //切换动画方式
  });
});
</script>
</body>
</html>