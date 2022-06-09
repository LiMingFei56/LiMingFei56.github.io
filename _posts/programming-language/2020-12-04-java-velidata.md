---
layout: post
title: "Java 数据效验"
categories: java
tags: [java]
date: 2020-12-04
---

## Java 数据效验

### 配置

javax.validation 是规范, 不是实现
spring-boot-starter-validation 是实现

```

<dependency>
<groupId>javax.validation</groupId>
<artifactId>validation-api</artifactId>
<version>2.0.1.Final</version>
</dependency>
<dependency>
<groupId>org.springframework.boot</groupId>
<artifactId>spring-boot-starter-validation</artifactId>
<version>2.3.5.RELEASE</version>
</dependency>


```

### 注解说明

@Validated: 验证类
@Valid: 验证嵌套类
@AssertFalse
@AssertTure
@DecimalMax
@DecimalMin
@Digis
@Future 将来日期
@Max 必须是一个数字
@Min 必须是一个数字
@NotNull
@Null
@Past 过去日期
@Pattern 符合正则
@Size 大小


## Reference
[Java 数据校验自动化（validation）](https://www.cnblogs.com/z-sm/p/4872259.html)
