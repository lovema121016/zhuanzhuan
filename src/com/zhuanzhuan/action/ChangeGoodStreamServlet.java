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
		// ��ȡ��ǰ�û�
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		// ������Ϣʵ��
		GoodStreamDaoImpl goodStreamDao = DaoFactory.getGoodStreamDao();
		CourierDaoImpl courierDao = DaoFactory.getCourierDao();
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();
		UserDaoImpl userDao = DaoFactory.getUserDao();
		int streamid = 0;
		int status = -1;
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		try {
			streamid = Integer.parseInt(request.getParameter("streamid"));					//�������
			status = Integer.parseInt(request.getParameter("status"));						//����״̬
			GoodStream goodStream = goodStreamDao.load(streamid);							//����������Ϣ
			Order order = orderDao.load(goodStream.getOrderid());
			User buyer = userDao.load(order.getBuyerid());
			if(status == GoodStream.WAIT_TO_RECEIVE)
			{
				goodStream.setDeliverid(user.getId());										//���ÿ��ԱID
				goodStream.setSendTime(new Timestamp(System.currentTimeMillis()));			//���ýӵ�ʱ��
				writer.println("�ӵ��ɹ���");
				ValidCodeUtil.sendSMS(order.getSerialnumber(), goodStream.getId(), buyer.getMobilephone());
			}
			else if(status == GoodStream.FINISH) 
			{
				goodStream.setReceiveTime(new Timestamp(System.currentTimeMillis()));		//����ǩ��ʱ��
				goodStreamDao.update(goodStream);
				Courier courier = courierDao.load(user.getId());
				courier.setSalary(courier.getSalary() + 1);
			}
			goodStream.setStatus(status);		//��������״̬
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
