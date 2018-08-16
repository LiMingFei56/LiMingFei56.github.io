---
layout: page
permalink: /network-system/http/http-integration-point
---

## 集成点

### 网关
作为某种翻译器使用，它抽象出了一种能够到达资源的方法。网关是资源和应用程序之间的粘合剂。

服务器端网关(Server-side gateway) - 使用HTTP与客户端通信，通过其他协议与服务器通信(HTTP/*)
客户端网关(client-side gateway) - 通过其他协议与客户端对话，通过HTTP与服务器通信(*/HTTP)

#### 协议网关


#### 资源网关
应用程序服务器是服务器端网关，与客户端通过HTTP进行通信，并与服务器端的应用程序相连

CGI Common Gateway Interface - 通用网关接口

RPC Remote procedure call - 远程过程调用

### 隧道
Web隧道-Web tunnel 使用HTTP连接发送非HTTP协议的数据，使用HTTP的CONNECT方法建立连接。
用来发送TCP数据.

SSL隧道：使用WEB隧道发送SSL加密数据， 端口443

SSL隧道与HTTP/HTTPS网关的对比：
* 网关有一端是使用不安全的HTTP
* 客户端不能认证

隧道要有安全考虑，不要随便打开隧道端口

### 中继
HTTP中断(relay)是没有完全遵循HTTP规范的简单HTTP代理，只能盲转发。
需要注意的是持久连接的问题，
