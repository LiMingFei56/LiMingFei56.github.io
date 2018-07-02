---
layout: page
permalink: /network-system/http/http-basic
---

    * Web客户端与服务器是如何通信的；
    * （表示Web内容的）资源来自何方；
    * Web事务是怎么工作的；
    * HTTP通信所使用的报文格式；
    * 底层TCP网络传输；
    * 不同的HTTP协议变体；
    * 因特网上安装的大量HTTP架构组件中的一部分

#### 1. HTTP事务

    HTTP服务器: 使用HTTP协议共享资源的Web服务器
    HTTP客户端: 使用HTTP协议请求存储在HTTP服务器上的资源
    HTTP事务: 由HTTP客户端的HTTP请求，HTTP服务器的HTTP响应构成

#### 2. 资源
    
    媒体类型 -- MIME type
    URI      -- Uniform Resource Idenitifier, 统一资源标识符, 在世界范围内唯一标识并定位
                信息资源，现在说的URI一般指的是URL
    URI->URL -- Uniform Resource Locator, 统一资源定位符, 描述一台特定服务器上的
                某资源的特定位置。scheme + hostname + path定位
    URI->URN -- Uniform Resource Name，统一资源名，描述特定内容的唯一名称，与目前的
                资源所在地无关。使用URN，可以在不同地址，使用不同访问协议来得到相同的资源。

#### 3. 方法

    GET      -- 请求资源
    PUT      -- 把数据传递给服务器
    DELETE   -- 删除服务器中的资源
    POST     -- 将数据发送到一个服务器网关应用程序
    HEAD     -- 仅发送请求资源的响应头

#### 4. 状态码

    200      -- OK
    300      -- 重定向
    400      -- 请求错误
    500      -- 服务器错误

#### 5. 组件

    代理     -- 中间件，信息安全，应用集成，性能优化
    缓存     -- 特殊的HTTP代理服务器Web cache/proxy cache
    网关     -- 特殊的服务器，将HTTP转换成其他的协议
    隧道     -- 转发非http数据，不会窥探数据，一般用于SSL
    Agent代理-- 代表用户发启http请求的程序，一般为浏览器
