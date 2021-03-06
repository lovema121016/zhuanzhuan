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
 * ����ע������
 * ��Ҫ��request������
 * 	username��ѧ��
 * 	nickname���ǳ�
 * 	mobilephone���ֻ�
 * 	dormitory������¥
 * 	room�������
 * 	head��ͷ��ͼƬ�ļ���
 * 	sex���Ա�
 * 	realname����ʵ����
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		UserDaoImpl userDao = DaoFactory.getUserDao(); 		// userʵ����
		
		/***����request��������һ��user***/
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setNickname(request.getParameter("nickname"));
		user.setPassword(request.getParameter("password"));
		user.setMobilephone(request.getParameter("mobilephone"));
		user.setDormitory(request.getParameter("dormitory"));
		user.setRoom(request.getParameter("room"));
		user.setHead(request.getParameter("head"));
		user.setSex(request.getParameter("sex").equals("Ů"));
		user.setRealname(request.getParameter("realname"));
		user.setHead("head.JPG");
		/***����user����***/
		
		/***�ж�ѧ���Ƿ��Ѵ���***/
		if(userDao.load(String.valueOf(user.getUsername())) != null)
		{
			response.setContentType("text/html");
			/*String docType =
				      "<!doctype html public \"-//w3c//dtd html 4.0 " +
				      "transitional//en\">\n";*/
			PrintWriter writer = response.getWriter();
			writer.println("<script language='javascript'>alert('��ѧ���Ѵ��ڣ���ֱ�ӵ�¼��');</script>");
			session.setAttribute("number", Integer.toString(user.getUsername()));
			writer.println("<script language='javascript'>top.location.href='login.jsp';</script>");
			return;
		}
		/***�ж�ѧ���Ƿ��Ѵ��ڽ���***/
		
		/***ѧ��+��������***/
		if(!userDao.valid(user))
		{
			response.setContentType("text/html");
			PrintWriter writer = response.getWriter();
			writer.println("<script language='javascript'>alert('��ѧ�������ڣ����ʵ��ϸ��Ϣ��');history.go(-1);</script>");
			return;
		}
		/***ѧ��+�����������***/
		
		userDao.add(user);	// ע����֤ͨ������user��������ݿ�
		request.setAttribute("user", user);		// Ϊ��������user����
		
		// ת������
		session.setAttribute("number", Integer.toString(user.getUsername()));
		PrintWriter writer = response.getWriter();
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		Message message = new Message();
		message.setTitle("ע��ɹ�����");
		message.setSenduserid(0);
		user = userDao.load(Integer.toString(user.getUsername()));
		message.setReciveuserid(user.getId());
		message.setContent("ע��ɹ����뾡���֧������QQ������Ϊ�����Ĳ����������㣬���巽����ο�������");
		messageDao.add(message);
		response.setContentType("text/html");
		writer.println("<script language='javascript'>alert('ע��ɹ����뾡���֧������QQ��');</script>");
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
