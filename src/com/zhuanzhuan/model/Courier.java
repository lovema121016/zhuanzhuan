package com.zhuanzhuan.model;

public class Courier {
	public static final int NORMOL = 1;
	public static final int FORBID = 0;
	
	private int courierid;			//与userid一样
	private double salary;			//工资
	private int status;				//状态
	public int getCourierid() {
		return courierid;
	}
	public void setCourierid(int courierid) {
		this.courierid = courierid;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
