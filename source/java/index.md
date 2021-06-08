---
title: Java笔记
comments: true
---

> 基于JDK 8
>
> 如有错误，还望指正，不甚感激。

1. Java中的基本数据类型（int、byte等），比较时使用`==`，比较的是它们的值，引用类型（类）使用`==`比较的是它们的引用地址，如果要比较对象的内容是否相等，需要重写`equals()`方法，重写equals方法通常还应该重写`hashCode()`方法，它们都继承自Object类。

2. （Override）重写方法时，可以返回父类方法返回值类型的子类，但不允许返回返回值类型的父类。同时重写方法时，访问修饰符一定要大于被重写方法的访问修饰符。如果被重写方法没有定义受检异常（指的是除RuntimeException之外的异常），那么重写方法也不能定义受检异常。重写方法可以添加synchronized和final关键字。

3. 基本数据类型和包装类之间可以互相转换，方法是固定的，如int/Integer，装箱方法为`Integer.valueOf(int)`，拆箱方法为`Integer.intValue()`。

4. 警惕三目运算符中的拆箱：

   ```java
   int a = 0;
   Integer b = null;
   System.out.println(false ? a : b); // NullPointerException
   ```

   ```java
   Integer a = null;
   Integer b = null;
   System.out.println(false ? a : b); // null
   ```

   第一段代码会报NullPointerException异常，第二段代码能正常输出null，这是因为三目运算符返回结果中同时包含基础类型和包装类型时，会对包装类型进行拆包，如果拆包对象为null，则会抛出异常，在使用三目运算符时应当注意返回结果有没有可能为null。

5. Java接口中的成员都是public的，可以包含成员变量，默认修饰`public static final`，且必须初始化；成员方法默认修饰`public abstract`；接口中可以有静态方法，静态方法属于该接口，实现类无法再重写该方法；接口的方法可以有默认实现，实现类可以重写接口的默认方法。

6. Java不支持运算符重载，字符串中的`+`是编译器语法糖，实际实现是StringBuilder的`append()`方法。

7. 对于非静态内部类，它持有外部类的引用，所以内部类的创建依赖于外部类，外部类对于内部类是透明的，内部类可以访问外部类的所有成员变量，但是外部类无法得知内部类的成员变量，在形式上类似于以下写法。

   ```java
   class Outer$Inner{
   	final Outer this$0;
   	public Outer$Inner(Outer outer){
   		this.this$0 = outer;
   	}
   }
   ```

8. finally语句总会执行（除非虚拟机停止，如调用`System.exit()`），finally语句在try或catch的return语句执行之后，return返回之前执行，finally块中可以修改返回值中的内容，但是不能修改返回值的指向。

   ```java
   public class Test {
       public static void main(String[] args) {
           System.out.print(fun1());
   
       }
   
       public static String fun1() {
           try {
               System.out.print("A");
               return fun2();
           } finally {
               System.out.print("B");
           }
       }
   
       public static String fun2() {
           System.out.print("C");
           return "D";
       }
   }
   // 输出 ACBD
   ```

9. 如果finally有返回值且无异常，则会覆盖try-catch中出现异常和返回值；没有finally时，catch中出现未捕获异常，则语句块抛出异常。

10. try-catch异常捕获范围只能从小到大，否则无法通过编译。

    ```java
    try {
        // do something
    } catch (Exception e) {
        // do something
    } catch (RuntimeException e) {
        // do something
    }
    // 编译失败
    ```

11. 关于try-catch和循环体：在循环体内的try-catch在发生异常之后，可以继续执行循环；而循环外的 try-catch 在发生异常之后会终止循环。

12. 谨慎使用泛型中的super和extends关键字，`List<? extends E>`表示泛型是E的子类，无法add，只能get；`List<? super E>`表示泛型是E的父类，无法get，只能add。

13. 在定义泛型时可以使用`&`限制泛型的多边界，同时也可以一次性定义多个泛型。

    ```java
    public <E extends Cloneable & Serializable & Comparable<E>, K extends Comparable<K>> void fun(E e, K k) {
    	
    }
    ```

14. 匿名内部类不能extends（继承）其它类，但内部类（接口）可以被另一个内部类继承或实现。

15. 整形的二进制表示法（以0b开头）：`int i = 0b10101`，八进制表示法（以0开头）：`int i = 065`，十六进制表示法（以0x开头）：`int i = 0x354af`。

16. 在定义数值类型时，可以使用下划线`_`做隔断，且不限制下划线个数，方便阅读，如：`float pi = 3.14_15F`，`long l= 0x7fff_ffff_ffff_ffffL`，`int i = 1554____46_46_5`都是可以的，但是不能在数值的起始位置或末端添加；double 和float类型可以使用科学计数法表示，比如`double d = 1.34e4`表示`13400.0`。

17. 不同的包装类之间无法使用`==`进行比较，包装类和原生类型比较时会自动拆箱，如果包装类为null会抛出空指针异常。整型和浮点型比较，整数部分一致且浮点型没有小数部分那么结果为true，float和double进行比较，整数部分相等，小数部分如果是相同的2的负数次幂，那么结果为true，否则为false。Java中的小数运算是不精确的，使用时应当注意，如果要采用精确的小数运算，推荐使用BigDecimal类。

    ```java
    System.out.println(new Integer(1) == new Long(1)); // 编译失败
    Integer d = null;
    System.out.println(d == 0); // NullPointerException
    System.out.println(1.d == 1); // true
    System.out.println(1.1d == 1); // false
    System.out.println(1.1d == 1.1d); // true
    System.out.println(1.1d == 1.1f); // false
    System.out.println(1.125d == 1.125f); // true
    double a = 0.8 - 0.7;
    double b = 0.6 - 0.5;
    double c = 0.5 - 0.4;
    System.out.println(a == b); // false
    System.out.println(b == c); // true
    ```

18. `short s = 1;s = s + 1;`无法通过编译，byte、char和short在运算时会将类型提升为int型，再赋值时就需要做强制类型转换。`+=`，`-=`，`*=`，`/=`，`++`，`--`这几类运算隐含了强制类型转换，所以`short s = 1;s += 1;`是正确的。

19. `+=`，`-=`，`*=`，`/=`，`++`，`--`都不是原子操作，在多线程环境中需要考虑线程安全的问题。

20. `Math.round(11.5)`结果为12，`Math.round(-11.5)`结果为-11，`Math.round(-11.6)`结果为-12。可以这么理解：四舍五入是在数轴上进行的，四舍是向左，五入是向右。

21. 关于for循环，三个表达式都是可选的，第一个表达式只会执行一次，后两个表达式每循环一次就会执行一次，第一/三个表达式允许写多条语句，使用`,`分隔，第二个表达式要么为空，要么返回布尔值。

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

22. 当使用`Arrays.asList()`方法将数组转换成列表的时候，需要注意参数的类型，当参数为基础类型的数组时，生成的列表长度为1，其内容为参数指向的数组对象，使用基础类型的包装类数组可以解决这个问题。

    ```java
    int[] ints = {1, 2, 3};
    System.out.println(Arrays.asList(ints).size()); // 1
    Integer[] integers = {1, 2, 3};
    System.out.println(Arrays.asList(integers).size()); // 3
    ```

23. 当方法的参数是基础数据类型时，调用方法传入对应的包装类，会调用对应包装类的拆箱方法`xxxValue()`，如果传入的参数为null，则会报空指针异常。

    ```java
    Double d = null;
    method(d); // NullPointerException
    public void method(double d) {
    	// do something
    }
    ```

24. 接口可以继承多个接口，类只能继承一个类，可以实现多个接口。

25. 注意使用String的`split()`方法，当分隔符之间为空时，会自动忽略掉。

    ```java
    String s = "a,b,c,d,,";
    System.out.println(s.split(",").length); // 4
    ```

26. String的`split()`，`replaceAll()`方法是以正则表达式去匹配的，特殊字符需要转义，比如`replaceAll(".", "x")`会把所有的字符替换为`x`，正确用法应该为`replaceAll("\\.", "x")`。

27. 子类可以继承父类的所有成员变量和成员方法，只是对于定义为私有的无法访问，构造器不是类的成员，所以无法继承，静态方法也是可以被继承的，子类可以直接调用父类的非私有静态方法，比如常见的`main`方法。

28. 使用关键字`new`创建对象的时候，JVM先分配空间并返回`this`引用，之后再使用引用去调用构造器，JVM将`this`引用作为构造器的第一个隐含参数传入，初始化对象，这也是为什么在构造器中可以通过`this`调用其他方法的原因。

29. 在Lambda表达式中使用的变量必须声明为final，JDK8之后无需声明是因为编译器做了隐含声明。

30. 关于序列化：静态变量属于类，所以不参与序列化；如果成员变量是基础类型，则可直接序列化，如果成员变量是引用类型，引用类型也必须实现序列化接口，否则序列化时将会抛出异常；父类实现了序列化接口，那么子类无需实现也可以序列化；父类未实现序列化接口，子类实现序列化接口，则父类必须提供空构造器，否则反序列化会抛出异常，序列化的时候默认只会序列化子类拥有的成员变量，从父类继承的成员变量不会被序列化，但是可以通过重写序列化方法来序列化从父类继承下来的成员变量。

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

31. final修饰的非静态成员，必须在申明时，普通代码块或者构造器中初始化。

    ```java
    public class Test {
        final int i = 1;
        final int j;
        final int k;
        
        {
            j = 1;
        }
    
        Test() {
            k = 1;
        }
    }
    ```

32. 枚举类默认继承了Enum类，所以无法继承其他类，但是可以实现接口，与常规抽象类一样，enum类允许我们为其定义抽象方法，然后使每个枚举实例都实现该方法，以便产生不同的行为方式。

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

33. switch只允许使用char、byte、short、int、Character、Byte、Short、Integer、String和enum类型，enum类型是JDK5新增的，String类型是JDK7新增的，通过反编译可以看出，String是利用`hashCode()`和`equals()`实现的，enum是利用`ordinal()`实现的。

34. synchronized加锁时只能用于引用对象（数组是一种特殊的引用对象），不能用于基本数据类型，因为只有引用对象具有对象头。

35. new和反射都会调用构造器，new操作符可以指定调用的构造器，反射包括Class的`newInstance()`方法和Constructor的`newInstance()`方法，Class的`newInstance()`方法要求实例化类提供无参的构造器，在对象的反射中，可以通过指定构造器的参数类型获取特定的构造器对象Constructor，然后再使用`newInstance()`方法生成对象实例。

36. 子类无法覆盖父类的成员变量和方法。实际上，即使子类声明了与父类完全一样的成员变与方法（重写），也不会将父类的覆盖。子类在实例化时，会优先初始化父类的成员变，子类可以通过super关键字访问父类非私有的成员变和方法，但父类不能访问到子类的成员变量（父类不知道子类的存在）。当子父类具有同名成员变量：通过实例直接引用（`.`运算符）时，使用父类还是子类的成员变量取决于实例声明时的类型；通过实例方法访问时，使用父类还是子类的成员变量取决于具体的方法定义（是否重写，是否使用super关键字）。这些特性是Java多态的重要组成部分。

    ```java
    public class Test {
        public static void main(String[] args) {
            A a = new B();
            System.out.println(a.fun());
            System.out.println(a.getI());
            System.out.println(a.i);
            System.out.println(((B) a).i);
        }
    }
    
    class A {
        public int i = 1;
    
        public int fun() {
            return this.i;
        }
    
        public int getI() {
            return this.i;
        }
    }
    
    class B extends A {
        public int i = 2;
    
        public int getI() {
            return this.i;
        }
    }
    // 输出
    // 1
    // 2
    // 1
    // 2
    ```

37. 构造器中`this()`和`super()`必须放在第一行，且不可同时调用，且可以调用带有参数的`this()`和`super()`（构造器重载）。调用子类构造器时，一定会调用父类的构造器，即使没有显式调用，编译器也会在子类的构造器的第一行自动加上`super()`方法，如果父类没有无参的构造器或者子类不具有父类构造器的访问权限，则编译失败。即使调用了父类的构造器，也只是对父类进行初始化操作，并不代表就实例化了父类，可以用以下代码加以证明，输出结果可以说明，this和super都指向同一个实例。

    ```java
    public class Test {
        public static void main(String[] args) {
            new B().fun();
        }
    }
    
    
    class A {
        A(int i) {
            System.out.println(this.getClass().getSimpleName());
            System.out.println("A:" + i);
        }
    }
    
    class B extends A {
        B() {
            // this必须位于第一行
            this(1);
        }
    
        B(int i) {
            // super必须位于第一行
            super(2);
            System.out.println("B:" + i);
        }
    
        public void fun() {
            System.out.println(super.equals(this));
        }
    }
    // 输出
    // B
    // A:2
    // B:1
    // true
    ```

38. 当某个类实现多个接口或者某个接口继承多个接口时，不同的实现接口中有相同的默认方法，那么必须重写该方法。

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

39. final修饰的整型变量可以阻止运算时的类型提升。

    ```java
    final byte a = 1, b = 2;
    byte c = 1, d = 2, e, f;
    e = a + b;
    f = c + d; // 编译错误，类型提升
    ```

40. `wait()`和`notify()`方法必须在synchronized修饰的方法或者代码块里面调用，否者会抛出IllegalMonitorStateException异常，之所以会抛出异常，是因为在调用方法时没有获取到monitor对象的所有权。

41. 在创建数组时，如果没有显式初始化元素内容，那么所有的元素都会被初始化为默认值，引用类型都初始化为null，基础类型初始化为相对应的默认值。

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


44. final类中的方法隐含为final方法，因为类无法被继承，自然方法就不能被重写；private方法只属于类本身，即使子类存在相同签名的方法，也不算是重写。

45. 移位操作`<<` `>>` `>>>`只适用于整型，无法对boolean和浮点型使用。作用于byte，short和char时，会发生类型提升，运算结果为int。

46. 局部变量声明时不会有默认值，使用之前必须初始化。

    ```java
    int i;
    System.out.println(i); // 编译错误
    int i = 1;
    System.out.println(i);
    ```
    
47. `clone()`方法声明于Object类，所有类实例都可以调用该方法，但是当调用对象没有实现Cloneable时，会抛出CloneNotSupportedException异常。

48. 类实例初始化顺序：

    - 父类中静态成员变量/静态代码块（只会在类第一次使用时执行）；
    - 子类中静态成员变量/静态代码块（只会在类第一次使用时执行）；
    - 父类中普通成员变量/代码块；
    - 父类构造器；
    - 子类中普通成员变量/代码块；
    - 子类构造器；

    同一级次的初始化顺序取决于声明的先后顺序。

49. 无法阻止成员变量的自动初始化，自动初始化一定会在构造器被调用之前发生，这让成员变量具有初始值得到了保证（《Java编程思想》p94）。这里的自动初始化指的是声明的所有成员变量，都会先被设置为默认的初始值，即使在定义时指定了初始值，这种情况也是成立的。以下代码可以说明这一点：父类会先于子类初始化，自动初始化会先于指定初始化之前执行，指定初始化会先于构造器之前执行，初始化时会先将变量`i`设置为0，再变更为2。

    ```java
    public class Test {
        public static void main(String[] args) {
            B b = new B();
            b.fun();
        }
    }
    
    class A {
        int i = 1;
    
        public A() {
            fun();
        }
    
        public void fun() {
            System.out.println("A.i:" + this.i);
        }
    }
    
    class B extends A {
        int i = 2;
    
        public B() {
            System.out.println("B constructor i:" + this.i);
        }
        
        public void fun() {
            System.out.println("B.i:" + this.i);
        }
    }
    // 输出
    // B.i:0
    // B constructor i:2
    // B.i:2
    ```

50. 在编译期能确定的静态常量会在编译时直接以常量的形式替换到编译文件中。

    ```java
    public class Test {
        public static void main(String[] args) {
            System.out.println(A.s); // 并不会加载类A
            System.out.println(B.s);
        }
    }
    
    class A {
        static {
            System.out.println("a static");
        }
    
        static final String s = "a";
    }
    
    class B {
        static {
            System.out.println("b static");
        }
    
        static final String s = new String("b");
    }
    // 输出
    // a
    // b static
    // b
    ```

51. 通过子类引用父类的静态变量，只会触发父类的加载。

    ```java
    public class Test {
        public static void main(String[] args) {
            System.out.println(B.S);
        }
    
    }
    
    class A {
        static {
            System.out.println("a static");
        }
    
        static String S = "a";
    }
    
    class B extends A {
        static {
            System.out.println("b static");
        }
    }
    // 输出
    // a static
    // a
    ```


51. 如果有多个重载方法，在方法调用时总是匹配范围更小，描述更精确的方法。

    ```java
    public class Test {
        public static void main(String[] args) {
            fun(null);
        }
    
        static void fun(String s) {
            System.out.println("A");
        }
    
        static void fun(Object o) {
            System.out.println("B");
        }
    }
    // 输出 A
    ```

52. 即使没有显式的声明，实例方法的第一个参数也是this，这是实例方法区别于构造器和静态方法显著的标志。实例方法声明时可以显式的将this放在参数的第一位，且必须是第一位，类型为方法所在类类型。《Java编程思想》p96中写到：*“即使没有显式地使用static关键字，构造器实际上也是静态方法。”*是错误的，一个直观的证明就是构造器中存在this引用，而静态方法是不存在this引用的。参考：[如何理解《Java编程思想》描述的“即使没有显式地使用static关键字，构造器实际上也是静态方法”](https://www.zhihu.com/question/35860619/answer/64802279)

    ```java
    public class Test {
        // 可以显式的声明第一个参数为this
        public void fun(Test this) {
        }
    
        public void fun(Test test) {
        }
    
        public static void main(String[] args) {
            // 实际调用时无需传入
            new Test().fun();
            // 两个方法是有区别的，从调用方式可以看出来
            new Test().fun(new Test());
        }
    }
    ```

53. 被final、static、private修饰的方法和构造器都是静态绑定的，在编译期即可确定方法的具体调用。除此之外的方法都是动态绑定（运行时绑定）的，这是构成Java多态的基础之一。

54. 关于常用的几个容器对象：

    ArrayList：底层是数组，默认初始容量为0，添加第一个元素后变为10，每次扩容为之前的1.5倍，线程不安全；

    LinkedList：底层是双向链表，没有初始容量，无需扩容，线程不安全；

    Vector：底层是数组，默认初始容量为10，每次扩容为之前的2倍，线程安全；

    HashMap：底层是数组+单向链表/红黑树，默认初始容量为0，添加第一组元素后变为16，默认装填因子为0.75，元素数量>=容量*装填因子之后开始扩容，每次扩容为之前的2倍。当元素数量>=64且桶大小>=8时，桶由链表转换为红黑树，桶大小<=6，红黑树转换为链表。key和value都可以为null，线程不安全；

    LinkedHashMap：底层是HashMap，重写了HashMap中的节点类型，内部维护了一个由所有元素节点构成的双向循环链表，保证了元素的插入顺序；

    HashTable：底层是数组+单向链表，默认初始容量为11，默认装填因子为0.75，元素数量>=容量*装填因子之后开始扩容，每次扩容为之前的2倍+1，key可以为null，value不可以为null，线程安全，通过给方法加synchronized实现；

    ConcurrentHashMap：底层，容量，扩容和HashMap一致，key和value都不可以为null，线程安全，JDK7采用分段锁，JDK8采用CAS（桶为空）和synchronized（桶非空）；

    HashSet：底层是HashMap；

    LinkedHashSet：底层是LinkedHashMap；

    TreeMap：底层是红黑树，如果创建时未传入默认的比较器，那么key必须实现Comparable接口，否则将抛出ClassCastException异常。添加的元素以key排序，保证了元素的有序性，key不可以为null，value可以为null，线程不安全；

    TreeSet：底层是TreeMap。

55. ClassLoader的`loadClass()`方法只是将类加载到内存中，不会触发类的初始化，只有对类的首次主动使用才会初始化类（静态初始化）。类的首次使用包括以下几种：

    - 类实例化
    - 子类实例化
    - 访问类/接口的静态成员（非静态常量）
    - 调用类的静态方法
    - 反射
    - 虚拟机启动时被标注为启动类的类

    ```java
    public class Test {
        public static void main(String[] args) throws ClassNotFoundException {
            // 不会初始化
            Class<?> clazz = ClassLoader.getSystemClassLoader().loadClass("A");
            // 不会初始化
            A[] arr = new A[10];
            // 实例化
            new A();
            // 子类实例化
            new B();
            // 访问静态成员
            A.S = "s";
            // 调用静态方法
            A.fun();
            // 反射
            Class.forName("A");
        }
    }
    
    
    class A {
        public static String S;
    
        static {
            System.out.println("A");
        }
    
        public static void fun() {
    
        }
        // 启动类
        public static void main(String[] args) {
    
        }
    }
    
    class B extends A {
    
    }
    ```

56. 当父类实例不为null时，强制转换为子类会抛出ClassCastException异常。

    ```java
    public class Test {
        public static void main(String[] args) {
            // ClassCastException
            // A a = new A();
            // B b = (B) a;
    
            A a = null;
            B b = (B) a;
        }
    }
    
    class A {
    }
    
    class B extends A {
    }
    ```

57. 关于Java的值传递：

    - 方法不能修改基本数据类型的参数（数值型或布尔型）；
    - 方法可以改变引用类型的状态；
    - 方法不能修改引用类型的引用。

    ```java
    public class Test {
        public static void main(String[] args) {
            int a = 1, b = 2;
            int[] arr = {1, 2};
            String s = "a";
            fun(a, b);
            fun(arr);
            fun(s);
            System.out.printf("a=%d,b=%d\n", a, b);
            System.out.printf("arr[0]=%d,arr[1]=%d\n", arr[0], arr[1]);
            System.out.printf("s=%s\n", s);
        }
    
        public static void fun(int a, int b) {
            int t = a;
            a = b;
            b = t;
        }
    
        public static void fun(int[] arr) {
            int t = arr[0];
            arr[0] = arr[1];
            arr[1] = t;
        }
    
        public static void fun(String s) {
            s = "b";
        }
    }
    // 输出
    // a=1,b=2
    // arr[0]=2,arr[1]=1
    // s=a
    ```

58. 在使用匿名内部类的过程中，有以下几点需要注意：

    - 在使用匿名内部类时，必须继承一个类或者实现一个接口，但不能同时继承一个类并实现一个接口；
    - 匿名内部类没有构造器，显而易见的，没有类名自然就不能定义构造器；
    - 匿名内部类中不能定义静态成员变量和静态方法，因为静态成员/方法是通过类名绑定的，没有类名自然无法定义；
    - 匿名内部类是局部内部类，所以局部内部类的所有限制同样对匿名内部类有效；
    - 匿名内部类不能是抽象的，它必须要实现继承类或者实现接口的所有抽象方法。

