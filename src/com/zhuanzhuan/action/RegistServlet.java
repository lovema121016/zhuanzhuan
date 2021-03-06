package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhuanzhuan.dao.MessageDaoImpl;
import com.zhuanzhuan.dao.UserDaoImpl;
import com.zhuanzhuan.model.Message;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;

/**
 * 处理注册请求：
 * 需要的request参数：
 * 	username：学号
 * 	nickname：昵称
 * 	mobilephone：手机
 * 	dormitory：宿舍楼
 * 	room：宿舍号
 * 	head：头像图片文件名
 * 	sex：性别
 * 	realname：真实姓名
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		UserDaoImpl userDao = DaoFactory.getUserDao(); 		// user实现类
		
		/***根据request参数创建一个user***/
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setNickname(request.getParameter("nickname"));
		user.setPassword(request.getParameter("password"));
		user.setMobilephone(request.getParameter("mobilephone"));
		user.setDormitory(request.getParameter("dormitory"));
		user.setRoom(request.getParameter("room"));
		user.setHead(request.getParameter("head"));
		user.setSex(request.getParameter("sex").equals("女"));
		user.setRealname(request.getParameter("realname"));
		user.setHead("head.JPG");
		/***创建user结束***/
		
		/***判断学号是否已存在***/
		if(userDao.load(String.valueOf(user.getUsername())) != null)
		{
			response.setContentType("text/html");
			/*String docType =
				      "<!doctype html public \"-//w3c//dtd html 4.0 " +
				      "transitional//en\">\n";*/
			PrintWriter writer = response.getWriter();
			writer.println("<script language='javascript'>alert('该学生已存在，请直接登录！');</script>");
			session.setAttribute("number", Integer.toString(user.getUsername()));
			writer.println("<script language='javascript'>top.location.href='login.jsp';</script>");
			return;
		}
		/***判断学号是否已存在结束***/
		
		/***学号+姓名核验***/
		if(!userDao.valid(user))
		{
			response.setContentType("text/html");
			PrintWriter writer = response.getWriter();
			writer.println("<script language='javascript'>alert('该学生不存在，请核实详细信息！');history.go(-1);</script>");
			return;
		}
		/***学号+姓名核验结束***/
		
		userDao.add(user);	// 注册验证通过，将user添加至数据库
		request.setAttribute("user", user);		// 为请求设置user属性
		
		// 转发请求
		session.setAttribute("number", Integer.toString(user.getUsername()));
		PrintWriter writer = response.getWriter();
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		Message message = new Message();
		message.setTitle("注册成功提醒");
		message.setSenduserid(0);
		user = userDao.load(Integer.toString(user.getUsername()));
		message.setReciveuserid(user.getId());
		message.setContent("注册成功！请尽快绑定支付宝和QQ，以免为将来的操作带来不便，具体方法请参看帮助。");
		messageDao.add(message);
		response.setContentType("text/html");
		writer.println("<script language='javascript'>alert('注册成功！请尽快绑定支付宝和QQ！');</script>");
		writer.println("<script language='javascript'>top.location.href='login.jsp';</script>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
