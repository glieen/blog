---
title: SpringBoot全局异常处理
tags: [Spring,SpringBoot,异常]
comments: true
date: 2019-01-17 17:25:02
categories: Spring
---

异常是Java开发中经常会遇到的问题，异常如果不妥善的处理将会对开发带来非常大的困扰，所以在代码中我们经常能看到`try-catch`代码块手动处理异常，这对业务代码会产生干扰，而SpringBoot提供了全局的异常处理机制，简单而且优雅，本文就简要介绍一下SpringBoot全局异常处理的配置。

<!--more-->

### 创建项目

使用Maven创建一个SpringBoot项目，添加web模块的依赖即可，因为只是简单展示一下异常的处理，就不用引入过多的依赖了。

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-parent</artifactId>
    <version>2.0.5.RELEASE</version>
    <relativePath/>
</parent>

<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
</dependencies>
```

### 创建控制器和启动类

简单的一个`Controller`和`MainApplication`

```java
// 控制器
@RestController
public class HelloController {
    @GetMapping("/hello")
    public String hello(String name) {
        return "Hello " + name;
    }
}
```

```java
// SpringBoot
@SpringBootApplication
public class MainApplication {
    public static void main(String[] args){
        SpringApplication.run(MainApplication.class, args);
    }
}
```

启动`MainApplication`，打开Postman（Postman是一个非常方便的接口测试工具），访问地址`localhost:8080/hello?name=Glieen`，成功返回响应数据。

![image](https://wx1.sinaimg.cn/large/005tkHc2gy1fzfi261jarj30qy09naae.jpg)

### 创建异常响应实体类

我们不能直接将异常返回到客户端，这对用户和开发者来说都不友好，也不方便对异常进行处理，这里我们创建一个异常的响应实体来封装异常信息。

```java
// 异常响应实体
public class ErrorMessage {
    // 提示信息
    private String message;
    // 请求地址
    private String url;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
```

### 创建自定义异常和异常处理类

开发中经常遇到的是运行时异常，所以这里我们继承`RuntimeException`创建自定义的异常，具体的异常在实际运用中应该跟业务逻辑有很大的关系。

```java
// 自定义异常
public class MyException extends RuntimeException {
    public MyException(String message) {
        super(message);
    }
}
```

异常处理类只需要创建一个简单的Java类，并且加上`ControllerAdvice`注解，SpringBoot在启动时会自动扫描并配置。这里使用的`RestControllerAdvice`是组合了`ResponseBody`和`ControllerAdvice`的注解，用来返回json数据，`ExceptionHandler`注解用来捕捉程序运行时发生的异常，将其配置到方法上，当指定的异常发生时即会调用该注解下的方法。

```java
// 异常处理类
@RestControllerAdvice
public class DefaultExceptionHandler {
    // 日志对象
    private final Logger logger = LoggerFactory.getLogger(DefaultExceptionHandler.class);

    // 捕捉自定义异常MyException
    @ExceptionHandler(MyException.class)
    public ErrorMessage exception(HttpServletRequest request, Exception e) {
        logger.info("This is my custom exception!");
        return exceptionHandler(request.getRequestURI(), e.getMessage());
    }

    private ErrorMessage exceptionHandler(String url, String message) {
        ErrorMessage errorMessage = new ErrorMessage();
        errorMessage.setMessage(message);
        errorMessage.setUrl(url);
        return errorMessage;
    }

}
```

### 测试异常处理流程

这里我们将控制器做一个简单的修改，让其主动抛出自定义异常。

```java
// 控制器类
@RestController
public class HelloController {
    
    @GetMapping("/hello")
    public String hello(String name) {
        if (true)
            throw new MyException("MyException");
        return "hello " + name;
    }
}
```

使用Postman再次访问该接口`localhost:8080/hello?name=Glieen`，程序将自定义的异常实体类以json形式返回，包含提示信息和请求地址，同时在控制台输出日志信息，异常被成功捕捉并处理。

![image](https://wx1.sinaimg.cn/large/005tkHc2gy1fzfij9qvgqj30rh0aijrt.jpg)

![image](https://ws3.sinaimg.cn/large/005tkHc2gy1fzfimpxulqj31bc04j0t3.jpg)

### 总结

SpringBoot是如此的高效和简单，在处理全局异常亦是如此，本文只是简单的记录如何捕获程序运行时发生的异常，相信在以后的开发中会用的更加得心应手。