---
title: Java高级特性-反射
date: 2018-07-24 15:48:28
tags: [Java,基础知识]
categories: Java
comments: true
---

在Java开发中，反射是一个经常用到的技术，几乎所有的框架都有使用反射机制，反射作为Java的一种高级特性，在实际生产中被大量应用，掌握它就显得尤为必要了。

<!-- more -->

### 什么是反射？

反射机制是Java 语言的特性之一，所谓的反射就是Java语言在运行时拥有的一项自观的能力。在Java运行时环境中，对于任意一个类，可以知道这个类有哪些属性和方法；对于任意一个对象，可以调用它的任意一个方法。这种动态获取类的信息以及动态调用对象的方法的能力就是Java 语言的反射（Reflection）机制。 

### 万物皆对象

Java是面向对象的高级语言，在面向对象的世界里，万事万物皆是对象，那么类是不是对象呢？是的，我们写的每一个类都是`Class`类的对象。每一个类有自己的对象，同时也是`Class`类的对象，想要了解反射，就必须先了解`Class`这个类。

#### java.lang.Class

构造方法

```java
	/*
     * Private constructor. Only the Java Virtual Machine creates Class objects.
     * This constructor is not used and prevents the default constructor being
     * generated.
     */
    private Class(ClassLoader loader) {
        classLoader = loader;
    }
```

根据注释可知，`Class`类的构造方法是私有的，只有 Java 虚拟机可以创建该类的对象，因此我们无法在代码中显式地声明一个 `Class`对象。

#### 获取Class类的对象

声明一个`Person`类

```java
public class Person {
    private String name;
    private int age;

    public Person() {
    }

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    //省略setter和getter
}
```

在上面说过，`Class` 类的构造方法是私有的，只有 java 虚拟机可以调用该方法创建该类的对象。也就是说我们无法像定义普通类对象一样，通过 new 直接创建 `Class` 类的对象，那应该如何得到`Person`的类对象呢？有以下几种方法。

```java
public class ClassTest {
    public static void main(String[] args) throws ClassNotFoundException {
        Person person = new Person();
        Class clazz;

        // 1、通过类的静态成员得到Person的类对象，每一个类都有一个隐含的静态成员class
        clazz = Person.class;
        System.out.println(clazz);

        // 2、通过Person类的实例得到它的Class对象
        clazz = person.getClass();
        System.out.println(clazz);

        // 3、通过Class的静态方法forName(className)得到类对象，这里注意处理异常
        clazz = Class.forName("cn.glieen.pojo.Person");
        System.out.println(clazz);
    }
}
```

从运行结果可以看到，我们都能得到`Person` 的`Class`对象。

![image](https://ws1.sinaimg.cn/large/005tkHc2gy1fzf5p44tt7j30dn02wjrb.jpg)

实际使用当中，最常用的是第三种方法，该方法可以实现类的动态加载，在使用时才加载该类。



### 反射的基本运用

#### 得到类的成员（constructor、field、method）

```java
public class ReflectTest {
    public static void main(String[] args) throws ClassNotFoundException {
        // 得到类的Class对象
        Class<?> clazz = Class.forName("cn.glieen.pojo.Person");

        // 获取类的构造方法
        Constructor<?>[] constructors = clazz.getConstructors();
        for (Constructor<?> constructor : constructors) {
            System.out.println("constructor = " + constructor);
        }

        // 获取类的成员变量
        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            System.out.println("field = " + field);
        }

        // 获取类的成员方法
        Method[] methods = clazz.getMethods();
        for (Method method : methods) {
            System.out.println("method = " + method);
        }
    }
}
```

运行结果：

![image](https://ws2.sinaimg.cn/large/005tkHc2gy1fzf5p49bsej30rv0bnt9o.jpg)

由运行结果我们可以看到，`Person`类的构造方法，成员变量和成员方法都获取到了，**值得注意的是**，`getConstructors()`、`getFields()`和`getMethods()`只能得到类中公有的成员属性，如果想得到私有的成员属性，需要调用`getDeclaredConstructors()`、`getDeclaredFields()`和`getDeclaredMethods()`方法。

#### 得到类的实例

通过`Class`类的`newInstance()`方法可以得到`Class`对象所指类的实例。

```java
// 通过Class的对象得到Person类的实例，注意强制转型和异常处理
Person person = (Person) clazz.newInstance();
```

**需要注意的是:**`clazz.newInstance()`会调用`Person`类的无参构造方法，当`Person`类不存在无参构造方法时，程序会抛出`InstantiationException `异常，所以当决定使用动态加载时，应当保留类中公有无参的构造器。

#### 反射调用类中的方法

通过反射可以调用类中的各个方法，下面代码利用反射为`Person`对象的成员变量注入值：

```java
public class ReflectTest {
    public static void main(String[] args) throws ClassNotFoundException, IllegalAccessException, InstantiationException, NoSuchMethodException, InvocationTargetException {
        // 得到类的Class对象
        Class<?> clazz = Class.forName("cn.glieen.pojo.Person");

        // 通过Class的对象得到Person类的实例，注意强制转型和异常处理
        Person person = (Person) clazz.newInstance();

        // 得到类中的成员变量
        Field[] fields = clazz.getDeclaredFields();

        for (Field field : fields) {
            String fieldName = field.getName();
            // 得到成员变量的setter方法
            Method method = clazz.getMethod("set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1), field.getType());
            if (field.getGenericType().equals(String.class)) {
                // 反射调用setter方法
                method.invoke(person, "glieen");
            }
            if (field.getGenericType().equals(int.class)) {
                method.invoke(person, 23);
            }
        }

        System.out.println(person);
    }
}
```

运行结果：

![image](https://ws2.sinaimg.cn/large/005tkHc2gy1fzf5p4i6xrj30f801va9x.jpg)

反射不仅可以调用普通方法，私有方法，构造函数也是可以调用的，需要注意的是调用私有方法之前应当使用`method.setAccessible(true)`改变方法可见性，否则调用时会抛出异常。

### java.lang.reflect

`java.lang.reflect`包提供了用于获取类和对象的反射信息的类和接口。反射API允许对程序访问有关加载类的字段，方法和构造函数的信息进行编程访问。它允许在安全限制内使用反射的字段，方法和构造函数对其底层对等进行操作。 

`java.lang.reflect`包下有几个比较重要的类，`java.lang.reflect.Field`，`java.lang.reflect.Method`，`java.lang.reflect.Type`，`java.lang.reflect.Constructor`，在反射的使用中是经常会用到的，这里我就不过多阐述了。

### 总结

反射作为Java最核心机制之一，已经被普遍使用于各大框架和项目之中，理解并掌握反射将会使得编写和阅读代码更加高效。

*运行环境*

*JDK：1.8*

*IDE：IntelliJ IDEA 2017.3.5*

*如有错误，还请指正*