package com.pk.server.app.ctrl;

import com.pk.server.app.model.TakeByQu;
import com.pk.server.app.service.ITakeByQuService;
import com.pk.server.app.util.AppUtil;
import com.pk.server.wechat.api.process.WxMemoryCacheClient;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/weChat/takeByQu")
public class TakeByQuCtrl {

    @Resource
    private ITakeByQuService takeByQuService;

    @InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        //转换日期
        DateFormat dateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 系统下单
     */
    @RequestMapping("/pleaseOrder")
    @ResponseBody
    public String pleaseOrder(@ModelAttribute final TakeByQu takeByQu, HttpServletRequest request){
        try {
            String openId = WxMemoryCacheClient.getOpenid(request.getSession().getId());
            takeByQu.setId(AppUtil.getOrderIdByUUId());
            takeByQu.setOpenId(openId);
            takeByQuService.save(takeByQu);
            return takeByQu.getId();
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
    public String deleteByOrderNo(@ModelAttribute TakeByQu takeByQu){
        try {
            takeByQuService.delete(takeByQu.getId());
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
}
