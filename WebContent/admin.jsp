<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.zhuanzhuan.util.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增学生信息</title>
</head>
<%
	Connection con = null;
	PreparedStatement ps = null;
	int userid = 0;
	String realname = null;
	String major = null;
	try{
		userid = Integer.parseInt(request.getParameter("userid"));
		realname = request.getParameter("realname");
		major = request.getParameter("major");
	}catch(Exception e){
		
	}
	if(userid != 0 && realname != null && major != null){
		try{
			con = DBUtil.getConnection();
			String sql = "INSERT INTO `allstudents` (`id`, `name`, `major`) VALUES (?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setString(2, realname);
			ps.setString(3, major);
			ps.executeUpdate();
			out.println("添加成功！");
		}catch(Exception e){
			out.println("连接数据库出错！");
		}finally{
			if(ps != null)
				ps.close();
			if(con != null)
				con.close();
		}
	}
	
%>
<body>
	<form action="admin.jsp" method="get" style="width:80%;margin:auto">
		姓名：<input name="realname" />
		学号：<input name="userid" />
		专业：<input name="major" />
		<button>新增学生数据</button>
	</form>
</body>
</html>