---
layout: post
title: "Flutter IO编程"
categories: flutter
tags: [flutter]
date: 2020-03-16
excerpt: "Flutter IO编程"
---

## Flutter IO编程
[IO DOC](https://api.dart.dev/stable/2.7.1/dart-io/dart-io-library.html)
[path_provider](https://pub.flutter-io.cn/packages/path_provider)

### Flutter File编程
使用`path_previder`库操作本地文件及目录

文件操作类有File、Directory、Link, 都继承至FileSystemEntity 每种操作函数都有两个版本
: 同步和异步(如, rename()和renameSync())

使用File.open(FileMode) 得到IOSink或者RandomAccessFile来对文件进行读写，读写对象需要close()

### Flutter Socket编程
Tcp使用Socket、ServerSocket 及 RawSocket、RawServerSocket

    ServerSocket.bind('127.0.0.1', 4041)
    .then((serverSocket) {
        serverSocket.listen((socket) {
        socket.transform(utf8.decoder).listen(print);
        });
    });

    Socket.connect('127.0.0.1', 4041).then((socket) {
        socket.write('Hello, World!');
    });

Socket和ServerSocket是高级API，可以很方便的处理报文是字符串类型的数据。字符串数据分包问题
， 使用Socket.join()函数处理。

RawSocket、RawServerSocket是低级API, 处理面向字节的数据。使用`dart:typed_data`库来处理字节
ByteBuffer: 缓冲区
ByeeData: 缓冲区操作

> 需要注意的是Socket实现Stream和IOSink接口，其中IOSink `add()`和`write()`函数不同
> ， `add()`是把字节流添加到写入队尾， 而`write()`是接收object对象
> ， 并调用object.toString()再添加到写入队尾

> Socket的read()和write()函数是非阻塞的， 所以需要使用listen来监听SocketEvent来处理

    RawSocket.connect(ipv4, port).then((socket) {
        socket.listen((event) {
        switch (event) {
            case RawSocketEvent.read:
            __requestDirRead(path, socket, onSuccess, onError);
            break;

            case RawSocketEvent.write:
            __requestDirWrite(socket, path);

            break;
            default:
        }
        }, cancelOnError: true);
    });


** Socket默认字节顺序是大头端 **