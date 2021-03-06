package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.GoodStreamDaoImpl;
import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.model.GoodStream;
import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class SubmitGoodStreamServlet
 */
@WebServlet("/SubmitGoodStreamServlet")
public class SubmitGoodStreamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitGoodStreamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int orderid = 0;
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		try {
			orderid = Integer.parseInt(request.getParameter("orderid"));
			OrderDaoImpl orderDao = DaoFactory.getOrderDao();
			Order order = orderDao.load(orderid);
			if(order.getStatus() > Order.WAIT_TO_SEND)
			{
				writer.print("该订单已发货，请刷新页面");
				return;
			}
			GoodStreamDaoImpl goodStreamDao = DaoFactory.getGoodStreamDao();
			GoodStream goodStream = new GoodStream();
			goodStream.setCreateTime(new Timestamp(System.currentTimeMillis()));
			goodStream.setOrderid(orderid);
			goodStream.setStatus(0);
			System.out.println(goodStream);
			goodStreamDao.add(goodStream);
			writer.print("OK");
			return;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			writer.print("发生错误");
			e.printStackTrace();
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
