---
layout: post
title: "Linux Nginx"
categories: linux
tags: [linux]
date: 2020-12-22
---

## Linux Nginx


### 导入配置

> 在http段中加入

    include vhost/*.conf;

### Proxy
[NGINX Reverse Proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)  
  
#### Proxy Header

> 默认情况下会把源请求头转发给目标地址(默认`proxy_pass_request_headers on;`).
> 
> 如果请求头包含下划线, 那么会忽略这个请求头.
> 需要使用`underscores_in_headers on;` 来打开 (http | service标签下)

### 超时

    // http service local
    keepalive_timeout 600s;
    client_body_timeout 600s;
    send_timeout 600s;
    proxy_connect_timeout 600s;
    proxy_read_timeout 600s;
    proxy_send_timeout 600s;

### 缓冲区

    proxy_buffers 16 16k;  
    proxy_buffer_size 16k;

### 问题

1. no resolver defined to resolve xxx.xxx

> Nginx0.6.18以后的版本中启用了一个resolver指令，在使用变量来构造某个server地址
> 的时候一定要用resolver指令来制定DNS服务器的地址。
> 
> 在nginx的配置文件中的http{}部分添加一行`resolver 8.8.8.8;`即可

2. peer closed connection in SSL handshake

[Nginx - Upstream SSL - peer closed connection in SSL handshake](https://stackoverflow.com/questions/46467613/nginx-upstream-ssl-peer-closed-connection-in-ssl-handshake)  
> 在`proxy_pass`里添加`proxy_ssl_server_name on;`

## Reference
[Nginx](http://nginx.org/en/#generic_proxy_server_features)  
[Nginx doc](http://nginx.org/en/docs/)  
[Nginx配置请求转发location及rewrite规则](https://www.cnblogs.com/kanyun/p/7466309.html)  
[How can query string parameters be forwarded through a proxy_pass with nginx?](https://stackoverflow.com/questions/8130692/how-can-query-string-parameters-be-forwarded-through-a-proxy-pass-with-nginx)  
