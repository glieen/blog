---
title: Java笔记
comments: true
---

记录工作和学习中了解到的Java知识点。

<!--more-->

> 基于Java 1.8
>
> 水平有限，如有错误，还望指正，不甚感激。

1. Java中的基本数据类型（int，byte等），比较时使用`==`，比较的是它们的值，引用类型（类）使用`==`比较的是它们的地址值，如果要比较对象的内容是否相等，需要重写equals方法，equals方法继承自Object类，重写equals方法时通常还应该重写hashCode方法。

2. （Override）重写方法时，可以返回父类方法返回值类型的子类，但不允许返回返回值类型的父类。

3. 基本数据类型和包装类之间可以互相转换，方法是固定的，如int/Integer，装箱方法为`Integer.valueOf(int)`，拆箱方法为`Integer.intValue()`。

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

   第一段代码会报NullPointerException异常，第二段代码能正常输出null，这是因为三目运算符返回结果中同时包含基础类型和包装类型时，会对包装类型进行拆包，如果拆包对象为null，则会抛出异常，在使用三目运算符时应当注意返回结果有没有可能为null。

5. Java接口中的成员都是public的，可以包含成员变量，默认修饰`public static final`，且必须初始化；成员方法默认修饰`public abstract`；接口中可以有静态方法，静态方法属于该接口，实现类无法再重写该方法；接口的方法可以有默认实现，实现类可以重写接口的默认方法。

6. Java不支持运算符重载，字符串中的`+`是编译器语法糖，实际实现是StringBuilder的`append()`方法。

7. 对于非静态内部类，它持有外部类的引用，所以内部类的创建依赖于外部类，内部类可以访问外部类的成员变量，但是外部类无法得知内部类的成员变量，在形式上类似于以下写法。

   ```java
   class Outer$Inner{
   	final Outer this$0;
   	public Outer$Inner(Outer outer){
   		this.this$0 = outer;
   	}
   }
   ```

8. try-catch-finally语句块中如果都有返回值，finally中的返回值会屏蔽掉try-catch中的返回值。

9. 如果finally有返回值且无异常，则会屏蔽掉try-catch中出现异常；没有finally时，catch中出现未捕获异常，则语句块抛出异常。

10. 如果仅try-catch中有返回值，finally无法修改已经返回的返回值。

11. 关于try-catch和循环体：在循环体内的try-catch在发生异常之后，可以继续执行循环；而循环外的 try-catch 在发生异常之后会终止循环。

12. 谨慎使用泛型中的super和extends关键字，`List<? extends E>`表示泛型是E的子类，无法add，只能get；`List<? super E>`表示泛型是E的父类，无法get，只能add。

13. 匿名内部类不能extends（继承）其它类，但内部类（接口）可以被另一个内部类继承或实现。

14. 整形的二进制表示法（以0b开头）：`int i = 0b10101`，八进制表示法（以0开头）：`int i = 065`，十六进制表示法（以0x开头）：`int i = 0x354af`。

15. 在定义数值类型时，可以使用下划线`_`做隔断，且不限制下划线个数，方便阅读，如：`float pi = 3.14_15F`，`long l= 0x7fff_ffff_ffff_ffffL`，`int i = 1554__4546_46_5`都是可以的，但是不能在数值的起始位置或末端添加；double 类型可以使用科学计数法表示，比如`double d = 1.34e4`表示`13400.0`。

16. `short s = 1;s = s + 1;`存在语法错误，整型在做运算时会将类型提升为int型，再赋值给s就需要做强制类型转换。`+=`，`-=`，`*=`，`/=`，`++`，`--`这几类运算隐含了强制类型转换，所以`short s = 1;s += 1;`是正确的。

17. `+=`，`-=`，`*=`，`/=`，`++`，`--`都不是原子操作，在多线程环境中需要考虑线程安全的问题。

18. `Math.round(11.5)`结果为12，`Math.round(-11.5)`结果为-11，`Math.round(-11.6)`结果为-12，我是这么理解的，`-11.5 = -12 + 0.5`，四舍五入：`-12 + 1 = 11`，`-11.6 = -12 + 0.4`，四舍五入：`-12 + 0 = -12`。

19. Java中的小数运算是不精确的，使用时应当注意，如果要采用精确的小数运算，推荐使用BigDecimal类。

    ```java
    double a = 0.8 - 0.7;
    double b = 0.6 - 0.5;
    double c = 0.5 - 0.4;
    System.out.println(a == b);// false
    System.out.println(b == c);// true
    ```

20. 关于for循环，三个表达式都是可选的，第一个表达式只会执行一次，后两个表达式每循环一次就会执行一次，第一/三个表达式允许写多条语句，使用`,`分隔，第二个表达式要么为空，要么返回布尔值。

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

21. 当使用`Arrays.asList()`方法将数组转换成列表的时候，需要注意参数的类型，当参数为基础类型的数组时，生成的列表长度为1，其内容为参数指向的数组对象，使用基础类型的包装类数组可以解决这个问题。

    ```java
    int[] ints = {1, 2, 3};
    System.out.println(Arrays.asList(ints).size());// 1
    Integer[] integers = {1, 2, 3};
    System.out.println(Arrays.asList(integers).size());// 3
    ```

22. 当方法的参数是基础数据类型时，调用方法传入对应的包装类，会调用对应包装类的拆箱方法`xxxValue()`，如果传入的参数为null，则会报空指针异常。

    ```java
    Double d = null;
    method(d);// NullPointerException
    public void method(double d) {
    	// do something
    }
    ```

23. 接口可以继承多个接口，类只能继承一个类，可以实现多个接口。

24. 注意使用String的`split()`方法，当分隔符之间为空时，会自动忽略掉。

    ```java
    String s = "a,b,c,d,,";
    System.out.println(s.split(",").length); // 4
    ```

25. String的`split()`，`replace()`，`replaceAll()`方法是以正则表达式去匹配的，特殊字符需要转义，比如`replaceAll(".", "x")`会把所有的字符替换为`x`，正确用法应该为`replaceAll("\\.", "x")`。

26. 子类可以继承父类的所有成员变量和成员方法，只是对于定义为私有的无法访问，构造方法不是类的成员，所以无法继承，静态方法也是可以被继承的，子类可以直接调用父类的非私有静态方法，比如常见的`main`方法。

27. 使用关键字`new`创建对象的时候，JVM先分配空间并返回`this`引用，之后再使用引用去调用构造方法，JVM将`this`引用作为构造方法的第一个隐含参数传入，初始化对象，这也是为什么在构造方法中可以通过`this`调用其他方法的原因。

28. 在Lambda表达式中使用的变量必须声明为final，Java8中无需声明是因为编译器做了隐含声明。

29. 关于序列化：静态变量属于类，所以不参与序列化；如果成员变量是基础类型，则可直接序列化，如果成员变量是引用类型，引用类型也必须实现序列化接口，否则序列化时将会抛出异常；父类实现了序列化接口，那么子类无需实现也可以序列化；父类未实现序列化接口，子类实现序列化接口，则父类必须提供空构造器，否则反序列化会抛出异常，序列化的时候默认只会序列化子类拥有的成员变量，从父类继承的成员变量不会被序列化，但是可以通过重写序列化方法来序列化从父类继承下来的成员变量。

    ```java
    // 序列化方法
    private void writeObject(ObjectOutputStream oos) throws IOException {
    	// 调用默认的序列化方法，可以把非静态和非transient字段给序列化
    	oos.defaultWriteObject();
    	// 序列化其他成员变量
    }
    // 反序列化
    private void readObject(ObjectInputStream ois) throws IOException,
                ClassNotFoundException {
    	// 调用默认的反序列化方法，可以把非静态和非transient字段给反序列化
    	ois.defaultReadObject();
    	// 反序列化其他成员变量
    }
    ```

30. final修饰的非静态成员变量可以在构造方法中初始化。

    ```java
    public class Test {
        final int i;
    
        Test() {
            i = 1;
        }
    }
    ```

31. 枚举类默认继承了Enum类，所以无法继承其他类，但是可以实现接口，与常规抽象类一样，enum类允许我们为其定义抽象方法，然后使每个枚举实例都实现该方法，以便产生不同的行为方式。

    ```java
    public enum EnumDemo {
        INSTANCE(1) {
            // 实现抽象方法
            @Override
            public void abstractMethod() {
                // do something
            }
        };
    
        private int i;
    
        private EnumDemo(int i) {
            this.i = i;
        }
    
        // 抽象方法
        public abstract void abstractMethod();
    }
    ```

32. Hashtable是线程安全的，有contains方法，用来判断是否包含某个值，key和value都不允许为null；HashMap线程不安全，没有contains方法，key和value都允许为null。

33. switch只允许使用char，byte，short，int，Character，Byte，Short，Integer，String和enum类型，enum类型是Java 5新增的，String类型是Java 7新增的。

34. 构造方法中`this()`和`super()`必须放在第一行，且不可同时调用。

35. synchronized加锁时只能用于对象和数组，不能用于基本数据类型。

36. new和反射都会调用构造方法，new操作符可以指定调用的构造方法，反射包括Class的`newInstance()`方法和Constructor的`newInstance()`方法，Class的`newInstance()`方法要求实例化类提供无参的构造方法，在对象的反射中，可以通过指定构造方法的参数类型获取特定的构造器对象Constructor，然后再使用`newInstance()`方法生成对象实例。

37. Java子类是无法覆盖父类的成员变量的。实际上，即使子类声明了与父类完全一样的成员变量，也不会覆盖掉父类的成员变量。而是在子类实例化时，会同时定义两个成员变量，子类也可以同时访问到这两个成员变量（非私有），但父类不能访问到子类的成员变量（父类不知道子类的存在）。而具体在方法中使用成员变量时，究竟使用的是父类还是子类的成员变量，则由方法所在的类决定；即，方法在父类中定义和执行，则使用父类的成员变量，方法在子类中定义（包括重写父类方法）和执行，则使用子类的成员变量。

38. 使用TreeMap或TreeSet等有序集合类时，添加的对象必须实现Comparable接口，否则将抛出ClassCastException异常。

39. 当某个类实现多个接口或者某个接口继承多个接口时，不同的实现接口中有相同的默认方法，那么必须重写该方法。

    ```java
    // 接口1
    public interface Interface1 {
        default void method() {
        }
    }
    // 接口2
    public interface Interface2 {
        default void method() {
        }
    }
    // 实现类
    public class InterfaceImpl implements Interface1, Interface2 {
        // 必须重写
        @Override
        public void method() {
        }
    }
    ```

40. final修饰的整型变量可以阻止运算时的类型提升。

    ```java
    final byte a = 1, b = 2;
    byte c = 1, d = 2, e, f;
    e = a + b;
    f = c + d; // 编译错误，类型提升
    ```

41. `wait()`和`notify()`方法必须在synchronized修饰的方法或者代码块里面调用，否者会抛出IllegalMonitorStateException异常，之所以会抛出异常，是因为在调用方法时没有获取到monitor对象的所有权。

42. 数组是一类特殊的对象，length存在于它的对象头之中，通过`数组实例.length`可以直接获取其长度，因为数组是对象，所以它拥有Object所声明的一系列方法，通过`数组类型.class`或者数组实例调用`getClass()`可以获得数组的类型，数组实现的克隆方法`clone()`是浅拷贝；声明数组有多种方式，可以直接指定数组大小，或者直接初始化，在声明时，一维数组必须指定其大小，多维数组必须指定第一维的大小。

    ```java
    public class ArrayDemo {
        public static void main(String[] args) {
            int[] a = new int[1];
            int[] b = {1, 2};
            // C语言风格，不推荐使用
            int c[] = {};
            int d[][] = new int[1][1];
            int[][] e = new int[1][];
            int[] f[] = new int[1][];
            // 数组的拷贝是浅拷贝
            c = a.clone();
            System.out.println(a.length); // 1
            System.out.println(a.getClass()); // class [I
            System.out.println(int[].class == a.getClass()); // true
        }
    }
    ```

43. goto是Java中的保留字，无法使用，但可以使用标签（label）达到类似goto的效果。标签只可用于循环语句之前，且通常用于嵌套循环，必须搭配break或者continue关键字一起使用，这是因为break和continue通常只中断当前循环，若配合标签一起使用则可以中断多层循环并到达标签所在的位置继续执行。关于标签、break和continue作用于循环时，有以下几点需要注意（《Java编程思想》p73）：
    1. 一般的continue会退回当前循环的开头，并继续执行；
    2. 带标签的continue会到达标签的位置，并重新进入紧接在哪个标签后面的循环；
    3. 一般的break会中断并跳出当前循环；
    4. 带标签的break会中断并跳出标签所指的循环。
    
44. final类中的方法隐含为final方法，因为类无法被继承，自然方法就不能被重写；private方法也隐含为final，即使子类存在相同签名的方法，也不算是重写。

45. 移位操作`<<` `>>` `>>>`只适用于整型，无法对boolean和浮点型使用。作用于byte，short和char时，会发生类型提升，运算结果为int。


