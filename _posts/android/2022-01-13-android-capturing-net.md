---
layout: post
title: "Android 抓包"
categories: android
tags: [android]
date: 2022-01-13
---

## Android 抓包

### tcpdump

#### 参数

	-a：尝试将网络和广播地址转换成名称； 
	-c<数据包数目>：收到指定的数据包数目后，就停止进行倾倒操作； 
	-d：把编译过的数据包编码转换成可阅读的格式，并倾倒到标准输出； 
	-dd：把编译过的数据包编码转换成C语言的格式，并倾倒到标准输出； 
	-ddd：把编译过的数据包编码转换成十进制数字的格式，并倾倒到标准输出； 
	-e：在每列倾倒资料上显示连接层级的文件头； 
	-f：用数字显示网际网络地址； 
	-F<表达文件>：指定内含表达方式的文件； 
	-i<网络界面>：使用指定的网络截面送出数据包； 
	-l：使用标准输出列的缓冲区； 
	-n：不把主机的网络地址转换成名字； 
	-N：不列出域名； 
	-O：不将数据包编码最佳化； 
	-p：不让网络界面进入混杂模式； 
	-q ：快速输出，仅列出少数的传输协议信息； 
	-r<数据包文件>：从指定的文件读取数据包数据； 
	-s<数据包大小>：设置每个数据包的大小； 
	-S：用绝对而非相对数值列出TCP关联数； 
	-t：在每列倾倒资料上不显示时间戳记； 
	-tt： 在每列倾倒资料上显示未经格式化的时间戳记； 
	-T<数据包类型>：强制将表达方式所指定的数据包转译成设置的数据包类型； 
	-v：详细显示指令执行过程； 
	-vv：更详细显示指令执行过程； 
	-x：用十六进制字码列出数据包资料； 
	-w<数据包文件>：把数据包数据写入指定的文件。

#### 使用

	tcpdump -i wlan0 host <ip> -p -s 0 -w /sdcard/capture.pcap

#### 查看网络情况

	netstat -e
	cat /proc/net/tcp
	cat /proc/net/tcp6
	ps


### Reference
[最全的tcpdump使用详解](https://www.cnblogs.com/lvdongjie/p/10911564.html)  
[tcpdump抓包和Wireshark解包](https://www.cnblogs.com/domestique/p/8028405.html)  
[androidtcpdump](https://www.androidtcpdump.com/)  
[HTTP Toolkit](https://github.com/httptoolkit)  
[How to monitor HTTP (get, post etc) requests that my app is making in android](https://www.py4u.net/discuss/613265)  
[Android : Capturing HTTP Requests with non-rooted android device](https://stackoverflow.com/questions/17684936/android-capturing-http-requests-with-non-rooted-android-device)  
[android通过执行netstat及cat /proc/net/tcp查看正在运行应用的本地端口号pid和uid以及对方的IP和端口号](https://blog.csdn.net/haima1998/article/details/34434159)  
