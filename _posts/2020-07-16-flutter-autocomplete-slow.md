---
layout: post
title: "Tools Vscode中Flutter自动补全卡顿"
categories: tools
tags: [tools]
date: 2020-07-16
---

## Tools Vscode中Flutter自动补全卡顿

1. 如果安装Vim和Flutter插件, 那么自动补全时会出现卡顿
2. Vim每次键入会分析并且需要插件返回结果
3. Dart自动补全目前是同步的, 并且需要分析代码
4. 2和3项合起来导致卡顿

解决:
1. 不使用Vim插件 "vim.disableExtension": true
2. "dart.previewLsp": true  使用dart lsp服务   这是异步实现


### Reference
[Editor lags badly when Vim extension is enabled #1800](https://github.com/Dart-Code/Dart-Code/issues/1800)
