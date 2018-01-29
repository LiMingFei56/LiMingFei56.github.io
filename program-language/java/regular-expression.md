---
layout: page
permalink: /program-language/java/regular-expression
---

Regular Expression

### Java中的正则表达式
	Pattern Class:是正则表达式解析表示，使用compile()接收一个正则表达式返回一个Pattern对象
	Matcher Class:解析模型和字符串匹配，使用Pattern.matcher方法
	PatternSyntaxException:正则表达式解析错误。

### index methods
	start
	start(int group)
	end
	end(int group)

### study methods
	lookingAt
	find
	find(int start)
	matches

### replacement methods
	appendReplacement(StringBuffer sb, String replacement)
	appendTail(StringBuffer sb)
	replaceAll(String replacement)
	replaceFirst(String replacement)
	quoteReplacement(String s)

