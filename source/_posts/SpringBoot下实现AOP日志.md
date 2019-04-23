---
title: SpringBoot下实现AOP日志
tags: [Spring,SpringBoot,AOP]
comments: true
date: 2019-01-17 15:00:04
categories: Spring
---

Spring两大核心为IoC和AOP，本篇文章旨在记录下在SpringBoot下如何整合使用AOP，适用场景为Web项目中对请求做切面来记录日志。

<!--more-->

### 引入依赖

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.0.5.RELEASE</version>
    <relativePath/>
</parent>
<dependencies>
    <dependency>
    	<groupId>org.springframework.boot</groupId>
    	<artifactId>spring-boot-starter-web</artifactId>
	</dependency>
    <dependency>
		<groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-aop</artifactId>
     </dependency>
</dependencies>
```

本次项目使用的是SpringBoot 2.0.5，引入web和aop依赖。

### 实现一个Web请求

```java
@RestController
public class HelloController {
    @GetMapping("/hello")
    public String hello(String name) {
        return "Hello " + name;
    }
}
```

### 实现切面和日志

```java
package cn.glieen.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LogAop {
    private final Logger logger = LoggerFactory.getLogger(LogAop.class);

    @Pointcut("execution(* cn.glieen.controller.*.*(..))")
    public void pointcut() {
    }

    @Before("pointcut()")
    public void log(JoinPoint joinPoint) {
        StringBuilder param = new StringBuilder();
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            param.append(arg).append(" ");
        }
        logger.info("Args:" + param.toString());
        logger.info("Method:" + joinPoint.getSignature().toLongString());
    }
}
```

`@Aspect`定义为切面类

`@Component`将切面注入到Spring容器中

`@Pointcut`定义切入点

`@Before`前置通知，在执行目标方法之前执行切面方法

`JoinPoint`可以获得通知的签名信息

### 运行结果

使用Postman或者浏览器访问`http://localhost:8080/hello?name=Glieen`，的到以下运行结果：

```java
INFO 10856 --- [nio-8080-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring FrameworkServlet 'dispatcherServlet'
INFO 10856 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : FrameworkServlet 'dispatcherServlet': initialization started
INFO 10856 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : FrameworkServlet 'dispatcherServlet': initialization completed in 7 ms
INFO 10856 --- [nio-8080-exec-1] cn.glieen.aop.LogAop                     : Args:Glieen 
INFO 10856 --- [nio-8080-exec-1] cn.glieen.aop.LogAop                     : Method:public java.lang.String cn.glieen.controller.HelloController.hello(java.lang.String)

```

现在就可以使用AOP来记录方法的访问日志了。