package com.zhuanzhuan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DBUtil;

public class UserDaoImpl implements IUserDao{

	@Override
	public void add(User user) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		String sql = "INSERT INTO users (username,nickname,password,head,mobilephone,dormitory,room,sex,realname,alipay,qq) VALUES " + "(?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, user.getUsername());
			ps.setString(2, user.getNickname());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getHead());
			ps.setString(5, user.getMobilephone());
			ps.setInt(6, user.getDormitory());
			ps.setInt(7, user.getRoom());
			ps.setBoolean(8, user.getSex());
			ps.setString(9, user.getRealname());
			ps.setString(10, user.getAlipay());
			ps.setString(11, user.getQq());
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
	public void update(User user) {
		
		Connection connection = DBUtil.getConnection();
		String sql = "UPDATE users SET "
				+ "nickname=?,"
				+ "password=?,"
				+ "head=?,"
				+ "mobilephone=?,"
				+ "dormitory=?,"
				+ "room=?,"
				+ "sex=?,"
				+ "realname=?,"
				+ "alipay=?,"
				+ "qq=? "
				+ "WHERE id=? or username=?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, user.getNickname());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getHead());
			ps.setString(4, user.getMobilephone());
			ps.setInt(5, user.getDormitory());
			ps.setInt(6, user.getRoom());
			ps.setBoolean(7, user.getSex());
			ps.setString(8, user.getRealname());
			ps.setString(9, user.getAlipay());
			ps.setString(10, user.getQq());
			ps.setInt(11, user.getId());
			ps.setInt(12, user.getUsername());
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
	public void delete(String username) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User load(int id) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM users WHERE id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getInt("username"));
				user.setNickname(rs.getString("nickname"));
				user.setPassword(rs.getString("password"));
				user.setHead(rs.getString("head"));
				user.setMobilephone(rs.getString("mobilephone"));
				user.setDormitory(rs.getInt("dormitory"));
				user.setRoom(rs.getInt("room"));
				user.setSex(rs.getBoolean("sex"));
				user.setRealname(rs.getString("realname"));
				user.setAlipay(rs.getString("alipay"));
				user.setQq(rs.getString("qq"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return user;
	}

	@Override
	public User load(String username) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM users WHERE username = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, username);
			rs = ps.executeQuery();
			while(rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getInt("username"));
				user.setNickname(rs.getString("nickname"));
				user.setPassword(rs.getString("password"));
				user.setHead(rs.getString("head"));
				user.setMobilephone(rs.getString("mobilephone"));
				user.setDormitory(rs.getInt("dormitory"));
				user.setRoom(rs.getInt("room"));
				user.setSex(rs.getBoolean("sex"));
				user.setRealname(rs.getString("realname"));
				user.setAlipay(rs.getString("alipay"));
				user.setQq(rs.getString("qq"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return user;
	}

	@Override
	public User load(String username, String password) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM users WHERE username = ? and password = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeQuery();
			while(rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getInt("username"));
				user.setNickname(rs.getString("nickname"));
				user.setPassword(rs.getString("password"));
				user.setHead(rs.getString("head"));
				user.setMobilephone(rs.getString("mobilephone"));
				user.setDormitory(rs.getInt("dormitory"));
				user.setRoom(rs.getInt("room"));
				user.setSex(rs.getBoolean("sex"));
				user.setRealname(rs.getString("realname"));
				user.setAlipay(rs.getString("alipay"));
				user.setQq(rs.getString("qq"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return user;
	}

	@Override
	public boolean valid(User user) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM allstudents WHERE id = ? and name = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, user.getUsername());
			ps.setString(2, user.getRealname());
			rs = ps.executeQuery();
			while(rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return false;
	}

}
