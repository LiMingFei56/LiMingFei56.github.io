---
layout: post
title: "Hackintosh 介绍"
categories: compute
tags: [hackintosh]
date: 2020-05-16
excerpt: "Hackintosh 介绍"
---

## Hackintosh

> Hackintosh是在非Mac平台上安装macOS系统, 在价钱和性能上占优, 但是不管怎么配置也
> 会遇到这样那样的问题(特别是系统升级). 

> 因为苹果选择使用Intel CPU, 所以使得Hackintosh成为可能, 有谣言说苹果在自研ARM处理
> 器, 想要统一MAC, IPHONE, IPAD. 如果是真的, 那么Hackintosh到苹果停止维护X86平台时
> 就消失, 或者找到另一条路.

> 在非MAC平台安装macOS, 会遇到最大的问题就是硬件和驱动. 苹果禁止在非MAC平台安装
> macOS系统, 并且驱动也是苹果自己选择指定. 所以选择与MAC平台兼容的硬件是非常有必要
> 的, 可以使安装的Hackintosh使用体验更接近Macintosh, 当然也可以放弃一些部件(声音, 网卡).
> 选择好硬件后也不能像Windows那样直接安装后就可以用了, 因为苹果系统安装与启动需要检查
> 硬件平台是否是MAC平台, 所以需要如`Clover`或`OpenCore`来模拟MAC平台.

### Hackintosh 安装过程

1. 配置Bios
2. 根据机器的情况配置OpenCore(选择别人已经证实可行的硬件非常有必要)
3. 安装完成后才是真正的开始, 进入系统后会发现各种各样的问题
4. 不停的解决问题, 或者放弃, 直到心理上的完美

### Hackintosh 完美定义

1. 各部件驱动正常, USB, 声卡, 网卡, 蓝牙等  
2. cpu变频正常(不见得变频档位越多越好，高低两档够用 四档很优秀 再多没多大意义)  
3. 显卡变频正常 睡眠唤醒后不停留在高频 风扇不卡死高速 可以双屏或多频  
4. usd3.0&3.1 能够正常识别 速度是5G  
5. 声卡端口正常，HDMI能够输出，插入耳机能够自动跳转。可以静音。  
6. wifi可以开启airdrop 和handoff 与以太网网口en 0（这个影响你苹果账户的登录以及  
    使用imessage和FaceTime）  
7. SSD开启TRIM（这个影响你ssd的寿命）如果你有ssd 并且还有一块HDD 那就强烈建议大  
    家组建FusionDrive 类似raid功能 两行代码就解决 非常简单 表现的结果是速度快  
    稳定安全！可以让硬盘读写速度到400M 当然要看你的ssd速度了
    注意：fusionDrive只能适合osx10.12 之前版本  
8. 系统偏好设置的电源管理项目 多也就是cpu可以变频 或者LPC加载和X86Pla二选一
9. 能够自动睡眠，唤醒后不黑屏 用鼠标和键盘何以唤醒。  
10. 可以登录iMessage和FaceTime tips：开启FaceTime 可以远程遥控啊！非常不错
    就是让别人帮你在软件层面上修电脑 你就可以看到他的操作了  

见[ 黑苹果完美定义！如是我闻！](https://www.feng.com/post/11610510)
见[完美的黑苹果应当有那些特性?](https://www.zhihu.com/question/321338542/answer/682548600)


### Reference
Hackintosh Basics
[The Basics](https://www.tonymacx86.com/forums/the-basics.165/)
[The How-To Geek Guide to Hackintoshing – Part 1: The Basics](https://www.howtogeek.com/72417/the-how-to-geek-guide-to-hackintoshing-part-1-the-basics/)
[The How-To Geek Guide to Hackintoshing – Part 2: The Installation](https://www.howtogeek.com/72821/the-how-to-geek-guide-to-hackintoshing-part-2-the-installation/)
[The How-To Geek Guide to Hackintoshing – Part 3: Upgrading to Lion and Dual-Booting](https://www.howtogeek.com/73113/the-how-to-geek-guide-to-hackintoshing-part-3-upgrading-to-lion-and-dual-booting/)
[Learning the Hackintosh Four Letter Words](https://www.tonymacx86.com/threads/learning-the-hackintosh-four-letter-words.273877/)

选择兼容硬件
[tonymacx86](https://www.tonymacx86.com/)
[Hackintosh黑苹果长期维护机型整理清单](https://blog.daliansky.net/Hackintosh-long-term-maintenance-model-checklist.html)

OpenCore
[OpenCore](https://dortania.github.io/OpenCore-Desktop-Guide/)
[使用OpenCore引导黑苹果](https://blog.xjn819.com/)
