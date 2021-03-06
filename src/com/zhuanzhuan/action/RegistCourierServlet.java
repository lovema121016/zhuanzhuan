package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhuanzhuan.dao.CourierDaoImpl;
import com.zhuanzhuan.model.Courier;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class RegistCourierServlet
 */
@WebServlet("/RegistCourierServlet")
public class RegistCourierServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistCourierServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int userid = 0;
		String verify = null;
		String realverify = null;
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		CourierDaoImpl courierDao = DaoFactory.getCourierDao();
		try {
			userid = user.getId();
			verify = request.getParameter("verify");
			realverify = (String)session.getAttribute("rand");
			Courier courier = courierDao.load(userid);
			if (courier != null) {
				writer.print("������\"��ʹ���\"��Ա�������ٴ�����");
				return;
			}
			
			System.out.println("�û�������֤�룺" + verify);
			System.out.println("ʵ����֤�룺" + realverify);
			
		} catch (NumberFormatException e) {
			System.out.println(e.getMessage());
			writer.print("����");
			e.printStackTrace();
			return;
		}
		try {
			if(verify.equals(realverify)) {
				Courier courier = new Courier();
				courier.setCourierid(userid);
				courier.setSalary(0);
				courier.setStatus(1);
				courierDao.add(courier);
				writer.print("����ɹ���");
			}else {
				writer.print("��֤�����");
			}
		} catch (NullPointerException e) {
			System.out.println(e.getMessage());
			writer.print("��������");
			e.printStackTrace();
			return;
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
