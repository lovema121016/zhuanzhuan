package com.zhuanzhuan.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.zhuanzhuan.model.Message;
import com.zhuanzhuan.util.DBUtil;

public class MessageDaoImpl implements IMessageDao {

	@Override
	public void add(Message message) {
		Connection connection = DBUtil.getConnection();
		PreparedStatement preparedStatement = null;
		try {
			String sql = "insert into message(senduserid,reciveuserid,status,content,time,title) value(?,?,?,?,?,?)";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, message.getSenduserid());
			preparedStatement.setInt(2, message.getReciveuserid());
			preparedStatement.setInt(3, message.getStatus());
			preparedStatement.setString(4, message.getContent());
			preparedStatement.setTimestamp(5, new Timestamp(new Date().getTime()));
			preparedStatement.setString(6, message.getTitle());
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
	public void delete(int id) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		PreparedStatement preparedStatement = null;
		try {
			String sql = "delete from message where id=?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, id);
			preparedStatement.executeUpdate();
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
	}

	@Override
	public Message loadone(int id) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		String sql = "select * from message where id=?";
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Message message = null;
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, id);
			resultSet = preparedStatement.executeQuery();
			while(resultSet.next()) {
				message=new Message();
				message.setId(id);
				message.setSenduserid(resultSet.getInt("senduserid"));
				message.setReciveuserid(resultSet.getInt("reciveuserid"));
				message.setContent(resultSet.getString("content"));
				message.setStatus(resultSet.getInt("status"));
				message.setTime(resultSet.getTimestamp("time"));
				message.setTitle(resultSet.getString("title"));;
			}
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
				
		return message;
	}

	@Override
	public List<Message> load(int sendid, int reciveid) {
		// TODO Auto-generated method stub
		List<Message> messages = new ArrayList<Message>();
		Connection connection = DBUtil.getConnection();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			String sql = "select * from message where senduserid=? and reciveuserid=?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, sendid);
			preparedStatement.setInt(2, reciveid);
			resultSet = preparedStatement.executeQuery();
			Message message = null;
			while(resultSet.next()) {
				message = new Message();
				message.setId(resultSet.getInt("id"));
				message.setSenduserid(sendid);
				message.setReciveuserid(reciveid);
				message.setContent(resultSet.getString("content"));
				message.setStatus(resultSet.getInt("status"));
				message.setTime(resultSet.getTimestamp("time"));
				message.setTitle(resultSet.getString("title"));;
				messages.add(message);
			}
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return messages;
	}
	@Override
	public List<Message> load(int reciveid) {
		// TODO Auto-generated method stub
		List<Message> messages = new ArrayList<Message>();
		Connection connection = DBUtil.getConnection();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			String sql = "select * from message where reciveuserid=?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, reciveid);
			resultSet = preparedStatement.executeQuery();
			Message message = null;
			while(resultSet.next()) {
				message = new Message();
				message.setId(resultSet.getInt("id"));
				message.setSenduserid(resultSet.getInt("senduserid"));
				message.setReciveuserid(reciveid);
				message.setContent(resultSet.getString("content"));
				message.setStatus(resultSet.getInt("status"));
				message.setTime(resultSet.getTimestamp("time"));
				message.setTitle(resultSet.getString("title"));
				messages.add(message);
			}
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return messages;
	}

	@Override
	public List<Message> loadWithCondition(int receiveid, int status) {
		// TODO Auto-generated method stub
		List<Message> messages = new ArrayList<Message>();
		Connection connection = DBUtil.getConnection();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			String sql = "select * from message where reciveuserid=?";
			if (status != Message.ALL) {
				sql = "select * from message where reciveuserid=? and status=?";
			}
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, receiveid);
			if (status != Message.ALL) 
				preparedStatement.setInt(2, status);
			resultSet = preparedStatement.executeQuery();
			Message message = null;
			while(resultSet.next()) {
				message = new Message();
				message.setId(resultSet.getInt("id"));
				message.setSenduserid(resultSet.getInt("senduserid"));
				message.setReciveuserid(receiveid);
				message.setContent(resultSet.getString("content"));
				message.setStatus(resultSet.getShort("status"));
				message.setTime(resultSet.getTimestamp("time"));
				message.setTitle(resultSet.getString("title"));;
				messages.add(message);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return messages;
	}

	@Override
	public void update(Message message) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		String sql = "update message set senduserid=? , reciveuserid=?,status=?,content=?,title=? where id = ?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1,message.getSenduserid());
			ps.setInt(2,message.getReciveuserid() );
			ps.setInt(3,message.getStatus());		
			ps.setString(4, message.getContent());
			ps.setString(5,message.getTitle() );
			ps.setInt(6, message.getId());
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
	public void deleteByReciveId(int reciveid) {
		// TODO Auto-generated method stub
		Connection connection = DBUtil.getConnection();
		PreparedStatement preparedStatement = null;
		String sql = "delete from message where reciveuserid=?";
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, reciveid);
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
