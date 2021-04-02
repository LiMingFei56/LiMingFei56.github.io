---
layout: post
title: "Net Http Authorization"
categories: net
tags: [net]
date: 2020-12-03
---

## Net Http Authorization

### Basic

`Authorization: Basic jdhaHY0=`

Authorization: http head  
Basic: 认证方式  
jdhaHY0=: user:passwd base64  

Authorization: Basic Base64(username:password)

服务端在未授权时返回 HTTP 401 及如下 HTTP HEADER

    WWW-Authenticate: Basic realm="User Visible Realm"

### Bearer token

使用Authorization Basic登陆后会拿到token  

`Authorization: Bearer ${token}`  

### Digest Authentication

> 这是 HTTP 数字授权，定义在 RFC 2069中,后来在RFC 2617中被重新定义，比 Basic Auth
> 还要早，此方法适用了数字签名的方式保护了信息的安全性

1. 客户端请求
2. 服务器返回

    WWW-Authenticate: Digest realm="testrealm@host.com",
                        qop="auth,auth-int",
                        nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093",
                        opaque="5ccc069c403ebaf9f0171e9517f40e41"

3. 客户端使用服务器返回的数据加密(默认MD5)

    Authorization: Digest username="Mufasa",
                     realm="testrealm@host.com",
                     nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093",
                     uri="/dir/index.html",
                     qop=auth,
                     nc=00000001,
                     cnonce="0a4f113b",
                     response="6629fae49393a05397450978507c4ef1",
                     opaque="5ccc069c403ebaf9f0171e9517f40e41"

### JWT (Json Web Tokens)

> JWT 是基于开源标准(RFC 7519)自包含紧凑的通过json 传递安全信息的一种方式，因为
> 它使用了数字签名所以可以被信任，JWTs 可以使用带密钥的数字签名(例如HMAC)或者非
> 对称密钥对(RSA 或者 ECDSA)进行签名，因为不需要存储所以在分布式以及集群服务的
> 应用中不会有单点数据节点的问题，而且不去要频繁的查询只是需要频繁的验证签名

### OAuth2

## Reference
[HTTP API 授权认证有哪些方式？(Authoration, Authentication)](https://www.jianshu.com/p/71254888b9cc)  
