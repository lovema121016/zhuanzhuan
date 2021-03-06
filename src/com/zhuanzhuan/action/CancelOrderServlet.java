package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.dao.MessageDaoImpl;
import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.model.Good;
import com.zhuanzhuan.model.Message;
import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class CancelOrder
 */
@WebServlet("/CancelOrder")
public class CancelOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CancelOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();	// 订单实现类
		GoodDaoImpl goodDao = DaoFactory.getGoodDao();		// 商品实现类
		int id = 0;											// 订单id
		try {		//获取请求的订单id
			id = Integer.parseInt(request.getParameter("orderid"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		Order order = orderDao.load(id);	//加载订单
		Good good = goodDao.load(order.getGoodid());	//加载商品
		order.setStatus(Order.CANCEL);			//设置订单状态为“交易关闭”
		good.setNum(good.getNum() + order.getNum());  	//恢复商品数量
		goodDao.update(good);					//更新商品数据
		orderDao.delete(order);					//删除订单数据
		Message message = new Message();		//创建消息
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		message.setTitle("订单通知");
		message.setReciveuserid(order.getBuyerid());
		message.setContent("您已成功取消订单，订单号："+order.getSerialnumber());
		messageDao.add(message);				//发送消息
		response.setContentType("text/html");	//设置响应类型
		PrintWriter writer = response.getWriter();
		writer.print("OK");						//输出OK
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
