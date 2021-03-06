<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.sun.org.apache.xerces.internal.util.Status"%>
<%@page import="com.zhuanzhuan.model.Good"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@page import="com.zhuanzhuan.model.ShoppingCart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<%
// 加载购物车列表
List<ShoppingCart> shoppingCarts = (List<ShoppingCart>) request.getAttribute("shoppingCarts");
if(shoppingCarts == null)
{
	System.out.println("空");
	return ;
}
// 商品实现类
GoodDaoImpl goodDao = DaoFactory.getGoodDao(); 
UserDaoImpl userDao = DaoFactory.getUserDao();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/demo.js"></script>
<title>购物车</title>
</head>
<body style="margin: 0px;">
<jsp:include page="../header.jsp"></jsp:include>
<div id="functionmenu" style="float: left">
	<ul style="padding: 0px;margin-top: 0px;font-family:'微软雅黑'">
		<a href="buyer_orders.jsp"><li>我购买的商品</li></a>
		<a href="seller_orders.jsp"><li>出售订单</li></a>
		<a href="released_goods.jsp"><li>我发布的商品</li></a>
		<a href="javascript:;"><li><b>购物车</b></li></a>
		<a href="User.jsp" onclick="personimg()"><li>个人资料</li></a>
		<a href="buy_history.jsp"><li>购买历史</li></a>
		<a href="sell_history.jsp"><li>出售历史</li></a>
	</ul>	
</div>
	<style>
		.nav{
			margin: 0 auto;
			bottom: 0;
			background-color:#E5E5E5;
			/*line-height:*/
			position: fixed;
	        left: 300px;
	        bottom:0px;
	        width: 900px;
	        z-index: 2;
		}
		.account{
			float: right;
			height: 50px;
			background-color: #FF4400;
			border: navajowhite;
			font-size: 20px;
			color: white;
			padding: 10px;
			padding-left: 24px;
			padding-right:24px;
			cursor:pointer;
		}
		@font-face
		{
		    font-family: 汉仪平安行简;
		    src: url(font-awesome-4.7.0/fonts/汉仪平安行简.woff);
		}
		@font-face
		{
		    font-family: 方正粗倩简体;
		    src: url('../font-awesome-4.7.0/fonts/FZCQJW.woff');
		}
		</style>
	<script type="text/javascript" src="js/jquery-2.1.0.js" ></script>
	<script>
		function checkboxed(objName){
			var objNameList=document.getElementsByName(objName)
			if(null!=objNameList)
			{
			      for(var i=0;i<objNameList.length;i++)
			     {
				   objNameList[i].checked="checked";
			     }
			      x=document.getElementByTd("demo");
			      x.style.color="yellow";
			}
		}
		function uncheckboxed(objName){
			var objNameList=document.getElementsByName(objName)
			if(null!=objNameList)
			{
			      for(var i=0;i<objNameList.length;i++)
			     {
				   objNameList[i].checked="";
			     }
			}
		}
		function deleteShoppingCart(){
			var objNameList=document.getElementsByName('checkbox');
			if(null!=objNameList)
			{
				layer.confirm('确认删除所选内容吗？',{btn:['确认','取消']},function(){
					for(var i=0;i<objNameList.length;i++)
				     {
					  	 if(objNameList[i].checked == true)
					  	 	deleteshoppingcart(objNameList[i].value);
				     }
					layer.msg("删除成功",{anim: 0,time:1500},function(){
						location.reload();
					});
				},function(){
					
				});
			      
			}
			
		}
	</script>
	<img alt="转赚" src="../img/logo-title.png" style="width: 33px;margin-top: 18px;"><b style="position: relative;top: 10px;font-size: 20px;font-family: 方正粗倩简体;color: #C01B00;">购物车</b>
	<% 
	for(ShoppingCart shoppingcart:shoppingCarts)		// 遍历输出
	{
		//获取商品信息
		System.out.println(shoppingcart.getGoodid());
		Good good = goodDao.load(shoppingcart.getGoodid());
		User goodowner = null;//卖家
		User buyer = null;//买家
		goodowner = userDao.load(good.getGoodownerid()); 
		buyer = userDao.load(shoppingcart.getUserid());
	%>
    <div style="padding-left:300px;">
	<p><input type="checkbox" name="checkbox" value=<%=shoppingcart.getId() %>><%=goodowner.getNickname() %></p>
	<hr>
	<p><a href="../Good?id=<%=good.getId()%>"><img border="0" src="../img/goods/<%=good.getImagesStr() %>" style="height:100px;width:100px;" ></a></p>
	<p><%=good.getGoodname() %></p>
	</div>
	<%} 
	if(shoppingCarts.size() == 0){	
	%>
		<div style="margin-top:13%">
			<img alt="" src="../img/shoppingcart.png" style="float:left;margin-left:6%;">
			<div style="float:left">
				<h2 style="font:700 14px arial">您的购物车还是空的，赶紧行动吧!您可以：</h2>
				<br>
				<p style="font-size:14px;">看看 <a href="../index.jsp">其它宝贝</a><br/>
				看看 <a href="buyer_orders.jsp">已买到的宝贝</a></p>
			</div>
		</div>
	<%} else{%>
	
	<p class="nav" >
	  <a style="position:relative;top:14px;margin-left:10px;" onclick="checkboxed('checkbox')">全选</button>&nbsp;&nbsp;
	  <a style="position:relative;top:14px;" onclick="uncheckboxed('checkbox')">取消全选</button>&nbsp;&nbsp;
	  <a style="position:relative;top:14px;" href="javascript:;" onclick="deleteShoppingCart()">删除</a>
	  <button class="account" onclick="window.location.href='buyer_orders.jsp'">结 算</button>
	</p>
	<%} %>
</body>
</html>