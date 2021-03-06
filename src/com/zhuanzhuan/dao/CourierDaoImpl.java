package com.zhuanzhuan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.zhuanzhuan.model.Courier;
import com.zhuanzhuan.util.DBUtil;

public class CourierDaoImpl implements ICourierDao {

	@Override
	public void add(Courier courier) {
		Connection connection = DBUtil.getConnection();
		String sql = "INSERT INTO couriers (courierid,salary,status) VALUES " + "(?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, courier.getCourierid());
			ps.setDouble(2, courier.getSalary());
			ps.setInt(3, courier.getStatus());
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
	public void update(Courier courier) {
		Connection connection = DBUtil.getConnection();
		String sql = "UPDATE couriers SET "
				+ "salary=?,"
				+ "status=? "
				+ "WHERE courierid=?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setDouble(1, courier.getSalary());
			ps.setInt(2, courier.getStatus());
			ps.setInt(3, courier.getCourierid());
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
	public void delete(int courierid) {
		// TODO Auto-generated method stub

	}

	@Override
	public Courier load(int courierid) {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM couriers WHERE courierid = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		Courier courier = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, courierid);
			rs = ps.executeQuery();
			while(rs.next()) {
				courier = new Courier();
				courier.setCourierid(courierid);
				courier.setSalary(rs.getDouble("salary"));
				courier.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return courier;
	}

	@Override
	public List<Courier> loadNormalCourier() {
		Connection connection = DBUtil.getConnection();
		String sql = "SELECT * FROM couriers WHERE status = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		Courier courier = null;
		List<Courier> couriers = new ArrayList<Courier>();
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, Courier.NORMOL);
			rs = ps.executeQuery();
			while(rs.next()) {
				courier = new Courier();
				courier.setCourierid(rs.getInt("courierid"));
				courier.setSalary(rs.getDouble("salary"));
				courier.setStatus(rs.getInt("status"));
				couriers.add(courier);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
			DBUtil.close(connection);
		}
		return couriers;
	}

}
