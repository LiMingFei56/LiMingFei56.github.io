---
layout: page
permalink: /network-system/http/http-basic-connect
---

### TCP的连接的时延、瓶颈以及存在的障碍
HTTP事务的时延：
    1. DNS域名解析
    2. 上百个http连接等待
    3. 服务器处理的性能
    4. 回送HTTP响应

TCP相关时延:
    1. TCP连接建立握手
    2. TCP慢启动拥塞控制
    3. 数据聚集的Nagle算法
    4. 用于捎带确认的TCP延迟确认算法
    5. TIME_WAIT时延和端口耗尽

#### TCP连接的握手时延
SYN/SYN+ACK， 每次建立HTTP连接都要TCP握手，如果HTTP事务很小，那么TCP握手会花费50%，
或更多的时间。


#### TCP慢启动
为了防止因特网的突然过载和拥塞，所以使用“打开拥塞窗口”方法，也就是先发送一个数据包，
收到确认后才能发送2个，再就是4个。这样慢慢的提高传输性能。

所以已调谐的连接比没有调谐的连接快，所以HTTP中有一些可以重用现存连接的工具.

#### Nagle算法与TCP_NODELAY
TCP段大小 - LAN上最大尺寸的分组大约是1500字节，因特网上是几百字节，最小段最好是大于40
    字节
发送端傻窗口综合症 - 发送大量单字节分组的行为
Nagle算法 - 将大量TCP数据绑定在一起，以发送全尺寸的段。只有当所有其他分组都被确认之后，
    Nagle算法才允许发送非全尺寸的分组，否则就缓存分组到一个全尺寸分组
时延      - 等待全尺寸时，与延迟确认之间存在问题。
TCP_NODELAY - 不使用Nagle算法

#### 延迟确认
分组确认 - 当收到完整的数据分组（分组序号和数据校验码），需要返回给发送者分组确认报文
发送捎带 - 确认报文很小，允许在发往相同方向的输出数据分组中对其进行捎带
延迟确认 - 在一特定的窗口时间内将输出确认存放在缓冲区中，以寻找能够捎带它的输出数据分组
时延     - 因为HTTP具有双峰特征的请求（应答行为降低了捎带信息的可能）

#### TIME_WAIT累积与端口耗尽
重复分组问题 - TCP以源IP,源端口,目标IP,目标端口来唯一确认连接，当前连接被关闭后，又
    立刻创建源IP端口，目标IP端口一样的连接，有可能收到上一连接的分组包。
TIME_WAIT - 为了防止上面的问题，会记录最近所关闭连接的IP地址和端口号，这个信息只会
    维持一小段时间，通常是所估计的最大分段使用期的两倍（2MSL）左右。
时延 - 需要保证在TIME_WAIT中不要耗尺端口号

#### HTTP连接的处理

##### Connection
Connection首部是个逐跳道部，只适用于单条传输链路
Connection的3种不同类型的标签:
    * HTTP首部字段名，列出了只与此连接有关的首部 - HTTP允许传输通过中间实体(代理
        、高速缓存等），当报文到代理里，代理会删除列出首部，不会再往下传。可以防
        止无意中对本地首部的转发
    * 自定义标签值，用于描述此连接的非标准选项
    * 值close，说明操作完成后需要关闭这条持久连接

一定不能被代理转发的逐跳首部

    Proxy-Authenticate
    Proxy-Connection
    Transfer-Encoding
    Upgrade

##### 持久连接
HTTP/1.0 keep-alive连接
keep-alive在HTTP/1.1中没有说明了，但是珲是使用相当广泛
Connection: Keep-Alive 来打开持久连接
Keep-Alive: max=5, timeout=120 - timeout连接保持在活跃的时间；max服务器希望保持持久连接
    数
需要正确的指定Content-Length
代理需要删除Connetion首部，不然会出现哑代理，使第二条数据挂起


HTTP/1.1 persistent
HTTP/1.1 默认是持久连接的

##### 持久连接的限制和规则
* Connection: close, 事务完成连接一定是关闭了，如果后续没有连接了推荐添加这个首部
* 只有Content-Length设置正确，连接才能是持久保持
* HTTP/1.1的代理必须能够分别管理与客户端和服务器的持久连接-每个持久连接都只适用于一
    跳传输
* HTTP/1.0的代理不应该使用持久连接
* HTTP/1.1设备都可以在任意时刻关闭连接
* HTTP/1.1应用程序必须能够从异步的关闭中恢复出来。只要不存在可能会累积起来的副作用
    ，客户端都应该重试这条请求。
* 客户端对服务器或代理最多只能维护两条持久连接，以防服务器过载。

##### 管道化连接
可以将多条请求放入队列，在高时延网络条件下，这样做可以降低网络的环回时间，提高性能。

* 只有支持持久连接，才能用管道。
* 必须按照与请求相同的顺序回送HTTP响应。
* 不要发送产生副作用的请求

### 关闭连接
* 应用程序可以在任何时间关闭TCP连接
* 持久连接一般会在空闲状态时关闭，但是关闭时无法确定客户端是否在写数据
* 一般以关闭连接来判断报文长度，如果Content-Length与接收的报文不一样就不能使用Content-Length
* 完全关闭 - 调用close() 输入 输出信道都关闭
* 半关闭 - 调用shutdown() 可以单独关闭输入或输出
* 连接被对端重置 - 当发送数据到已关闭输入信道的端口时，会返回TCP的“连接被对端重置”的报文