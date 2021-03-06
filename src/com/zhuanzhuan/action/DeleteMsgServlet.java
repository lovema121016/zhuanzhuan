package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.zhuanzhuan.dao.MessageDaoImpl;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class deletemsg
 */
@WebServlet("/deletemsg")
public class DeleteMsgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteMsgServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String reciveid = request.getParameter("reciveid").trim();
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		messageDao.deleteByReciveId(Integer.parseInt(reciveid));
		PrintWriter writer = response.getWriter();
		writer.println("<script>layer.alert('²Ù×÷³É¹¦!')</script>");
		writer.println("<script>window.location.href='message.jsp'</script>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
