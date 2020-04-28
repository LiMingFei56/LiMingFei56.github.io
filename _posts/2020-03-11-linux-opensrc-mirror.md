---
layout: post
title: "开源镜像站"
categories: linux
tags: [ses]
date: 2020-03-11
excerpt: "开源镜像站"
---

## 配置源

### linux
    
    #deb https://mirrors.aliyun.com/kali kali-rolling main non-free contrib
    #deb-src https://mirrors.aliyun.com/kali kali-rolling main non-free contrib

### github

    1. 修改Hosts 速度到100kb
    2. 使用码云转一道, 麻烦 但是速度快

### flutter
SDK下载地址: https://storage.flutter-io.cn/flutter_infra/releases/stable/windows/flutter_windows_v1.0.0-stable.zip

    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

### brew

    cd "$(brew --repo)"
    git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
    # 替换homebrew-core.git:
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git
    # 应用生效
    brew update
    # 替换homebrew-bottles:
    echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.bash_profile

    # 关闭自动更新
    export HOMEBREW_NO_AUTO_UPDATE=true

### pip

    unix: ~/.pip/pip.conf
    windows: ~/pip/pip.ini

    [global]
    index-url = http://mirrors.aliyun.com/pypi/simple/
    
    [install]
    trusted-host=mirrors.aliyun.com

### npm

    npm install --registry=https://registry.npm.taobao.org

## 开源镜像站

阿里：https://developer.aliyun.com/mirror/  
网易: http://mirrors.163.com/  
搜狐: http://mirrors.sohu.com/  
华为：https://mirrors.huaweicloud.com/  
腾讯：https://mirrors.cloud.tencent.com/  

<<<<<<< HEAD


华中科技大学: http://mirror.hust.edu.cn/
北京交通大学: https://mirror.bjtu.edu.cn/cn/
兰州大学: http://mirror.lzu.edu.cn/
厦门大学: http://mirrors.xmu.edu.cn/
上海交通大学: http://ftp.sjtu.edu.cn/
=======
华中科技大学: http://mirror.hust.edu.cn/  
北京交通大学: https://mirror.bjtu.edu.cn/cn/  
兰州大学: http://mirror.lzu.edu.cn/  
厦门大学: http://mirrors.xmu.edu.cn/  
上海交通大学: http://ftp.sjtu.edu.cn/  
>>>>>>> f57ff88cfea989c5bd66fd6fd52a9a006a20672c
清华大学: http://mirrors.tuna.tsinghua.edu.cn/ http://mirrors.6.tuna.tsinghua.edu.cn/ <IPv6 only> http://mirrors.4.tuna.tsinghua.edu.cn/ <IPv4 only>  
天津大学: http://mirror.tju.edu.cn/  
中国科学技术大学: http://mirrors.ustc.edu.cn/ http://mirrors4.ustc.edu.cn/ http://mirrors6.ustc.edu.cn/  
西南大学: http://linux.swu.edu.cn/swudownload/  
泰安移动: http://mirrors.ta139.com/  
东北大学: http://mirror.neu.edu.cn/  
浙江大学: http://mirrors.zju.edu.cn/  
东软信息学院: http://mirrors.neusoft.edu.cn/  