## Java6新特性
### 使用JAXB来实现对象与XML之间的映射
> JAXB是Java Architecture for XML Binding的缩写，可以将一个Java对象转变成为XML
  格式，反之亦然。我们把对象与关系数据库之间的映射称为ORM, 其实也可以把对象与XML之间
  的映射称为OXM(Object XML Mapping). 原来JAXB是JavaEE的一部分，在JDK6中，SUN将其放
  到了Java SE中，这也是SUN的一贯做法。JDK6中自带的这个JAXB版本是2.0, 比起1.0
  (JSR 31)来，JAXB2(JSR 222)用JDK5的新特性Annotation来标识要作绑定的类和属性等，
  这就极大简化了开发的工作量。实际上，在Java EE 5.0中，EJB和Web Services也通过
  Annotation 来简化开发工作。另外,JAXB在底层是用STAX(JSR173)来处理XML文档。

> 注：除了JAXB之外，我们还可以通过XMLBeans和Castor等来实现同样的功能。

### 理解STAX
> STAX是The Streaming API for XML的缩写，一种利用拉模式解析(pull-parsing)XML文档
  的API. STAX通过提供一种基于事件迭代器(Iterator)的API让程序员去控制xml文档解析过程
  ,程序遍历这个事件迭代器去处理每一个解析事件，解析事件可以看做是程序拉出来的，也就是
  程序促使解析器产生一个解析事件然后处理该事件，之后又促使解析器产生下一个解析事件，
  如此循环直到碰到文档结束符；SAX 也是基于事件处理xml 文档，但却是用推模式解析，
  解析器解析完整个xml 文档后，才产生解析事件，然后推给程序去处理这些事件；DOM 采用的
  方式是将整个xml文档映射到一颗内存树，这样就可以很容易地得到父节点和子结点以及兄弟
  节点的数据，但如果文档很大，将会严重影响性能。

### 使用Compiler API
> 现在我们可以用JDK6 的Compiler API(JSR 199)去动态编译Java源文件，Compiler API结合
  反射功能就可以实现动态的产生Java代码并编译执行这些代码，有点动态语言的特征。这个特性
  对于某些需要用到动态编译的应用程序相当有用， 比如JSP Web Server，当我们手动修改JSP
  后，是不希望需要重启Web Server 才可以看到效果的，这时候我们就可以用Compiler API来
  实现动态编译JSP文件，当然，现在的JSP Web Server也是支持JSP热部署的，现在的
  JSP Web Server通过在运行期间通过Runtime.exec 或ProcessBuilder 来调用javac 来
  编译代码，这种方式需要我们产生另一个进程去做编译工作，不够优雅而且容易使代码依赖与
  特定的操作系统；Compiler API通过一套易用的标准的API提供了更加丰富的方式去做动态编译
  ,而且是跨平台的。

### 轻量级Http Server
> JDK6 提供了一个简单的Http Server API,据此我们可以构建自己的嵌入式Http Server,
  它支持Http 和Https 协议,提供了HTTP1.1的部分实现，没有被实现的那部分可以通过扩展已
  有的Http Server API来实现,程序员必须自己实现HttpHandler接口,HttpServer 会调用
  HttpHandler 实现类的回调方法来处理客户端请求,在这里,我们把一个Http 请求和它的响应
  称为一个交换,包装成HttpExchange类,HttpServer负责将HttpExchange传给HttpHandler
  实现类的回调方法。

### 用Console开发控制台程序
> JDK6 中提供了java.io.Console 类专用来访问基于字符的控制台设备. 你的程序如果要
  与Windows 下的cmd 或者Linux 下的Terminal交互,就可以用Console类代劳. 但我们不总
  是能得到可用的Console, 一个JVM是否有可用的Console依赖于底层平台和JVM如何被调用.
   如果JVM是在交互式命令行(比如Windows的cmd)中启动的,并且输入输出没有重定向到另外的
   地方,那么就可以得到一个可用的Console实例。

### Common Annotations
> Common annotations 原本是Java EE 5.0(JSR 244)规范的一部分，现在SUN 把它的一部分
  放到了Java SE 6.0 中.随着Annotation元数据功能(JSR 175)加入到Java SE 5.0里面，
  很多Java 技术(比如EJB,Web Services)都会用Annotation部分代替XML 文件来配置运行
  参数（或者说是支持声明式编程,如EJB的声明式事务）, 如果这些技术为通用目的都单独定义了
  自己的Annotations,显然有点重复建设, 所以,为其他相关的Java 技术定义一套公共的
  Annotation是有价值的，可以避免重复建设的同时，也保证Java SE和Java EE 各种技术的
  一致性.

### Web服务元数据(Web Services metadata)
> JSR-181的元数据清单

### 更简单,更强大的JAX-WS
> JAX-WS(JSR-224) 是Java Architecture for XML Web Services的缩写,简单说就是一种
  用Java和XML开发Web Services应用程序的框架, 目前版本是2.0, 它是JAX-RPC 1.1的后续
  版本, J2EE 1.4 带的就是JAX-RPC1.1, 而Java EE 5里面包括了JAX-WS 2.0,但为了向后
  兼容,仍然支持JAX-RPC. 现在,SUN 又把JAX-WS 直接放到了Java SE 6里面,由于JAX-WS
  会用到.Common Annotation(JSR 250),Java Web Services Metadata(JSR 181),
  JAXB2(JSR 222), StAX(JSR 173), 所以SUN也必须把后几个原属于Java EE范畴的
  Components下放到Java SE, 现在我们可以清楚地理解了为什么Sun要把这些看似跟JavaSE
  没有关系的Components放进来,终极目的就是要在Java SE里面支持Web Services.

### 脚本语言支持(Scripting)
> JDK6增加了对脚本语言的支持(JSR 223)，原理上是将脚本语言编译成bytecode，这样脚本
  语言也能享用Java平台的诸多优势，包括可移植性，安全等，另外，由于现在是编译成
  bytecode 后再执行，所以比原来边解释边执行效率要高很多。加入对脚本语言的支持后，
  对Java语言也提供了以下好处。
