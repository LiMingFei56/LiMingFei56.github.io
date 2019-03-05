---
layout: page
permalink: ./technology-home/platform/flutter/platform-specific
---

## Platform Specific
Flutter支持调用本地平台的代码，通过消息传递机制（不是基于代码生成），flutter channels

Flutter UI(client) 发送消息，而platform(host)，通过MethodChannel进行异步通信
* MethodChannel(Client) - 允许发送方法调用的消息
* MethodChannel(Platform) - 允许接收方法调用的消息并返回调用结果
Android `MethodChannel`实现；iOS `FlutterMethodChannel`实现，消息也可以返向发送。

### 实现

#### 1. 创建新的工程
    // 默认模板支持Java, objc
    flutter create batterylevel
    // 指定模板支持kotlin, swift
    flutter create -i swift -a kotlin batterylevel

#### 2. 创建Flutter Client
    // 通道名必须唯一，通过通道名来建立连接
    static const platform = const MethodChannel('samples.flutter.io/battery');
    // 发送信息，有可能报错
    final int result = await platform.invokeMethod('getBatteryLevel');
    // 使用
    batteryLevel = 'Battery level at $result % .';
    setState(() {
      _batteryLevel = batteryLevel;
    });

#### 3. Android实现

     new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                       if (call.method.equals("getBatteryLevel")) {
                            int batteryLevel = getBatteryLevel();

                            if (batteryLevel != -1) {
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null);
                            }
                        } else {
                            result.notImplemented();
                        }
                    }
                });

#### 4. iOS实现

    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"samples.flutter.io/battery"
                                          binaryMessenger:controller];

    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"getBatteryLevel" isEqualToString:call.method]) {
            int batteryLevel = [weakSelf getBatteryLevel];

            if (batteryLevel == -1) {
            result([FlutterError errorWithCode:@"UNAVAILABLE"
                                        message:@"Battery info unavailable"
                                        details:nil]);
            } else {
            result(@(batteryLevel));
            }
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

#### 5. 平台调用Flutter

