---
layout: post
title: iOS Universal Link
categories: ios
tags: [ios]
date: 2023-11-06
---

## iOS Universal Link

放在https://www.saanw.com/.well-known/apple-app-site-association


### scheme

1. 配置可以跳转的 url scheme(下例为tobias配置)

	<key>CFBundleURLTypes</key>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>alipay</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>chuoooo</string>
        </array>
    </dict>



## Reference
+ [Apple Universal Link setup in iOS](https://nishbhasin.medium.com/apple-universal-link-setup-in-ios-131a508b45d1)
