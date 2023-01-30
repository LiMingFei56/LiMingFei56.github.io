---
layout: post
title: leetcode-cli
categories: tools 
tags: [tools]
date: 2022-12-02
---

## leetcode-cli

### 登录国际服

+ [[ERROR] invalid password? ](https://github.com/skygragon/leetcode-cli/issues/153)

    Login into leetcode on chrome
    install cookie.chrome pluging with command => leetcode plugin -i cookie.chrome
    install libsecret tools =>
    linux (sudo apt-get install libsecret-tools)
    mac ( brew install libsecret )
    now try to log in

    Ref link: https://github.com/skygragon/leetcode-cli-plugins/blob/master/docs/cookie.chrome.md

    leetcode user -l -v

### 登录中国服

    /opt/homebrew/lib/node_modules/leetcode-cli/lib/config.js

    leetcode.com => leetcode.cn

## Reference
+ [leetcode-cli](git@github.com:skygragon/leetcode-cli.git)
