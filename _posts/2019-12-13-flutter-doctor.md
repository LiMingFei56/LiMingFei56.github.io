---
layout: post
title: "Flutter doctor"
categories: flutter
tags: [flutter, doctor]
date: 2019-12-13
excerpt: "Android license status unknown"
---

## Flutter doctor 报错 Android license status unknown

  Android license status unknown.
  Try re-installing or updating your Android SDK Manager.
  See https://developer.android.com/studio/#downloads or visit https://flutter.dev/setup/#android-setup for
  detailed instructions

需要同意Android license 的条款

  flutter doctor --android-licenses // 命令
  
  Trying to run the cmd you gave gives the following: A newer version of the
  Android SDK is required. To update
  , run: $HOME/Library/Android/Sdk/tools/bin/sdkmanager --update

## sdkmanager

  flutter doctor --android-licenses 
  会调用 sdkmanager --licenses

  根据上面提示调用

  $HOME/Library/Android/Sdk/tools/bin/sdkmanager --update

报
  Exception in thread "main" java.lang.NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema

java jdk 9开始就去掉了javax/xml/bind包

## 解决javax/xml/bind

1. 手动下载jaxb包

  activation.jar
  istack-commons-runtime.jar
  jaxb-api.jar
  jaxb-core.jar
  jaxb-impl.jar
  jaxb-jxc.jar
  jaxb-xjc.jar

并在sdkmanager 中 CLASSPATH里添加上面的包路径

`注`: 包的版本有要求, 目前不能确定包的具体版本, 如果版本不对会报
  
Warning: Found corrupted package.xml at /home/zerocool/Android/Sdk/build-tools/29.0.2/package.xml
Exception in thread "main" java.lang.NullPointerException
  at com.android.repository.impl.meta.SchemaModuleUtil.marshal(SchemaModuleUtil.java:265)

2. 安装jdk8 (推荐)

  brew cask uninstall java
  brew tap homebrew/cask-versions
  brew cask install homebrew/cask-versions/adoptopenjdk8

## flutter 检查cocoapod没有安装

> 需要安装1.7.5版本

  sudo gem install cocoapods -v 1.7.5
