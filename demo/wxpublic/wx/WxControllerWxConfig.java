package org.ppnsr.controller.wx;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.net.URLDecoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.ppnsr.controller.base.BaseController;
import org.ppnsr.wx.TokenManager;
import org.ppnsr.wx.utils.WeiXinApiUtils;
import org.ppnsr.wx.utils.WeiXinLog;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author: YangChen
 * @Date: 2018/08/20 0020 09:35
 * @Description:
 */
@Controller
public class WxControllerWxConfig extends BaseController {

	@RequestMapping("/wxConfig")
	public String wxConfig(HttpServletRequest request) {
		String timestamp = request.getParameter("timestamp");
		String nonceStr = request.getParameter("nonceStr");
		String url = request.getParameter("url");
		try {
			url = URLDecoder.decode(url, "US-ASCII");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			WeiXinLog.error("url 解码错误 -- " + e.toString() + " url=" + url);
		}
		String ticket = TokenManager.getJsApiTicket().getTicket();

		// ASCII排序
		String[] arr = new String[] { "noncestr=" + nonceStr, "jsapi_ticket=" + ticket, "timestamp=" + timestamp,
				"url=" + url };
		Arrays.sort(arr);
		
		// 用&组合成字符串
		StringBuilder combination = new StringBuilder();
		for (String s: arr) {
			combination.append("&");
			combination.append(s);
		}
		combination.deleteCharAt(0);
		
		// sha1加密
		String sign = null;
		try {
			sign = WeiXinApiUtils.getSha1(combination.toString());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			WeiXinLog.error("sign 加密错误 -- " + e.toString() + " combination=" + combination.toString());
		}

		return String.format("{\"success\":\"%s\", \"sign\":\"%s\"}", sign == null ? "0": "1", sign);
	}
}
