package com.pk.server.master.redis;

import com.pk.server.admin.service.IApiLogService;
import com.pk.server.app.model.Run;
import com.pk.server.app.model.TakeByQu;
import com.pk.server.app.model.TakeBySong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;

import javax.annotation.Resource;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * Redis 消息中心
 *
 *
 */
@ServerEndpoint("/admin/websocket")
public class RedisMessageListener implements MessageListener {

    //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    private static int onlineCount = 0;

    //concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
    private static CopyOnWriteArraySet<RedisMessageListener> webSocketSet = new CopyOnWriteArraySet<RedisMessageListener>();

    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;

    //注入Service用于把日志保存数据库    
    @Resource
    private IApiLogService apiLogService;

    @Autowired
    private RedisCache redisCache;

    /**
     * 连接建立成功调用的方法
     *
     * @param session 可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    @OnOpen
    public void onOpen(Session session) {
        this.session = session;
        webSocketSet.add(this);     //加入set中
        addOnlineCount();           //在线数加1
//		System.out.println("有新连接加入！当前在线人数为" + getOnlineCount());
//        while (true) {  
//            sendMessage("test");  
//        }  

    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose() {
        webSocketSet.remove(this);  //从set中删除
        subOnlineCount();           //在线数减1
//		System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     * @param session 可选的参数
     */
    @OnMessage
    public void onMessage(String message, Session session) {
//		System.out.println("来自客户端的消息:" + message);
        //群发消息
        for (RedisMessageListener item : webSocketSet) {
            try {
                item.sendMessage(message);
            } catch (IOException e) {
                e.printStackTrace();
                continue;
            }
        }
    }

    /**
     * 发生错误时调用
     *
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        error.printStackTrace();
    }

    /**
     * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
     *
     * @param message
     * @throws IOException
     */
    public void sendMessage(String message) throws IOException {
        this.session.getBasicRemote().sendText(message);
        //this.session.getAsyncRemote().sendText(message);
    }

    public static synchronized int getOnlineCount() {
        return onlineCount;
    }

    public static synchronized void addOnlineCount() {
        RedisMessageListener.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        RedisMessageListener.onlineCount--;
    }

    @Override
    public void onMessage(Message message, byte[] pattern) {
        Object obj = null;
        try {
            ByteArrayInputStream bis = new ByteArrayInputStream(message.getBody());
            ObjectInputStream ois = new ObjectInputStream(bis);
            obj = ois.readObject();
            ois.close();
            bis.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }

        //处理日志
        if (obj instanceof Run) {
            System.out.println("您有新的跑腿订单");
            //群发消息
            for (RedisMessageListener item : webSocketSet) {
                try {
                    item.sendMessage("您有新的跑腿订单:  订单号为    " + ((Run) obj).getId());
                } catch (IOException e) {
                    e.printStackTrace();
                    continue;
                }
            }
        }
else
        if (obj instanceof TakeBySong) {
            System.out.println("您有新的送件订单");
            //群发消息
            for (RedisMessageListener item : webSocketSet) {
                try {
                    item.sendMessage("您有新的送件订单:  订单号为    " + ((TakeBySong) obj).getId());
                } catch (IOException e) {
                    e.printStackTrace();
                    continue;
                }
            }
        }

else
        if (obj instanceof TakeByQu) {
            System.out.println("您有新的取件订单");
            //群发消息
            for (RedisMessageListener item : webSocketSet) {
                try {
                    item.sendMessage("您有新的取件订单:  订单号为    " + ((TakeByQu) obj).getId());
                } catch (IOException e) {
                    e.printStackTrace();
                    continue;
                }
            }
        }
    }
}
