---
layout: page
permalink: /android/url_scheme
---
## Uri-Scheme介绍和使用
    由于苹果的app都是在沙盒中，相互是不能访问数据的。但是苹果还是给出了一个可以
在app之间跳转的方法：URL Scheme。简单的说，URL Scheme就是一个可以让app相互之间
可以跳转的协议。每个app的URL Scheme都是不一样的，如果存在一样的URL Scheme，那么
系统就会响应先安装那个app的URL Scheme，因为后安装的app的URL Scheme被覆盖掉了
，是不能被调用的。

    那么app之间的跳转有什么作用呢？我们所使用的每一个app就相当于一个功能，app的
跳转可以使得每个app就像一个功能组件一样，帮助我们完成需要做的事情，比如三方支付
，搜索，导航，分享等等。

### Android使用Scheme
在Android中一般使用Intent来实现应用间的跳转,但是如果想在H5中实现App的跳转就要使用
Uri Scheme.

#### Uri Scheme说明
xl://goods:8888/goodsDetail?goodsId=10011002

scheme: xl
主机地址: goods
端口号: 8888
地址: goodsDetail
参数: goodsId=10011002


#### Activity配置
	<intent-filter>
		<!--协议部分，随便设置-->
		<data android:scheme="xl" android:host="goods" android:path="/goodsDetail" android:port="8888"/>
        <!--下面这几行也必须得设置-->
        <category android:name="android.intent.category.DEFAULT"/>
        <action android:name="android.intent.action.VIEW"/>
        <category android:name="android.intent.category.BROWSABLE"/>
    </intent-filter>

	Intent i_getvalue = getIntent();
	String action = i_getvalue.getAction();
	if(Intent.ACTION_VIEW.equals(action)){
	
	Uri uri = i_getvalue.getData();
