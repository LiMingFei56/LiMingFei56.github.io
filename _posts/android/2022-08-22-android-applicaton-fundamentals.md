---
layout: post
title: Application Fundamentals
categories: android
tags: [android]
date: 2022-08-22
---

## Application Fundamentals

> Android apps 可以使用kotlin, java, c++语言编写, Android SDK tools 会编译代码, 把
> 数据文件和资源文件打包成`APK`或者`Android App Bundle`.

> Apk包是一个Android package, 后缀`.apk`, 是`zip`的压缩包. 可以提供安装和运行的数据.

> Android App Bundle, 后缀`.aab`, 不能直接安装. 它将APK生成和签名推迟到稍后(google play).
> AAB把apk分为主模块和动态特性模块, 在资源维度, ABI维度, Language维度进行了拆分.
> 当google play分发应用时, 会根据用户设备优化APK.

* 每个APP都是在独立沙箱中运行
* Android操作系统是多用户linux, 每个APP一个用户
* 默认, Android操作系统会为每个用户创建唯一user id, 这个id仅系统可用, 通过id来分配文件目录访问权限
* 每个进程有自己的virtual machine, 所以一个app运行在隔离区中.
* 默认, app运行自己的进程, Android会自动启动进程或者销毁进程.

> Android 系统实现最小化权限原则(principle of least privilege). 默认情况只能访问自己
> 工作所需组件, 而不能访问更多.

APP间共享数据和访问系统服务:
* 两个应用共用一个user id, 可以共用文件, 进一步可以共用进程和虚拟机.
* 应用可以请求访问设备数据的权限, 如定位, 摄像头. 用户必须同意.

### App components

> APP components 是Android app 重要的基本组件, 每一个组件是系统或者用户的进入点.

四种组件:
* Activities
* Services
* Broadcast receivers
* Content providers

> 每种类型都有不同的用途和生命周期，后者会定义如何创建和销毁组件。以下部分将介绍应用组件的四种类型。
> Android 系统设计的独特之处在于，任何应用都可启动其他应用的组件。

> 当系统启动某个组件时，它会启动该应用的进程（如果尚未运行），并实例化该组件所需的类。
> 例如，如果您的应用启动相机应用中拍摄照片的 Activity，则该 Activity 会在属于相机应用的进程（而非您的应用进程）中运行。
> 由于系统在单独的进程中运行每个应用，且其文件权限会限制对其他应用的访问，因此您的应用无法直接启动其他应用中的组件
> ，但 Android 系统可以。如要启动其他应用中的组件，请向系统传递一条消息，说明启动特定组件的 Intent。系统随后便会为您启动该组件。

#### Activity

* 追踪用户当前关心的内容（屏幕上显示的内容），以确保系统继续运行托管 Activity 的进程。
* 了解先前使用的进程包含用户可能返回的内容（已停止的 Activity），从而更优先保留这些进程。
* 帮助应用处理终止其进程的情况，以便用户可以返回已恢复其先前状态的 Activity。
* 提供一种途径，让应用实现彼此之间的用户流，并让系统协调这些用户流。（此处最经典的示例是共享。）

#### Services

* 音乐播放是用户可直接感知的服务，因此，应用会向用户发送通知，表明其希望成为前台，从而告诉系统此消息；在此情况下，系统明白它应尽全力维持该服务进程运行，因为进程消失会令用户感到不快。
* 通常，用户不会意识到常规后台服务正处于运行状态，因此系统可以更自由地管理其进程。如果系统需要使用 RAM 来处理用户更迫切关注的内容，则其可能允许终止服务（然后在稍后的某个时刻重启服务）。

#### Content providers

* 分配 URI 无需应用保持运行状态，因此 URI 可在其所属的应用退出后继续保留。当系统必须从相应的 URI 检索应用数据时，系统只需确保所属应用仍处于运行状态。
* 这些 URI 还会提供重要的细粒度安全模型。例如，应用可将其所拥有图像的 URI 放到剪贴板上，但将其内容提供程序锁定，以便其他应用程序无法随意访问它。当第二个应用尝试访问剪贴板上的 URI 时，系统可允许该应用通过临时的 URI 授权来访问数据，这样便只能访问 URI 后面的数据，而非第二个应用中的其他任何内容。

#### 启动组件

> 应用间不能相互调用组件, 但是通过系统可以. 使用Intent以显示方式或者隐式方式来启动组件(不包括内容提供者).
> Intent 还可以返回处理结果URI.

> ContentResolver来启动内容提供者.

* 如要启动 Activity，您可以向 startActivity() 或 startActivityForResult() 传递 Intent（当您想让 Activity 返回结果时），或者为其安排新任务。
* 在 Android 5.0（API 级别 21）及更高版本中，您可以使用 JobScheduler 类来调度操作。对于早期 Android 版本，您可以通过向 startService() 传递 Intent 来启动服务（或对执行中的服务下达新指令）。您也可通过向将 bindService() 传递 Intent 来绑定到该服务。
* 您可以通过向 sendBroadcast()、sendOrderedBroadcast() 或 sendStickyBroadcast() 等方法传递 Intent 来发起广播。
* 您可以通过在 ContentResolver 上调用 query()，对内容提供程序执行查询。

### Manifest

* 确定应用需要的任何用户权限，如互联网访问权限或对用户联系人的读取权限。
* 根据应用使用的 API，声明应用所需的最低 API 级别。
* 声明应用使用或需要的硬件和软件功能，如相机、蓝牙服务或多点触摸屏幕。
* 声明应用需要链接的 API 库（Android 框架 API 除外），如 Google 地图库。

#### 声明组件

* Activity 的 <activity> 元素。
* 服务的 <service> 元素。
* 广播接收器的 <receiver> 元素。
* 内容提供程序的 <provider> 元素。

#### 声明组件功能

`<intent-filter>`

#### 声明应用要求

> 声明设备和软件要求, 系统并不会读取它们, 但是应用市场会

    <manifest ... >
        <uses-feature android:name="android.hardware.camera.any"
                      android:required="true" />
        <uses-sdk android:minSdkVersion="7" android:targetSdkVersion="19" />
        ...
    </manifest>

### 应用资源

* 项目res/目录中支持的资源目录


#### 提供备用资源

> 在res/中创建以<resources_name>-<config_qualifier>形式命名的新目录. 以便支持特定的设备配置.
> 备用资源名称必须同默认资源完全相同.
> <config_qualifier> 顺序必须遵守src-qualifier中所列.

    * <resources_name> 是相应默认资源的目录名称
    * <config_qualifier> 是指定要使用这些资源的各个配置的名称, 可以追加多个<config_qualifier>, 以`-`分隔

表1
![src-dir.png]((https://github.com/LiMingFei56/picturebed/raw/main/android/src-dir.png)
表2
![src-qualifier.png]((https://github.com/LiMingFei56/picturebed/raw/main/android/src-qualifier.png)

#### 限定符命名规则

* 您可以为单组资源指定多个限定符，并使用短划线分隔。例如，drawable-en-rUS-land 适用于屏幕方向为横向的美国英语设备。
* 这些限定符必须遵循表 2 中列出的顺序。例如：
* 错误：drawable-hdpi-port/
* 正确：drawable-port-hdpi/
* 不能嵌套备用资源目录。例如，您的目录不能为 res/drawable/drawable-en/。
* 值不区分大小写。在处理之前，资源编译器会将目录名称转换为小写，以免不区分大小写的文件系统出现问题。名称中使用的所有大写字母只是为了便于认读。
* 每种限定符类型仅支持一个值。例如，若要对西班牙语和法语使用相同的可绘制对象文件，则您不能拥有名为 drawable-rES-rFR/ 的目录，而是需要两个包含相应文件的资源目录，如 drawable-rES/ 和 drawable-rFR/。然而，您实际无需在两处复制相同的文件。相反，您可以创建指向资源的别名。请参阅下面的创建别名资源。


#### 创建别名资源

> 想复用一个资源(不想复制多份), 又不能当成默认资源, 那么就需要使用别名资源.
> 请注意：并非所有资源都会提供相应机制，以便您创建指向其他资源的别名。
> 特别是，xml/ 目录中的动画资源、菜单资源、原始资源及其他未指定资源均不提供此功能。

##### 可绘制对象

> 在默认资源中, 创建一个非对应默认资源名, 如默认资源为icon.png, 创建一个icon_ca.png
> 英语和加拿大法语共用个icon, 那分别在`res/drawable-en-rCA/`和`res/drawable-fr-rCA/`中创建`drawables.xml`

    <?xml version="1.0" encoding="utf-8"?>
    <resources>
        <drawable name="icon">@drawable/icon_ca</drawable>
    </resources>

##### 布局

    <?xml version="1.0" encoding="utf-8"?>
    <merge>
        <include layout="@layout/main_ltr"/>
    </merge>

##### 字符串和其他简单值

    <?xml version="1.0" encoding="utf-8"?>
    <resources>
        <string name="hello">Hello</string>
        <string name="hi">@string/hello</string>
        <color name="red">#f00</color>
        <color name="highlight">@color/red</color>
    </resources>

##### 访问应用资源

> 资源id是由`aapt`工具自动生成.

    在代码中访问资源
    [<package_name>.]R.<resource_type>.<resource_name>
    * <package_name> 是资源所在包的名称（如果引用的资源来自您自己的资源包，则不需要）。
    * <resource_type> 是资源类型的 R 子类。
    * <resource_name> 是不带扩展名的资源文件名，或 XML 元素中的 android:name 属性值（若资源是简单值）。

    在 XML 中访问资源
    @[<package_name>:]<resource_type>/<resource_name>
    * <package_name> 是资源所在包的名称（如果引用的资源来自相同资源包，则不需要）
    * <resource_type> 是资源类型的 R 子类
    * <resource_name> 是不带扩展名的资源文件名，或 XML 元素中的 android:name 属性值（若资源是简单值）。

    引用样式属性
    ?[<package_name>:][<resource_type>/]<resource_name>

    访问原始文件
    assets/ AssetManager
    res/raw/ openRawResource

    访问平台资源
    android.R.layout.simple_list_item_1

##### [Android 如何查找最佳匹配资源](https://developer.android.google.cn/guide/topics/resources/providing-resources#BestMatch)

> 淘汰不匹配的, 然后选择优先级最高的

### 处理配置变更

> 某些设备配置可能会在运行时发生变化（例如屏幕方向、键盘可用性，以及当用户启用多窗口模式时）。发生这种变化时，Android 会重启正在运行的 Activity（先后调用 onDestroy() 和 onCreate()）。重启行为旨在通过利用与新设备配置相匹配的备用资源来自动重新加载您的应用，从而帮助它适应新配置。

> 如要妥善处理重启行为，Activity 必须恢复其先前的状态。您可以同时使用 onSaveInstanceState()、ViewModel 对象以及持久存储，以在配置变更时保存并恢复 Activity 的界面状态。如需详细了解如何保存 Activity 状态，请阅读保存界面状态。

配置应用在配置变更时避免Activity重启:

    <activity>元素中
    android:configChanges
    * orientation - 屏幕方向发生变更时阻止重启
    * screenSize - 屏幕方向发生变更时阻止重启 API 13以上
    * keyboardhidden - 键盘可用性发生变更时阻止重启

    <activity android:name=".MyActivity"
          android:configChanges="orientation|keyboardHidden"
          android:label="@string/app_name">

    但是会接收`onConfigurationChanged()`函数的调用. 系统调用此方法时，
    Activity 的 Resources 对象会相应地进行更新，并根据新配置返回资源，
    以便您在系统不重启 Activity 的情况下轻松重置界面元素

### 内嵌复杂的 XML 资源

> 某些资源是由XML文件表示的多个复杂资源合成的, 一般多个复杂资源为了复用是放在多个
> 文件中, 这是最佳实现方法.

> Android也可以把多个复杂资源放在一个XML文件中, 使用`<aapt:attr>`, 告诉AAPT工具该标记
> 的子标记应被视为资源并提取到其自己的资源文件中.

### 资源类型概览
本部分中的每个页面介绍了一种您可以在项目资源目录 (res/) 中提供的应用资源的用法、格式和语法。

以下是对每个页面的简要说明：

动画资源
    定义预先确定的动画。
    补间动画保存在 res/anim/ 中并通过 R.anim 类访问。
    帧动画保存在 res/drawable/ 中并通过 R.drawable 类访问。
颜色状态列表资源
    定义根据 View 状态而变化的颜色资源。
    保存在 res/color/ 中并通过 R.color 类访问。
可绘制资源
    使用位图或 XML 定义各种图形。
    保存在 res/drawable/ 中并通过 R.drawable 类访问。
布局资源
    定义应用界面的布局。
    保存在 res/layout/ 中并通过 R.layout 类访问。
菜单资源
    定义应用菜单的内容。
    保存在 res/menu/ 中并通过 R.menu 类访问。
字符串资源
    定义字符串、字符串数组和复数形式（并包括字符串格式和样式）。
    保存在 res/values/ 中，并通过 R.string、R.array 和 R.plurals 类访问。
样式资源
    定义界面元素的外观和格式。
    保存在 res/values/ 中并通过 R.style 类访问。
字体资源
    在 XML 中定义字体系列并包含自定义字体。
    保存在 res/font/ 中并通过 R.font 类访问。
更多资源类型
    将其他原始值定义为静态资源，具体包括：
    Bool
        包含布尔值的 XML 资源。
    颜色
        包含颜色值（十六进制颜色）的 XML 资源。
    维度
        包含维度值（及度量单位）的 XML 资源。
    ID
        为应用资源和组件提供唯一标识符的 XML 资源。
    整数
        包含整数值的 XML 资源。
    整数数组
        提供整数数组的 XML 资源。
    类型化数组
        提供 TypedArray（可用于可绘制对象数组）的 XML 资源。

### 源码

    repo init -u https://android.googlesource.com/platform/manifest
    repo init -u https://android.googlesource.com/platform/manifest -b master
    repo sync -c -j8

## Reference
[Application Fundamentals](https://developer.android.google.cn/guide/components/fundamentals?hl=en)  
[Source Control Tools](https://source.android.com/docs/setup/develop#installing-repo)  
[Downloading the Source](https://source.android.com/docs/setup/build/downloading)
