---
layout: page
permalink: /network-system/http/http-robot
---

## Web机器人

### 爬行方式

1. 从根集开始爬行

2. 链接提取并且需要标准化与已爬行的URL进行比较
    树和散列表       保存URL
    有损的存在位图   使用hashcode来保存URL
    检查点           序列化URL
    分类             分类URL，多个爬虫并行工作


3. 避免环路
    规范化URL
    识别文件系统连接环路（软链接）和动态虚拟Web空间
    广度优先
    节流 - 限制从一个站点中获取的页面数
    限制URL的大小
    URL/站点黑名单
    模式检测 - 检测出URL重复的部分
    内容指纹 - 对文档进行MD5并保存与对比
    人工监视 - 记录日志并分析修改机器人的工作方式

### 机器人的HTTP
* User-Agent - 告知你是机器人
* From - 机器人管理者的E-mail
* Accept - 告知服务器可以发送哪些媒体
* Referer - 提供包含当前请求URL的文档的URL

### 控制机器人访问
在服务器根目录下保存robots.txt文件

User-Agent: 机器人的身份
Disallow 不允许访问的URL 前缀匹配
Allow 允许访问的URL 前缀匹配

html robot-control元标签

