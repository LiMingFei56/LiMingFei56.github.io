---
layout: page
permalink: /ios/guide/detail/the-app-life-cycle
---

The App Life cycle

应用在代码和系统框架间做复杂的交互。系统框架提供基础设施，可以使应用接收各种设备状态，
和用户的操作事件。

iOS框架是使用mvc和代理模式。

### Main函数
跟其他c语言程序一样，iOS程序入口也是Main函数，不一样的地方是iOS程序不用自己创建Main函数。

	#import <UIKit/UIKit.h>
	#import "AppDelegate.h"
	 
	int main(int argc, char * argv[])
	{
	    @autoreleasepool {
	        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	    }
	}

上面的iOS代码就是把控制权交给UIKit框架，UIApplicationMain函数通过创建应用程序的核心
对象来处理些过程，从可用的Storyboard文件中读取用户界面，调用自定义代码以便应用有机会
做一些初始设置，并使开启应用的运行环。

### 应用的结构
UIApplicationMain函数会设置几个关键对象和开始应用的运行。最关键的是UIApplication对象，
这个对象主要负责系统和应用其他对象间的交互。iOS应用是使用mvc模型，这个模型把数据和
业务逻辑同视图分离开来，这种设计可以很方便的创建运行在不同屏幕大小的不同设备上。

应用的关键对象
![应用的关键对象](/assets/ios/ios-guide-keyobjects.png)

应用的对象角色
![应用的对象角色](/assets/ios/ios-guide-roleobjects.png)

### Main运行环
Main运行环处理所有用户相关的事件。UIApplication对象在应用启动时开启Main运行环，并且
使用Main运行环来处理事件并更新用户界面。Main运行环是运行在主线程中的，此行为可确保
用户相关事件按接收顺序进行连续处理。

当用户与设备交互时，设备会生成一个事件，并通过UIKit设置的特殊端口传送到应用程序。应用程序
在Main运行环中一个接一个的顺序执行。UIApplication对象是第一个接收到事件，并确定怎么处理。

触摸事件通常是先分发到window对象，然后分发到发生触摸的view对象。其他的事件可能通过
不同的对象。

主运行环事件处理
![主运行环事件处理](/assets/ios/ios-guide-mainrunloop-event.png)

许多类型的事件可以分发到应用。许多类型的事件可以使用Main运行环处理，但是有些事件不行。
有些事件是发送到代理对象，或者通过一个回调代码块处理，如触摸，遥控，运动，加速度设备，
逻盘设备等。

常见的事件类型
![常见的事件类型](/assets/ios/ios-guide-common-type-events.png)

Responder objects在应用中使用广范，像触摸事件和远程控制事件是交给Responder objects处理。
Responder objects可以是UIApplication对象，View对象，ViewController对象。大多数事件会指定
一个目标Responder objects处理，但是这个对象可以把事件通过responder chain传递给其他Responder objects处理。

通过controls触发的Touch事件跟其他类型的view触发的touch事件的处理方式不一样。因为跟Controls交互的事件只有有限的几种，
所以这些交互被重新打包成动作消息并传送到适当的目标对象，这叫做Target-action模式。
目标操作模式可以轻松使用控件来触发应用程序中自定义代码的执行。

### 应用的运行状态
在任何时候，应用都存在一种运行状态。系统会根据不同的操作来改变应用的状态。如用户按了Home键，
来了个电话等等。

应用的运行状态
![应用的运行状态](/assets/ios/ios-guide-app-state.png)

应用的状态改变
![应用的状态改变](/assets/ios/ios-guide-state-change.png)

应用状态转换会调用代理对象的相应方法，应用需要在不同的状态转换方法里实现对应的处理：

* application:willFinishLaunchingWithOptions: 应用刚启动时会调用这个方法
* application:didFinishLaunchingWithOptions: 在应用显示在前台前调用，执行最终的初始化工作
* applicationDidBecomeActive: 应用将会进入前台，这个方法是最后的准备
* applicationWillResignActive: 应用将会退出前台，到静止状态
* applicationDidEnterBackground: 应用运行在后台，有可能在任何时间里进入Suspended
* applicationWillEnterForeground: 应用将要从后台进入前台
* applicationWillTerminate: 应用将要终止，如果应用处于Suspended状态就不会调用这个方法

### 应用终止
应用必须在任何时候准备被终止，不要等着去执行保存用户数据或者执行重要的任务。系统终止应用
是应用生命周期中普通的部分。系统通常为了回收内存给其他应用使用而终止应用，也有可能错误的终止
应用或者终止不及时回应事件的应用。

Suspended状态的应用终止时不会接收任何消息，系统重启也不会给应用任何消息。用户手动终止应用
也不会给应用任何消息。

### 线程和并发
iOS系统会给应用创建主线程，应用也可以在必要时添加线程，处理其他任务。iOS应用首选使用
Grand Central Dispatch(GCD，多线程优化技术)，operation objects，和其他异步编程接口，去创建
并管理线程。

在考虑线程和并发性时，可以参考下面几点：

	* 涉及到View的操作，核心动画，和其他UIKit类通常在主线程执行。如果拿不准，最好放在
		主线程里。
	* 耗时的任务（或者有可能耗时的任务）应始终在后台线程中执行。涉及网络访问，文件访问
		或大量数据处理的任务应用使用GCD或者operation objects异步执行。
	* 在启动时尽量把任务从主线程中移出，只在主线程上执行有助于设置用户界面的任务。所有其他任务
		应该异步执行。

