---
layout: post
title: "Weixin开发介绍"
categories: weixin
tags: [intro]
date: 2019-11-25
excerpt: "Weixin开发介绍"
---

# 微信开发

## 微信公众号

### 1. 准备

服务器要求:
	1. 需要域名
	2. 需要80或443端口(http或https)
	3. 路径只支持字母, 数字, -. 不支持下划线

微信账号要求:
	1. 需要认证(自定义菜单, 及消息事件处理)
	2. 如果需要获取用户的UnionId, 那么需要服务号(订阅号不支持)

### 2. 微信公众号配置

#### 1. 基本配置-服务器配置
开启后微信有信息或者事件就会通知服务器(如用户跟公众号发信息, 用户关注了公众号等).

`注: 开启后在页面里配置的菜单将失效, 需要调用接口来配置菜单`

1. 服务器地址: 接收微信消息的接口地址, 所以信息发送到这一个接口, Get请求用来认证
	, Post请求才是接收信息和事件.
2. 令牌: 自定义加密串, 用来认证和加密的
3. 消息加解密密钥: 自定义加密串, 加解密密钥
4. 消息加解密方式: 使用密钥加密, 选择安全模式

[微信加解密说明](https://developers.weixin.qq.com/doc/oplatform/Third-party_Platforms/Message_Encryption/Message_encryption_and_decryption.html)

#### 2. 基本配置-公众号开发信息
1. AppId: 唯一识别公众号
2. AppSecret: 唯一识别公众号, 加解密使用
3. IP白名单: 使用微信JSSDK和获取access_token时使用

#### 3. 网页授权
微信公众号里获取用户基本信息, 需要使用网页授权

1. 配置授权: 开发->接口权限->网页服务->网页授权(需要认证和服务号)
2. 组装授权URL

[微信网页授权](https://developers.weixin.qq.com/doc/offiaccount/OA_Web_Apps/Wechat_webpage_authorization.html)



### 遇到问题

1. 加解密遇到illegal key size

	JDK发布时, 应美国政府要求, 限制了计算密钥长度.(OpenJdk新版本没有问题)
	需要使用Oracle提供的Jar包, 破除限制
	http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html
	下载后解压，可以看到local_policy.jar和US_export_policy.jar以及readme.txt
	如果安装了JRE，将两个jar文件放到%JRE_HOME%\lib\security目录下覆盖原来的文件
	如果安装了JDK，将两个jar文件放到%JDK_HOME%\jre\lib\security目录下覆盖原来文件




## 微信小程序

需要https, 域名需要ipc备案
