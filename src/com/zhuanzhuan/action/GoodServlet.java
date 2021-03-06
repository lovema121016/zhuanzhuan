package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.model.Good;

/**
 * ������ʾ��Ʒ��������
 * ����request���ԣ�
 * 	id����Ʒid
 * ����session���ԣ�
 * 	user����ǰ��¼�û�
 */
@WebServlet("/GoodServlet")
public class GoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = 0;		//��ƷID
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		String docType =
			      "<!doctype html public \"-//w3c//dtd html 4.0 " +
			      "transitional//en\">\n";
		try {
			// ���Դ�request��ȡid
			id = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {	// ������ֵ�����쳣
			writer.println(docType);
			writer.println("<html><head></head><body>���ݲ��Ϸ�!</body></html>");
			return;
		}
		GoodDaoImpl goodDao = new GoodDaoImpl();	// ��Ʒʵ����
		Good good = goodDao.load(id);				// ������Ʒ
		if(good == null) {		// ��������ڸ���Ʒ�����������Ϣ
			writer.println(docType);
			writer.println("<html><head></head><body>��Ʒ������!</body></html>");
		}else {
			request.setAttribute("good", good);		// ��request����good����
			// ����ת��
			RequestDispatcher rd = request.getRequestDispatcher("good_info.jsp");
			rd.forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
