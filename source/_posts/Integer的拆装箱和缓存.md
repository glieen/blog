---
title: Integer的拆装箱和缓存
comments: true
date: 2018-08-31 17:49:32
tags: [Java,基础知识]
categories: Java
---

Integer作为基础类型int的包装类，提供了非常多的功能，增强了基础类型的一些方法使用，但是在使用的时候还是有一些问题需要注意的。

<!-- more -->

## true还是false？

咱们先看下面这段代码：

```java
public class IntegerTest {
    public static void main(String[] args) {
        Integer i1 = 1;
        Integer i2 = 1;
        System.out.println(i1 == i2);

        Integer i3 = new Integer(200);
        Integer i4 = new Integer(200);
        System.out.println(i3 == i4);

        Integer i5 = 200;
        Integer i6 = 200;
        System.out.println(i5 == i6);
    }
}
```

运行结果：

> true
> false
> false

`i3 == i4`返回结果为`false`可能会很容易理解，使用new关键字创建两个类，应当为其分配不同的内存空间，所以它们的地址应该是不同的。但是为什么`i1 == i2`返回结果为`true`，而`i5 == i6`返回结果为`false`呢？

### 自动装箱

实际上当给Integer对象赋值为数值对象时，Java虚拟机会执行装箱操作，就是将基础数据类型封装成对应的包装类，其底层调用的方法是Integer中的静态方法`Integer.valueOf(int i)`，那我们来看看这个方法具体是怎么做的。

```java
/**
 * Returns an {@code Integer} instance representing the specified
 * {@code int} value.  If a new {@code Integer} instance is not
 * required, this method should generally be used in preference to
 * the constructor {@link #Integer(int)}, as this method is likely
 * to yield significantly better space and time performance by
 * caching frequently requested values.
 *
 * This method will always cache values in the range -128 to 127,
 * inclusive, and may cache other values outside of this range.
 *
 * @param  i an {@code int} value.
 * @return an {@code Integer} instance representing {@code i}.
 * @since  1.5
 */
public static Integer valueOf(int i) {
    if (i >= IntegerCache.low && i <= IntegerCache.high)
        return IntegerCache.cache[i + (-IntegerCache.low)];
    return new Integer(i);
}
```

通过注解我们可以看到，这个方法会返回一个Integer对象的实例，当对象值处于`-128 ~ 127`之间时，从缓存中返回实例，不处于区间之中则通过new关键字创建一个实例并返回。

IntegerCache是Integer类中的一个内部类，Java虚拟机会用它做一个对象的缓存池，缓存整型值介于`-128 ~ 127`之间的Integer对象实例，用以提升Java的性能。

### 结论

回到代码中，现在结论就应该很清楚了，i1和i2取值都为1，介于`-128 ~ 127`之间，所以直接返回的是缓存池中的实例，所以它们都指向同一个对象，地址是相等的，i5和i6取值都为200，不在缓存池中，所以都是新创建的对象实例，所以它们的地址不相等。