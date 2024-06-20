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


    AbilityStage 
        UIAbility
            UIAbilityContext
                Context
            WindowStage
            Window
            ArkUI Page

        ExtensionAbility
        Context
    HAP

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

    UIAbility onCreate
    WindowStage onWindowStageCreate
    UIAbility onForeground
    WindowStage Visible
    WindowStage Active
    WindowStage InActive
    WindowStage InVisible
    UIAbility onBackground
    WindowStage onWindowStageDestroy
    UIAbility onDestory



WindowStageCreate和WindowStageDestroy状态

#### UIAbility组件启动模式

* singleton启动模式 onNewWant()
    每次调用startAbility(), 系统只存在唯一一个UIAbility
* multiton启动模式
    每次调用startAbility(), 系统都会创建一个UIAbility
* specified启动模式 onAcceptWant() onNewWant()
    每次调用startAbility(), 根据传入的KEY判断是否要创建新的实例

#### UIAbility 组件基本用法

* 指定UIAbility的启动页面

    windowStage.loadContent

* 获取UIAbility的上下文信息
    
    UIAbility.context UIAbilityContext

#### UIAbility组件与UI的数据同步

* 使用EventHub进行数据通信：基于发布订阅模式来实现，事件需要先订阅后发布，订阅者收到消息后进行处理。
* 使用globalThis进行数据同步：ArkTS引擎实例内部的一个全局对象，在ArkTS引擎实例内部都能访问。
* 使用AppStorage/LocalStorage进行数据同步：ArkUI提供了AppStorage和LocalStorage两种应用级别的状态管理方案，可用于实现应用级别和UIAbility级别的数据同步。

### UIAbility组件间交互（设备内）

* 启动应用内的UIAbility
    
    this.context.startAbility(wantInfo)

* 启动应用内的UIAbility并获取返回结果

    this.context.startAbilityForResult(wantInfo)

* 启动其他应用的UIAbility

    显式Want启动：启动一个确定应用的UIAbility，在want参数中需要设置该应用bundleName和abilityName，当需要拉起某个明确的UIAbility时，通常使用显式Want启动方式。
    隐式Want启动：根据匹配条件由用户选择启动哪一个UIAbility，即不明确指出要启动哪一个UIAbility

* 启动其他应用的UIAbility并获取返回结果

    this.context.startAbilityForResult(wantInfo)

* 启动UIAbility的指定页面

    首次启动: onCreate(want, launchParam)
    非首次启动: onNewWant(want, launchParam) 

### ExtensionAbility组件

> ExtensionAbility组件是基于特定场景提供的应用组件，以便满足更多的使用场景。 每一个具体场景对应一个ExtensionAbilityType

* FormExtensionAbility：FORM类型的ExtensionAbility组件，用于提供服务卡片场景相关能力。
* WorkSchedulerExtensionAbility：WORK_SCHEDULER类型的ExtensionAbility组件，用于提供延迟任务注册、取消、查询的能力。

### 服务卡片开发指导（Stage模型）

> 服务卡片（以下简称“卡片”）是一种界面展示形式，可以将应用的重要信息或操作前置到卡片，以达到服务直达、减少体验层级的目的。卡片常用于嵌入到其他应用（当前卡片使用方只支持系统应用，如桌面）中作为其界面显示的一部分，并支持拉起页面、发送消息等基础的交互功能。

### AbilityStage组件容器

> AbilityStage是一个Module级别的组件容器，应用的HAP在首次加载时会创建一个AbilityStage实例，可以对该Module进行初始化等操作。

> AbilityStage与Module一一对应，即一个Module拥有一个AbilityStage。

AbilityStage拥有onCreate()生命周期回调和onAcceptWant()、onConfigurationUpdated()、onMemoryLevel()事件回调。

* onCreate()生命周期回调：在开始加载对应Module的第一个UIAbility实例之前会先创建AbilityStage，并在AbilityStage创建完成之后执行其onCreate()生命周期回调。AbilityStage模块提供在Module加载的时候，通知开发者，可以在此进行该Module的初始化（如资源预加载，线程创建等）能力。
* onAcceptWant()事件回调：UIAbility指定实例模式（specified）启动时候触发的事件回调，具体使用请参见UIAbility启动模式综述。
* onConfigurationUpdated()事件回调：当系统全局配置发生变更时触发的事件，系统语言、深浅色等，配置项目前均定义在Configuration类中。
* onMemoryLevel()事件回调：当系统调整内存时触发的事件。

### 应用上下文Context

* 各类Context的继承关系

    BaseContext
        Context
            ApplicationContext
            AbilityStageContext
            UIAbilityContext
            ExtensionContext
                其他ExtensionContext
                FormExtensionAbility
                ServiceExtensionContext

#### 订阅进程内Ability生命周期变化

    let abilityLifecycleCallback = {

### 信息传递载体Want

+ [信息传递载体Want](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/4_6_u4fe1_u606f_u4f20_u9012_u8f7d_u4f53want-0000001478181153-V2)

### 进程模型概述

* 应用中（同一包名）的所有UIAbility运行在同一个独立进程中。
* WebView拥有独立的渲染进程。
* 公共事件发布

### 线程模型概述

* 执行UI绘制；
* 管理主线程的ArkTS引擎实例，使多个UIAbility组件能够运行在其之上；
* 管理其他线程（例如Worker线程）的ArkTS引擎实例，例如启动和终止其他线程；
* 分发交互事件；
* 处理应用代码的回调，包括事件处理和生命周期管理；
* 接收Worker线程发送的消息；

> 除主线程外，还有一类与主线程并行的独立线程Worker，主要用于执行耗时操作，但不可以直接操作UI。Worker线程在主线程中创建，与主线程相互独立。最多可以创建8个Worker：
> 基于HarmonyOS的线程模型，不同的业务功能运行在不同的线程上，业务功能的交互就需要线程间通信。线程间通信目前主要有Emitter和Worker两种方式，其中Emitter主要适用于线程间的事件同步， Worker主要用于新开一个线程执行耗时任务。




## Reference
+ [Stage模型开发概述](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/stage-model-development-overview-0000001427744552-V2)
