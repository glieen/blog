---
title: javap的基本用法
tags: [javap]
comments: true
date: 2019-01-17 15:38:27
categories: JVM
---

有时候需要深入了解类的运行方式和流程，或者查看一个类中的属性成员，我们可以使用反编译来进行查看，JDK自带了一个反编译工具javap，可以反编译，也可以查看Java编译器生成的字节码，用于分解class文件，本文简单介绍一下javap的基本方法。

<!--more-->

### javap命令参数

在控制台输入`javap -help`查看javap的命令用法以及参数

```powershell
C:\Windows\system32>javap -help
用法: javap <options> <classes>
其中, 可能的选项包括:
  -help  --help  -?        输出此用法消息
  -version                 版本信息
  -v  -verbose             输出附加信息
  -l                       输出行号和本地变量表
  -public                  仅显示公共类和成员
  -protected               显示受保护的/公共类和成员
  -package                 显示程序包/受保护的/公共类
                           和成员 (默认)
  -p  -private             显示所有类和成员
  -c                       对代码进行反汇编
  -s                       输出内部类型签名
  -sysinfo                 显示正在处理的类的
                           系统信息 (路径, 大小, 日期, MD5 散列)
  -constants               显示最终常量
  -classpath <path>        指定查找用户类文件的位置
  -cp <path>               指定查找用户类文件的位置
  -bootclasspath <path>    覆盖引导类文件的位置
```

### 实际使用

#### 测试类

```java
public class Test {
    public int a = 1;
    private int b = 2;
    public final int c = 3;
    public static int D = 4;
    public Integer e = 5;
    int f = 6;
    protected int g =7;

    public void method1() {
    }

    private void method2() {
    }

    public int method3() {
        return 0;
    }
}
```

#### javap -p

```powershell
C:\Users\Glieen\Desktop> javap -p Test.class
Compiled from "Test.java"
public class Test {
  public int a;
  private int b;
  public final int c;
  public static int D;
  public java.lang.Integer e;
  int f;
  protected int g;
  public Test();
  public void method1();
  private void method2();
  public int method3();
  static {};
}
```

默认执行javap只能查看到公开和包级别的成员变量，使用`javap -p`可以查看类中所有的成员变量。

#### javap -v -p

```powershell
C:\Users\Glieen\Desktop> javap -v -p .\Test.class
Classfile /C:/Users/Glieen/Desktop/Test.class
  Last modified 2019-1-17; size 726 bytes
  MD5 checksum eb60967015bd6e02e460a5bf462e8c5a
  Compiled from "Test.java"
public class Test
  minor version: 0
  major version: 52
  flags: ACC_PUBLIC, ACC_SUPER
Constant pool:
   #1 = Methodref          #11.#34        // java/lang/Object."<init>":()V
   #2 = Fieldref           #10.#35        // Test.a:I
   #3 = Fieldref           #10.#36        // Test.b:I
   #4 = Fieldref           #10.#37        // Test.c:I
   #5 = Methodref          #38.#39        // java/lang/Integer.valueOf:(I)Ljava/lang/Integer;
   #6 = Fieldref           #10.#40        // Test.e:Ljava/lang/Integer;
   #7 = Fieldref           #10.#41        // Test.f:I
   #8 = Fieldref           #10.#42        // Test.g:I
   #9 = Fieldref           #10.#43        // Test.D:I
  #10 = Class              #44            // Test
  #11 = Class              #45            // java/lang/Object
  #12 = Utf8               a
  #13 = Utf8               I
  #14 = Utf8               b
  #15 = Utf8               c
  #16 = Utf8               ConstantValue
  #17 = Integer            3
  #18 = Utf8               D
  #19 = Utf8               e
  #20 = Utf8               Ljava/lang/Integer;
  #21 = Utf8               f
  #22 = Utf8               g
  #23 = Utf8               <init>
  #24 = Utf8               ()V
  #25 = Utf8               Code
  #26 = Utf8               LineNumberTable
  #27 = Utf8               method1
  #28 = Utf8               method2
  #29 = Utf8               method3
  #30 = Utf8               ()I
  #31 = Utf8               <clinit>
  #32 = Utf8               SourceFile
  #33 = Utf8               Test.java
  #34 = NameAndType        #23:#24        // "<init>":()V
  #35 = NameAndType        #12:#13        // a:I
  #36 = NameAndType        #14:#13        // b:I
  #37 = NameAndType        #15:#13        // c:I
  #38 = Class              #46            // java/lang/Integer
  #39 = NameAndType        #47:#48        // valueOf:(I)Ljava/lang/Integer;
  #40 = NameAndType        #19:#20        // e:Ljava/lang/Integer;
  #41 = NameAndType        #21:#13        // f:I
  #42 = NameAndType        #22:#13        // g:I
  #43 = NameAndType        #18:#13        // D:I
  #44 = Utf8               Test
  #45 = Utf8               java/lang/Object
  #46 = Utf8               java/lang/Integer
  #47 = Utf8               valueOf
  #48 = Utf8               (I)Ljava/lang/Integer;
{
  public int a;
    descriptor: I
    flags: ACC_PUBLIC

  private int b;
    descriptor: I
    flags: ACC_PRIVATE

  public final int c;
    descriptor: I
    flags: ACC_PUBLIC, ACC_FINAL
    ConstantValue: int 3

  public static int D;
    descriptor: I
    flags: ACC_PUBLIC, ACC_STATIC

  public java.lang.Integer e;
    descriptor: Ljava/lang/Integer;
    flags: ACC_PUBLIC

  int f;
    descriptor: I
    flags:

  protected int g;
    descriptor: I
    flags: ACC_PROTECTED

  public Test();
    descriptor: ()V
    flags: ACC_PUBLIC
    Code:
      stack=2, locals=1, args_size=1
         0: aload_0
         1: invokespecial #1                  // Method java/lang/Object."<init>":()V
         4: aload_0
         5: iconst_1
         6: putfield      #2                  // Field a:I
         9: aload_0
        10: iconst_2
        11: putfield      #3                  // Field b:I
        14: aload_0
        15: iconst_3
        16: putfield      #4                  // Field c:I
        19: aload_0
        20: iconst_5
        21: invokestatic  #5                  // Method java/lang/Integer.valueOf:(I)Ljava/lang/Integer;
        24: putfield      #6                  // Field e:Ljava/lang/Integer;
        27: aload_0
        28: bipush        6
        30: putfield      #7                  // Field f:I
        33: aload_0
        34: bipush        7
        36: putfield      #8                  // Field g:I
        39: return
      LineNumberTable:
        line 1: 0
        line 2: 4
        line 3: 9
        line 4: 14
        line 6: 19
        line 7: 27
        line 8: 33

  public void method1();
    descriptor: ()V
    flags: ACC_PUBLIC
    Code:
      stack=0, locals=1, args_size=1
         0: return
      LineNumberTable:
        line 11: 0

  private void method2();
    descriptor: ()V
    flags: ACC_PRIVATE
    Code:
      stack=0, locals=1, args_size=1
         0: return
      LineNumberTable:
        line 14: 0

  public int method3();
    descriptor: ()I
    flags: ACC_PUBLIC
    Code:
      stack=1, locals=1, args_size=1
         0: iconst_0
         1: ireturn
      LineNumberTable:
        line 17: 0

  static {};
    descriptor: ()V
    flags: ACC_STATIC
    Code:
      stack=1, locals=0, args_size=0
         0: iconst_4
         1: putstatic     #9                  // Field D:I
         4: return
      LineNumberTable:
        line 5: 0
}
SourceFile: "Test.java"
```

可以查看到类中所有的成员变量以及字节码，通过分析字节码和类中的常量池，就能对类有一个更加深入的了解。

### 总结

本文只是记录一下javap的简单用法，学会使用javap可以在深入理解Java基础和了解JVM时提供更大的助力，有时候遇到一些奇奇怪怪的问题，用javap反编译看一下字节码将会得到不一样的收获。