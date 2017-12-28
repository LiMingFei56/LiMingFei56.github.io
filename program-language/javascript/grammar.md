---
layout: page
permalink: /program-language/javascript/grammar
---

Grammar

### Basic Syntax

#### 定义Script

	<script language="javascript" type="text/javascript">
		JavaScript code
	</script>

	可以定义在<head>和<body>里，推荐<head>

	判断浏览器是否支持JavaScript
	<noscript>
         Sorry...JavaScript is needed to go ahead.
    </noscript>

	导入JavaScript文件
	<script type="text/javascript" src="filename.js" ></script>
#### 分号
分号可以分隔语句，如果一行只有一条语句，那么可以省略分号

#### 区分大小写

#### 注释

// - 行注释
/* */ - 多行注释
< ! - -  - 单行注释
<!- - //--> - 多行注释

#### 数据类型

* Numbers
* Strings
* Boolean

* null
* undefined

#### 变量

	var varname;

	typeof varname;  // 返回对象类型字符串

Number		"number"
String		"string"
Boolean		"boolean"
Object		"object"
Function	"function"
Undefined	"undefined"
Null		"object"

### 操作符
* Arithmetic Operators
* Comparison Operators
* Logical (or Relational) Operators
* Assignment Operators
* Conditional (or ternary) Operators

### 控制流
* if-else
* switch
* while-loop
* do-while-loop
* for-loop
* for-in-loop

#### 循环控制
* break
* continue
* Using Labels - `label_name:`

### 函数

	function functionname(parameter-list)
      {
         statements
		 return result;
      }


