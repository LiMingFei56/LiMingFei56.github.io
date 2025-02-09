---
layout: post
title: 自定义键盘布局
categories: macos
tags: [macos]
date: 2024-01-04
---

## 自定义键盘布局

> macos 中键盘布局包含dead keys, 可以通过快捷键快速输入另一种语言或者符号, 但是这会严重影响开
> 发人员使用快捷键绑定开发功能.

### 1. 自定义键盘布局

> 使用ukelele创建自定义键盘布局

    1. brew install --cask ukelele
    2. sudo cp -r MYABC.bundle  /Library/Keyboard\ Layouts
    3. sudo cp -r MYABC.bundle ~/Library/Keyboard\ Layouts

### 2. 删除默认ABC键盘布局

> macos登录时需要输入密码, 所以必须要一个默认的键盘布局, 这个键盘布局不能在控制面版里删除
> 需要修改系统配置文件

    /Library/Preferences/com.apple.HIToolbox.plist
    ~/Library/Preferences/com.apple.HIToolbox.plist

    sudo cp /Library/Preferences/com.apple.HIToolbox.plist /Library/Preferences/com.apple.HIToolbox.plist.bak
    sudo cp ~/Library/Preferences/com.apple.HIToolbox.plist ~/Library/Preferences/com.apple.HIToolbox.plist.bak

    sudo cp /Library/Preferences/com.apple.HIToolbox.plist /tmp
    sudo chmod 777 /tmp/com.apple.HIToolbox.plist
    cd /tmp
    plutil -convert xml1 com.apple.HIToolbox.plist 

需要修改:
    AppleCurrentKeyboardLayoutInputSourceID
    把ABC都改成自定义布局
    KeyboardLayout ID  KeyboardLayout Name

可以在~/Library/Preferences/com.apple.HIToolbox.plist文件中查看

    sudo cp /tmp/com.apple.HIToolbox.plist /Library/Preferences/com.apple.HIToolbox.plist
    sudo chmod 644 /Library/Preferences/com.apple.HIToolbox.plist


    sudo cp ~/Library/Preferences/com.apple.HIToolbox.plist ~/Library/Preferences/com.apple.HIToolbox.plist.bak

用户目录下的com.apple.HIToolbox.plist 不能使用上面的方法, 因为plutil后会把plist解析成xml.
当系统重启后, 发现该文件不是plist后会重新生成用户目录下的com.apple.HIToolbox.plist

可以使用plistedit-pro 或者 xcode来编辑com.apple.HIToolbox.plist文件

安装 
    brew install --cask plistedit-pro

    1. 删除AppleEnabledInputSources 下面ABC 那个对象里的KeyboardLayout Name字段
    2. 修改AppleCurrentKeyboardLayoutInputSourceID 到自定义布局
    3. 删除AppleInputSourceHistory 下面ABC
    4. 修改AppleSelectedInputSources 下面ABC 到自定义布局


## Reference
+ [Use dead keys](https://support.apple.com/en-mn/guide/mac-help/mh27474/mac)
+ [Removing Dead Keys on macOS use ukelele]
+ [Remove keyboard layout from OS X leaving custom layouts only](https://superuser.com/questions/712306/remove-keyboard-layout-from-os-x-leaving-custom-layouts-only)
