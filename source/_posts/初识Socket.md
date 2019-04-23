---
title: 初识Socket
tags: [Socket]
comments: true
date: 2019-01-24 16:00:58
categories: [Java]
---

在网络编程中，我们经常提及socket，什么是socket呢？我们经常把socket翻译为套接字，socket是在应用层和传输层之间的一个抽象层，它把TCP/IP层复杂的操作抽象为几个简单的接口供应用层调用以实现进程在网络中通信。

<!--more-->

### Java中基于TCP的Socket

TCP协议是面向连接的、可靠的、有序的、以字节流的方式发送数据，通过三次握手方式建立连接，形成传输数据的通道。

Java中基于TCP实现的套接字类有Socket类和ServerSocket类，ServerSocket类用于服务器端，监听请求，Socket是在连接建立时使用的，在连接成功时，应用程序的两端都会生成一个Socket实例，对这个实例进行操作就能实现服务端和客户端的通信了。

### 通信步骤

#### 服务器端

1. 创建ServerSocket对象，绑定监听端口号；
2. 通过`accept()`方法监听客户端请求；
3. 连接建立之后，通过输入流读取客户端发送的请求信息；
4. 通过输出流将响应信息发送到客户端；
5. 关闭连接。

#### 客户端

1. 创建Socket对象，指明需要连接的服务器的地址和端口号。
2. 连接建立后，通过输出流向服务器发送请求信息。
3. 通过输入流获取服务器响应的信息。
4. 关闭连接。

### 代码实现

服务器端

```java
public class Server {
    public static void main(String[] args) throws IOException {
        // 创建ServerSocket实例,端口号设置为2333
        ServerSocket serverSocket = new ServerSocket(2333);
        // 循环监听客户端发来的请求
        System.out.println("服务器端已启动");
        while (true) {
            System.out.println("正在监听请求...");
            Socket socket = serverSocket.accept();
            // 将请求得到的socket句柄交由handle方法处理
            new Server().handle(socket);
        }
    }

    private void handle(Socket socket) throws IOException {
        // 将字节流转换成字符流
        BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
        String string = reader.readLine();
        while (string != null) {
            System.out.println(string);
            string = reader.readLine();
        }
        OutputStream outputStream = socket.getOutputStream();
        outputStream.write("你好,这是服务器端回复的消息!".getBytes());
        outputStream.flush();
        socket.close();
    }
}
```

客户端

```
public class Client {
    public static void main(String[] args) throws IOException {
        System.out.println("正在连接服务端...");
        Socket socket = new Socket("127.0.0.1", 2333);
        OutputStream outputStream = socket.getOutputStream();
        outputStream.write("你好,这是客户端发来的消息!".getBytes());
        outputStream.flush();
        // 关闭输出流，告知服务端消息已经发送完毕
        socket.shutdownOutput();
        System.out.println("消息发送成功");
        BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        String string = reader.readLine();
        while (string != null) {
            System.out.println(string);
            string = reader.readLine();
        }
        socket.close();
    }
}
```

因为Socket是阻塞的，阻塞会发生多个地方，一个是accept方法，调用这个方法之后，服务端会一直等待，直到有客户端连接进来；第二个地方是流的读取，当服务端使用输入流读取了客户端发送的消息，而服务端没有标记消息已经发送完成，那么服务端就会一直等待，所以这里要使用`socket.shutdownOutput()`这个方法关闭客户端的输出流，告知服务端消息已经发送完成，后续的代码才会继续执行。

### 测试结果

![image](https://ws1.sinaimg.cn/large/005tkHc2gy1fzmhpu7sivj30g204c3yl.jpg)

![image](https://ws2.sinaimg.cn/large/005tkHc2gy1fzmhq9ydikj30gw06imxk.jpg)

![image](https://wx3.sinaimg.cn/large/005tkHc2gy1fzmhqjnnvrj30dv05wmxh.jpg)

### 多线程处理

因为服务端是循环监听客户端的请求，那么当一个客户端建立连接，但是又长期通信的时候，其他客户端的请求将会全部阻塞，无法建立连接，所以这里改进了一下代码，使用多线程技术提高处理的效率。

服务端

```java
public class Server implements Runnable{
    private Socket socket;

    public Server(Socket socket) {
        this.socket = socket;
    }

    public static void main(String[] args) throws IOException {
        // 创建ServerSocket实例,端口号设置为2333
        ServerSocket serverSocket = new ServerSocket(2333);
        // 循环监听客户端发来的请求
        System.out.println("服务器端已启动");
        while (true) {
            System.out.println("正在监听请求...");
            Socket socket = serverSocket.accept();
            // 将请求得到的socket句柄交由handle方法处理
            new Thread(new Server(socket)).start();
        }
    }

    @Override
    public void run() {
        try {
            // 将字节流转换成字符流
            BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
            String string = reader.readLine();
            while (string != null) {
                System.out.println(string);
                string = reader.readLine();
            }
            OutputStream outputStream = socket.getOutputStream();
            outputStream.write("你好,这是服务器端回复的消息!".getBytes());
            outputStream.flush();
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
```

### 总结

了解Socket对理解计算机的网络通信有更深的意义，只有掌握了应用的沟通方式才能更加得心应手的去使用代码控制它，Java对Socket的支持还是比较好的，提供了大量接口给开发者使用。