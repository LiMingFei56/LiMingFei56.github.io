---
layout: page
permalink: /network-system/http/http-identifying-user
---

## 客户端识别

通过From的E-mail来识别用户
通过Referer来识别用户-可以知道用户从哪里来
通过User-Agent来识别用户-只能知道是什么浏览器

通过IP地址识别 - 不能唯一确定用户

通过用户登录 - Authenticate WWW-Authenticate首部， 不方便 不安全

通过胖URL - 对每个用户生成特写的URL的文档，文档不能缓存，URL容易丢


### Cookie
domain : 域    只有站点匹配域，才传对应的cookie
secure : 安全  是否只有在使用SSL连接时才发送这个cookie
expiration: 过期 绝对时间设置过期时间
name : 名字 
value : 值
path : 路径属性 - URL要匹配这个路径才传

cookies版本0
    
    Set-Cookie: name=value [; expires=date] [; path=path] [; domain=domain]
    [; secure]

    客户端会把服务器所有Set-Cookie组合成Cookie传回去
    Cookie: name1=value1 [; name2=value2]...

cookies版本1
    见书

因为浏览器可以关闭cookies，所以最好cookies与上面其他的方法一起合用
但是目前可以不考虑cookies关闭 99%都是开启的
