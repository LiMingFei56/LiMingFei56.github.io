---
layout: page
permalink: /program-language/c++/io-stream
---

IO Stream

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

    
