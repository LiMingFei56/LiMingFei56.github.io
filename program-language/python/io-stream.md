---
layout: page
permalink: /program-language/python/io-stream
---

IO Stream

### File I/O

#### 打印到屏幕
print

#### 从键盘读输入
raw_input # 以字符串形式返回，去掉结尾的换行
input # 输入的是一个表达式

#### 打开和关闭File

打开文件方法:

	file object = open(file_name [, access_mode][, buffering])

关闭文件方法:

	fileObject.close()

#### 读和写文件

写到文件:

	fileObject.write(string)

从文件读:

	fileObject.read([count])

#### 文件位置

tell() - 方法返回当前文件的位置
seek(offset[, from]) - 方法移动当前文件的位置

#### 改名和删除文件
os模块提供执行文件处理操作

os.rename(current_file_name, new_file_name) - 改名
os.remove(file_name) - 删除

#### 目录
os模块提供目录相关的方法

os.mkdir("newdir") - 创建目录
os.chdir("newdir") - 修改当前目录
os.getcwd() - 显示当前目录
os.rmdir('dirname') - 删除目录




