---
layout: page
permalink: /network-system/http/http-identifying-digest
---

## 摘要认证
为了解决基本认证的缺陷

### 1. 用摘要密码
一般摘要算法  MD5(默认)  MD5-sess

### 2. 用随机字符串防止重放攻击

nonce字符串

### 3. 握手机制

    1. WWW-Authenticate 质询：发送域、随机数和算法
    2. Authorization 响应：发送算法、客户端随机数（用来验证服务器）
    3. Authentication-Info 信息：发送服务器下一个随机数，发送客户端rspauth摘要

### 4. 安全策略
上面的3个头可以包含qop保护质量字段，用来防止请求被篡改

qop="auth" - 只包含HTTP请求方法和URL
qop="auth-int" - 添加了报文实体的主体部分
