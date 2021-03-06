package com.zhuanzhuan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.util.DBUtil;

public class OrderDaoImpl implements IOrderDao{

	@Override
	public void create(Order order) {
		Connection connection = DBUtil.getConnection();
		String sql = "INSERT INTO orders (serialnumber, buyerid, sellerid, goodid, time, status, num,freight,type,price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, order.getSerialnumber());
			ps.setInt(2, order.getBuyerid());
			ps.setInt(3, order.getSellerid());
			ps.setInt(4, order.getGoodid());
			ps.setTimestamp(5, order.getTime());
			ps.setInt(6, order.getStatus());
			ps.setInt(7, order.getNum());
			ps.setDouble(8, order.getFreight());
			ps.setInt(9, order.getType());
			ps.setDouble(10, order.getPrice());
			ps.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		
	}

	@Override
	public void update(Order order) {
		Connection connection = DBUtil.getConnection();
		String sql = "UPDATE orders SET "
				+ "buyerid=?, "
				+ "sellerid=?, "
				+ "goodid=?, "
				+ "time=?, "
				+ "status=?, "
				+ "num=?, "
				+ "freight=?, "
				+ "type=?, "
				+ "price=? "
				+ "WHERE id=?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, order.getBuyerid());
			ps.setInt(2, order.getSellerid());
			ps.setInt(3, order.getGoodid());
			ps.setTimestamp(4, order.getTime());
			ps.setInt(5, order.getStatus());
			ps.setInt(6, order.getNum());
			ps.setDouble(7, order.getFreight());
			ps.setInt(8, order.getType());
			ps.setDouble(9, order.getPrice());
			ps.setInt(10, order.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
	}

	@Override
	public void delete(Order order) {
		Connection connection = DBUtil.getConnection();
		PreparedStatement preparedStatement = null;
		String sql = "delete from orders where id=?";
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, order.getId());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
	}

	@Override
	public Order load(int id) {
		Order order = null;
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM orders WHERE id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			while(rs.next()) 
			{
				order = new Order();
				order.setBuyerid(rs.getInt("buyerid"));
				order.setGoodid(rs.getInt("goodid"));
				order.setId(id);
				order.setNum(rs.getInt("num"));
				order.setSellerid(rs.getInt("sellerid"));
				order.setSerialnumber(rs.getString("serialnumber"));
				order.setStatus(rs.getInt("status"));
				order.setTime(rs.getTimestamp("time"));
				order.setFreight(rs.getDouble("freight"));
				order.setType(rs.getInt("type"));
				order.setPrice(rs.getDouble("price"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return order;
	}

	@Override
	public List<Order> loadByBuyer(int buyerid,int status) {
		List<Order> orders = new ArrayList<Order>();
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM orders WHERE buyerid = ?";
		if(status != Order.ALL)
			sql = "SELECT * FROM orders WHERE buyerid = ? and status = ?";
		Order order = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, buyerid);
			if(status != Order.ALL)
				ps.setInt(2, status);
			rs = ps.executeQuery();
			while(rs.next()) 
			{
				order = new Order();
				order.setBuyerid(buyerid);
				order.setGoodid(rs.getInt("goodid"));
				order.setId(rs.getInt("id"));
				order.setNum(rs.getInt("num"));
				order.setSellerid(rs.getInt("sellerid"));
				order.setSerialnumber(rs.getString("serialnumber"));
				order.setStatus(rs.getInt("status"));
				order.setTime(rs.getTimestamp("time"));
				order.setPrice(rs.getDouble("price"));
				order.setType(rs.getInt("type"));
				order.setFreight(rs.getDouble("freight"));
				orders.add(order);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return orders;
	}

	@Override
	public List<Order> loadBySeller(int sellerid,int status) {
		List<Order> orders = new ArrayList<Order>();
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM orders WHERE sellerid = ?";
		if(status != Order.ALL)
			sql = "SELECT * FROM orders WHERE sellerid = ? and status = ?";
		Order order = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, sellerid);
			if(status != Order.ALL)
				ps.setInt(2, status);
			rs = ps.executeQuery();
			while(rs.next()) 
			{
				order = new Order();
				order.setBuyerid(rs.getInt("buyerid"));
				order.setGoodid(rs.getInt("goodid"));
				order.setId(rs.getInt("id"));
				order.setNum(rs.getInt("num"));
				order.setSellerid(sellerid);
				order.setSerialnumber(rs.getString("serialnumber"));
				order.setStatus(rs.getInt("status"));
				order.setTime(rs.getTimestamp("time"));
				order.setPrice(rs.getDouble("price"));
				order.setType(rs.getInt("type"));
				order.setFreight(rs.getDouble("freight"));
				orders.add(order);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return orders;
	}

	@Override
	public Order load(String serialnumber) {
		Order order = null;
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM orders WHERE serialnumber = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, serialnumber);
			rs = ps.executeQuery();
			while(rs.next()) 
			{
				order = new Order();
				order.setBuyerid(rs.getInt("buyerid"));
				order.setGoodid(rs.getInt("goodid"));
				order.setId(rs.getInt("id"));
				order.setNum(rs.getInt("num"));
				order.setSellerid(rs.getInt("sellerid"));
				order.setSerialnumber(serialnumber);
				order.setStatus(rs.getInt("status"));
				order.setTime(rs.getTimestamp("time"));
				order.setFreight(rs.getDouble("freight"));
				order.setType(rs.getInt("type"));
				order.setPrice(rs.getDouble("price"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return order;
	}
}
