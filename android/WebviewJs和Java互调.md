## WebviewJs和Java互调

### Js调用Java

1. webview需要支持Js
	settings.setJavaScriptEnabled(true);

2. webview添加Java接口
	web.addJavascriptInterface(new JsInteration(), "control");

	第一个参数是java接口,android版本17开始,为了安全考虑,每个可以被JS调用的方法,
	需要使用@JavascriptInterface注解.

	第二个参数是Js调用对象的名字.

3. Js调用java

	window.control.callCamera()

### Java调用Js

	String js = "javascript:setImageStr(\"" + imageString + "\")";
	webView.loadUrl(js);

	4.4版本前是使用webkit内核
	4.4版本后是使用Chromium内核

	为了二种都支持, 所以javascript要全小写
