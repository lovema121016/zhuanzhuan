<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<%
		String alipay = request.getParameter("alipay");
		System.out.println(alipay);
		
//加载上传文件组件
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext); //执行初始化操作   
		mySmartUpload.upload(); //加载文件数据
		File file = mySmartUpload.getFiles().getFile(0);
		//文件大小限制
		int size = 1024 * 1024 * 1024;
		
		//上传文件
		if (mySmartUpload.getFiles().getSize() > size) {  
	  	  out.println("文件大小必须 < 1024MB !");  
		} else {  
		    try { 
		    	//保存文件
				file.saveAs("../img/alipayQRcode/" + user.getId() + ".jpg");
				//更新用户数据
				user.setAlipay(alipay);
				System.out.println(file.getFieldName());
				UserDaoImpl userDao = DaoFactory.getUserDao();
				userDao.update(user);
				
		        out.print("<script>alert('成功保存');window.location.href='User.jsp';</script>");  

		    } catch (Exception e) {  
		        out.print(e.toString());  
		    }
		}

%>