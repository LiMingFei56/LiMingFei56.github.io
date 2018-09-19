---
layout: page
permalink: /network-system/http/http-content
---

## 内容协商
为了使得同一个URI下，返回的文档对象不一样（主要为语言地区不同），可以进行内容协商

### 客户端驱动的协商
1. 客户端请求URI
2. 服务器返回供客户选择的页面(1. 返回一个HTML文档；2. 返回响应 300 Multiple Choices)
3. 客户端根据服务器返回，显示窗口供用户选择(1. 显示一个HTML页面；2. 弹出一个Dialog)

优点：决定是由用户作出的
缺点：多次交互增加时延；需要多个URL

### 服务器驱动的协商
服务器通过客户提供的Accept首部来判断使用的语言

Accept Content-Type
Accept-Language Content-Language
Accept-Charset Content-Type
Accept-Encoding Content-Encoding

Accept-Language中可以q选项，设置语言的优先级

User-Agent也可以作为协商的参考

使用type-map和MultiView可以在服务器中配置内容协商，自动匹配

Vary首部列出客户端所有请求首部，服务器可以选择首部来进行协商

### 转码
根据客户端的首部信息，对返回的文档进行处理转码：

    HTML 转 WML
    高分辨率 转 低分辨率

