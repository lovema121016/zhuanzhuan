package com.zhuanzhuan.dao;

import com.zhuanzhuan.model.User;

public interface IUserDao {
	public void add(User user);
	public void update(User user);
	public void delete(String username);
	public User load(int id);
	public User load(String username);
	public User load(String username,String password);
	public boolean valid(User user);
}
