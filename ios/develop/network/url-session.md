---
layout: page
permalink: /ios/develop/network/url-session
---

URL Session

Foundation framework 提供类使用标准的网络协议与服务器通信。这些类叫作URL loading system。
这里简称ULS。ULS的技术核心为`NSURL`类，它可以让应用程序操作URLs和它引用的资源。ULS支持通过
URLs下载内容，上传数据，管理cookie，控制响应缓存，处理证书和认证，并且编写自己的协议。

ULS支持的协议：
* File Transfer Protocol (ftp://)
* Hypertext Transfer Protocol (http://)
* Hypertext Transfer Protocol with encryption (https://)
* Local file URLs (file:///)
* Data URLs (data://)

对于HTTP,支持HTTP/1.1, SPDY, and HTTP/2 protocols. HTTP/2 support

![](/assets/network/url-loading-system.png)

### NSURLSession
这个类提供API使用HTTP协议下载数据，而且支持应用处于`Suspended`状态时下载。使用这套API需要
创建一系列Session，每个Session协调一组数据相关的传输Task。

有两种方法接收到请示响应：

* 使用系统提供的代理方法，需要提供下载完成处理代码。
* 实现自定义代理对象，当下载完成，系统会调用代理对象的方法。

一般使用第二种方法，如果两种方法都实现了，那么第二个不会调用，只会调用第一个方法。

#### URL Session 概念
Session中Task的行为依赖三件事：

* Session的类型
* Task类型
* Task创建时应用是否在前台

##### Session类型
使用配置对象创建NSURLSession对象决定这个Session类型，支持三种：
* Default session - 与其他Foundation URLs下载行为相似。它们使用一贵的基于硬盘的缓存和保存凭证到用户的keychain。
* Ephemeral session - 所有数据保存在内存中。Session失效后自动清除。
* Background session - 类似Default session，只是在单独的进程中执行。

##### Task类型
Session中支持3类Task:
* Data Tasks - 通过`NSData`对象发送和接收数据。
* Download Tasks - 下载一个文件，支持后台下载。
* Upload tasks - 发送一个文件，支持后台下载。

##### 后台传输注意事项
Background session实际是在单独的进程中进行，因为重新启动应用的代阶是昂贵的，因此有几种特性是不可用的，导致以下限制：
* Session必须提供代理处理事件
* 只支持HTTP和HTTPS协议，不支持自定义协议
* 重定向总是遵循
* 只支持从文件上传任务（从程序退出后，从数据对象上传或流将失败）。
* 如果后台传输是在`background`状态下开启的，那么配置对象`discretionary`要为true

当应用重启后，ios和os x的行为略微不一样：
iOS中，当后台传输完成后或者需要凭证，如果应用没有在运行，iOS会自动重新启动应用在`background`状态，并且调用应用代理方法
`application:handleEventsForBackgroundURLSession:completionHandler: `，调用时会提供identifier，使用这个标识符重新创建一样
的Session，系统就会自动把这个Session连接上下载完成的Session。稍后，当Session中最后一个Task完成时，会发送消息给Session代理，
`URLSessionDidFinishEventsForBackgroundURLSession:`。在这个代理方法中应该调用先前存储在主线程中completion handler，告诉
系统可以重新安全挂起应用。

如果任何Task是在应用`Suspended`状态时完成的，代理方法`URLSession:downloadTask:didFinishDownloadingToURL: `会在与任务URL
想关联的新下载任务开始时调用。

如果任何Task需要凭证，那么会调用NSURLSession的代理对象`URLSession:task:didReceiveChallenge:completionHandler:`和
`URLSession:didReceiveChallenge:completionHandler:`方法。

后台运行的上传和下载的Task会在出错后自动重试，没有必要使用可达性API来确定何时重试失败的任务。

##### NSCopying行为
Session和Task符合NSCopying协议：
* 当复制Session或者Task对象时，可以得到同样的对象。
* 当复制配置对象，可以得到一个新副本。

### 实现代理

	NS_ASSUME_NONNULL_BEGIN
	typedef void (^CompletionHandler)();
	 
	@interface MySessionDelegate : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate, NSURLSessionStreamDelegate>
	 
	@property NSMutableDictionary <NSString *, CompletionHandler>*completionHandlers;
	 
	@end
	NS_ASSUME_NONNULL_END

### 创建和配置Session
NSURLSession提供下面这些配置：
* 对于单个Session提供私有的存储缓存，cookies，凭证，协议
* 身份验证，绑定到一个特定的请求（Task）或一组请求（Session）
* 通过URL上传和下载文件，鼓励从元数据（URL和设置）中分离数据（文件的内容）
* 配置每个主机的最大连接数
* 如果无法在一定的时间内下载整个资源，则会触发每资源超时
* 最小和最大TLS版本支持
* 自定义代理字典
* 控制Cookie政策
* 控制HTTP流水线行为

由于大多数设置都包含在单独的配置对象中，因此您可以重复使用常用的设置。当你实例化一个会话对象时，你需要指定以下内容:
* 管理该会话及其中任务的行为的配置对象
* 可项，Session代理对象。

如果不提供代理对象，NSURLSession使用系统提供的代理。可以使用`sendAsynchronousRequest:queue:completionHandler: `,
如果支持后台传输，那么必须设置Session代理。

在实例化会话对象之后，不能在不创建新会话的情况下更改配置或委托

#### 接收结果-系统提供代理
* 需要创建配置对象和session对象
* 提供下载完成处理代理

#### 接收结果-自定义代理
* `URLSession:dataTask:didReceiveData:` - 从一个请求提供数据到您的任务，一次一个。
* `URLSession:task:didCompleteWithError:` - 告诉代理任务完成传输数据，如果出错error参数不为空。

### 下载文件
* `URLSession:downloadTask:didFinishDownloadingToURL:` - 文件下载完成，需要处理文件，不然方法返回后会删除临时文件。
* `URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:` - 提供下载的状态。
* `URLSession:downloadTask:didResumeAtOffset:expectedTotalBytes:` - 重新尝试下载出错的任务成功。
* `URLSession:task:didCompleteWithError:` - 告诉代理任务完成传输数据，如果出错error参数不为空。

* `cancelByProducingResumeData:` - 暂停任务
* `downloadTaskWithResumeData:` 或 `downloadTaskWithResumeData:completionHandler:` - 重新开启任务

如果断点续传成功，userInfo中包含`NSURLSessionDownloadTaskResumeData`，

### 上传body
实现HTTP POST请求有三种方法：NSData,File,stream：
* 如果您的应用程序已经有内存中的数据，并没有理由处置它，请使用NSData对象。
* 如果正在上传的内容作为文件存在于磁盘上，如果您正在进行后台传输，或者如果您的应用程序将其写入磁盘以便释放与该数据关联的内存
	，请使用File。
* 如果您通过网络接收数据，请使用流。

`URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend: ` - 获取上传进度
`URLSession:task:needNewBodyStream:` - 如果使用的是流，那么需要实现这个方法

#### 上传body - NSBData
调用session`uploadTaskWithRequest:fromData:`和`uploadTaskWithRequest:fromData:completionHandler:`方法创建一个upload task。
使用`fromData`参数提供body数据，session对象会计算body数据得到`Content-Length`。

	NSURL *textFileURL = [NSURL fileURLWithPath:@"/path/to/file.txt"];
	NSData *data = [NSData dataWithContentsOfURL:textFileURL];
	
	NSURL *url = [NSURL URLWithString:@"https://www.example.com/"];
	NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
	mutableRequest.HTTPMethod = @"POST";
	[mutableRequest setValue:[NSString stringWithFormat:@"%lld", data.length] forHTTPHeaderField:@"Content-Length"];
	[mutableRequest setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
	
	NSURLSessionUploadTask *uploadTask = [defaultSession uploadTaskWithRequest:mutableRequest fromData:data];
	[uploadTask resume];

#### 上传body - File
调用session`uploadTaskWithRequest:fromFile:`和`uploadTaskWithRequest:fromFile:completionHandler: `方法创建一个upload task。
使用`fromFile`参数提供file URL。session对象会计算body数据得到`Content-Length`。

	NSURL *textFileURL = [NSURL fileURLWithPath:@"/path/to/file.txt"];
	
	NSURL *url = [NSURL URLWithString:@"https://www.example.com/"];
	NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
	mutableRequest.HTTPMethod = @"POST";
	
	NSURLSessionUploadTask *uploadTask = [defaultSession uploadTaskWithRequest:mutableRequest fromFile:textFileURL];
	[uploadTask resume];

#### 上传body - stream
调用session`uploadTaskWithStreamedRequest:`方法创建一个upload task。必须提供：
* 读取body的流
* body的`Content-Type`
* body的`Content-Length`

	NSURL *textFileURL = [NSURL fileURLWithPath:@"/path/to/file.txt"];
	 
	NSURL *url = [NSURL URLWithString:@"https://www.example.com/"];
	NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
	mutableRequest.HTTPMethod = @"POST";
	mutableRequest.HTTPBodyStream = [NSInputStream inputStreamWithFileAtPath:textFileURL.path];
	[mutableRequest setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
	[mutableRequest setValue:[NSString stringWithFormat:@"%lld", data.length] forHTTPHeaderField:@"Content-Length"];
	 
	NSURLSessionUploadTask *uploadTask = [defaultSession uploadTaskWithStreamedRequest:mutableRequest];
	[uploadTask resume];

#### 上传body通过 Download Task
要为下载任务上传正文内容，您的应用程序必须提供NSData对象或正文流作为创建下载请求时提供的NSURLRequest对象的一部分。

使用`URLSession:task:needNewBodyStream:`


### 处理认证和自定义TLS链验证
如果远程服务器返回一个状态码，指示需要身份验证，并且该身份验证需要连接级别的质询（如SSL客户端证书）
，则NSURLSession将调用身份验证质询委托方法.

如果使用流的方式上传内容时，认证失败，那么应该重新创建session再尝试。

### 处理iOS后台活动
`application:handleEventsForBackgroundURLSession:completionHandler:`
`URLSessionDidFinishEventsForBackgroundURLSession: `

### 编解码URL
percent-encode使用NSString的`stringByAddingPercentEncodingWithAllowedCharacters:`方法:

* User: URLUserAllowedCharacterSet
* Password: URLPasswordAllowedCharacterSet
* Host: URLHostAllowedCharacterSet
* Path: URLPathAllowedCharacterSet
* Fragment: URLFragmentAllowedCharacterSet
* Query: URLQueryAllowedCharacterSet

	NSString *originalString = @"color-#708090";
	NSCharacterSet *allowedCharacters = [NSCharacterSet URLFragmentAllowedCharacterSet];
	NSString *percentEncodedString = [originalString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
	NSLog(@"%@", percentEncodedString"); // prints "color-%23708090"
	
	NSURL *URL = [NSURL URLWithString:@"https://example.com/#color-%23708090"];
	NSURLComponents *components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];
	NSString *fragment = components.fragment;
	NSLog(@"%@", fragment); // prints "color-#708090"

### 处理重定向和其他请示改变
当服务器返回重定向，NSURLSession会调用代理`URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:`方法。


