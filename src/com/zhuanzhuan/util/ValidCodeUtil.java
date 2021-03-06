package com.zhuanzhuan.util;

import com.montnets.mwgate.common.GlobalParams;
import com.montnets.mwgate.common.Message;
import com.montnets.mwgate.smsutil.ConfigManager;
import com.montnets.mwgate.smsutil.SmsSendConn;

public class ValidCodeUtil {
	public static String sendSMS(String validCode,String mobilePhone)
	{
		
		// 用户账号
		String userid = "E101MH";

		// 创建全局参数
		GlobalParams globalParams = new GlobalParams();
		// 设置请求路径
		globalParams.setRequestPath("/sms/v2/std/");
		// 设置是否需要日志 1:需要日志;0:不需要日志
		globalParams.setNeedLog(1);
		// 设置全局参数
		ConfigManager.setGlobalParams(globalParams);

		// 设置用户账号信息
		setAccountInfo();

		// 是否保持长连接
		boolean isKeepAlive = false;
		// 实例化短信处理对象
		SmsSendConn smsSendConn = new SmsSendConn(isKeepAlive);

		// 单条发送
		int result = singleSend(smsSendConn, userid,validCode,mobilePhone);

		// 移除用户账号(此处为移除用户账号功能示例，使用时请根据实际情况，有需要才调用此方法)
		removeAccount(userid);
		
		if(result == 0)
			return "发送成功";
		else return "错误：" + result;
	}
	public static String sendSMS(String orderser, int streamid,String mobilePhone)
	{
		
		// 用户账号
		String userid = "E101MH";

		// 创建全局参数
		GlobalParams globalParams = new GlobalParams();
		// 设置请求路径
		globalParams.setRequestPath("/sms/v2/std/");
		// 设置是否需要日志 1:需要日志;0:不需要日志
		globalParams.setNeedLog(1);
		// 设置全局参数
		ConfigManager.setGlobalParams(globalParams);

		// 设置用户账号信息
		setAccountInfo();

		// 是否保持长连接
		boolean isKeepAlive = false;
		// 实例化短信处理对象
		SmsSendConn smsSendConn = new SmsSendConn(isKeepAlive);

		// 单条发送
		int result = singleStream(smsSendConn, userid,orderser,streamid,mobilePhone);

		// 移除用户账号(此处为移除用户账号功能示例，使用时请根据实际情况，有需要才调用此方法)
		removeAccount(userid);
		
		if(result == 0)
			return "发送成功";
		else return "错误：" + result;
	}
	/**
	 * @description 设置用户账号信息
	 */
	public static void setAccountInfo() {
		// 设置用户账号信息

		// 用户账号
		String userid = "E101MH";
		// 密码
		String password = "pYxFoY";
		// 发送优先级
		int priority = 1;
		// 主IP信息
		String ipAddress1 = "api02.monyun.cn:7901";

		// 备用IP1信息
		String ipAddress2 = "api01.monyun.cn:7901";
		// 备用IP2信息
		String ipAddress3 = null;
		// 备用IP3信息
		String ipAddress4 = null;
		// 返回值
		int result = -310007;
		try {
			// 设置用户账号信息
			result = ConfigManager.setAccountInfo(userid, password, priority,
					ipAddress1, ipAddress2, ipAddress3, ipAddress4);
			// 判断返回结果，0设置成功，否则失败
			if (result == 0) {
				System.out.println("设置用户账号信息成功！");
			} else {
				System.out.println("设置用户账号信息失败，错误码：" + result);
			}
		} catch (Exception e) {
			// 异常处理
			e.printStackTrace();
		}
	}

	/**
	 * 移除用户账号
	 * 
	 * @param userid
	 *            用户账号
	 */
	public static void removeAccount(String userid) {
		try {
			// 调用移除用户账号的方法
			int result = ConfigManager.removeAccount(userid);

			// 返回0，代表移除成功
			if (result == 0) {
				System.out.println("移除用户账号[" + userid + "]成功！");
			}
			// 返回非0，代表移除失败
			else {
				System.out.println("移除用户账号[" + userid + "]失败！错误码：" + result);
			}
		} catch (Exception e) {
			// 异常处理
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * @description 单条发送
	 * @param smsSendConn
	 *            短信处理对象,在这个方法中调用发送短信功能
	 * @param userid
	 *            用户账号
	 */
	public static int singleSend(SmsSendConn smsSendConn, String userid,String validCode,String mobilePhone) {
		
		try {
			// 参数类
			Message message = new Message();
			// 设置用户账号 指定用户账号发送，需要填写用户账号，不指定用户账号发送，无需填写用户账号
			message.setUserid(userid);
			// 设置手机号码 此处只能设置一个手机号码
			message.setMobile(mobilePhone);
			// 设置内容
			message.setContent("您的验证码是" + validCode + "，在10分钟内输入有效。如非本人操作请忽略此短信。");

			// 业务类型
			message.setSvrtype("SMS001");

			// 返回的流水号
			StringBuffer returnValue = new StringBuffer();
			// 返回值
			int result = -310099;
			// 发送短信
			result = smsSendConn.singleSend(message, returnValue);
			// result为0:成功
			if (result == 0) {
				System.out.println("单条发送提交成功！");
				System.out.println(returnValue.toString());
			}
			// result为非0：失败
			else {
				System.out.println("单条发送提交失败,错误码：" + result);
			}
			return result;
		} catch (Exception e) {
			// 异常处理
			e.printStackTrace();
		}
		return -310099;
	}
	public static int singleStream(SmsSendConn smsSendConn, String userid,String orderser,int streamid,String mobilePhone) {
		
		try {
			// 参数类
			Message message = new Message();
			// 设置用户账号 指定用户账号发送，需要填写用户账号，不指定用户账号发送，无需填写用户账号
			message.setUserid(userid);
			// 设置手机号码 此处只能设置一个手机号码
			message.setMobile(mobilePhone);
			// 设置内容
			message.setContent("订单编号" + orderser + "您购买的物品以发出，我们正在为您派件，提货码" + streamid + "请保持电话畅通，感谢您选择转赚，我们将会继续竭诚为您服务。");
			// 业务类型
			message.setSvrtype("SMS001");

			// 返回的流水号
			StringBuffer returnValue = new StringBuffer();
			// 返回值
			int result = -310099;
			// 发送短信
			result = smsSendConn.singleSend(message, returnValue);
			// result为0:成功
			if (result == 0) {
				System.out.println("单条发送提交成功！");
				System.out.println(returnValue.toString());
			}
			// result为非0：失败
			else {
				System.out.println("单条发送提交失败,错误码：" + result);
			}
			return result;
		} catch (Exception e) {
			// 异常处理
			e.printStackTrace();
		}
		return -310099;
	}
}
