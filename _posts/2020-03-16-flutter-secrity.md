---
layout: post
title: "Flutter 加解密"
categories: flutter
tags: [encode]
date: 2020-03-16
excerpt: "Flutter 加解密"
---

## Flutter 加解密及转换


### Flutter 签名

* SHA-1
* SHA-224
* SHA-256
* SHA-384
* SHA-512
* MD5
* HMAC (i.e. HMAC-MD5, HMAC-SHA1, HMAC-SHA256)

MD5:

    var digest = md5.convert(List<int>);
    var str = hex.encode(digest.bytes);

### Reference
[crypto 签名](https://pub.flutter-io.cn/packages/crypto)
[convert 转换工具](https://pub.flutter-io.cn/packages/convert)
[dart:convert 系统转换工具](https://api.dart.dev/stable/2.7.1/dart-convert/dart-convert-library.html)
