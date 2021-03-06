package com.zhuanzhuan.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.MessageDaoImpl;
import com.zhuanzhuan.model.Message;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class MessageServlet
 */
@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int status = -1;
		int receiveid = 0;
		try {
			status = Integer.parseInt(request.getParameter("status"));
			receiveid = Integer.parseInt(request.getParameter("receiveid"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		List<Message> messages = messageDao.loadWithCondition(receiveid, status);
		request.setAttribute("messages", messages);
		RequestDispatcher rd = request.getRequestDispatcher("msglist.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
