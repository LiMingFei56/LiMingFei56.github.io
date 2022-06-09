---
layout: post
title: "selenium 浏览器机器人检测"
categories: rpa
tags: [rpa]
date: 2022-03-28
---

## selenium 浏览器机器人检测
> selenium是使用[WebDriver](https://www.w3.org/TR/webdriver/)API, 实现网页浏览自动化.
> 有自动化, 也有反自动化. 使用WebDriver会在浏览器中有特有的指纹, 通过这些指纹可以判断
> 浏览器是否为自动化访问, 从而进行处理. [机器人浏览器检测](https://www.w3.org/TR/webdriver/)

### selenium隐身

> selenium打开新页面的时候调用[stealth.min.js](https://github.com/requireCool/stealth.min.js)

			stealth_path = "/Users/limingfei/myenv/git/stealth.min.js/stealth.min.js"
			with open(stealth_path) as stealth:
				stealthjs = stealth.read()
				self.driver.execute_cdp_cmd("Page.addScriptToEvaluateOnNewDocument", {
						"source": stealthjs
				})


### Reference
[Selenium被检测为爬虫，怎么屏蔽和绕过](https://zhuanlan.zhihu.com/p/484522386)  
[浏览器指纹识别与浏览器指纹在线检测网站工具](https://zhuanlan.zhihu.com/p/461968729)  
[针对selenium的指纹识别](http://www.chipscoco.com/?id=231)  
[Selenium真正绕过webdriver检测](https://benpaodewoniu.github.io/2021/04/22/python136/)  
[puppeteer-extra](https://github.com/berstend/puppeteer-extra)  
[requireCool/stealth.min.js](https://github.com/requireCool/stealth.min.js)  
