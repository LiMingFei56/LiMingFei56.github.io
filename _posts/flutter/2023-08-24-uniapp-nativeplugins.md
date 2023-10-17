---
layout: post
title: Uniapp 原生插件开发
categories: flutter
tags: [flutter, uniapp]
date: 2023-08-24
---

## Uniapp 原生插件开发

### 插件有两种类型

* Activity的获取方式。通过mUniSDKInstance.getContext()强转Activity。建议先instanceof Activity判断一下再强转
* .vue暂时只能使用module形式。component还不支持在.vue下使用
* component、module的生命周回调，暂时只支持onActivityDestroy 、onActivityPause、onActivityResult其他暂时不支持

* module 没有界面, 支持vue和nvue
* component native控件, 支持nvue

> 使用uni原生插件必须先提交云端打包才能生效，购买插件后在应用的manifest.json页面的“App原生插件配置”项下点击“选择云端插件”，选择需要打包的插件：


|-- DCloud-RichAlert --->插件id命名的文件夹
   |-- android       --->安卓插件目录
	  |--libs
		 - xxx.jar    --->依赖的jar
		 - libxxx.so  --->依赖的so文件
	  - vendor.aar   --->依赖的aar
	  - unipluginRichAlert.aar --->插件module的aar
   |-- ios
   |-- package.json

### 离线打包

> android 中嵌入uniapp. 开发者中心创建uniapp类型的应用, 配置Android应用得到appkey和appid
> uniapp使用appid开发, build -> mobile app - local packaging -> generator local packaged app resource, 打包uniapp资源
> 把uniapp资源放到android/src/main/assets/apps/{appid}/www


    项目src/main/assets/data/dcloud_control.xml里面的appid和开发者中心的appid一致
    项目的build.gradle里面的applicationId和开发者中心的 Android 包名一致
    项目的证书签名SHA1和开发者中心的Android 证书签名SHA1一致
    assets子目录改成appid
    src/main/assets/apps/xxx/www/manifest.json里面的id和开发者中心的appid一致(xxx表示appid)

> 添加新的module

    1. 新module中build.gradle 添加必要配置

        compileOnly fileTree(dir: 'libs', include: ['*.jar'])

        compileOnly 'androidx.recyclerview:recyclerview:1.0.0'
        compileOnly 'androidx.legacy:legacy-support-v4:1.0.0'
        compileOnly 'androidx.appcompat:appcompat:1.0.0'
        compileOnly 'com.alibaba:fastjson:1.2.83'

        compileOnly fileTree(dir: '../app/libs', include: ['uniapp-v8-release.aar'])
        compileOnly fileTree(dir: '../app/libs', include: ['lib.5plus.base-release.aar']) // Permissions

        compileOnly 'com.alibaba:fastjson:1.1.46.android'

    2. 主app中build.gradle

        implementation project(":unilmfadalliance")

    3. dcloud_uniplugins.json配置新插件

    {
      "nativePlugins": [
        {
          "plugins": [
            {
              "type": "module",
              "name": "TestModule",
              "class": "io.dcloud.uniplugin.TestModule"
            }
          ]
        },
        {
        "plugins": [
          {
            "type": "component",
            "name": "myText",
            "class": "io.dcloud.uniplugin.TestText"
          }
        ]
        },
        {
          "hooksClass": "",
          "plugins": [
            {
              "type": "module",
              "name": "DCloud-RichAlert",
              "class": "uni.dcloud.io.uniplugin_richalert.RichAlertModule"
            }
          ]
        },
        {
          "hooksClass": "",
          "plugins": [
            {
              "type": "module",
              "name": "unilmfadalliance",
              "class": "com.lmf.unilmfadalliance.RichAlertModule"
            }
          ]
        }
      ]
    }


### 使用原生插件

uniapp项目下创建nativeplugins目录

nativeplugins
    uniapp-pluginname
        android
            插件aar
            插件依赖aar
            libs
                jar包
        ios
        package.json

1. uniapp项目manifest.json -> App原生插件中选择
2. run -> mobile app playground -> generate custom playgroud 自定义插件基座(不这样用不了原生插件)
3. 选择 custom playground native runner
4. 选择 standard model
5. 会上传到uniapp打包, 一个号一天只能上传5次, 多的2元/次 (垃圾)
6. uniapp项目 ->  unpackage/debug/android_debug.apk 就是打包出来的基座
7. 运行 -> run  -> mobile app playgroun -> android run -> operating with custom base (自定义基座运行)


##### uniapp [JS Framework] 当前运行的基座不包含原生插件

1. 检查插件名称是否正确
    插件名称(nativeplugsin目录下的插件目录名)与 插件package.json id 要跟module name 相同
    android_debug.apk assert 中 dcloud_uniplugins.json, 中有插件配置
    uni.requireNativePlugin("插件名称")

2. 把uniapp 全卸载, 先安装android_debug.apk, 再自定义基座运行

#### 原生广告

Error code = -5100
Error message:
uni原生插件所包含的库与uni-AD冲突，无法共存。如需广告服务，请登录 https://uniad.dcloud.net.cn 开通内置的uni-AD

### 自定义基坐


### UniJSCallback

> Uniapp 与 原生平台通信使用 UniJSCallback

void invoke(Object data);
void invokeAndKeepAlive(Object data);

* invoke调用javascript回调方法，此方法将在调用后被销毁。
* invokeAndKeepAlive 调用javascript回调方法并保持回调活动以备以后使用。

> 调用invoke后, 后续UniJSCallback对象将不可用. 
> 调用invokeAndKeepAlive后, 后续可以用, 直到invoke

### keystore

    keytool -genkey -alias lmf -keyalg RSA -keysize 2048 -validity 36500 -keystore lmf.keystore 
    keytool -list -v -keystore lmf.keystore
    keytool -exportcert -keystore lmf.keystore | openssl dgst -md5

    SHA1: 72:BB:49:36:B1:83:EB:B1:AA:6A:7E:3D:BA:E5:97:07:16:5E:2D:12
    SHA256: 4B:CA:A6:1F:B8:D0:FA:D9:0F:4F:11:85:82:55:2F:BB:30:B9:46:43:49:81:E1:17:C8:73:A8:BF:68:7F:85:14
    MD5: 8e1552463b7ebe658ba0fb545f3d3ad2

无效

public class MyApplication extends DCloudApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        removeAdTip(this);

        registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
                removeAdTip(activity);
            }

            @Override
            public void onActivityStarted(Activity activity) {

            }

            @Override
            public void onActivityResumed(Activity activity) {

            }

            @Override
            public void onActivityPaused(Activity activity) {

            }

            @Override
            public void onActivityStopped(Activity activity) {

            }

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle outState) {

            }

            @Override
            public void onActivityDestroyed(Activity activity) {
                removeAdTip(activity);
            }
        });
    }

    /**
     * 移除DCloud广告toast提示
     *
     * @param context
     */
    private void removeAdTip(Context context) {
        context.getSharedPreferences("_adio.dcloud.feature.ad.dcloud.ADHandler", Context.MODE_PRIVATE)
                .edit()
                .clear()
                .apply();
    }
}

com.taobao.weex.base.SystemMessageHandler

修改这部分android:name=".MyApplication"

添加tools:replace="android:name" 这部分，避免merge冲突


## Reference
+ [uni原生插件开发教程](https://nativesupport.dcloud.net.cn/NativePlugin/course/android.html)
+ [Android应用市场上架uni-app(5+App)应用合规指南，以及收到工信部或应用市场合规整改通知的解决办法 ](https://ask.dcloud.net.cn/article/39073)
+ [uni原生插件开发流程全一览——Component扩展](https://www.jianshu.com/p/8b40ce7f7566)
+ [项目配置都正确怎么还是提示"未配置AppKey或配置错误"](https://nativesupport.dcloud.net.cn/AppDocs/usesdk/appkey.html#%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98)
+ [自定义基座](https://uniapp.dcloud.net.cn/tutorial/run/run-app.html#customplayground)
