---
layout: page
permalink: /network-system/http/http-entity
---

## 实体和编码
实体与首部是用空白的CRLF行分隔的

### 描述HTTP报文的内容
* Content - Type                                        - 实体中所承载对象的类型
* Content - Length                                      - 所传送实体主体的长度或大小
* Content - Language                                    - 与所传送对象最相配的人类语言
* Content - Encoding                                    - 对象数据所做的任意变换(比如，压缩)
* Content - Location                                    - 一个备用位置，请求时可通过它获得对象
* Content - Range                                       - 如果这是部分实体，这个首部说明它是整体的哪个部分
* Content - MD5                                         - 实体主体内容的校验和
* Last    - Modified                                    - 所传输内容在服务器上创建或最后修改的日期时间
* Expires - 实体数据将要失效的日期时间
* Allow   - 该资源所允许的各种请求方法，例如，GET和HEAD
* ETag    - 这份文档特定实例的唯一验证码
* Cache   - Control                                     - 指出应该如何缓存该文档。

### 媒体类型
Content-Type的值是使用标准化的MIME类型，都在互联网号码分配机构IANA中注册。MIME类型
由一个主媒体类型后面跟一条斜线以及一个子类型组成。

Content-Type还支持可选的参数来进一步说明内容的类型：

    * charset - 说明内容编码
    * boundary - 分界字符串，通常用于多部分媒体类型

### 多部分媒体类型
MIME中multipart报文中包含多个实体，每一部分都是独立的，有各自的描述其内容的集；不同
的部分用分界字符串连接在一起。

multipart/form-data
multipart/mixed
multipart/x-byteranges

### 内容编码
如果对内容进行编码，那么需要把Content-Length的长度设置成编码后的

内容编码类型：

    * gzip - gun zip 编码
    * compress - unix的文件压缩
    * deflate - zlib
    * identify - 没有编码

Accept-Encoding - 说明客户端可以接收的编码，其中Q表示质量，0.0-1.0，表示编码的优先级。0.0表示
不接收

### 传输编码
传输编码是针对报文，而不像内容编码针对实体

TE - 客户端表明支持的编码
Transfer-Encoding - 使用的传输编码 

传输编码类型：
    
    * chunked - 块传输，把报文分为大小已知的块，块之间紧挨着发送，这样就不需要在发送之前知道
        整个报文的长度，适用于动态生成内容。用大小为0的块作为报文的结束

分块传输拖挂 - 可以在块结束后带上可选的拖挂(Trailer首部定义)

### 实例操控
有条件的请求（conditional request）- 客户端发送验证码，并仅当文档有新的版本时才要求发
送新的文档。

新鲜度 - 通过Expires(过期)，Cache-Control(缓存控制)

验证码：
    If-Modified-Since
    If-UnModified-Since
    If-Match
    If-None-Match

weak validators(W/)/strong validators
弱验证码 - 当文档改变时，ETag不一定改变，如精度低的时间，如文档大小。ETag前加W/
强验证证 - 当文档改变时，ETag必须改变，如MD5。ETag默认为强验证码


请求范围 - Range: bytes=4000-8000o

差异编码 - 当文档有改变，不需要传全部内容，只用传修改的部分
差异编码步骤：

    1. 请求文档，服务器响应（包含该文档的Etag）
        Expires: xxx
        Etag: abcdef
    2. 文档不再新鲜，发启差异请求
        If-None-Match: abcdef
        A-Im(Accept-Instance-Manipulation): diffe
    3. 服务器通过Etag判断文档是否有改变，如果改变就使用差异生成器，并返回
        IM: diffe
        Etag: cdefabc
        Delta-base: abcdef
    4. 客户端接收到差异响应，使用差异应用器更新内容

实例操控类型：

    * vcdiff
    * diffe
    * gdiff
    * gzip
    * deflate
    * range
    * identity

差异生成器和应用器是使用上述操控类型，生成中间编码，然后客户端使用上述算法，使用
旧文档和中间编码生成新的文档。在文档改动频繁的情况下不适用



