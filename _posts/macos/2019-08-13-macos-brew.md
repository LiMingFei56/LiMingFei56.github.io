---
layout: post
title: "macOS brew换源"
categories: macOS
tags: [macOS]
date: 2019-08-13
excerpt: "macOS brew换源"
---

## macOS brew换源

### 换源

    # 替换brew.git:
    cd "$(brew --repo)"
    # 中国科大:
    git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
    # 清华大学:
    git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

    # 替换homebrew-core.git:
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    # 中国科大:
    git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
    # 清华大学:
    $ git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

    # 替换homebrew-cask.git 镜像
    # 中科大镜像
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask"
    git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git

    # 替换homebrew-bottles:
    # 中国科大:
    $ echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile
    $ source ~/.bash_profile
    # 清华大学:
    $ echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.bash_profile
    $ source ~/.bash_profile

    # 应用生效:
    $ brew update

### 换回官方源

    # 重置brew.git:
    $ cd "$(brew --repo)"
    $ git remote set-url origin https://github.com/Homebrew/brew.git

    # 重置homebrew-core.git:
    $ cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    $ git remote set-url origin https://github.com/Homebrew/homebrew-core.git

    # 重置homebrew-cask.git
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask"
    git remote set-url origin https://github.com/Homebrew/homebrew-cask.git 

### Reference
[Homebrew切换为国内镜像源](http://t.zoukankan.com/anly95-p-14728311.html)  
