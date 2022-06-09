---
layout: post
title: "Homebrew source"
categories: tools
tags: [tools]
date: 2022-01-17 
---

## Homebrew source

# 替换brew.git:
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

# 替换homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

brew update


### Reference
[Homebrew国内加速](https://blog.csdn.net/msatergz/article/details/93241764)  
