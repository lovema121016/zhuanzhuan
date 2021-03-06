<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Good"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品搜索结果页面</title>
<link rel="stylesheet" href="layui/css/layui.css"/>
<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript">
	layui.use('form',function(){
		
	});
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
	<%
	GoodDaoImpl gooddao = DaoFactory.getGoodDao();
	UserDaoImpl userDao = DaoFactory.getUserDao();
	//接收传递过来的关键词
	double small_price = 0;				//默认最小价格为0
	double big_price = 2147483647;		//最大为2147483647;
	String key = null;	//获取关键字
	String catagory = null;				//分类
	try{
		key = request.getParameter("key").trim();
	}catch(Exception e){
		key = "";
	}
	
	try{		//分类可能不存在，捕捉该异常
		catagory = request.getParameter("catagory").trim();
	}catch(Exception e){
		catagory = "";
	}
	try{		//最小价格可能不存在，捕捉异常
		small_price = Double.parseDouble(request.getParameter("small_price"));
	}catch(Exception e){
		System.out.println("最小价格解析出错！");
	}
	try{		//最大价格可能不存在，捕捉异常
		big_price = Double.parseDouble(request.getParameter("big_price"));
	}catch(Exception e){
		System.out.println("最大价格解析出错！");
	}

	System.out.println("key:" + key);
	System.out.println("catagory:" + catagory);
	System.out.println("small:" + small_price);
	System.out.println("big:" + big_price);
	//根据关键词去数据库查找相关产品，返回List对象
	List<Good> goods=gooddao.loadWithCondition(key, catagory, small_price, big_price);
/* 	//对商品搜索结果进行详细筛选
	List<Good> goods2=new ArrayList<Good>();
	if(("".equals(catagory)||catagory==null)&&small_price==0&&big_price==0)
	{
		 goods2=goods;
	}
	if(("".equals(catagory)||catagory==null)&&small_price!=0&&big_price!=0)
	{	
		for(int i=0;i<goods.size();i++)
		{
			if(goods.get(i).getPrice()<=big_price&&goods.get(i).getPrice()>=small_price)
			{
				goods2.add(goods.get(i));
			}
		}
		
	}
	if(("".equals(catagory)||catagory==null)&&small_price!=0&&big_price==0)
	{
		for(int i=0;i<goods.size();i++)
		{
			if(goods.get(i).getPrice()>=small_price)
			{
				goods2.add(goods.get(i));
			}
		}		
	}
	if(("".equals(catagory)||catagory==null)&&small_price==0&&big_price!=0)
	{
		for(int i=0;i<goods.size();i++)
		{
			if(goods.get(i).getPrice()<=big_price)
			{
				goods2.add(goods.get(i));
			}
		}		
	}
	if((!"".equals(catagory)||catagory==null)&&small_price==0&&big_price==0)
	{
		for(int i=0;i<goods.size();i++)
		{
			if(goods.get(i).getCatagory().equals(catagory))
			{
				goods2.add(goods.get(i));
			}
		}			
	}
	if((!"".equals(catagory)||catagory==null)&&small_price!=0&&big_price!=0)
	{
		for(int i=0;i<goods.size();i++)
		{
			if(goods.get(i).getCatagory().equals(catagory)&&goods.get(i).getPrice()<=big_price&&goods.get(i).getPrice()>=small_price)
			{
				goods2.add(goods.get(i));
			}
		}		
	}
	if((!"".equals(catagory)||catagory==null)&&small_price!=0&&big_price==0)
	{
		for(int i=0;i<goods.size();i++)
		{
			if(goods.get(i).getCatagory().equals(catagory)&&goods.get(i).getPrice()>=small_price)
			{
				goods2.add(goods.get(i));
			}
		}		
	}
	if((!"".equals(catagory)||catagory==null)&&small_price==0&&big_price!=0)
	{
		for(int i=0;i<goods.size();i++)
		{
			if(goods.get(i).getCatagory().equals(catagory)&&goods.get(i).getPrice()<=big_price)
			{
				goods2.add(goods.get(i));
			}
		}		
	} */
	%>
	<form action="select_result.jsp" method="get" class="layui-form">
		<div class="layui-form-item">
			<label class="layui-form-label">关键字</label>
			<div class="layui-input-block">
				<input type="text" name="key" lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" value="<%=key %>" style="margin-top:20px;width:30%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">分类</label>
			<div class="layui-input-block" style="width:28%;">
				<select name="catagory">
					<option></option>	
					<option>办公用品</option>
					<option>游戏设备</option>
					<option>数码产品</option>
					<option>图书音像</option>
					<option>运动户外</option>
					<option>玩具乐器</option>
					<option>五金工具</option>
					<option>居家日用</option>	
					<option>园艺植物</option>	
					<option>服饰/配件</option>	
					<option>电子零件</option>	
					<option>工艺礼品</option>
					<option>其它闲置</option>	
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
			
				<label class="layui-form-label">价格(元):</label>
				<div class="layui-input-inline" style="width:20%;">
					<input type="text" name="small_price" placeholder="￥" class="layui-input"/>
				</div>
				<div class="layui-form-mid">-</div>
				<div class="layui-input-inline" style="width:20%;">
					<input type="text" name="big_price" placeholder="￥" class="layui-input"/>
				</div>
				<div class="layui-form-mid"><button class="layui-btn" style="position: relative;top: -7px;">筛选</button></div>
			</div>
		</div>
	</form>
<%-- 	<table align="center" border="1" style="border-color:transparent;font-size:20px;font-family:楷体">
		<tr style="border-color:transparent;height:80px">
		</tr>

<% 
   
   for(int i=0;i<goods2.size();i+=2)
   {
	   
%>
	
		<tr style="border-color:pink;border-style:groove;border-width:thick;">
			<td  style="width:600px;height:600px;border-style:groove;">
			<div align="center">
				<img src='img/goods/<%=goods2.get(i).getImages()[0]%>'alt="Pulpit rock" width="40%" height="60%" >
			</div><br>	
				<a href="Good?id=<%=goods2.get(i).getId()%>">商品名称:<%=goods.get(i).getGoodname()%></a><br>
				商品价格:<%=goods2.get(i).getPrice() %><br>
				商品介绍:<%=goods2.get(i).getDescription()%>
			</td>
			
				<td style="width:200px;border-color:transparent">
				
				</td>
				<%
				if(i<goods2.size()-1)
				{
				%>
		
			<td style="width:600px;height:600px;border-style:groove;">
			<div align="center">
				<img src='img/goods/<%=goods2.get(i+1).getImages()[0]%>'alt="Pulpit rock" width="30%" height="40%">
			</div><br>
				<a href="Good?id=<%=goods2.get(i+1).getId()%>">商品名称:<%=goods.get(i+1).getGoodname()%></a><br>
				商品价格：<%=goods2.get(i+1).getPrice()%><br>
				商品介绍:<%=goods2.get(i+1).getDescription()%>			
			</td>
			<%
				}
				else
				{
					continue;
				}
			%>
		</tr>
		<tr style="border-color:transparent;height:80px">
		</tr>
		
	
	<%  
	} 
	%>
</table> --%>
	<table class="layui-table" style="width:80%;margin-left:auto;margin-right:auto;">
		<tbody>
		<%
			for(Good good:goods){
				User goodowner = userDao.load(good.getGoodownerid());
		%>
				<tr>
					<td><img alt="<%=good.getGoodname() %>" src="img/goods/<%=good.getImages()[0] %>" width="100px;"></td>
					<td>
						<p style="font-weight:bold;font-size:20px;"><a href="Good?id=<%=good.getId()%>"><%=good.getGoodname() %></a></p>
						<p style="font-size:16px;color:red;font-weight:bold;">￥<%=good.getPrice() %></p>
						<p><%=good.getDescription() %></p>
					</td>
					<td width="110" align="center"><img src="img/header/<%=goodowner.getHead()%>" style="width: 50px;border-radius: 25px;"/><br/><%=goodowner.getNickname() %></td>
				</tr>
			<%} %>
		</tbody>
	</table>
	
	<%
		if(goods.size() == 0){
	%>
		<h2 style="margin-left:50px;">很遗憾，没有找到您想要的商品！</h2>
	<%
		}
	%>
</body>
</html>
<% //List<Good>%>