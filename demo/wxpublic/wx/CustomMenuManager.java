package org.ppnsr.wx;

import java.net.MalformedURLException;
import java.net.URL;

import org.ppnsr.wx.utils.HttpsUtils;

public class CustomMenuManager {

	public static void create() throws MalformedURLException {
		String accessToken = TokenManager.getAccessToken().getAccess_token();
		String url = String.format("https://api.weixin.qq.com/cgi-bin/menu/create?access_token=%s", accessToken);
		String result = HttpsUtils.httpPost(new URL(url), "{\"menu\":{\"button\":[{\"name\":\"☀服务\",\"sub_button\":[{\"name\":\"车管所\",\"sub_button\":[{\"type\":\"view\",\"name\":\"车管所首页\",\"url\":\"https:\\/\\/open.weixin.qq.com\\/connect\\/oauth2\\/authorize?appid=wx8fd7b521a8c59fcd&redirect_uri=https:\\/\\/www.tracking56.com\\/login?type=home&response_type=code&scope=snsapi_base&state=home#wechat_redirect\",\"sub_button\":[], {\"type\":\"view\",\"name\":\"车管所个人中心\",\"url\":\"https:\\/\\/open.weixin.qq.com\\/connect\\/oauth2\\/authorize?appid=wx8fd7b521a8c59fcd&redirect_uri=https:\\/\\/www.tracking56.com\\/login?type=mine&response_type=code&scope=snsapi_base&state=mine#wechat_redirect\",\"sub_button\":[]}}]}, {\"type\":\"view\",\"name\":\"自助查询\",\"url\":\"http:\\/\\/www.youzan.com\\/v2\\/x\\/cdgql9hj\",\"sub_button\":[]},{\"type\":\"click\",\"name\":\"交通违章\",\"key\":\"xk0gj8ep\",\"sub_button\":[]},{\"type\":\"view\",\"name\":\"资费\\/网点\",\"url\":\"http:\\/\\/www.youzan.com\\/v2\\/x\\/uifz0bqa\",\"sub_button\":[]}]},{\"name\":\"☀便民\",\"sub_button\":[{\"type\":\"click\",\"name\":\"证照专递\",\"key\":\"1amjjokji\",\"sub_button\":[]},{\"type\":\"view\",\"name\":\"便民电话\",\"url\":\"https:\\/\\/h5.youzan.com\\/v2\\/showcase\\/category?alias=191g3j62q&sf=wx_menu\",\"sub_button\":[]},{\"type\":\"view\",\"name\":\"金点子\",\"url\":\"http:\\/\\/www.youzan.com\\/v2\\/x\\/qlfdq1tw\",\"sub_button\":[]}]},{\"type\":\"view\",\"name\":\"☀微商城\",\"url\":\"https:\\/\\/h5.youzan.com\\/v2\\/showcase\\/feature?alias=BiVoOV8LwM&sf=wx_menu\",\"sub_button\":[]}]}}");
		System.out.println(result);
	}
	
	public static void query() throws MalformedURLException {
		String accessToken = TokenManager.getAccessToken().getAccess_token();
		String url = String.format("https://api.weixin.qq.com/cgi-bin/menu/get?access_token=%s", accessToken);
		String result = HttpsUtils.httpGet(new URL(url));
		System.out.println(result);
	}
	
	public static void delete() {
		
	}
	
	public static void main(String[] args) throws MalformedURLException {
		create();
	}
	
}
