---
layout: post
title: "Node HTTP"
categories: lib
tags: [lib]
date: 2021-04-13
---

## Node HTTP

http: 为http协议的库
https: 为https协议的库
http2: 为http2协议的库

### 添加超时时间

	options中:
		timeout: 5000
	
	request.on('timeout', () => {})

	req.on('socket', function (socket) {
    socket.setTimeout(myTimeout);  
    socket.on('timeout', function() {
        req.abort();
    });
	});

	setTimeout(req.abort.bind(req), 3000);



### 问题

1. Uncaught Exception: Error: socket hang up

	当socket关闭了, 还调用socket时触发

2. Uncaught Exception: Error: certificate has expired

	https 证书过期
	在option中添加

	strictSSL: false,
	rejectUnauthorized: false


### Reference

