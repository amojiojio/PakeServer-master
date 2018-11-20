package com.pk.server.app.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AppUtil {
	
    public static String getOrderIdByUUId() {
        int machineId = 1;//最大支持1-9个集群机器部署
        int hashCodeV = UUID.randomUUID().toString().hashCode();
        if(hashCodeV < 0) {//有可能是负数
            hashCodeV = - hashCodeV;
        }
        return machineId + String.format("%015d", hashCodeV);
    }
	
	public static String emojiToUtf8(String str)
	        throws UnsupportedEncodingException {  
	    String patternString = "([\\x{10000}-\\x{10ffff}\ud800-\udfff])";  
	  
	    Pattern pattern = Pattern.compile(patternString);  
	    Matcher matcher = pattern.matcher(str);  
	    StringBuffer sb = new StringBuffer();  
	    while(matcher.find()) {  
	        try {  
	            matcher.appendReplacement(  
	                    sb,  
	                    "[["  
	                            + URLEncoder.encode(matcher.group(1),  
	                                    "UTF-8") + "]]");  
	        } catch(UnsupportedEncodingException e) {  
	            throw e;  
	        }  
	    }  
	    matcher.appendTail(sb);  
	    return sb.toString();  
	}  
	  
	public static String Utf8Toemoji(String str)
	        throws UnsupportedEncodingException {  
	    String patternString = "\\[\\[(.*?)\\]\\]";  
	  
	    Pattern pattern = Pattern.compile(patternString);  
	    Matcher matcher = pattern.matcher(str);  
	  
	    StringBuffer sb = new StringBuffer();  
	    while(matcher.find()) {  
	        try {  
	            matcher.appendReplacement(sb,  
	                    URLDecoder.decode(matcher.group(1), "UTF-8"));  
	        } catch(UnsupportedEncodingException e) {  
	            throw e;  
	        }  
	    }  
	    matcher.appendTail(sb);  
	    return sb.toString();  
	}  

}
