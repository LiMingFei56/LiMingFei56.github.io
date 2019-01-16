---
layout: page
permalink: /android/protect_process
---

## Android保活

### 网络连接保活
a. GCM; 国内不适用
b. 公共的第三方push通道(信鸽等)；安全和不稳定
c. 自身跟服务器通过轮询，或者长连接。 

长连接实现包括几个要素：
* a. 网络切换或者初始化时 server ip 的获取。
* b. 连接前的 ip筛选，出错后ip 的抛弃。
* c. 维护长连接的心跳。
* d. 服务器通过长连notify。
* e. 选择使用长连通道的业务。
* f. 断开后重连的策略。

长连接心跳机制:
* 中国2G环境, 部分3G环境, Net超时5分钟
* 美国, 台湾, 28分钟
* GCM 28分钟心跳
* 国内保证4.5分钟一次心跳

心跳实现:
* a. 连接后主动到服务器Sync拉取一次数据，确保连接过程的新消息。
* b. 心跳周期的Alarm 唤醒后，一般有几秒的cpu 时间，无需wakelock。
* c. 心跳后的Alarm防止发送超时，如服务器正常回包，该Alarm 取消。
* d. 如果服务器回包，系统通过网络唤醒，无需wakelock。

流程基于两个系统特性：
a. Alarm唤醒后，足够cpu时间发包。
b. 网络回包可唤醒机器

特别是b项，假如Android封堵该特性，那就只能用GCM了。API level >= 23的doze就关闭所有的网络
， alarm等。但进入doze条件苛刻，现在6.0普及低，至今微信没收到相关投诉。
另Google也最终加入REQUEST_IGNORE_BATTERY_OPTIMIZATIONS权限。

### 进程保活
进程被杀的原因:
* a. 应用Crash
* b. 系统回收内存
* c. 用户触发
* d. 第三方root权限app.

当上述b发生时, 进程是按照优先级从大到小来杀死app:
    ps | grep tencent.mm 查看进程uid
    cat /proc/uid/oom_adj 

保活方法:
1. 开启一个像素的Activity
2. 前台Service 
    对于 API level < 18 ：调用startForeground(ID， new Notification())，发送空的Notification ，图标则不会显示。
    对于 API level >= 18：在需要提优先级的service A启动一个InnerService，两个服务同时startForeground，且绑定同样的 ID。Stop 掉InnerService ，这样通知栏图标即被移除。
3. 进程相互唤醒
4. JobSheduler
5. 多种广播, Alerm等



