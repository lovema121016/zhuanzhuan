<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.zhuanzhuan.util.IPTimeStampUtil"%>
<%@page import="com.jspsmart.upload.Files"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传头像</title>
</head>
<body>
	<%
		//加载上传文件组件
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext); //执行初始化操作   
		mySmartUpload.upload(); //加载文件数据
		
		//文件大小限制
		int size = 1024 * 1024 * 1024;
		
		//使用IPTimeStampUtil生成文件名
		IPTimeStampUtil timeStampUtil = new IPTimeStampUtil();
		File file = mySmartUpload.getFiles().getFile(0);		//头像文件
		String header = timeStampUtil.getIPTimeRand() + "." + file.getFileExt();	//生成的文件名
		
		//上传文件
		if (mySmartUpload.getFiles().getSize() > size) {  
	  	  out.println("文件大小必须 < 1024MB !");  
		} else {  
		    try { 
		    	//保存文件
				file.saveAs("/img/header/" + header);
				//更新用户数据
				user.setHead(header);
				System.out.println(header);
				UserDaoImpl userDao = DaoFactory.getUserDao();
				userDao.update(user);
				
		        out.print("<script>alert('成功上传头像');window.location.href='User.jsp';</script>");  

		    } catch (Exception e) {  
		        out.print(e.toString());  
		    }
		}
	%>
{
  "code": 0
  ,"msg": ""
  ,"data": {
    "src": "http://cdn.layui.com/123.jpg"
  }
}   