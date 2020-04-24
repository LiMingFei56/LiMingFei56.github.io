---
layout: post
title: "Eclipse 导入Maven项目"
categories: javaweb
tags: [javaweb]
date: 2020-03-27
excerpt: "Eclipse 导入Maven项目"
---

## Eclipse 导入Maven项目

### 安装Svn插件
1. eclipse market在线安装 eclipse -> Help -> Eclipse Marketplace (搜索subclipse)
2. Install new Software eclipse -> Help -> Install New Software http://subclipse.tigris.org/update_1.10.x/ （subversion 1.8.x） 版本太旧

### Svn Checkout
1. 使用Eclipse svn Checkout 出项目
2. 右键项目 -> Configure -> convert maven 项目

### 安装lombok插件
1. https://projectlombok.org/download 下载lombok.jar包， 放到eclipse根目录
2. java -jar D:\DEV_ENV\eclipse\lombok.jar
3. 查看eclipse.ini 如果有lombok配置就证明安装成功

### 运行
1. 如果是spring boot 直接循行Application
2. 如果是java web， 右键项目 -> Project Facets -> （勾选：1 Dynamic web Module 2 java 3 Javascript）

### 程序相关目录
** 程序相关目录（如安装目录，部署目录） 不要使用中文路径 **


