package org.ppnsr.wx.utils;

import java.net.MalformedURLException;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.ppnsr.wx.bean.AccessToken;
import org.ppnsr.wx.bean.JsApiTicket;
import org.ppnsr.wx.bean.OpenId;

import com.google.gson.Gson;

public class WeiXinApiUtils {

	public static AccessToken requestAccessToken(String appid, String secret) {
		String urlStr = String.format(
				"https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s", appid,
				secret);

		String response = null;
		try {
			response = HttpsUtils.httpGet(new URL(urlStr));
		} catch (MalformedURLException e) {
			e.printStackTrace();
			WeiXinLog.error("URL 解析异常--" + e.toString() + " url=" + urlStr);
		}
		Gson gson = new Gson();
		AccessToken accessToken = gson.fromJson(response, AccessToken.class);
		if (accessToken != null && accessToken.getExpires_in() != null) {
			accessToken.setExpiryTime(System.currentTimeMillis() + (Long.valueOf(accessToken.getExpires_in()) * 1000));
		}

		return accessToken;
	}

	public static OpenId requestOpenId(String appid, String secret, String code) {
		String urlStr = String.format(
				"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code",
				appid, secret, code);

		String response = null;
		try {
			response = HttpsUtils.httpGet(new URL(urlStr));
		} catch (MalformedURLException e) {
			e.printStackTrace();
			WeiXinLog.error("URL 解析异常--" + e.toString() + " url=" + urlStr);
		}

		Gson gson = new Gson();
		OpenId openId = gson.fromJson(response, OpenId.class);
		if (openId != null && openId.getExpires_in() != null) {
			openId.setExpiryTime(System.currentTimeMillis() + (Long.valueOf(openId.getExpires_in()) * 1000));
		}

		return openId;
	}

	public static JsApiTicket requestTicket(AccessToken accessToken) {
		String urlStr = String.format("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=%s&type=jsapi",
				accessToken.getAccess_token());

		String response = null;
		try {
			response = HttpsUtils.httpGet(new URL(urlStr));
		} catch (MalformedURLException e) {
			e.printStackTrace();
			WeiXinLog.error("URL 解析异常--" + e.toString() + " url=" + urlStr);
		}

		Gson gson = new Gson();
		JsApiTicket jsApiTicket = gson.fromJson(response, JsApiTicket.class);
		if (jsApiTicket != null && jsApiTicket.getExpires_in() != null) {
			jsApiTicket.setExpiryTime(System.currentTimeMillis() + (Long.valueOf(jsApiTicket.getExpires_in()) * 1000));
		}
		return jsApiTicket;
	}

	public static String getSha1(String ser) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-1");
		md.update(ser.getBytes());
		byte[] digest = md.digest();

		StringBuffer hexstr = new StringBuffer();
		String shaHex = "";
		for (int i = 0; i < digest.length; i++) {
			shaHex = Integer.toHexString(digest[i] & 0xFF);
			if (shaHex.length() < 2) {
				hexstr.append(0);
			}
			hexstr.append(shaHex);
		}
		return hexstr.toString();
	}

}
