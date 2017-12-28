---
layout: page
permalink: /program-language/c++/io-stream
---

IO Stream

### IO库
<iostream> - 标准输入输出
<iomanip> - 这个文件声明了用于执行带有所谓的参数化流操纵器的格式化I / O的服务
<fstream> - 文件处理

### File IO

#### Open

	void open(const char *filename, ios::openmode mode);

#### Close

	void close();

#### Position Pointer

	seekp ("seek put") 
	seekg ("seek get")
