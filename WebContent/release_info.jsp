<%@page import="com.zhuanzhuan.util.IPTimeStampUtil"%>
<%@page import="com.jspsmart.upload.Files"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.awt.print.Printable"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Good"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>    
    <%
    //获取从客户端传递过来的参数
    String goodname = null;
    int goodownerid = 0;
    double price = 0;
    String description = null;
    int num = 0;
    double freight = 0;
    String catagory = null;
	String images = null;
    try{
    	goodname=request.getParameter("goodname");
    	goodownerid=user.getId();
    	price=Double.parseDouble(request.getParameter("price"));
    	description=request.getParameter("description");
    	num=Integer.parseInt(request.getParameter("num"));
    	freight=Double.parseDouble(request.getParameter("freight"));
    	catagory=request.getParameter("catagory");
    	images=request.getParameter("nam");
    }catch(Exception e){
    	System.out.println(e.getMessage());
    	e.printStackTrace();
    }
    	
   //添加进数据库
   if(goodname != null){
    	Good good=new Good();
    	good.setGoodname(goodname);
    	good.setGoodownerid(goodownerid);
    	good.setPrice(price);
    	good.setNum(num);
    	good.setFreight(freight);
    	good.setCatagory(catagory);
    	good.setDescription(description);
    	good.setImages(images);
    	System.out.println(good.toString());
    	GoodDaoImpl goodDao=DaoFactory.getGoodDao();
    	try{
    		
    		goodDao.add(good);
    		//重定向
    		response.sendRedirect("center/released_goods.jsp");
    	%>
    		
    	<%
    		}catch(Exception e){
    	%>
    		<h2 style="color:red ; font-size:50px">发生错误 : <%=e.getMessage() %></h2>
    		<%
    		}
   }
    		%>
