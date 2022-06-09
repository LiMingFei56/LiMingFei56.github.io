---
layout: post
title: "Java Unit Test"
categories: java
tags: [java]
date: 2020-12-03
---

## Java Unit Test

### 使用Junit

### Spring Boot 单元测试

    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>5.2.11.RELEASE</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-test</artifactId>
      <scope>test</scope>
    </dependency>


> Unable to find a @SpringBootConfiguration, you need to use @ContextConfiguration or @SpringBootTest(classes=...) with your test

```
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)


@RunWith(SpringJUnit4ClassRunner.class)
// @RunWith(SpringRunner.class)
@ContextConfiguration(classes = {JPAConfig.class}

@RunWith(SpringJUnit4ClassRunner.class)
// @RunWith(SpringRunner.class)
@ContextConfiguration(value={"myJPAConfig.xml"})

或者指定测试类
@RunWith(SpringRunner.class)
@SpringBootTest(classes = CorreiosServiceImpl.class)


```



## Reference

