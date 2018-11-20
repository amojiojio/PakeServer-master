package com.pk.server.wechat.wxPay.util;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * XML工具包
 * XMLUtil
 *
 */
@Component
public class XmlUtil {
    
    /**
     * 解析字符串（XML）
     * 
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public  Map<String, String> parseXml(String msg)
            throws Exception {
        // 将解析结果存储在HashMap中
        Map<String, String> map = new HashMap<String, String>();
        // 从request中取得输入流
        InputStream inputStream = new ByteArrayInputStream(msg.getBytes("UTF-8"));
        // 读取输入流
        SAXReader reader = new SAXReader();
        Document document = reader.read(inputStream);
        // 得到xml根元素
        Element root = document.getRootElement();
        // 得到根元素的所有子节点
        List<Element> elementList = root.elements();
        // 遍历所有子节点
        for (Element e : elementList){
            map.put(e.getName(), e.getText());
        }
            
        // 释放资源
        inputStream.close();
        inputStream = null;
        return map;
    }
    
    private XStream inclueUnderlineXstream = new XStream(new DomDriver(null,new XmlFriendlyNameCoder("_-", "_")));

    public XStream getXstreamInclueUnderline() {
        return inclueUnderlineXstream;
    }
    
}