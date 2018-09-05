document.write("<script type='text/javascript' src='http://res.wx.qq.com/open/js/jweixin-1.2.0.js'></script>"); // 导入weixin jssdk

// 取时间戳
function getTimestamp() {
	var timestamp = new Date().getTime()；
	return timestamp;
}

// 取随机字符串
function getNonceStr() {
	var len = 16;
	var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';    /****默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1****/
	var maxPos = $chars.length;
	var pwd = '';
	for (i = 0; i < len; i++) {
	　　pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
	}
	return pwd;
}

// 取当前完整的url
function getCurrAllUrl(){
	return window.location.href;
}

// 取ticket
function wxConfig(timestamp, nonceStr, url) {
	alert(timestamp);
	alert(nonceStr);
	alert(url);
	
	
	var xmlHttp = new XMLHttpRequest();
	var url = "http://" + window.location.host + "/wxConfig?timestamp=" + timestamp + "&nonceStr" + nonceStr + "&url=" + encodeURI(url);
	xmlHttp.open("GET", url, true);
	xmlHttp.onreadystatechange = function() {
		alert("response");
		
		if (xmlHttp.readyState==4 && xmlHttp.status==200) {
			alert("200");
			
			if (xmlHttp.responseText.success == "1") {
				alert("success");
				
				var signature = xmlHttp.responseText.sign;
				alert(signature);
				
				wx.config({
				    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
				    appId: 'wx8fd7b521a8c59fcd', // 必填，公众号的唯一标识
				    timestamp: timestamp, // 必填，生成签名的时间戳
				    nonceStr: nonceStr, // 必填，生成签名的随机串
				    signature: signature,// 必填，签名
				    jsApiList: ['chooseImage', 'chooseWXPay'] // 必填，需要使用的JS接口列表
				});
				
				wx.ready(function(){
				    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
					alert("lmf success");
				});
				
				wx.error(function(res){
				    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
					alert("lmf error");
				});
			}
		} else {
			// 网络失败
		}
	}
}

var timestamp = getSignature();
var nonceStr = getNonceStr();
var url = getCurrAllUrl();

wxConfig(timestamp, nonceStr, url);

/**
 * 选择照片
 * sourceType: album为想册中选择; camera为相机
 */ 
function chooseImage(sourceType) {
	wx.chooseImage({
		count: 1, // 默认9
		sizeType: ['original'], // 可以指定是原图还是压缩图，默认二者都有
		sourceType: [sourceType], // 可以指定来源是相册还是相机，默认二者都有
		success: function (res) {
				alert(res);
				var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			}
	});
}

/**
 * 支付
 * 
 * @returns
 */
function chooseWXPay() {
	wx.chooseWXPay({
		timestamp: 0, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
		nonceStr: '', // 支付签名随机串，不长于 32 位
		package: '', // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
		signType: '', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
		paySign: '', // 支付签名
		success: function (res) {
		// 支付成功后的回调函数
		}
		});
}



