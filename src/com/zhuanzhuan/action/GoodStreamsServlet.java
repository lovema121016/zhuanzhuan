package com.zhuanzhuan.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.GoodStreamDaoImpl;
import com.zhuanzhuan.model.GoodStream;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class GoodStreamsServlet
 */
@WebServlet("/GoodStreamsServlet")
public class GoodStreamsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoodStreamsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int status = 0;				//请求状态
		int courierid = 0;			//请求快递员id
		try {
			status = Integer.parseInt(request.getParameter("status"));
			courierid = Integer.parseInt(request.getParameter("courierid"));
		} catch (Exception e) {
			//e.printStackTrace();
			System.out.println("courierid空指针，不用获取，忽略该错误");
		}
		//物流实现类
		GoodStreamDaoImpl goodStreamDao = DaoFactory.getGoodStreamDao();
		//物流信息列表
		List<GoodStream> goodStreams = null;
		//如果未获取到快递员id
		if(courierid == 0)
		{
			//调试输出
			System.out.println("GoodStreamsServlet：\n"
					+ "courierid：" + courierid + "\nstatus：" + status);
			goodStreams = goodStreamDao.loadByStatus(status);
			request.setAttribute("goodStreams", goodStreams);
		}else {
			System.out.println("GoodStreamsServlet：\n"
					+ "courierid：" + courierid + "\nstatus：" + status);
			goodStreams = goodStreamDao.load(courierid, status);
			request.setAttribute("goodStreams", goodStreams);
		}
		//请求转发
		RequestDispatcher rd = request.getRequestDispatcher("goodstream.jsp");
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
