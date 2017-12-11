---
layout: page
permalink: /ios/guide/detail/expected-app-behaviors
---

Expected App Behaviors

应用程序提交到App Store前，需要提供一个自定义信息，确保给用户好的用户体验。自定义
信息从提供一个应用Icon到应用怎么呈现用户信息的系统级决策。本章描述了所有应用程序
预期要处理的行为，并且应该在规划过程中尽早考虑。

### 提供必要的资源

	* An information property-list file: Info.plist文件包含提供给系统的
		一些元数据。

	* A declaration of the app's required capabilities: 所有的App必需声明硬件的功能
		或者特性。App Store会根据这些信息确定哪些设置可以运行这个App。Info.plist文件
		中定义。

	* One or more icons: 系统设备在主页，设置中，搜索中显示App的Icon。
	
	* One or more launch image:	在打开App时显示的临时图片。

### App程序包
当build iOS应用时，Xcode会把项目捆绑成一个程序包。程序包是一个目录，会将执行文件
和资源（Icon,image等）集中在一起。

A typical app bundle

File     | Example   | Description
---------|-----------|--------------------------------
App executable | MyApp  | 可执行文件包含编译的代码。名字为应用名减去.app后缀，这个文件是必须的
The information property list file | Info.plist | 应用信息文件，这个文件必须叫Info.plist
App icons | Icon.png | 一般在设备主屏幕显示，其他的分辨率显示在合适的地方，@2x显示带有Retina显示器
Launch images | Default.png | 在启动应用时显示
Storyboard file(or nib files) | MainBoard.storyboard | 包括View和ViewController，用来显示内容，也可以使用Segues通过Identify实现2个Scene间的跳转。可以在Info.plist中修改主Storyboard，UIMainStoryboardFile(nib file使用NSMainNibFile)

