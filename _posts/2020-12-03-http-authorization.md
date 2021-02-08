---
layout: post
title: "Net Http Authorization"
categories: net
tags: [net]
date: 2020-12-03
---

## Net Http Authorization

### Basic

`Authorization: Basic jdhaHY0=`

Authorization: http head  
Basic: 认证方式  
jdhaHY0=: user:passwd base64  

### Bearer token

使用Authorization Basic登陆后会拿到token  

`Authorization: Bearer ${token}`  

## Reference

