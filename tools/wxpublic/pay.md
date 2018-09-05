---
layout: page
permalink: /tools/wxpublic/pay
---

## 微信公众号支付

### 微信APIwx.chooseWXPay 和 getBrandWCPayRequest区别

    getBrandWCPayRequest 不用调wx.config()
    wx.chooseWXPay需要先调用wx.config(), 内部实现还是调的getBrandWCPayRequest()

    var response = eval('(' + responseStr + ')'); // 
		alert(JSON.stringify(res)); // 查看getBrandWCPayRequest的详细错误信息
