package com.zhuanzhuan.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {

	private static String USERNAMR = "c##zz";
    private static String PASSWORD = "root";
    private static String DRVIER = "oracle.jdbc.OracleDriver";
    private static String URL = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
    public  static  Connection getConnection2() {
        try {
            //1.加载驱动
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String user = "root";
        String password = "root";
        String url = "jdbc:mysql://localhost:3306/scienceannualreport";
        Connection connection = null;
        try {
            //2.创建连接对象
            connection = DriverManager.getConnection(url,user,password);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return connection;
    }
    
    public static Connection getConnection() {
    	Connection connection = null;
    	try {
            Class.forName(DRVIER);
            connection = DriverManager.getConnection(URL, USERNAMR, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("class not find !", e);
        } catch (SQLException e) {
            throw new RuntimeException("get connection error!", e);
        }

        return connection;
    }
    
    //3.关闭连接
    public static void close(Connection connection ) {
        try {
            if (connection != null) {
                connection.close();
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    public static void close(PreparedStatement preparedStatement ) {
        try {
            if (preparedStatement != null) {
                preparedStatement.close();
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    public static void close(ResultSet resultSet ) {
        try {
            if (resultSet != null) {
                resultSet.close();
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}