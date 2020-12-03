## Flutter Packages
source: `{{ page.path }}`

### Using packages

[Using Packages](https://flutter.dev/docs/development/packages-and-plugins/using-packages)
[Package versioning](https://dart.dev/tools/pub/versioning)

flutter 使用pub管理包:
[pub-cn](https://pub.flutter-io.cn/)
[pub](https://pub.dev/)

#### dependencies

    url_launcher: ^5.4.0 配置pub管理

    plugin1:
        path: ../plugin1/  配置本地库

    plugin1:
        url: git://github.com/flutter/plugin1.git 配置git库

    plugin1:
        url: git://github.com/flutter/plugin1.git 配置git库
        path: packages/package1                   配置为git库的子目录


#### 解决包冲突
多个库中的依赖同一个库不同的版本, 就会造成冲突

1. 使用库版本范围依赖, 如^5.4.0  any 5.4.x version where x >= 0 works
    推荐, gradle和cocoapods会支持这种方式, pub自动处理依赖
2. 配置dependency_overrides, 强制指定一个版本

Unshared libraries (the npm approach)
Version lock (the dead end approach)
Version constraints (the Dart approach)

#### 版本配置

指定版本号: widgets 2.0.5
约束版本号: widgets '&gt;=2.3.5 &lt;2.4.0'
Semantic versions: widgets ^2.3.5   (相当与&gt;=2.3.5 &lt;3.0.0)
Semantic versions: widgets 0.1.2+1  (相当与&lt;1.0.0, 只在版本号小于1.0.0时使用)

### Developing packages & plugins

[Developing packages & plugins](https://flutter.dev/docs/development/packages-and-plugins/developing-packages)

Dart packages: 使用dart开发库
Plugin Packages: 使用dart调用本地API

flutter create --template=package hello
flutter create --org com.example --template=plugin

#### [Platform channel](https://flutter.dev/docs/development/platform-integration/platform-channels)

1. 使用`defaultTargetPlatform`判断当前平台
2. 客户端使用MethodChannel
3. Host使用Android(MethodChannelAndroid), iOS(MethodChanneliOS)
4. Channel名称必须保证唯一
5. Channel运行的方法都在主线程中调用

自定义channels和codecs
1. MethodChannel继承自BasicMessageChannel
2. Codecs有BinaryCodec, StringCodec, JSONMessageCodec

#### Pigeon

MethodChannel是类型不安全的, 类型取决与发送和接收端定义的类型. 需要传类型安全的结构  
化的数据需要使用`Pigeon`

### 使Widget显示本地View

1. Texture
2. PlatformView: Android(AndroidView), iOS(UIKitView)

Platform也是使用Texture呈现NativeView, Texture使用SurfaceView来呈现
点击事件通过Channel传递

### Referance

[Platform adaptations](https://flutter.dev/docs/resources/platform-adaptations)  
[Flutter PlatformView: How to create Widgets from Native Views](https://medium.com/flutter-community/flutter-platformview-how-to-create-flutter-widgets-from-native-views-366e378115b6)  
[5分钟彻底搞懂Flutter中PlatFormView与Texture](https://cloud.tencent.com/developer/article/1584477)  
[PlatformView](https://github.com/loosaSH/flutter-PlatformView)  
