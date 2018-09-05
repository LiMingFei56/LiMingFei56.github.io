---
layout: page
permalink: /network-system/http/http-identifying-basic
---

## 基本认证

HTTP提供了原生的质询/响应(challenge/response)框架：

    1. 客户端访问授限的资源
    2. 服务器质询客户身份 - WWW-Authenticate 401 Unauthorized
        WWW-Authenticate: Basic realm="Corporate Financials"

    3. 客户端根据安全域授权 - Authorization 包含认证算法 Base64的用户名和密码
    4. 成功 - 返回资源文件 HTTP 200 OK

    注： Authentication-Info 对高级的认证算法里，包含授权信息返回

### 安全域
服务器端实现不同的资源使用不同的访问权限。包含在WWW-Authenticate中。
安全域是服务器自定义的字符串

        WWW-Authenticate: Basic realm="Corporate Financials"

### 代理认证

    质询返回码 Unauthorized status code: 407
    质询头:Proxy-Authenticate
    授权头:Proxy-Authorication
    授权附加信息头:Proxy-Authentication-Info

### 缺点

    1. 明文用户名和密码
    2. 可以请求重放
    3. 可以修改报文
    4. 很容易假冒服务器


