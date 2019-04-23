---
title: Java知识点总结（长期更新）
tags: [Java,基础知识]
comments: true
top: true
date: 2018-11-17 11:37:32
categories: Java
---

Java作为一门发展了多年的编程语言，拥有众多的开发者，我亦是其中之一，Java有众多的特性和知识点，为避免遗忘，我将我所了解的记录在此，知识点无先后顺序，本文长期维护更新，拓展新的知识点。

<!--more-->

> 本文基于Java 1.8
>
> 水平有限，如有错误，还望指正，不甚感激。

1. Java中的基本数据类型（int,byte等），比较时使用`==`，比较的是它们的值，引用类型（类）使用`==`比较的是它们的地址值，如果要比较对象的内容是否相等，需要重写equals方法，equals方法继承自Object类，重写equals方法时通常还应该重写hashCode方法；

2. （Override）重写方法时，可以返回父类方法返回值类型的子类，但不允许返回返回值类型的父类；

3. 基本数据类型和包装类之间可以互相转换，方法是固定的，如int/Integer，装箱方法为`Integer.valueOf(int)`，拆箱方法为`Integer.intValue()`；

4. 警惕三目运算符中的拆箱：

   ```java
   int a = 0;
   Integer b = null;
   System.out.println(false ? a : b);
   ```

   ```java
   Integer a = null;
   Integer b = null;
   System.out.println(false ? a : b);
   ```

   第一段代码会报`NullPointerException`异常，第二段代码能正常输出null，这是因为三目运算符返回结果中同时包含基础类型和包装类型时，会对包装类型进行拆包，如果拆包对象为null，则会抛出异常，在使用三目运算符时应当注意返回结果有没有可能为null；

5. Java接口中的成员都是`public`的，可以包含成员变量，默认修饰`public static final`，成员方法默认修饰`public abstract`，在JDK8之后，接口中的方法可以有实现，默认修饰`public static`，实现后的方法属于该接口，实现类无法再重写该方法；

6. *非静态内部类会持有外部类的引用*，内部类可以访问外部类的成员变量，但是外部类无法得知内部类的成员变量。

7. try-catch-finally语句块中如果都有返回值，finally中的返回值会屏蔽掉try/catch中的返回值。

8. 如果finally有返回值且无异常，则会屏蔽掉try/catch中出现异常；没有finally时，catch中出现未捕获异常，则语句块抛出异常。

9. 如果仅try/catch中有返回值，finally无法修改已经返回的返回值。

10. 谨慎使用泛型中的super和extends关键字，`List<? extends E>`表示泛型是E的子类，无法add，只能get；`List<? super E>`表示泛型是E的父类，无法get，只能add。