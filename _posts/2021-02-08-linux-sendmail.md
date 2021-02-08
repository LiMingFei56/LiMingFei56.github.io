---
layout: post
title: "Linux sendmail"
categories: linux
tags: [linux]
date: 2021-02-08
---

## Linux sendmail

### 安装mailx
    // 卸载
    yum remove sendmail
    yum remove postfix

    // 安装
    yum install mailx

### 配置mailx

    vim /etc/mail.rc
    set from="dingkaitest@163.com"   #用来发送邮件的邮箱 
    set smtp=smtp.163.com　　　　　　#163的邮件发送服务器　
    set smtp-auth-user=dingkaitest　　#邮箱用户名（也可以写成"dingkaitest@163.com"）
    set smtp-auth-password=密码　　#邮箱密码
    set smtp-auth=login

    // ssl
    set from=xxxooo@126.com
    set smtp=smtps://smtp.126.com:465
    set smtp-auth-user=xxxooo@126.com
    set smtp-auth-password=你的授权码
    set smtp-auth=login
    set ssl-verify=ignore
    set nss-config-dir=/root/.certs

### 阿里云没有开25端口, 需要使用ssl

    mkdir -p /root/.certs/
    yum install nss-tools
    apt-get install libnss3-tools
    echo -n | openssl s_client -connect smtp.126.com:465 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ~/.certs/qq.crt
    certutil -A -n "GeoTrust Global CA" -t "C,," -d ~/.certs -i ~/.certs/qq.crt
    certutil -L -d /root/.certs<br><br>若需要qq的ssl  只需把第二条命令中的smtp.xxx.com:465  给替换了就行

## Reference
[mailx使用smtp邮箱发送邮件](https://www.cnblogs.com/ying568353087/p/13365061.html?utm_source=tuicool)  
[在 Linux 命令行发送邮件的 5 种方法](https://linux.cn/article-11663-1.html?pr)  
