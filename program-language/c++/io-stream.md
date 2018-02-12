---
layout: page
permalink: /program-language/c++/io-stream
---

IO Stream

* streambuf - 类为缓冲区提供了内存，并提供了用于填充缓冲区、访问缓冲区内容、刷新缓
    冲区和管理缓冲区内存的类方法
* ios_base - 类表示流的一般特征，如是否可读取、是二进制流还是文本流等
* ios - 类基于ios_base，其中包括了一个指向streambuf对象的指针成员
* ostream - 类是从ios类派生而来的，提供了输出方法
* istream - 类是从ios类派生而来的，提供了输出方法
* iostream - 类是基于istream和ostream类的，因此继承了输入方法和输出方法

### IO库
<iostream> - 标准输入输出
<iomanip> - 这个文件声明了用于执行带有所谓的参数化流操纵器的格式化I / O的服务
<fstream> - 文件处理

### 标准输入输出
cout 
cin - 单词输入，空白分隔
getline - 行输入
get - 行输入

### File IO

#### Open

	void open(const char *filename, ios::openmode mode);

#### Close

	void close();

#### Position Pointer

	seekp ("seek put") 
	seekg ("seek get")

    tellp()
    tellg()

#### Write

    #include <iostream>
    #include <fstream>
    
    ofstream outFile;
    outFile.open("carinfo.txt");

    outFile << fixed;
    outFile.close();

#### Read
    
    #include <iostream>
    #include <fstream>

    ifstream inFile;
    inFile.open(filename);

    inFile>>value
    inFile.close();

    
