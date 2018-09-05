package org.ppnsr.wx;

import org.ppnsr.util.CacheUtil;
import org.ppnsr.wx.bean.AccessToken;
import org.ppnsr.wx.bean.JsApiTicket;
import org.ppnsr.wx.bean.OpenId;
import org.ppnsr.wx.utils.WeiXinApiUtils;

public class TokenManager {

	// 一般AccessToken, 对应公众号
	public static synchronized AccessToken getAccessToken() {
		AccessToken accessToken = CacheUtil.getWxObject(AccessToken.class.getName());
		if (accessToken == null || accessToken.getExpiryTime() < System.currentTimeMillis()) {
			accessToken = WeiXinApiUtils.requestAccessToken(MyWeiXin.appId, MyWeiXin.appSecret);
			CacheUtil.setWxObject(accessToken);
		}
		return accessToken;
	}

	// jsapi调用使用的ticket, 使用一般AccessToken换
	public static JsApiTicket getJsApiTicket() {
		JsApiTicket jsApiTicket = CacheUtil.getWxObject(JsApiTicket.class.getName());
		if (jsApiTicket == null || jsApiTicket.getExpiryTime() < System.currentTimeMillis()) {
			jsApiTicket = WeiXinApiUtils.requestTicket(getAccessToken());
			CacheUtil.setWxObject(jsApiTicket);
		}
		return jsApiTicket;
	}

	// 用户AccessToken, 对应每个用户
	public static OpenId getOpenId(String openId) {
		return CacheUtil.getUserInfoToken(openId);
	}

}
