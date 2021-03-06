package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhuanzhuan.dao.CourierDaoImpl;
import com.zhuanzhuan.dao.GoodStreamDaoImpl;
import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.dao.UserDaoImpl;
import com.zhuanzhuan.model.Courier;
import com.zhuanzhuan.model.GoodStream;
import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;
import com.zhuanzhuan.util.ValidCodeUtil;

/**
 * Servlet implementation class ChangeGoodStreamServlet
 */
@WebServlet("/ChangeGoodStreamServlet")
public class ChangeGoodStreamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeGoodStreamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 获取当前用户
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		// 物流信息实现
		GoodStreamDaoImpl goodStreamDao = DaoFactory.getGoodStreamDao();
		CourierDaoImpl courierDao = DaoFactory.getCourierDao();
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();
		UserDaoImpl userDao = DaoFactory.getUserDao();
		int streamid = 0;
		int status = -1;
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		try {
			streamid = Integer.parseInt(request.getParameter("streamid"));					//物流编号
			status = Integer.parseInt(request.getParameter("status"));						//物流状态
			GoodStream goodStream = goodStreamDao.load(streamid);							//加载物流信息
			Order order = orderDao.load(goodStream.getOrderid());
			User buyer = userDao.load(order.getBuyerid());
			if(status == GoodStream.WAIT_TO_RECEIVE)
			{
				goodStream.setDeliverid(user.getId());										//设置快递员ID
				goodStream.setSendTime(new Timestamp(System.currentTimeMillis()));			//设置接单时间
				writer.println("接单成功！");
				ValidCodeUtil.sendSMS(order.getSerialnumber(), goodStream.getId(), buyer.getMobilephone());
			}
			else if(status == GoodStream.FINISH) 
			{
				goodStream.setReceiveTime(new Timestamp(System.currentTimeMillis()));		//设置签收时间
				goodStreamDao.update(goodStream);
				Courier courier = courierDao.load(user.getId());
				courier.setSalary(courier.getSalary() + 1);
			}
			goodStream.setStatus(status);		//更改物流状态
			goodStreamDao.update(goodStream);
		} catch (Exception e) {
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
