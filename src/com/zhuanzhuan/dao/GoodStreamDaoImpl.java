package com.zhuanzhuan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.zhuanzhuan.model.GoodStream;
import com.zhuanzhuan.util.DBUtil;

public class GoodStreamDaoImpl implements IGoodStreamDao{

	@Override
	public void add(GoodStream goodStream) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		String sql = "INSERT INTO goodstream (orderid, deliverid, status, createtime, sendtime, receivetime) VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, goodStream.getOrderid());
			ps.setInt(2, goodStream.getDeliverid());
			ps.setInt(3, goodStream.getStatus());
			ps.setTimestamp(4, goodStream.getCreateTime());
			ps.setTimestamp(5, goodStream.getSendTime());
			ps.setTimestamp(6, goodStream.getReceiveTime());
			ps.execute();
			
			System.out.println(goodStream.toString());
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
	}

	@Override
	public void update(GoodStream goodStream) {
		Connection connection = DBUtil.getConnection();
		String sql = "UPDATE goodstream SET "
				+ "orderid=?,"
				+ "deliverid=?,"
				+ "status=?,"
				+ "createtime=?,"
				+ "sendtime=?,"
				+ "receivetime=? "
				+ "WHERE id=?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, goodStream.getOrderid());
			ps.setInt(2, goodStream.getDeliverid());
			ps.setInt(3, goodStream.getStatus());
			ps.setTimestamp(4, goodStream.getCreateTime());
			ps.setTimestamp(5, goodStream.getSendTime());
			ps.setTimestamp(6, goodStream.getReceiveTime());
			ps.setInt(7, goodStream.getId());
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
	public GoodStream loadByOrderid(int orderid) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM goodstream WHERE orderid = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		GoodStream goodStream = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, orderid);
			rs = ps.executeQuery();
			while(rs.next()) {
				goodStream = new GoodStream();
				goodStream.setId(rs.getInt("id"));
				goodStream.setOrderid(orderid);
				goodStream.setDeliverid(rs.getInt("deliverid"));
				goodStream.setStatus(rs.getInt("status"));
				goodStream.setCreateTime(rs.getTimestamp("createtime"));
				goodStream.setSendTime(rs.getTimestamp("sendtime"));
				goodStream.setReceiveTime(rs.getTimestamp("receivetime"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return goodStream;
	}

	@Override
	public List<GoodStream> loadByStatus(int status) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM goodstream WHERE status = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		GoodStream goodStream = null;
		List<GoodStream> goodStreams = new ArrayList<GoodStream>();
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, status);
			rs = ps.executeQuery();
			while(rs.next()) {
				goodStream = new GoodStream();
				goodStream.setId(rs.getInt("id"));
				goodStream.setOrderid(rs.getInt("orderid"));
				goodStream.setDeliverid(rs.getInt("deliverid"));
				goodStream.setStatus(status);
				goodStream.setCreateTime(rs.getTimestamp("createtime"));
				goodStream.setSendTime(rs.getTimestamp("sendtime"));
				goodStream.setReceiveTime(rs.getTimestamp("receivetime"));
				goodStreams.add(goodStream);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return goodStreams;
	}

	@Override
	public GoodStream load(int id) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM goodstream WHERE id = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		GoodStream goodStream = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				goodStream = new GoodStream();
				goodStream.setId(id);
				goodStream.setOrderid(rs.getInt("orderid"));
				goodStream.setDeliverid(rs.getInt("deliverid"));
				goodStream.setStatus(rs.getInt("status"));
				goodStream.setCreateTime(rs.getTimestamp("createtime"));
				goodStream.setSendTime(rs.getTimestamp("sendtime"));
				goodStream.setReceiveTime(rs.getTimestamp("receivetime"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return goodStream;
	}

	@Override
	public List<GoodStream> load(int courierid,int status) {
		Connection connection = DBUtil.getConnection();
		String sql = null;
		if(status == GoodStream.ALL)
			sql = "SELECT * FROM goodstream WHERE deliverid = ?";
		else
			sql = "SELECT * FROM goodstream WHERE deliverid = ? and status = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		GoodStream goodStream = null;
		List<GoodStream> goodStreams = new ArrayList<GoodStream>();
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, courierid);
			if(status != GoodStream.ALL)
				ps.setInt(2, status);
			rs = ps.executeQuery();
			while(rs.next()) {
				goodStream = new GoodStream();
				goodStream.setId(rs.getInt("id"));
				goodStream.setOrderid(rs.getInt("orderid"));
				goodStream.setDeliverid(courierid);
				goodStream.setStatus(rs.getInt("status"));
				goodStream.setCreateTime(rs.getTimestamp("createtime"));
				goodStream.setSendTime(rs.getTimestamp("sendtime"));
				goodStream.setReceiveTime(rs.getTimestamp("receivetime"));
				goodStreams.add(goodStream);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return goodStreams;
	}
}
