package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.CourierDaoImpl;
import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.dao.GoodStreamDaoImpl;
import com.zhuanzhuan.dao.MessageDaoImpl;
import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.dao.UserDaoImpl;
import com.zhuanzhuan.model.Courier;
import com.zhuanzhuan.model.Good;
import com.zhuanzhuan.model.GoodStream;
import com.zhuanzhuan.model.Message;
import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class ChangeOrderServlet
 */
@WebServlet("/ChangeOrderServlet")
public class ChangeOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = 0;
		int status = 0;
		
		try {
			id = Integer.parseInt(request.getParameter("orderid"));
			status = Integer.parseInt(request.getParameter("status"));
		} catch (Exception e) {
			PrintWriter writer = response.getWriter();
			writer.print("ERROR");
		}
		//实现类
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();
		GoodStreamDaoImpl goodStreamDao = DaoFactory.getGoodStreamDao();
		CourierDaoImpl courierDao = DaoFactory.getCourierDao();
		Order order = orderDao.load(id);
		System.out.println("订单id：" + id);
		GoodStream goodStream = goodStreamDao.loadByOrderid(order.getId());
		//订单完成，待评价
		if(status == Order.WAIT_TO_REVIEW && goodStream != null)			
		{	//如果使用天使快递员，收货时，快递员工资+1
			goodStream.setReceiveTime(new Timestamp(System.currentTimeMillis()));		//设置签收时间
			goodStream.setStatus(GoodStream.FINISH);
			goodStreamDao.update(goodStream);
			System.out.println(goodStream);
			
			Courier courier = courierDao.load(goodStream.getDeliverid());
			courier.setSalary(courier.getSalary() + 1);
			courierDao.update(courier);
			System.out.println("courierid" + courier.getCourierid() + " " + "salary：" + courier.getSalary() + " status：" + courier.getStatus());
		}
		order.setStatus(status);
		orderDao.update(order);
		Message message = new Message();
		Message message2 = new Message();
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		UserDaoImpl userDao = DaoFactory.getUserDao();
		User user = userDao.load(order.getBuyerid());
		GoodDaoImpl goodDao = DaoFactory.getGoodDao();
		Good good = goodDao.load(order.getGoodid());
		message.setSenduserid(0);
		message2.setSenduserid(0);
		switch (status) {
		case Order.WATT_TO_RECEIVE_MONEY:
			message.setTitle("订单信息");
			message.setReciveuserid(order.getBuyerid());
			message.setContent("您的订单 订单号："+order.getSerialnumber()+"申请已发送，请耐心等待卖家确认。");
			messageDao.add(message);
			message2.setTitle("订单购买通知");
			message2.setReciveuserid(order.getSellerid());
			message2.setContent("用户（支付宝：" + user.getAlipay() + "）"+user.getNickname()+"购买了您的商品【"+good.getGoodname()+"】，订单号："+order.getSerialnumber()+"，请尽快确认。");
			messageDao.add(message2);
			break;
		case Order.WAIT_TO_SEND:
			message.setTitle("订单信息");
			message.setReciveuserid(order.getSellerid());
			message.setContent("订单"+order.getSerialnumber()+"已确认收款，请尽快发货。");
			messageDao.add(message);
			break;
		case Order.WAIT_TO_RECEIVE:
			message.setTitle("发货通知");
			message.setReciveuserid(order.getSellerid());
			message.setContent("订单"+order.getSerialnumber()+"发货成功！请耐心等待买家确认收货。");
			messageDao.add(message);
			message2.setTitle("发货通知");
			message2.setReciveuserid(order.getBuyerid());
			message2.setContent("您的订单 订单号："+order.getSerialnumber()+"卖家已发货，请保持手机畅通。");
			messageDao.add(message2);
			break;
		case Order.WAIT_TO_REVIEW:
			message.setTitle("订单信息");
			message.setReciveuserid(order.getBuyerid());
			message.setContent("您的订单 订单号："+order.getSerialnumber()+"收货成功，请尽快评价！");
			messageDao.add(message);
			message2.setTitle("订单信息");
			message2.setReciveuserid(order.getSellerid());
			message2.setContent("订单 订单号："+order.getSerialnumber()+"，买家已收货，请耐心等待评价。");
			messageDao.add(message2);
			break;
		default:
			break;
		}
		System.out.println("订单id：" + request.getParameter("orderid"));
		System.out.println("status：" + request.getParameter("status"));
		PrintWriter writer = response.getWriter();
		writer.print("OK");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
