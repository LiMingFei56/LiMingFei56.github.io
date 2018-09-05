package org.ppnsr.controller.wx;

import javax.servlet.http.HttpServletRequest;

import org.ppnsr.controller.base.BaseController;
import org.ppnsr.util.CacheUtil;
import org.ppnsr.wx.MyWeiXin;
import org.ppnsr.wx.bean.OpenId;
import org.ppnsr.wx.utils.WeiXinApiUtils;
import org.ppnsr.wx.utils.WeiXinLog;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author: YangChen
 * @Date: 2018/08/20 0020 09:35
 * @Description:
 */
@Controller
public class WxController extends BaseController {

    @RequestMapping("/login")
    public String login(HttpServletRequest request){
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        
        OpenId openId = WeiXinApiUtils.requestOpenId(MyWeiXin.appId, MyWeiXin.appSecret, code);
        CacheUtil.setUserInfoToken(openId);// 缓存
//        System.out.println(openId.getOpenid()); // openid 字符串
        
        WeiXinLog.info(String.format("code=%s, state=%s, openId=%s", code, state, openId));
        
        if	("home".equals(state)) {
        	// 首页
        } else if("mine".equals(state)) {
        	// 个人中心
        }
        
        return "index";
    }
    
    @RequestMapping("/home")
    public String home(String mobileNo, Model mode){
    	
        return "index";
    }
    
    @RequestMapping("/mine")
    public String mine(String mobileNO, Model mode){
    	
        return "my-order";
    }
    
}
