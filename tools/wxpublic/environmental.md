---
layout: page
permalink: /tools/public/environmental
---

## 环境说明

主要配置的url:

    1. IP白名单
    2. 基本配置-服务器配置
    3. 接口权限-网页授权获取用户基本信息-修改
    4. 自定义菜单-网页授权回调
    5. JS域名 一个月只能修改3次

### 1. AppSecret
    配置好后不能查看，需要保存好

### 2. 服务器配置
    需要服务器提供微信认证的接口，见https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421135319
    服务器可以配置path，返回echostr参数

### 3. 微信网面授权
    见https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140842

    1. 配置业务域名，可以配置3个
    2. 需要把特定文件，按要求传到服务器中
    3. 授权url 不能用https, 不然android打不开，要用http


### 4. 自定义菜单

    1. 创建时如果用的查询出来的json，那么需要去掉{"menu":..}这一层
    2. 只一级3个  二级5个  没有三级
    3. 可以有接口配置和管理后台配置，如果用接口配置就不能用管理后台

### 5. JSSDK使用步骤
    
    1. 配置JS域名
    2. 引入JS文件 http://res.wx.qq.com/open/js/jweixin-1.2.0.js
    3. 通过config接口注入权限验证配置
    4. ready 成功   error 失败

### 6. Token
    一般有效期为7200秒

    1. 一般AccessToken, 属于公众号，调用公众号接口时使用
    2. 用户AccessToken, 访问用户相关的接口时使用
    3. jsapi_ticket, 调用jssdk时使用
