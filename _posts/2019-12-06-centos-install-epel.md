---
layout: post
title: "Centos 8 安装epel源"
categories: linux
tags: [centos, epel]
date: 2019-12-06
excerpt: "Centos 8 安装epel源"
---

## Centos 8 安装epel源

    yum install epel-release -y
    yum install aria2 -y

    1. wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    2. rpm -ivh epel-release-latest-7.noarch.rpm
    3. yum -y install aria2

但是提示找不到aria2这个包

## 手动下载rpm包
[fedoraproject](https://dl.fedoraproject.org)

    https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/a/aria2....rpm

    rpm -ivh aria2...rpm

但是提示缺少依赖

## 安装依赖包
需要使用yum-utils工具

    yum -y install yum-utils

    yumdownloader libgcc // 可以把包下载到本地
    yum whatprovides libgcc_s.so.1  // 可以查找是哪个包提供.so文件

但是找不到提供的库

## 网上找
[pkgs.org](https://pkgs.org/)

找到后发现上面下载的aria2包依赖的库, 是旧版本的, 新版本中没有这个so文件

## 源码编译
[aria2 doc](https://github.com/aria2/aria2)

    autoreconf -i
    // 使用openssl 关闭gnutls 指定ca-bundle文件   不然请求https时需要带 --check-certificate=false参数
    // ca-bundle 各linux发行版本不同
    ./configure --with-ca-bundle='/etc/ssl/certs/ca-bundle.crt' ARIA2_STATIC=yes --without-gnutls --with-openssl
    make
    make caeck // 可选 单元测试
    make install

还是提示不支持https 疯了

## 排查
[aria2 build](https://aria2.github.io/manual/en/html/README.html#how-to-build)
上面网页中罗列了依赖库

一个个的排查, 如`libgnutls-dev`
    
    yum search libgnutls-dev // 搜不到
    yum search gnutls // 搜这个

    yum -y install gnutls gnutls-devel
    yum -y install nettle nettle-devel
    yum -y install gmp gmp-devel
    yum -y install libssh2
    yum -y install c-ares c-ares-devel
    yum -y install libxml2 libxml2-devel
    yum -y install zlib zlib-devel
    yum -y install sqlite-libs sqlite-devel
    yum -y install pkgconf-pkg-config
    yum -y install libgcrypt-devel
    yum -y install openssl-libs openssl-devel

安装(cpputil)[https://sourceforge.net/projects/cppunit/files/cppunit/1.12.1/]

    tar -xvf ./cppunit-1.12.1.tar.gz
    ./configuer
    make
    make install

各linux发行版本不同, 上面有可能也不全

    删除原来的aria2源码, 重新解压
    autoreconf -i
    ./configuer ARIA2_STATIC=yes
    make
    sudo make install

测试

    aria2c https://www.baidu.com  // 正常


