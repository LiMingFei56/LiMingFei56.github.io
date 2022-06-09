---
layout: post
title: "iOS SwiftUI"
categories: ios
tags: [ios]
date: 2022-05-30
---

## iOS SwiftUI

> 打开SwiftUI预览, Editor > Canvas, 可以由代码和Inspector 控制 (Command-click view). 

### Preview

> Xcode's canvas 可以自动识别和显示当前编辑的View, 返回一个View, 可以自定义返回View

	struct ContentView_Previews: PreviewProvider {
			static var previews: some View {
					ContentView()
			}
	}

	struct LandmarkRow_Previews: PreviewProvider {
			static var previews: some View {
					Group {
							LandmarkRow(landmark: landmarks[0])
							LandmarkRow(landmark: landmarks[1])
					}
					.previewLayout(.fixed(width: 300, height: 70))
			}
	}

	struct LandmarkList_Previews: PreviewProvider {
			static var previews: some View {
					ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
							LandmarkList()
									.previewDevice(PreviewDevice(rawValue: deviceName))
									.previewDisplayName(deviceName)
					}
			}
	}

### [Content](https://stackoverflow.com/questions/56833659/what-is-content-in-swiftui)

> `Content`是一个泛型, 是一个类型的别名. 但是文档里没有说明到底是什么. 也有可以是`ViewModifier`
> 创建View的构造函数, 最后一个参数一般为闭包, 最后一句代码是表达式语句, 那么不用写`return`关键字
> 如果有多个返回View, 比如`HStack`, 内容包含多个View, 那么闭包需要使用`@ViewBuilder`修饰, 会把多个
> View自动打包成`TupleView`对象.

### Model

1. Codable
>	Codable = Decodable + Encodable
> 结构体序列化和反序列化

2. Hashable
> 生成默认的Hash值, 可以算定自`hashValue`(一般用异或)

3. Identifiable
> List视图, 需要id属性, 如果模型实现了`Identifiable`, 就可以不传递id属性. 生成对象唯一标识
> 如果元素是简单的值类型(如: 字符串), 那么可以使用`\.self`表示唯一标识

### [State and Data Flow](https://developer.apple.com/documentation/swiftui/state-and-data-flow)

> State And Binding
	
> SwiftUI中View创建出来是一个常量, 常量对象状态不可改变. 如果想改变一个对象的状态,
> 并且View随着状态改变而改变. 那么状态需要使用`@State`修饰

> `Binding`可以把View的值和状态属性绑定起来, 当状态属性值变了后, View展示也会变
> 使用`$`引用绑定的值.

		struct Input:view {
			@Binding var text: String
			var body: some View {
				TextField(text: $text)
			}
		}

### Observable Object

> View监听对象状态的改变, 属于`Combine`包

	1. 监听对象实现`ObservableObject`协议
	2. 需要监听的状态用`@Published `修饰
	3. 创建监听对象
		* `@StateObject`初始化监听对象时使用
		* `@EnvironmentObject`修饰监听对象, SwiftUI会自动获取状态值
			(创建ContentView时需要使用`environmentObject`方法, 应用到所有视图)
		* `@ObservedObject`修饰监听对象, 可以引用监听对象

### Drawing and Animation

> `CoreGraphics`画图核心

#### Animations

1. View使用`equatable`, SwiftUI会识别可动画的属性, 如颜色, 透明度, 旋转角度, 大小和其他属性使用`animation(_:) `
2. View不使用`equatable`, 可以在指定的值更改时使用`animation(_:value:) `
3. `withAnimation`: 使用相关View都有动画
4. 默认下SwiftUI动画是淡入淡出, 使用`transition(_:)`修改过度动画, 传入`AnyTransition`
5. `AnyTransition`使用`asymmetric(insertion:removal:)`自定义过度动画


### View

#### List

##### 1. 默认样式

> list默认样式有圆角, 有边距

1. 设置`listStyle` listStyle(GroupedListStyle()) 或者 listStyle(PlainListStyle())
2. item设置`listRowInsets(EdgeInsets()` 或者listRowInsets(EdgeInsets(top: -20, leading: -20, bottom: -20, trailing: -20))

### Interfacing with UIKit

1. 创建Swift File, 实现UIViewControllerRepresentable 协议
2. 实现`makeUIViewController`函数, 返回一个UIKit Controller 对象, swiftui 只会调用这方法一次, 然后管理视图生命同期
		`UIHostingController`, A UIKit view controller that manages a SwiftUI view hierarchy.
3. 实现`updateUIViewController`, 当swiftui状态更新时, 通知UIKit Controller更新
4. 实现`makeCoordinator`, 创建与AppKit协调对象

### Reference
[Introducing SwiftUI](https://developer.apple.com/tutorials/swiftui)  
[SwiftUI 概述 :: Learn Swift](https://swiftui.jokerhub.cn/)  
[Adding SwiftUI to Objective-C Apps](https://medium.com/@iainbarclay/adding-swiftui-to-objective-c-apps-63abc3b26c33)  
