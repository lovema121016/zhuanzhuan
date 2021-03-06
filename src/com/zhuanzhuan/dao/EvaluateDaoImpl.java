package com.zhuanzhuan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import com.zhuanzhuan.model.Evaluate;
import com.zhuanzhuan.util.DBUtil;

public class EvaluateDaoImpl implements IEvaluateDao{

	@Override
	public void addEvalute(Evaluate evaluate) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		PreparedStatement preparedStatement = null;
		try {
			String sql = "insert into evaluate(username,content) value(?,?)";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, evaluate.getUsername());
			preparedStatement.setString(2, evaluate.getContent());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}		
	}
}
