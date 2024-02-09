---
layout: post
title: Harmony Introduce 
categories: harmony
tags: [harmony]
date: 2024-02-04
---

## Harmony Introduce 

UI框架:
    * 声明式
    * 类Web
 
应用模型:
  * Feature Ability, FA
  * Stage

### Stage模型应用程序包结构

* 一个应用可以包含多个Module
* Module分为"Ability"和"Library"
* "Ability" - 对应编译后HAP (Harmony Ability Package)
* "Library" - 对应编译后HAR(Harmony Archive), 或HSP(Harmony Shared Package)
* 一个Module可以包含多个UIAbility组件

![Image1](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20240115191018.00543822837038786498842254176984:50001231000000:2800:1E4E5D4ADB3EE781EFCFF1BA3AB96B1533F3536ED04BE9CBABE15DC5C5758396.png?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true)

> DevEco Studio使用ohpm把应用编译为一个或多个.hap后缀的文件. HAP是应用安装的基本单样, 分为Entry, Feature

* Entry: 主模块, module.json5中type为entry, 同应用, 同设备中只支持一个Entry
* Feature: 动态特性模块, module.json5中type为feature, 可以配置(delivery/WithInstall)

> 一个应用可以包含多个.hap文件, hap文件合在一起称为一个Bundle
> 上架时, 需要把Bundle打包成.app(App Pack, Application Package)

![Image2](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20240115191018.96198009942332448006354049693122:50001231000000:2800:2F19D426B3518EA33A9319446AA8B3761561AB68B7A3B3B4ADEBA7C77BDB3364.png?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true)

#### 多HAP构建视图

![Image3](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20240115191019.18853973237489651667072369103380:50001231000000:2800:8EBB09701032F3A121A0DBEF611E30467A111EC34F84A81F534E3EADF315A042.png?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true)

#### 多HAP的开发调试与发布部署流程

![Image4](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20240115191019.81095604925746446771343672091636:50001231000000:2800:44085E776296058A5775C25D9DE2D78B55DC31C8DB14398FCB0AFAE3DEC15CCC.png?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true)

1. 直接使用hdc安装、更新HAP。:

    // 安装、更新，多HAP可以指定多个文件路径
    hdc install C:\entry.hap C:\feature.hap
    // 执行结果
    install bundle successfully.
    // 卸载
    hdc uninstall com.example.myapplication
    // 执行结果
    uninstall bundle successfully.

2. 先执行hdc shell，再使用bm工具安装、更新HAP。:

    // 先执行hdc shell才能使用bm工具
    hdc shell
    // 安装、更新，多HAP可以指定多个文件路径
    bm install -p /data/app/entry.hap /data/app/feature.hap
    // 执行结果
    install bundle successfully.
    // 卸载
    bm uninstall -n com.example.myapplication
    // 执行结果
    uninstall bundle successfully.

#### 多HAP使用规则

* App Pack包不能直接安装到设备上，只是上架应用市场的单元。
* App Pack包中所有HAP的配置文件中的bundleName标签必须一致。
* App Pack包中所有HAP的配置文件中的versionCode标签必须一致。
* App Pack包中同一设备类型的所有HAP中必须有且只有一个entry类型的HAP，feature类型的HAP可以有一个或者多个，也可以没有。
* App Pack包中的每个HAP必须配置moduleName标签，同一设备类型的所有HAP对应的moduleName标签必须唯一。
* 同一应用的所有HAP签名证书要保持一致。上架应用市场是以App Pack的形式上架，并对其进行了签名。应用市场分发时会将所有HAP从App Pack中拆分出来，同时对其中的所有HAP进行重签名，这样保证了所有HAP签名证书的一致性。在调试阶段，开发者通过命令行或IDE将HAP安装到设备上时要保证所有HAP签名证书一致，否则会出现安装失败的问题。

#### 多HAP运行机制及数据通信方式

* 多HAP机制主要是为方便开发者进行模块化管理。HAP和应用运行时的进程并不是一一对应的，具体运行机制如下：
* 默认情况下，应用中（同一包名）的所有UIAbility、ServiceExtensionAbility、DataShareExtensionAbility运行在同一个独立进程中，其他同类型ExtensionAbility分别运行在单独的进程。
* HAP支持在module.json5（Stage模型）或者config.json（FA模型）中通过process标签配置单独的进程（仅系统应用支持，三方应用不支持）。配置了process的HAP，其组件运行在单独的process进程中，多个HAP可以配置相同的process，则这些HAP运行在相同进程中，process配置的详细说明请参见module.json5配置文件。
* 应用运行时，同一进程中的UIAbility组件被启动时，才加载对应HAP的资源和代码。

基于上述机制，多HAP数据通信方式如下：
* 同一进程内的数据通信，请参见[线程间通信](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/thread-model-stage-0000001428061492-V2)。
* 跨进程的数据通信，请参见[进程间通信](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/process-model-stage-0000001428061488-V2)。
* 多HAP如果运行在同一进程，则多HAP间组件的通信方式与同一HAP内组件的通信方式相同。

### 共享包

> OpenHarmony提供了两种共享包，HAR（Harmony Archive）静态共享包，和HSP（Harmony Shared Package）动态共享包。
> HAR与HSP都是为了实现代码和资源的共享，都可以包含代码、C++库、资源和配置文件，最大的不同之处在于：HAR中的代码和资源跟随使用方编译，如果有多个使用方，它们的编译产物中会存在多份相同拷贝；而HSP中的代码和资源可以独立编译，运行时在一个进程中代码也只会存在一份。

HSP旨在解决HAR存在的几个问题：

* 多个HAP引用相同的HAR，导致的APP包大小膨胀问题。
* 多个HAP引用相同的HAR，HAR中的一些状态变量无法共享的问题。

HSP的一些约束：

* HSP及其使用方都必须是Stage模型。
* HSP及其使用方都必须使用esmodule编译模式。
* HSP不支持在配置文件中声明abilities、extensionAbilities标签。
* HSP按照使用场景可以分为应用内HSP和应用间HSP，应用间HSP暂不支持。

HAR资源文件出现重名冲突时, DevEco Studio会以优先级进行覆盖(优先级由高到低):
* AppScope（仅API9的Stage模型支持）。
* HAP包自身模块。
* 依赖的HAR模块，如果依赖的多个HAR之间有资源冲突，会按照依赖顺序进行覆盖（依赖顺序在前的优先级较高）。

跳转到HSP中页面:

    '@bundle:包名（bundleName）/模块名（moduleName）/路径/页面所在的文件名(不加.ets后缀)'

### 快速修复

> 快速修复的使用规则:
* 仅支持修复应用的TS和C++代码，对应的文件为.abc文件（TS编译后的文件）和.so文件（C++编译后的文件），不支持对资源的修复。
* 不支持新增.abc文件和.so文件。
* 快速修复包部署时要确保对应应用包已安装，如果未安装，则部署失败。
* 快速修复包中配置的包名和应用版本号必须和已安装的包名和版本号应用相同，如果不同则部署失败。
* 如果已经部署过快速修复包，新部署的快速修复包的版本号必须大于之前快速修复包的版本号，否则部署失败。
* 快速修复包的签名信息和待修复的应用的签名信息必须一致，否则会部署失败。
* 新的应用版本发布安装时，会清理掉快速修复包。

* appqf(Application Quick Fix), 由hqf(Harmony Ability Package Quick Fix)组成
* hqf包是修复HAP中问题的快速修复包，用于安装到设备上的快速修复单元。一个hqf可以包含.abc的快速修复文件，.so的快速修复文件和描述该包的配置文件。

+ [快速修复命令行调试开发指导](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/quickfix-debug-0000001493903876-V2)

### 应用配置文件

+ [应用配置文件概述](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/application-configuration-file-overview-stage-0000001428061460-V2)

### [资源分类与访问](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/resource-categories-and-access-0000001711674888-V2)

#### 资源访问

* 应用资源, "$r('app.type.name')"
* rawfile目录资源, "$rawfile('filename')"
* 系统资源, “$r('sys.type.resource_id')”

#### 资源匹配

限定词目录与设备状态的匹配规则

* 在为设备匹配对应的资源文件时，限定词目录匹配的优先级从高到低依次为：移动国家码和移动网络码 > 区域（可选组合：语言、语言_文字、语言_国家或地区、语言_文字_国家或地区）> 横竖屏 > 设备类型 > 颜色模式 > 屏幕密度。

* 如果限定词目录中包含移动国家码和移动网络码、语言、文字、横竖屏、设备类型、颜色模式限定词，则对应限定词的取值必须与当前的设备状态完全一致，该目录才能够参与设备的资源匹配。例如，限定词目录“zh_CN-car-ldpi”不能参与“en_US”设备的资源匹配。

## Reference

+ [HarmonyOS](https://developer.huawei.com/consumer/cn/hmos/overview/?catalogVersion=V2)
+ [HarmonyOS Developer](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/start-overview-0000001478061421-V3?catalogVersion=V3)
+ [DevEco Studio](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/devecostudio_userguide-0000001054619202-V2)
+ [术语](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/glossary-0000000000029587-V2)
+ [OpenHarmony](https://www.openharmony.cn/mainPlay)
+ [OpenHarmony开发者](https://space.bilibili.com/2029471800)
+ [Huawei 开发套件](https://developer.huawei.com/consumer/cn/market/prod-list/4a15e94084304e3a970b254e8a848886)
+ [OpenHarmony 工作台](http://ci.openharmony.cn/workbench/cicd/codecontrol/list)
