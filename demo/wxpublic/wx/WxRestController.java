package org.ppnsr.controller.wx;

import javax.servlet.http.HttpServletRequest;

import org.ppnsr.controller.base.BaseRestController;
import org.ppnsr.wx.MyWeiXin;
import org.ppnsr.wx.utils.AesException;
import org.ppnsr.wx.utils.SHA1;
import org.ppnsr.wx.utils.WeiXinLog;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author: YangChen
 * @Date: 2018/08/20 0020 09:39
 * @Description:
 */
@RestController
public class WxRestController extends BaseRestController {


    @RequestMapping("/validate")
    public String validate(HttpServletRequest request){
    	String signature = request.getParameter("signature");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");
        String echostr = request.getParameter("echostr");
        
        String currSignature = "";
        try {
        	currSignature = SHA1.getSHA1(MyWeiXin.weiXinToken, timestamp, nonce, MyWeiXin.weiXinEncodingAESKey);
        } catch (AesException e) {
        	e.printStackTrace();
        	WeiXinLog.info("微信验证异常--" + e.toString());
		}
		
        
        String result = null;
        if (currSignature.equals(signature)) {
        	result = echostr;
            WeiXinLog.info("微信Token验证成功");
        } else {
        	WeiXinLog.info(String.format("微信验证失败-- signature=%s, currSignature=%s, timestamp=%s, nonce=%s, echostr=%s"
        			, signature, currSignature, timestamp, nonce, echostr));
        	result = "请关注微信公众号";
        }
        return result;
    }
}
