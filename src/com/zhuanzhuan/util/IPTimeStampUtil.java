package com.zhuanzhuan.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/* 为防止用户上传文件与其它文件名相同
 * 可以以getIPTimeRand()方法生成的字符串（IP地址+时间戳+3位随机数）自动命名
 * */

public class IPTimeStampUtil {

    
    private SimpleDateFormat sdf = null;
    private String ip = null;
    
    
    public IPTimeStampUtil(String ip) {
        super();
    
        this.ip = ip;
    }


    public IPTimeStampUtil() {
        super();
    }
    
    /***生成唯一文件名***/
    public String getIPTimeRand(){
        StringBuffer buf = new StringBuffer();
        if(this.ip != null){
            String s[] = this.ip.split("\\.");//根据ip以点分割将IP中的数字提取
            for(int i = 0 ; i < s.length; i++){
                buf.append(this.addZero(s[i], 3));//不够三位数的补零
            }
        }
        buf.append(this.getTimeStamp());
        Random r = new Random();//再在结尾加上三个随机数
        for(int i = 0 ; i < 3 ; i++ ){
            buf.append(r.nextInt(10));
        }
        return buf.toString();
    }
    
    private String addZero(String str, int len){
        
        StringBuffer s = new StringBuffer();
        s.append(str);
        while(s.length()<len){
            s.insert(0, 0);
        }
        
        return s.toString();
    }
    
    
    private String getTimeStamp(){//获取时间戳
        this.sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        return this.sdf.format(new Date());
    }
    
    public String getDate(){
        this.sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        return this.sdf.format(new Date());
    }
}