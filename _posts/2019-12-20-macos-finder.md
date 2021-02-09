---
layout: post
title: "macOS Finder 设置"
categories: macOS
tags: [macOS]
date: 2019-12-20
---

## macOS Finder 设置

### 1. 显示隐藏文件

早期的OS X（10.6~10.8）:

	defaults write com.apple.Finder AppleShowAllFiles Yes && killall Finder //显示隐藏文件
	defaults write com.apple.Finder AppleShowAllFiles No && killall Finder //不显示隐藏文件

OS X 10.9 Mavericks版本之后:

	defaults write com.apple.finder AppleShowAllFiles Yes && killall Finder //显示隐藏文件
	defaults write com.apple.finder AppleShowAllFiles No && killall Finder //不显示隐藏文件

*注: 在 macOS Sierra，可以使用快捷键⌘⇧.(Command + Shift + .) 来快速（在 Finder 中）显示和隐藏隐藏文件了*

### 2. 显示完整路径

	defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES && killall Finder // 显示完整路径
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool NO && killall Finder // 取消完整路径


### Reference

