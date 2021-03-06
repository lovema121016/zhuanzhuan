package com.zhuanzhuan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.zhuanzhuan.model.Good;
import com.zhuanzhuan.util.DBUtil;

public class GoodDaoImpl implements IGoodDao {

	@Override
	public void add(Good good) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		String sql = "INSERT INTO goods (goodname,goodownerid,price,description,image,num,catagory,freight) VALUES (?,?,?,?,?,?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, good.getGoodname());
			ps.setInt(2, good.getGoodownerid());
			ps.setDouble(3, good.getPrice());
			ps.setString(4, good.getDescription());
			ps.setString(5, good.getImagesStr());
			ps.setInt(6, good.getNum());
			ps.setString(7, good.getCatagory());
			ps.setDouble(8, good.getFreight());
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
	public void delete(Good good) {
		
	}

	@Override
	public void update(Good good) {
		Connection connection = DBUtil.getConnection();
		String sql = "UPDATE goods SET "
				+ "goodname=?,"
				+ "price=?,"
				+ "description=?,"
				+ "image=?,"
				+ "num=?,"
				+ "freight=?,"
				+ "catagory=? "
				+ "WHERE id=?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, good.getGoodname());
			ps.setDouble(2, good.getPrice());
			ps.setString(3, good.getDescription());
			ps.setString(4, good.getImagesStr());
			ps.setInt(5, good.getNum());
			ps.setDouble(6, good.getFreight());
			ps.setString(7, good.getCatagory());
			ps.setInt(8, good.getId());
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
	public List<Good> load(String goodname) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM goods WHERE goodname like ? and num > 0";
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Good> goods = new ArrayList<Good>();
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, "%"+goodname+"%");
			rs = ps.executeQuery();
			while(rs.next()) {
				Good good = new Good();
				good.setId(rs.getInt("id"));
				good.setGoodname(rs.getString("goodname"));
				good.setGoodownerid(rs.getInt("goodownerid"));
				good.setPrice(rs.getDouble("price"));
				good.setDescription(rs.getString("description"));
				good.setImages(rs.getString("image"));
				good.setNum(rs.getInt("num"));
				good.setCatagory(rs.getString("catagory"));
				good.setFreight(rs.getDouble("freight"));
				goods.add(good);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return goods;
	}

	@Override
	public void delete(int id) {
		Connection connection = DBUtil.getConnection();
		String sql = "DELETE FROM goods WHERE id = ?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
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
	public Good load(int id) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM goods WHERE id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		Good good = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				good = new Good();
				good.setId(rs.getInt("id"));
				good.setGoodname(rs.getString("goodname"));
				good.setGoodownerid(rs.getInt("goodownerid"));
				good.setPrice(rs.getDouble("price"));
				good.setDescription(rs.getString("description"));
				good.setImages(rs.getString("image"));
				good.setNum(rs.getInt("num"));
				good.setCatagory(rs.getString("catagory"));
				good.setFreight(rs.getDouble("freight"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return good;
	}

	@Override
	public List<Good> loadByCatagory(String goodname, String catagory) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM goods WHERE goodname like ? and catagory like ? and num > 0";
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Good> goods = new ArrayList<Good>();
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, "%" + goodname + "%");
			ps.setString(2, "%" + catagory + "%");
			rs = ps.executeQuery();
			while(rs.next()) {
				Good good = new Good();
				good.setId(rs.getInt("id"));
				good.setGoodname(rs.getString("goodname"));
				good.setGoodownerid(rs.getInt("goodownerid"));
				good.setPrice(rs.getDouble("price"));
				good.setDescription(rs.getString("description"));
				good.setImages(rs.getString("image"));
				good.setNum(rs.getInt("num"));
				good.setCatagory(rs.getString("catagory"));
				good.setFreight(rs.getDouble("freight"));
				goods.add(good);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return goods;
	}
	public List<Good> loadWithCondition(String goodname,String catagory,double minPrice,double maxPrice)
	{
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM goods WHERE goodname like ? and catagory like ? and price > ? and price < ? and num > 0";
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Good> goods = new ArrayList<Good>();
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, "%" + goodname + "%");
			ps.setString(2, "%" + catagory + "%");
			ps.setDouble(3, minPrice);
			ps.setDouble(4, maxPrice);
			rs = ps.executeQuery();
			while(rs.next()) {
				Good good = new Good();
				good.setId(rs.getInt("id"));
				good.setGoodname(rs.getString("goodname"));
				good.setGoodownerid(rs.getInt("goodownerid"));
				good.setPrice(rs.getDouble("price"));
				good.setDescription(rs.getString("description"));
				good.setImages(rs.getString("image"));
				good.setNum(rs.getInt("num"));
				good.setCatagory(rs.getString("catagory"));
				good.setFreight(rs.getDouble("freight"));
				goods.add(good);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return goods;
	}
}
