package com.zhuanzhuan.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.zhuanzhuan.dao.UserDaoImpl;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet Filter implementation class CookiesFilter
 */
@WebFilter("/CookiesFilter")
public class CookiesFilter implements Filter {

    /**
     * Default constructor. 
     */
    public CookiesFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		/****从session加载user****/
		User user = null;
		
		HttpSession session = ((HttpServletRequest)request).getSession();
		user =  (User)session.getAttribute("user");
		
		if(user == null) {		//如果user为null尝试从Cookie加载user
			Cookie[] cookies = ((HttpServletRequest)request).getCookies();
			UserDaoImpl userDao = DaoFactory.getUserDao();
			if(cookies != null) 	//如果Cookie不为null
			{
				for(int i = 0;i < cookies.length;i++) 	//遍历Cookie
				{	
					if(cookies[i].getName().equals("user"))	//如果第i+1个cookie为user	
					{
						user = userDao.load(Integer.parseInt(cookies[i].getValue()));	//ͨ从cookie加载user
					}	//如果：cookies[i].equals("user")
				}	//for循环：遍历cookie
			}	//如果：cookies不为空
			session.setAttribute("user", user);
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
