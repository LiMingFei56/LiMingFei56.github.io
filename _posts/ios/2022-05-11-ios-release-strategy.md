---
layout: post
title: "苹果上传策略"
categories: ios
tags: [ios]
date: 2022-05-11
---

## 苹果上传策略

### 1. 如果换了application-identifier 会出现Potential Loss of Keychain Access 警告

> 这个是警告, 因为当前和原来上传的App ID不一样了. 再次上传后就会忽略, 见下面引用

### 2. "The requested app is not available or doesn't exist." in Testflight

> 如果当前因为为下架状态, 那么TestFlight中也不可用

### 3. 需要提交App Privacy后才能上传应用


### Reference
[Resolving the Potential Loss of Keychain Access warning](https://developer.apple.com/library/archive/qa/qa1726/_index.html#:~:text=The%20Potential%20Loss%20of%20Keychain%20Access%20warning%20is%20an%20indication,the%20Certs%20IDs%20%26%20Profiles%20website.)  
