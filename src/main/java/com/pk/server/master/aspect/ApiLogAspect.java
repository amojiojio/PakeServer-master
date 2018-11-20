package com.pk.server.master.aspect;

import com.alibaba.fastjson.JSON;
import com.pk.server.admin.model.ApiLog;
import com.pk.server.admin.service.IApiLogService;
import com.pk.server.master.redis.RedisCache;
import com.pk.server.master.util.HttpUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

/**
 * API层日志切面，用来打印接口调用日志。包含:uri、参数、返回值
 *
 * @author WangJie
 */
@Aspect
@Component
public class ApiLogAspect {

    @Autowired
    private RedisCache redisCache;

    //注入Service用于把日志保存数据库
    @Resource
    private IApiLogService apiLogService;

    //本地异常日志记录对象   
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private String requestPath = null; // 请求地址
    private Map<?, ?> inputParamMap = null; // 传入参数
    private Map<String, Object> outputParamMap = null; // 存放输出结果
    private long startTimeMillis = 0; // 开始时间
    private long endTimeMillis = 0; // 结束时间

    /**
     * @param joinPoint
     * @Title：doBeforeInServiceLayer
     * @Description: 方法调用前触发 记录开始时间
     * @author WangJie
     */
    @Before("execution(* com.pk.server.*.*.ctrl..*.*(..))")
    public void doBeforeInServiceLayer(JoinPoint joinPoint) {
        startTimeMillis = System.currentTimeMillis(); // 记录方法开始执行的时间
    }

    /**
     * @param joinPoint
     * @Title：doAfterInServiceLayer
     * @Description: 方法调用后触发 记录结束时间
     * @author WangJie
     */
    @After("execution(* com.pk.server.*.*.ctrl..*.*(..))")
    public void doAfterInServiceLayer(JoinPoint joinPoint) {
        endTimeMillis = System.currentTimeMillis(); // 记录方法执行完成的时间
        this.printOptLog();
    }

    /**
     * @param pjp
     * @return
     * @throws Throwable
     * @Title：doAround
     * @Description: 环绕触发
     * @author WangJie
     */
    @Around("execution(* com.pk.server.*.*.ctrl..*.*(..))")
    public Object doAround(ProceedingJoinPoint pjp) throws Throwable {
        /**
         * 1.获取request信息
         */
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes sra = (ServletRequestAttributes) ra;
        HttpServletRequest request = sra.getRequest();
        // 获取输入参数
        inputParamMap = request.getParameterMap();
        // 获取请求地址
        requestPath = request.getServletPath() == null ? "/testing" : request.getServletPath();
        // 执行完方法的返回值：调用proceed()方法，就会触发切入点方法执行
        outputParamMap = new HashMap<String, Object>();
        Object result = pjp.proceed();// result的值就是被拦截方法的返回值
        outputParamMap.put("result", result);
        outputParamMap.put("ip", HttpUtils.getIpAddress(request));
        outputParamMap.put("method", request.getMethod());
        outputParamMap.put("fromSource", HttpUtils.JudgeIsMoblie(request));
        logger.info("请求方式：" + request.getMethod());
        logger.info("请求头：" + request.getHeader("user-Agent"));
        return result;
    }

    /**
     * @Title：printOptLog
     * @Description: 输出日志
     * @author WangJie
     */
    private void printOptLog() {
        String logContent = String.format(
                "the api log is: uri：%s; api use time：%d ms; request param：%s; response result：%s", requestPath,
                (endTimeMillis - startTimeMillis), JSON.toJSONString(inputParamMap), JSON.toJSONString(outputParamMap));
        logger.info("请求地址：" + requestPath);
        logger.info("请求来源：" + outputParamMap.get("fromSource"));
        logger.info("请求参数：" + JSON.toJSONString(inputParamMap));
        logger.info("请求耗时：" + (endTimeMillis - startTimeMillis) + " ms");
        logger.info("返回数据：" + JSON.toJSONString(outputParamMap));
        logger.info(logContent);
            //缓存至Redis
            final ApiLog apiLog = new ApiLog();
            apiLog.setIp(outputParamMap.get("ip").toString());
            apiLog.setMethod(outputParamMap.get("method").toString());
            apiLog.setUrl(requestPath);
            apiLog.setParam(JSON.toJSONString(inputParamMap));
            apiLog.setStartTimeMillis(startTimeMillis);
            apiLog.setEndTimeMillis(endTimeMillis);
            apiLog.setSeTimeMillis((endTimeMillis - startTimeMillis));
//            apiLog.setReturnCode(jsonObject.getString("code"));
//            apiLog.setMessage(jsonObject.getString("msg"));
//            apiLog.setIsSuccess(jsonObject.getString("success"));
            apiLog.setFromSource(outputParamMap.get("fromSource") == null ? "PC" : outputParamMap.get("fromSource").toString());
            //将apiLog日志对象缓存至redisList中
//            redisCache.lSet("logList", apiLog);
            //通知redis消息中心
//            redisCache.getRedisTemplate().convertAndSend("redisMessage", "apiLog");
            // 清理创建对象资源
        //单线程异步到数据库
        Executor executor = Executors.newSingleThreadExecutor();
        executor.execute(new Runnable() {
            public void run() {
                apiLogService.save(apiLog);
            }
        });
        clearObject();
    }

    /**
     * 清理全局变量资源，释放内存
     */
    private void clearObject() {
        requestPath = null;
        if (!CollectionUtils.isEmpty(outputParamMap)) {
            outputParamMap.clear();
        }
    }
}

