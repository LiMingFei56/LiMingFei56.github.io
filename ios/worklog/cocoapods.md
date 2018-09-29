---
layout: page
permalink: /ios/worklog/cocoapods
---

## Cocoapods

### 1. 使用


### 问题

#### 1. Framework not Found

1. pods构建出错，需要重新构建

    安装deintegrate : sudo gem install cocoapods-deintegrate

    pod deintegrate
    pod install

2. 如果是swift语言，那么Podfile需要  use_frameworks!

3. 要确保打开的是工作区，而不是项目文件:

    open App.xcworkspace
