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

### 证书说明
ios应用打包需要Certificate 和provision profile文件. 

Certificate - 是用来证明你是谁，用该证书签名的应用， 用来证明这个应用是你的
provision profile - 是用来描述应用的， 包括证书， appid, deviceid等信息
p12证书 - 申请 Certificate 时需要上传csr(Certificate Signing Request)证书， csr私钥在本地， csr公钥给苹果生成Certificate证书。
          这时另一个人想要开发，但没有证书的私钥。所以需要导出p12证书（包括证书和证书私钥）。

证书时效：
Certificate证书一般是1年有效期， 企业证书是3年有效期
provision文件都是1年有效期

当证书过期时：
1. 如果是app store应用并且开发者账号没有欠费， 那么不影响使用。更新应用时需要更新证书。
2. 如果是企业应用， 那么用户不能安装应用和打开应用， 需要重新用新证书打包再安装（没有源码可以使用重签名方法， 见下）。


### 打包

#### App Stroe上传

见[DISTRIBUTE YOUR APP](https://help.apple.com/xcode/mac/current/#/devac02c5ab8)

#### 企业应用打包
准备：
1. 企业p12证书和mobileprovision描述文件
2. 支持https，有域名的， 端口80的服务器, 用来存放ipa, icon, plist文件
3. 57x57和512x512的icon

步骤:
1. Product->Archive
2. 导出ipa包， 选择enterprise， 填写好ipa和icon文件的地址
3. 把ipa, icon, plist 放到服务器对应位置

安装:

  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
  <html>
  <head>
      <title>下载界面</title>
      <meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">
  </head>
  <body>
    <div class="contxt">
      <a href="itms-services://?action=download-manifest&url=https://www.xxxx.com/ipa/manifest.plist" class="context">下载</a>
    </div>
  </body>
  </html>


### 重签名
准备：
1. 新的证书和provision文件
2. ipa包
3. entitlements.plist文件

生成entitlements.plist文件:

    1. 直接使用provision文件中的字段替换
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>application-identifier</key>
      <string>${application-identifier}</string>
      <key>com.apple.developer.team-identifier</key>
      <string>${com.apple.developer.team-identifier}</string>
      <key>get-task-allow</key>
      <false/>
      <key>keychain-access-groups</key>
      <array>
        <string>${application-identifier}</string>
      </array>
    </dict>
    </plist>

    2. 重新生成
    security cms -D -i "mobileprovision文件" > "entitlements文件"
    // 只需要entitlements元素
    /usr/libexec/PlistBuddy -x -c 'Print:Entitlements'  entitlements_full.plist > entitlements.plist


重签名:
1. unzip *.ipa
2. rm -rf Payload/*.app/_CodeSignature
3. cp embedded.mobileprovision Payload/*.app/   // 使用新的provition 替换embedded.mobileprovision
4. /usr/bin/codesign -f -s "iPhone Distribution: ${cerName}" --entitlements *.plist Payload/*.app // 显示已重复签名  成功
5. zip -r xxx.ipa Payload

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
