---
layout: post
title: COCOAPODS
categories: ios
tags: [ios]
date: 2022-08-16
---

## COCOAPODS

> CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. 
> It has over 91 thousand libraries and is used in over 3 million apps. 
> CocoaPods can help you scale your projects elegantly.

### INSTALL

    sudo gem install cocoapods

### INSTALL Specs.git

    rm -rf ~/.cocoapods
    mkdir -p ~/.cocoapods/repos
    cd ~/.cocoapods/repos
    git clone https://gitee.com/k4/specs.git
    mv specs Specs
    cd Specs
    git remote set-url origin https://github.com/CocoaPods/Specs.git
    git pull

### 找不到最新版本库

    pod repo update
    pod update GDTMobSDK

    gem cleanup
    brew uninstall cocoapods
    sudo gem uninstall cocoapods
    sudo gem install cocoapods
    cd ios
    pod install --repo-update

    

## Reference
[COCOAPODS](https://cocoapods.org/)  
