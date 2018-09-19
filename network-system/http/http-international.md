---
layout: page
permalink: /network-system/http/http-international
---

## 国际化

http通过字符编码和语言设置来处理同一URI下不同语言。

### 客户端支持的语言及编码

Accept-Language: fr, en;q=0.8   (q为优先级)
Accept-Charset: iso-8859-1, utf-8

### 服务器端设置语言及编码

Content-Type: charset=utf-8
Content-Language: fr

### 语言标记
语言标记不区分大小写

语言标记分类：
    * 一般 es
    * 国家 en-GB
    * 方言 no-bok
    * 地区 sgn-US-MA
    * 标准 i-navajo
    * 非标 x-snowboarder-slang

语言标记的组成：
    语言标记 = 主子标记-可选子标记-可选未注册子标记
    sgn-US-MA

### 国际化的URI
URI为了通用及方便传输，所以使用的是ASCII受限字符集。所以特定国家的语言需要转码，才
能在URI中使用



### 日期
日期发送,Date，需要发送Content-Language中设置的语言格式
