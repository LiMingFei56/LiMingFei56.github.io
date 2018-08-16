---
layout: page
permalink: /network-system/http/http-cache
---

## 缓存

* 缓存减少了冗余的数据传输，节省了你的网络费用。
* 缓存缓解了网络瓶颈的问题。不需要更多的带宽就能够更快地加载页面。
* 缓存降低了对原始服务器的要求。 服务器可以更快地响应，避免过载的出现。
* 缓存降低了距离时延，因为从较远的地方加载页面会更慢一些。

### 命中和未命中

命中   - cache hit
未命中 - cache miss

#### 再验证
原始服务器的内容可能会发生变化，缓存要不时对其进行检测，这些“新鲜度检测”被称为HTTP
再验证(revalidation)。HTTP定义了一些特殊的请求，不用获取整个对象，就可以验证。

发送特殊的请求（GET 带If-Modified_Since首部的请求），如果返回 304 Not Modified 就是再验证命中，否则为再验证未命中

再验证命中   - 304 Not Modified
再验证未命中 - 返回 200 OK和完整文档
对象被删除   - 404 Not Found

#### 命中率
缓存命中率 - cache hit rate  也叫文档命中率 - document hit rate

40%左右就是合理的

字节命中率 - (byte hit rate) 文档并不全是同一尺寸的， 所以文档命中率并不能代表流量真实情况

客户端判断是文档是缓存 还是原始服务器的。通过Date首部与当前时候进行比较

### 缓存结构

分级缓存
网状缓存

### 缓存的处理步骤

1. 接收
2. 解析
3. 查询
4. 新鲜度检测
5. 创建响应
6. 发送
7. 日志

### 保持副本的新鲜

* 文档过期 - 设置文档过期时间
             Cache-Control: max-age=484200 设置相对过期时间 HTTP1.1
             Expires: Fri, 05 Jul 2002, 05:00:00 GMT 设置绝对过期时间 HTTP1.0

* 服务器再验证 - 当文档过期就需要对服务再验证，看是否与服务器上的一致

* 条件方法进行再验证 - 条件GET请求，只有条件为真时对会返回文档对象
                       If-Modified-Since - 如果指定日期之后文档被修改
                       If-None-Match - 判断标签是否一样

### 缓存控制

* Cache-Control: no-story 不缓存
* Cache-Control: no-cache(Pragma: no-cache Http兼容) 缓存，但在再验证前不使用
* Cache-Control: must-revalidate - 缓存，但在再验证前不使用
* Cache-Control: max-age 设置相对过期时间
* Expires 设置绝对过期时间
* 不附加过期信息，让缓存确定自己的过期日期

试探性过期 - 如果没有显式的设置过期时间，那么缓存需要使用试探性过期算法来计算再验证时间
使用LM-Factor算法，

### 缓存与广告
缓存不计算广告点击量, 一般的解决方法是缓存服务器记录日志


