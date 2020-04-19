---
layout: post
title: "iOS 签名打包"
categories: ios
tags: [ios, signature]
date: 2020-04-18
excerpt: "iOS 签名打包"
---

## iOS 签名打包

### 苹果开发者账号
1. 个人(Individual)
  99美元一年, 上架App Store, 100个UUID

2. 公司(Company)
  99美元一年, 上架App Store, 100个UUID, 可以管理多个开发者

3. 企业(Enterprise)
  299美元一年, 企业内部使用(In house), UUID不限, 管理多个开发者

4. 教育(Educational Institutions)

### 打包

#### App Stroe上传

#### 企业应用打包

### 重签名

### 查看证书是否过期
cer证书

  unzip -q MyApp.ipa
  codesign -d --extract-certificates Payload/\*.app
  openssl x509 -inform DER -in codesign0 -noout -nameopt -oneline -dates
  codesign -dv --verbose=4 Payload/\*.app

mobileprovision描述文件

  more Payload/Runner.app/embedded.mobileprovision
  

### 操作签名文件

p12文件转成pem文件
openssl pkcs12 -in xxx.p12 -out xxx.pem -nodes
openssl pkcs12 -in xxx.p12 -out xxx.pem -nodes -password pass:'xxxpasword'

查看mobileprovision
security cms -D -i XXX.mobileprovision

查看证书内容
openssl x509 -in example.pem -noout -text

## Reference
[Choosing a Membership](https://developer.apple.com/support/compare-memberships/)
[Distribute App Store](https://developer.apple.com/distribute/)


[so反编译重新打包](https://www.jianshu.com/p/98fe8463d9e0)
[IOS ipa包（无源码）企业证书签名手动替换](https://blog.csdn.net/bz151531223/article/details/78284564?utm\_source=blogxgwz5)
[iOS应用程序的重签名\(打包\)](https://blog.csdn.net/skylin19840101/article/details/60583893)
