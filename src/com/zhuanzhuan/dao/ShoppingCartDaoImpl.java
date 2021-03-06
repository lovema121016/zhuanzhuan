package com.zhuanzhuan.dao;

import java.util.List;

import com.zhuanzhuan.model.ShoppingCart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.zhuanzhuan.util.DBUtil;
public class ShoppingCartDaoImpl implements IShoppingCartDao{
	@Override
	public void add(ShoppingCart shoppingCart) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		String sql = "INSERT INTO shoppingcart (id,goodid,userid) VALUES (?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, shoppingCart.getId());
			ps.setInt(2, shoppingCart.getGoodid());
			ps.setInt(3, shoppingCart.getUserid());
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
	public void delete(ShoppingCart shoppingCart) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		String sql = "DELETE FROM shoppingcart WHERE id = ?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1,id);
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
	public List<ShoppingCart> loadByBuyer(int userid) {
		// TODO Auto-generated method stub
		List<ShoppingCart> shoppingCarts = new  ArrayList<ShoppingCart>();//����һ������
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM shoppingcart WHERE userid = ?";
		ShoppingCart shoppingCart = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, userid);
			rs = ps.executeQuery();
			while(rs.next())
			{
			    shoppingCart = new ShoppingCart();
			    shoppingCart.setUserid(userid);
			    shoppingCart.setGoodid(rs.getInt("goodid"));
			    shoppingCart.setId(rs.getInt("id"));
			    shoppingCarts.add(shoppingCart);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return shoppingCarts;
	}
    
}
