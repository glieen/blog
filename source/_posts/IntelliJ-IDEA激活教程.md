---
title: IntelliJ IDEA激活教程
tags:
  - IDEA
comments: true
categories: 教程
abbrlink: 29543
date: 2020-02-04 10:57:05
---

IntelliJ IDEA是一款非常流行的Java集成开发工具，我愿称之为地球最强。但是在它更新到2020的版本之后，想要激活它就变得越来越困难了，这里记录一下我激活它的过程。

<!-- more -->

> 本文仅做记录，请支持正版软件
>
> 感谢[https://zhile.io](https://zhile.io)站长开发的激活补丁

![29543-1.png](https://i.loli.net/2020/09/03/Brp5lGqoRYJTySm.png)

### 下载安装

从[JetBrains官网](https://www.jetbrains.com/idea/download)下载IntelliJ IDEA安装包，并完成安装。

因为激活补丁只能激活`2020.2`之前的版本，所以不要下载超过该版本的安装包。

### 获取补丁

我已经将补丁上传到Github，可以直接获取：[下载地址](https://raw.githubusercontent.com/glieen/HexoBlog/source/source/files/jetbrains-agent-latest.zip)，补丁是zip格式的压缩包，使用时无需解压。

![29543-2.png](https://i.loli.net/2020/09/03/W2C4vUJFiKkog3Z.png)

### 开始激活

1. 如果存在旧版本的配置文件，那么先删除它们；

2. 启动IDEA，完成基本的配置，然后在激活界面选择`Evaluate for free`，点击`Evaluate`按钮进行试用；

   ![29543-3.png](https://i.loli.net/2020/09/03/ZkJMT48DdpswrBX.png)

3. 在项目管理界面，将激活补丁直接拖进来进行安装，安装成功后点击Restart重启；

   ![29543-4.png](https://i.loli.net/2020/09/03/Y8NtKgrVqy5asJc.png)

4. 重启之后进入补丁配置界面，填写安装参数，激活方式选择`Activation code`，点击`为IDEA安装`，然后再次重启；

   安装参数：

   ```text
   LFq51qqupnaiTNn39w6zATiOTxZI2JYuRJEBlzmUDv4zeeNlXhMgJZVb0q5QkLr+CIUrSuNB7ucifrGXawLB4qswPOXYG7+ItDNUR/9UkLTUWlnHLX07hnR1USOrWIjTmbytcIKEdaI6x0RskyotuItj84xxoSBP/iRBW2EHpOc
   ```

   ![29543-5.png](https://i.loli.net/2020/09/03/TEQ5bYhOUFCnk8j.png)

5. 重启之后就激活成功了。
