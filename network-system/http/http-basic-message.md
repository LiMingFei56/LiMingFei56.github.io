---
layout: page
permalink: /network-system/http/http-basic-message
---

### 报文流

    inbound outbound - 描述事务处理(transaction)
    downstream upstream - 报文发送者都在接收者的上游，报文都是向下游流动的

### 报文的组成

    start line - 请求行说明要做些什么，响应行说明发生了什么
    header -
    body -

起始行和首部就是由行分隔的ASCII文本，每行都以一个回车符一个换行符来终止(也需要支持单个换行符)。
实体的主体是一个可选的数据块，可以包含文本或二进制数据

### 请求和响应报文的区别

    request message -  

        <method> <request-URL> <version>
        <headers>

        <entity-body>

    resqonse message -

        <version> <status> <reason-phrase>
        <headers>

        <entity-body>

### HTTP-header
首部延续行 - 将长的首部行分为多行可以提高可读性，多出来的每行前面至少要有一个空格或制表符

#### 通用首部 - 请求和响应中都可以用

    Connection - 连接
    Date - 报文创建时间
    MIME-Version - MIME版本
    Trailer - 分块传输编码，报文拖挂部分的首部集合
    Transfer-Encoding - 报文编码方式
    Update - 发送端想要升级使用的新版本或协议
    Via - 报文经过的中间节点
    
通用缓存首部

    Cache-Control - 随报文缓存指示
    Pragma - 随报文指示

#### 请求首部 - 提供更多有关请求的信息

    Client-IP - 客户端ip
    From - 客户端E-mail
    Host - 服务器的主机名和端口号
    Referer - 包含当前请求URI的文档的URL
    UA—Color - 客户端显示器颜色信息
    UA-CPU - 客户端CPU信息
    UA-Disp - 客户端显示器信息
    UA-OS - 客户端操作系统信息
    UA-Pixels - 客户端显示器像素信息
    User-Agent - 发起请求的应用程序信息

Accept首部

    Accept - 可以接收哪些媒体
    Accept-Charset - 可以接收哪些字符集
    Accept-Encoding - 可以接收哪些编码方式
    Accept-Language - 可以接收哪些语言
    TE - 可以接收哪些扩展传输编码

条件首部

    Expect - 列出要求服务器行为
    If-Match - 如果实体标记与文档当前的实体标记相匹配，就获取这份文档
    If-Modified-Since - 请求的资源需要在指定的日期后修改过，不然就限制
    If-None-Match - 不相符就获取文档
    If-Range - 允许对文档的某个范围进行条件请求
    If-Unmodified-Since - 请求的资源需要在指定的日期后没有修改
    Range - 请求资源的指定范围

安全首部

    Authorization - 认证的数据
    Cookie - 令牌
    Cookie2 - cookie版本

代理首部

    Max-Forward - 通过中转的最大次数，与TRACE方法一同使用
    Proxy-Authorization - 代理认证时使用
    Proxy-Connection - 代理连接时使用

#### 响应首部 - 提供更多有关响应的信息

    Age - 响应持续时间
    Public - 请求方法列表
    Retry-After - 资源不可用的重试时间
    Server - 服务器应用名称和版本
    Title - HTML标题
    Warning - 比原因短语中更详细一些的警告报文

协商首部

    Accept-Ranges - 对此资源来说，服务器可接受的范围类型
    Vary - 服务器查看的其他首部列表

安全首部

    Proxy-Authenticate - 代理对客户端的质询列表
    Set-Cookie - 在客户端设置一个令牌
    Set-Cookie2 - 与Set-Cookie类似
    WWW-Authenticate - 来自服务器的质询列表

#### 实体首部 - 描述主体的长度和内容，或者资源自身

    Allow - 对这实体执行的请求方法
    Location - 实体实际上位于何片，用于将接收端定向到资源的位置上

内容首部

    Content-Base - 解析主体中的相对URL时使用的基础URL
    Content-Encoding - 主体的编码方式
    Content-Language - 主体的自然语言
    Content-Length - 主体的长度或尺寸
    Content-location - 资源实际所处的位置
    Content-MD5 - 主体的MD5校验和
    Content-Range - 整个资源中些实体表示的字节范围
    Content-Type - 主体的对象类型

实体缓存首部

    ETag - 与实体相关的实体标记
    Expires - 实体不再有效
    Last-modified - 这个实体最后一次被修改的日期和时间

#### 扩展首部 - 规范中没有定义的新首部


### 请求的方法
安全方法-GET和HEAD方法，不会产生什么动作

    GET - 获取资源
    HEAD - 不获取资源，只获取首部来查看资源的状态（需要确保与GET的首部一样）
    PUT - 向服务器写入文档，如果存在就覆盖，对文档的数据写入
    POST - 向服务器发送数据，一般用于表单提交
    TRACE - 请求可能要穿过防火墙、代理、网关或者其他一些应用，这个方法可以查看最终服务器收到的报文
            多用于论断
    OPTIONS - 请求服务器支持的方法
    DELETE - 请示服务器删除请求URL所指定的资源


### Content-Type
#### application/x-www-form-urlencoded 
    常用于表单提交

    POST http://www.example.com HTTP/1.1 
    Content-Type: application/x-www-form-urlencoded;charset=utf-8 

    title=test&sub%5B%5D=1&sub%5B%5D=2&sub%5B%5D=3 

#### multipart/form-data 
    常用于文件上传

    POST http://www.example.com HTTP/1.1 
    Content-Type:multipart/form-data; boundary=----WebKitFormBoundaryrGKCBY7qhFd3TrwA 
    
    ------WebKitFormBoundaryrGKCBY7qhFd3TrwA 
    Content-Disposition: form-data; name="text" 
    
    title 
    ------WebKitFormBoundaryrGKCBY7qhFd3TrwA 
    Content-Disposition: form-data; name="file"; filename="chrome.png" 
    Content-Type: image/png 
    
    PNG ... content of chrome.png ... 
    ------WebKitFormBoundaryrGKCBY7qhFd3TrwA-- 

#### application/json

    POST http://www.example.com HTTP/1.1 
    Content-Type: application/json;charset=utf-8 
    
    {"title":"test","sub":[1,2,3]} 

#### text/xml 

    POST http://www.example.com HTTP/1.1 
    Content-Type: text/xml 
    
    <!--?xml version="1.0"?--> 
    <methodcall> 
        <methodname>examples.getStateName</methodname> 
        <params> 
            <param> 
                <value><i4>41</i4></value> 
             
        </params> 
    </methodcall> 

[MIME 参考手册](http://www.w3school.com.cn/media/media_mimeref.asp)
