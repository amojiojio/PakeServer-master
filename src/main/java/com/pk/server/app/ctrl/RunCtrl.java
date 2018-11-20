package com.pk.server.app.ctrl;

import com.pk.server.app.model.Run;
import com.pk.server.app.service.IRunService;
import com.pk.server.app.util.AppUtil;
import com.pk.server.wechat.api.process.WxMemoryCacheClient;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 跑腿
 */
@Controller
@RequestMapping("/weChat/run")
public class RunCtrl {

    @Resource
    private IRunService runService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        //转换日期
        DateFormat dateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 系统下单
     */
    @RequestMapping("/pleaseOrder")
    @ResponseBody
    public String pleaseOrder(@ModelAttribute final Run run, HttpServletRequest request){
        try {
            String openId = WxMemoryCacheClient.getOpenid(request.getSession().getId());
            run.setId(AppUtil.getOrderIdByUUId());
            run.setOpenId(openId);
            runService.save(run);
            return run.getId();
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    /**
     * 删除订单
     */
    @RequestMapping(value="/deleteByOrderNo")
    @ResponseBody
    public String deleteByOrderNo(@ModelAttribute Run run){
        try {
            runService.delete(run.getId());
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
