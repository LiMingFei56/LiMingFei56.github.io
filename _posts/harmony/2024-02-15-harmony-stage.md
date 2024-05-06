---
layout: post
title: Harmony Stage
categories: harmony
tags: [harmony]
date: 2024-02-15
---

## Harmony Stage

![图1 Stage模型概念图](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20240115191033.49471475688516629319952599672520:50001231000000:2800:485D45AB239A70DEF95D3C19C682C0796DA6F1E936934FA2E3A1093857E382C0.png?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true)

### 基本概念

* UiAbility组件和ExtensionAbility组件
* WindowStage
* Context
* AbilityStage

### 应用/组件级配置

* 应用包名配置
* 应用图标和标签配置
* 入口图标和标签配置
* 应用版本声明配置
* Module支持的设备类型配置
* Module权限配置

### UIAbility组件

> UIAbility组件是一种包含UI界面的应用组件，主要用于和用户交互。

> UIAbility组件是系统调度的基本单元，为应用提供绘制界面的窗口；一个UIAbility组件中可以通过多个页面来实现一个功能模块。每一个UIAbility组件实例，都对应于一个最近任务列表中的任务。

module.json5配置:

    {
      "module": {
        // ...
        "abilities": [
          {
            "name": "EntryAbility", // UIAbility组件的名称
            "srcEntry": "./ets/entryability/EntryAbility.ts", // UIAbility组件的代码路径
            "description": "$string:EntryAbility_desc", // UIAbility组件的描述信息
            "icon": "$media:icon", // UIAbility组件的图标
            "label": "$string:EntryAbility_label", // UIAbility组件的标签
            "startWindowIcon": "$media:icon", // UIAbility组件启动页面图标资源文件的索引
            "startWindowBackground": "$color:start_window_background", // UIAbility组件启动页面背景颜色资源文件的索引
            // ...
          }
        ]
      }
    }


#### UIAbility组件生命周期

![UIAbility生命周期状态](https://github.com/LiMingFei56/picturebed/harmony/UIAbility/UIAbility生命周期状态.png)
![WindowStageCreate和WindowStageDestroy状态.png](https://github.com/LiMingFei56/picturebed/harmony/UIAbility/WindowStageCreate和WindowStageDestroy状态.png)

WindowStageCreate和WindowStageDestroy状态

#### UIAbility组件启动模式

* singleton启动模式 onNewWant()
* multiton启动模式
* specified启动模式 onAcceptWant() onNewWant()

#### UIAbility 组件基本用法

* 指定UIAbility的启动页面

    import UIAbility from '@ohos.app.ability.UIAbility';
    import Window from '@ohos.window';

    export default class EntryAbility extends UIAbility {
        onWindowStageCreate(windowStage: Window.WindowStage) {
            // Main window is created, set main page for this ability
            windowStage.loadContent('pages/Index', (err, data) => {
                // ...
            });
        }

        // ...
    }



## Reference
+ [Stage模型开发概述](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/stage-model-development-overview-0000001427744552-V2)
