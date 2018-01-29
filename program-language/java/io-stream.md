---
layout: page
permalink: /program-language/java/io-stream
---

IO Stream

## JavaIO类

![io class](/assets/java/JavaIO类.png)

## Java IO
### Java IO简介
> Java IO 是一套Java用来读写数据（输入和输出）的API。大部分程序都要处理一些输入，
  并由输入产生一些输出。Java为此提供了java.io包。Java.io 包主要涉及文件，网络数据流
  ，内存缓冲等的输入输出。
  * 文件访问
  * 网络访问
  * 内存缓存访问
  * 线程内部通信(管道)
  * 缓冲
  * 过滤
  * 解析
  * 读写文本 (Readers / Writers)
  * 读写基本类型数据 (long, int etc.)
  * 读写对象

### 输入、输出及流
*   输入：从数据源读取。
*   输出：把数据输出到目标媒介。
*   流：连续的数据串。

### 数据流分类
*   字节流：以字节为单位传输。都是继承InputStream、OutputStream
*   字符流：以字符为单位传输。都是继承Reader、Writer。输入和输出跟编码有关，编码不对
    会导致乱码。

### 文件
> 文件的输入、输出

#### 文件字节流读写
* FileInputStream
* FileOutputStream

#### 文件字符流读写
* FileReader
* FileWriter

#### 文件随机访问
* RandomAccessFile

### 管道
> 管道为运行在同一个JVM中的两个线程提供了通信的能力。

#### 管道字节流读写
* PipedInputStream
* PipedOutputStream

#### 管道字符流读写
* PipedReader
* PipedWriter

### 网络
> 当两个进程之间建立了网络连接之后，他们通信的方式如同操作文件一样。

### 顺序流
> 使用SequenceInputStream可以顺序的从多个输入流中读取，第一个读完读下一个。

### 过滤流
> 实现数据流过滤的基类

* FilterInputStream
* FilterOutputStream

#### 推回流
> 可以把数据插入到流的头部，插入数据的大小与推回流的缓冲区有关。

* PushbackInputStream
* PushbackReader

#### 令牌分析流
> 把数据流解释成一个个的Token，以Token为单位来读取。

* StreamTokenizer

#### 行数分析流
> 读取数据字符流，可以跟踪行数。

* LineNumberReader

#### 基本数据类型分析流
> 以基本数据类型来读取、写入流。

* DataInputStream
* DataOutputStream

### 对象序列化流
* ObjectInputStream
* ObjectOutputStream

## Java NIO
### NIO简介
> Java NIO(New IO)是一个可以替代标准Java IO API的IO API（从Java 1.4开始)，
  Java NIO提供了与标准IO不同的IO工作方式。

#### Channels and BuffersChannels
> 标准的IO基于字节流和字符流进行操作的，而NIO是基于通道（Channel）和缓冲区
  （Buffer）进行操作，数据总是从通道读取到缓冲区中，或者从缓冲区写入到通道中。

#### Non-blocking IO（非阻塞IO）
> Java NIO可以让你非阻塞的使用IO，例如：当线程从通道读取数据到缓冲区时，线程还是
  可以进行其他事情。当数据被写入到缓冲区时，线程可以继续处理它。从缓冲区写入通道
  也类似。

#### Selectors（选择器）
> Java NIO引入了选择器的概念，选择器用于监听多个通道的事件（比如：连接打开，
  数据到达）。因此，单个的线程可以监听多个数据通道。

### Channel
#### Channel简介
> Java NIO的通道类似流，但又有些不同。
> 既可以从通道中读取数据，又可以写数据到通道。但流的读写通常是单向的。
> 通道可以异步地读写。
> 通道中的数据总是要先读到一个Buffer，或者总是要从一个Buffer中写入。

#### Channel的实现
* FileChannel：从文件中读写数据。
* DatagramChannel：能通过UDP读写网络中的数据。
* SocketChannel：能通过TCP读写网络中的数据。
* ServerSocketChannel：可以监听新进来的TCP连接，像Web服务器那样。对每一个新进来的
  连接都会创建一个SocketChannel。

### Buffer
#### Buffer简介
> Java NIO中的Buffer用于和NIO通道进行交互。如你所知，数据是从通道读入缓冲区，从
  缓冲区写入到通道中的。缓冲区本质上是一块可以写入数据，然后可以从中读取数据的内存
  。这块内存被包装成NIO Buffer对象，并提供了一组方法，用来方便的访问该块内存。

#### Buffer基本用法
1. 写入数据到Buffer
2. 调用flip()方法
3. 从Buffer中读取数据
4. 调用clear()方法或者compact()方法

> 当向buffer写入数据时，buffer会记录下写了多少数据。一旦要读取数据，需要通过
  flip()方法将Buffer从写模式切换到读模式。在读模式下，可以读取之前写入到buffer
  的所有数据。一旦读完了所有的数据，就需要清空缓冲区，让它可以再次被写入。有两种
  方式能清空缓冲区：调用clear()或compact()方法。

#### Buffer三个属性
1. capacity：作为一个内存块，Buffer有一个固定的大小值，也叫“capacity”.你只能往里写
   capacity个byte、long，char等类型。一旦Buffer满了，需要将其清空（通过读数据或者
   清除数据）才能继续写数据往里写数据。

2. position：当写的时候为写的位置，当读的时候为读的位置，缓冲区flip后会把position重
   置为0。

3. limit：当写的时候为写入数据最大值，limit=capacity，当读时为position重置前的值。

#### Buffer数据类型
    ByteBuffer
    MappedByteBuffer
    CharBuffer
    DoubleBuffer
    FloatBuffer
    IntBuffer
    LongBuffer
    ShortBuffer

#### Buffer方法说明
* clear方法：清空Buffer，position设置为0，limit设置为capacity。
* compact方法：清理已经读过的数据，把未读的数据移动到Buffer头，然后position指向数据
  尾，limit设置为capacity。
* rewind方法：设置position为0，可以重新读缓存。
* mark方法：记录一个position值。
* reset方法：恢复到mark方法记录的position。
* equels方法：比较2个Buffer是否相等。
* compareTo方法：判断是否小于另一个。

### Scatter And Gather
#### Scatter And Gather简介
> 分散（scatter）从Channel中读取是指在读操作时将读取的数据写入多个buffer中。
  因此，Channel将从Channel中读取的数据“分散（scatter）”到多个Buffer中。

> 聚集（gather）写入Channel是指在写操作时将多个buffer的数据写入同一个Channel，
  因此，Channel 将多个Buffer中的数据“聚集（gather）”后发送到Channel。

#### Scatter And Gather实现
Scattering Reads

    ByteBuffer header = ByteBuffer.allocate(128);
    ByteBuffer body   = ByteBuffer.allocate(1024);
    ByteBuffer[] bufferArray = { header, body };
    channel.read(bufferArray);

Gathering Writes

    ByteBuffer header = ByteBuffer.allocate(128);
    ByteBuffer body   = ByteBuffer.allocate(1024);
    ByteBuffer[] bufferArray = { header, body };
    channel.write(bufferArray);

### FileChannel通道间的数据传输
> FileChannel只有阻塞模式，没有非阻塞模式。

* transferFrom
* transferTo

### Selectors
#### Selectors简介
> Selector（选择器）是Java NIO中能够检测一到多个NIO通道，并能够知晓通道是否为诸如
  读写事件做好准备的组件。这样，一个单独的线程可以管理多个channel，从而管理多个
  网络连接。

  Selector只能与非阻塞的Channel一起使用，所以不能和FileChannel一起使用。

#### Selector使用步骤
1. 创建:Selector.open()
2. 注册通道:channel.register
3. 监听:select()

#### Selector事件
1. SelectionKey.OP_CONNECT
2. SelectionKey.OP_ACCEPT
3. SelectionKey.OP_READ
4. SelectionKey.OP_WRITE

#### SelectionKey
##### interest集合
> interest集合是你所选择的感兴趣的事件集合。

##### ready集合
> ready 集合是通道已经准备就绪的操作的集合。

### Pipe管道
#### Pipe简介
> Java NIO 管道是2个线程之间的单向数据连接。Pipe有一个source通道和一个sink通道。
  数据会被写到sink通道，从source通道读取。

#### Pipe使用步骤
1. 创建管道:Pipe.open()
2. 写管道:pipe.sink()
3. 读管道:pipe.source()

