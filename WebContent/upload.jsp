<%@page import="com.zhuanzhuan.util.IPTimeStampUtil"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.Files"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
		//加载文件上传组件
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(pageContext); //执行初始化操作   
		mySmartUpload.upload(); //加载文件数据
		
		//文件大小限制
		int size = 1024 * 1024 * 1024;
		Files files = mySmartUpload.getFiles();			//商品图片
		
		//使用IPTimeStampUtil生成文件名
		IPTimeStampUtil itTsu = new IPTimeStampUtil();
		String fileString = itTsu.getIPTimeRand() + "." + files.getFile(0).getFileExt();
		
		System.out.print(fileString);
		files.getFile(0).saveAs("/img/goods/" + fileString);
		
		System.out.println(files.getCount());
		response.setContentType("application/json; charset=utf-8");
		System.out.println("iii");
%>
{
  "code": 0
  ,"msg": ""
  ,"data": {
    "src": "<%=fileString %>"
  }
}       