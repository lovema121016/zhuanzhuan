<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="../layer/layer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更改支付宝</title>
</head>
<body>
	<%
		
		//加载上传文件组件
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext); //执行初始化操作   
		mySmartUpload.upload(); //加载文件数据
		
		String alipay = mySmartUpload.getRequest().getParameter("alipay");
		if(mySmartUpload.getFiles().getSize() != 0){
			System.out.println("size:" + mySmartUpload.getFiles().getCount());
			File file = mySmartUpload.getFiles().getFile(0);
			//文件大小限制
			int size = 1024 * 1024 * 1024;
			
			//上传文件
			if (mySmartUpload.getFiles().getSize() > size) {  
		  	  	out.println("文件大小必须 < 1024MB !");  
			} else {  
			    try { 
			    	//保存文件
					file.saveAs("/img/alipayQRcode/" + user.getId() + ".jpg");
					//更新用户数据
					user.setAlipay(alipay);
					System.out.println(file.getFieldName());
					UserDaoImpl userDao = DaoFactory.getUserDao();
					userDao.update(user);
					
			    } catch (Exception e) {  
			        out.print(e.toString()); 
			        e.printStackTrace();
			    }
			}
		}
		//String img = request.getParameter("nam");
		//System.out.print(img);
		UserDaoImpl userDao = DaoFactory.getUserDao();
		user.setAlipay(alipay);
		userDao.update(user);
		out.print("<script>alert('保存成功！');window.top.location.href='User.jsp';</script>");
	%>
</body>
</html>