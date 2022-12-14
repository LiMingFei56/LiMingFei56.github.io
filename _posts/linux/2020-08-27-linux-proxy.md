---
layout: post
title: "Linux proxy Config"
categories: linux
tags: [linux]
date: 2020-08-27
---

## Linux proxy Config

    # bash
    export http_proxy=http://127.0.0.1:your port
    export https_proxy=http://127.0.0.1:your port
    export no_proxy=127.0.0.1,localhost

    # fish
    set -Ux http_proxy http://127.0.0.1:your port
    set -Ux https_proxy http://127.0.0.1:your port
    set -Ux no_proxy 127.0.0.1,localhost

    # del evn
    export http=
    set -e ...

    export all_proxy=sock5://127.0.0.1:1080

## java 中使用sock5

    java -DsocksProxyHost=192.168.2.148 -DsocksProxyPort=1080  -jar sdbdc-admin/target/sdbdc-admin.jar 

    Properties prop = System.getProperties();
    // 设置http访问要使用的代理服务器的地址
    prop.setProperty(“http.proxyHost”, “183.45.78.31”);
    // 设置http访问要使用的代理服务器的端口
    prop.setProperty(“http.proxyPort”, “8080”);
    // 设置不需要通过代理服务器访问的主机，可以使用通配符，多个地址用|分隔
    prop.setProperty(“http.nonProxyHosts”, "localhost|192.168.0.");
    // 设置安全访问使用的代理服务器地址与端口
    // 它没有https.nonProxyHosts属性，它按照http.nonProxyHosts 中设置的规则访问
    prop.setProperty(“https.proxyHost”, “183.45.78.31”);
    prop.setProperty(“https.proxyPort”, “443”);
    // 使用ftp代理服务器的主机、端口以及不需要使用ftp代理服务器的主机
    prop.setProperty(“ftp.proxyHost”, “183.45.78.31”);
    prop.setProperty(“ftp.proxyPort”, “21”);
    prop.setProperty(“ftp.nonProxyHosts”, “localhost|192.168.0.*”);
    // socks代理服务器的地址与端口
    prop.setProperty(“socksProxyHost”, “183.45.78.31”);
    prop.setProperty(“socksProxyPort”, “1080”);
    // 设置登陆到代理服务器的用户名和密码
    Authenticator.setDefault(new MyAuthenticator(“userName”, “Password”));

## 未走代理

    有些软件和程序不支持走代理, 如Redis, 上面设置没效果. 需要[proxifier](https://www.zhihu.com/question/37610676/answer/2262191475)软件, 可以在底层修改路由, 强制走代理

    [Jedis](https://github.com/redis/jedis/pull/1707) 
    [Lettuce]不支持proxy
    [Redisson]不确定

## 代理软件

* proxifier
* proximac 需要更新适配

### Reference

