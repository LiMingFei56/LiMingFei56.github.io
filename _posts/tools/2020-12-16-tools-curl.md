---
layout: post
title: "Linux curl"
categories: linux
tags: [linux]
date: 2020-12-16
---

## Linux curl

    curl -fsSL www.baidu.com

    curl -X POST https://updsstg.sp.com.sa/csapi/token -H 'Content-Type: application/x-www-form-urlencoded' -d 'UserName=SPAdmin&password=P@ssw0rdComplex#$@#$#@@$##@$$3##$%&grant_type=password'


### 查看curl 访问时间

    curl -o /dev/null -s -w %{time_namelookup}::%{time_connect}::%{time_starttransfer}::%{time_total}::%{speed_download}"\n" http://www.36nu.com 
    0.014::0.015::0.018::0.019::1516256.00

* time_namelookup：DNS 解析域名www.36nu.com的时间
* time_commect：client和server端建立TCP 连接的时间
* time_starttransfer：从client发出请求；到web的server 响应第一个字节的时间
* time_total：client发出请求；到web的server发送会所有的相应数据的时间
* speed_download：下载速度 单位 byte/s

## Reference

