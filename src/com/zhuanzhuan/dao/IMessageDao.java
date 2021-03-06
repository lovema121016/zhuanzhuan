package com.zhuanzhuan.dao;

import java.util.List;

import com.zhuanzhuan.model.Message;

public interface IMessageDao {
	public void add(Message message);
	public void delete(int id);
	public void deleteByReciveId(int reciveid);
	public void update(Message message);
	public Message loadone(int id);
	public List<Message> load(int sendid,int receiveid);
	public List<Message> load(int reciveid);
	public List<Message> loadWithCondition(int receiveid,int status);
}
