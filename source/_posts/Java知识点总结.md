---
title: Java知识点总结
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
   System.out.println(false ? a : b);// NullPointerException
   ```

   ```java
   Integer a = null;
   Integer b = null;
   System.out.println(false ? a : b);// null
   ```

   第一段代码会报`NullPointerException`异常，第二段代码能正常输出null，这是因为三目运算符返回结果中同时包含基础类型和包装类型时，会对包装类型进行拆包，如果拆包对象为null，则会抛出异常，在使用三目运算符时应当注意返回结果有没有可能为null；

5. Java接口中的成员都是`public`的，可以包含成员变量，默认修饰`public static final`，成员方法默认修饰`public abstract`，在JDK8之后，接口中的方法可以有实现，默认修饰`public static`，实现后的方法属于该接口，实现类无法再重写该方法；

6. *非静态内部类会持有外部类的引用*，内部类可以访问外部类的成员变量，但是外部类无法得知内部类的成员变量；

7. try-catch-finally语句块中如果都有返回值，finally中的返回值会屏蔽掉try/catch中的返回值；

8. 如果finally有返回值且无异常，则会屏蔽掉try/catch中出现异常；没有finally时，catch中出现未捕获异常，则语句块抛出异常；

9. 如果仅try/catch中有返回值，finally无法修改已经返回的返回值；

10. 谨慎使用泛型中的super和extends关键字，`List<? extends E>`表示泛型是E的子类，无法add，只能get；`List<? super E>`表示泛型是E的父类，无法get，只能add；

11. 匿名的内部类不能extends（继承）其它类，但内部类（接口）可以被另一个内部类继承或实现；

12. 整形的二进制表示法（以0b开头）：`int i = 0b10101;`,八进制表示法（以0开头）：`int i = 065;`，十六进制表示法（以0x开头）：`int i = 0x354af`；

13. 在定义数值类型时，可以使用下划线`_`做隔断，且不限制下划线个数，方便阅读，如：`float pi = 3.14_15F;`，`long l= 0x7fff_ffff_ffff_ffffL;`，`int i = 1554__4546_46_5`都是可以的，但是不能在数值的起始位置或末端添加；

14. `short s = 1;s = s +1;`存在语法错误，整形在做运算时会将类型提升为int型，再赋值给s就需要做强制类型转换。`+=`，`-=`，`*=`，`/=`，`++`，`--`这几类运算隐含了强制类型转换，所以`short s = 1;s += 1;`是正确的；

15. `Math.round(11.5)`结果为12，`Math.round(-11.5)`结果为-11，`Math.round(-11.6)`结果为-12，`Math.round()`方法可以看作先将数值`+0.5`再向下舍入。

16. Java中的小数运算是不精确的，使用时应当注意，如果要采用精确的小数运算，推荐使用BigDecimal类；
 ```java
    double a = 0.8 - 0.7;
    double b = 0.6 - 0.5;
    double c = 0.5 - 0.4;
    System.out.println(a == b);// false
    System.out.println(b == c);// true
 ```
17. 关于for循环，三个表达式都是可选的，第一个表达式只会执行一次，后两个表达式每循环一次就会执行一次，第一/三个表达式允许写多条语句，使用`,`分隔，第二个表达式要么为空，要么返回布尔值；

    ```java
    // 无限循环
    for(;;){
    	// do something
    }
    
    /**
     * method1和method2只执行一次
     * method3，method4和method5每次循环都会执行
     * method6会在method3之后执行
     * method3必须返回boolean值，其他方法无要求
     */
    for (method1(), method2(); method3(); method4(), method5()) {
        method6();
    }
    ```
    
18. 当使用`Arrays.asList()`方法将数组转换成列表的时候，需要注意参数的类型，当参数为基础类型的数组时，生成的列表长度为1，其内容为参数指向的数组对象，使用基础类型的包装类数组可以解决这个问题；

    ```java
    int[] ints = {1, 2, 3};
    System.out.println(Arrays.asList(ints).size());// 1
    Integer[] integers = {1, 2, 3};
    System.out.println(Arrays.asList(integers).size());// 3
    ```
    
19. 当方法的参数是基础数据类型时，调用方法传入对应的包装类，会调用对应包装类的拆箱方法`xxxValue（）`，如果传入的参数为null，则会报空指针异常；

	```java
	Double d = null;
	method(d);// NullPointerException
	public void method(double d) {
		// do something
	}
	```

20. 接口可以继承多个接口，类只能继承一个类，可以实现多个接口。
