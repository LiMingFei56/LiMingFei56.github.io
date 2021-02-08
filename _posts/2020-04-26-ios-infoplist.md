## iOS Info.plist说明
source: `{{ page.path }}`

### 1. NSAppTransportSecurity

> iOS 9.0开始不赞成使用Http不安全协议
> 如果确定使用Http, 那么需要配置`NSAppTransportSecurity`

* 方式一:
    
    <key>NSAppTransportSecurity</key>
    <dict>
      <key>NSAllowsArbitraryLoads</key>
      <true/>
    </dict>

* 方式二(有选择的允许HTTP):

    <key>NSAppTransportSecurity</key>
    <dict>
      <key>NSExceptionDomains</key>
      <dict>
        <key>域名.com</key>
        <dict>
          <!--允许子域名:subdomains-->
          <key>NSIncludesSubdomains</key>
          <true/>
          <!--允许App进行不安全的HTTP请求-->
          <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
          <true/>
          <!--在这里声明所支持的 TLS 最低版本-->
          <key>NSTemporaryExceptionMinimumTLSVersion</key>
          <string>TLSv1.1</string>
        </dict>
      </dict>
    </dict>

### 2. 配置URL Scheme

    <key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>JingantechSecurity</string>
			</array>
		</dict>
	</array>

### 3. CFBundleIcons 和 UILaunchImages

> iOS 5.0 时是使用`CFBundleIcons`和`UILaunchImages`来指定应用图标和启动图片. 现
> 在一般用来修改应用图标和启动图片

### 屏幕相关

1. UIRequiresFullScreen
> 是否全屏
> 注: 已不在Info.plist中配置, 在项目Targets->General中勾选

2. UISupportedInterfaceOrientations
> 应用支持的设备方向

3. UIViewControllerBasedStatusBarAppearance
> Status Bar的字体颜色, 是白色还是黑色. status bar 永远是透明的.

* NO:
> UIApplication setStatusBarStyle 有效
> UIViewController preferredStatusBarStyle 无效

* YES时 上面情况相反

### 设备相关

1. UIRequiredDeviceCapabilities
> 指定应用需要的设备功能

2. UIBackgroundModes
> 后台运行模式

### 权限相关

1. NSCameraUsageDescription
> 使用相机

2. NSLocationAlwaysUsageDescription
> 一直定位

3. NSLocationWhenInUseDescription
> 当使用时定位

4. NSMicrophoneUsageDescription
> 使用麦克风

### Reference
[What's New in iOS](https://developer.apple.com/library/archive/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-DontLinkElementID_13)
