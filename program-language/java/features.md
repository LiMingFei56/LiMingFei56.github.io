---
layout: page
permalink: /program-language/java/features
---

Features

## Exception
	java.lang.Object.Throwable
		-Error
		-Exceptions
			-Runtime Exceptions
			-Other Exceptions
	
	Error错误为系统级错误，ＪＡＶＡ程序一般不用处理这类的错误，交给操作系统来处理。

## Runtime Exceptions
> 运行时异常，也叫做UnChecked Exceptions（运行时异常），在程序中可以不处理，抛出交给虚拟机处理。

## Other Exceptions
> 非Runtime Exceptions（不是直接继承RuntimeExceptions类的），也叫做Checked Exceptions（编译时异常），在程序中要求处理起来，要不编译出错。

## Catching Exceptions
	try {
   		// Protected code
	}catch(ExceptionName e1) {
   		// Catch block
	}

	jdk7.0 单个处理块，处理多个异常
	catch (IOException|FileNotFoundException ex) {
   		logger.log(ex);
   		throw ex;

## finally block
	finally块总是执行
	try {
   // Protected code
	}catch(ExceptionType1 e1) {
   // Catch block
	}catch(ExceptionType2 e2) {
   // Catch block
	}catch(ExceptionType3 e3) {
   // Catch block
	}finally {
   // The finally block always executes.
	}

## try-whith-resouces
> 资源在try()中定义，资源需要实现AutoCloseable
> 资源定义可以定义多个
> 资源关闭会按照资源定义相反的顺序关闭
> 除了资源定义外，其他的跟原来try/catch一样
> 资源定义在，try块前初始化
> 资源定义被隐式声明为final

	一般在try中开的资源，在finally中关闭
	现在用try-with-resouces jdk1.7
	try(FileReader fr = new FileReader("file path")) {
   		// use the resource
   		}catch() {
      		// body of catch 
   		}
	}

## throw throws
	throw 抛出一个新异常
	throws 方法向上抛出异常

## Checking or unChecking
> Checking为强制处理异常，编译时会判断该异常是否被捕获，如果没有就会报错，这样可以提醒开发人员来处理异常，不会忘记。但是这样会出现很多try/catch语句，有的有用有的没有用。
> 处理Cheching也可以抛出去，让上层来处理，这样可以统一处理异常，把底层异常转换成业务异常或者多个子异常转换成一个父异常方便处理。但是这样一来不容易判断错误出现位置及原因，不方便定位错误。

> unChecking为运行时异常，编译时不强制要求被捕获，如果运行时发生异常会一层层抛出最后让虚拟机处理。使用运行时异常一般为程序错误，跟业务无关，正常情况下不会发生，数据异常时才会出现，方便定位错误。

