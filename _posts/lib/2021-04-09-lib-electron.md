---
layout: post
title: "Electron"
categories: lib
tags: [lib]
date: 2021-04-09
---

## Electron

	npm install -g npm
	npm install -g npm@6

	"electronDownload":{
      "mirror":"https://npm.taobao.org/mirrors/electron/"
	},

### 源

	npm config set registry https://npm.taobao.org/mirrors/node
	npm config set disturl https://npm.taobao.org/mirrors/node
	npm config set ELECTRON_MIRROR http://npm.taobao.org/mirrors/electron/

## API使用

### Webview

1. load第三方的网站
	webPreferences:
		nodeIntegration: true,
		webviewTag: true,
		webSecurity: false,
		javascript: true,
		contextIsolation: false,
    enableRemoteModule: true,

	webview allowpopups

2. 忽略https网站证书
[electron私有部署webview加载不安全的https网址](https://blog.csdn.net/qq_35432904/article/details/103975099)  

	app.commandLine.appendSwitch('--ignore-certificate-errors', 'true')
	or
 
	session.on('certificate-error', function(event, webContents, url, error, certificate, callback) {
		if (url == "https://github.com") {
			// 验证逻辑。
			event.preventDefault();
			callback(true);
		} else {
			callback(false);
		}
	});

3. Uncaught DOMException: Blocked a frame with origin

	app.commandLine.appendSwitch('disable-site-isolation-trials')

4. Electron require() is not defined

	As of version 5, the default for nodeIntegration changed from true to false. You can enable it when creating the Browser Window:

5. X-Frame-Option

		win.webContents.session.webRequest.onHeadersReceived({urls: ['*://*/*']}, (d, c) => {
		if (d.responseHeaders['X-Frame-Options']) {
			delete d.responseHeaders['X-Frame-Options']
		} else if (d.responseHeaders['x-frame-options']) {
			delete d.responseHeaders['x-frame-options']
		}
			c({cancel: false, responseHeaders: d.responseHeaders})
		})
	
6. Webview 函数调用

> 只有在html中引用的js, 才能调用webview函数


## build
[Builder, forge, packager… which do I use?](https://discuss.atom.io/t/builder-forge-packager-which-do-i-use/38894)  
[Application Distribution](https://www.electronjs.org/docs/tutorial/application-distribution)  

### electron-packager

### [electron-builder](https://www.electron.build/)  

	npm install electron-builder --save-dev
	

### electron-forge
	npm install --save-dev @electron-forge/cli

	报错 gyp: Undefined variable module_path in binding.gyp while trying to load binding.gyp

	需要使用npm@6 才能正常的安装, 排除

## ERROR

#### 1. Electron failed to install correctly, please delete node_modules/electron and try installing again
[记打造你的第一个electron的坑](https://segmentfault.com/a/1190000021424025)  

> 因为electron安装完成会执行preinstall, electron目录下的install.js.
> install.js 会下载平台lib, 国外源很慢, 很容易失败. 
> install.js 执行失败, 目录下不会生成`getElectronPath`需要的`path.txt`文件

解决:
	在package.json的script中加上
	"install": "set ELECTRON_MIRROR=http://npm.taobao.org/mirrors/electron/ && node ./node_modules/electron/install.js"

### Reference
[Electron](https://www.electronjs.org/docs/tutorial/quick-start)  
[electron-builder](https://www.electron.build/)  
