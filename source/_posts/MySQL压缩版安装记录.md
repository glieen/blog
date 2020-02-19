---
title: MySQL压缩版安装记录
tags:
  - MySQL
  - 数据库
comments: true
categories: MySQL
abbrlink: 4936
date: 2019-02-14 14:52:17
---

作为程序员，免不了与数据库打交道，MySQL作为一款最流行的关系型数据库，更是使用的非常之多，这篇文章主要记录MySQL压缩版在Windows下的安装和简单配置过程。

<!--more-->

### 安装环境

Windows版本：Windows 10专业版

MySQL版本：MySQL 5.7.22 64位ZIP压缩版

### 下载安装包

我推荐前往MySQL的官方网站下载MySQL的安装包，下载地址：[MySQL Community Server](https://downloads.mysql.com/archives/community/)，选择与自己系统对应的版本，下载安装包到本地磁盘。

本文使用的安装包为：mysql-5.7.22-winx64.zip

### 配置环境变量

将安装包解压到指定位置（为避免不必要的麻烦，位置路径请不要包含中文和空格字符），我这里是解压到`F:\Software\MySQL57`路径下，目录结构如下图所示。

![4936-1.jpg](https://i.loli.net/2020/02/19/X7cxflL1uEY6jPH.jpg)

打开Windows的系统变量设置，将MySQL下的bin目录配置进系统的Path变量，注意变量之间使用分号（;）间隔，这样就省去了每次都输入完整路径的麻烦。

![4936-2.jpg](https://i.loli.net/2020/02/19/pY2UbegOPK1csWj.jpg)

以管理员权限打开命令提示符，输入`mysql -V`，正确显示MySQL的版本号即配置成功。

![4936-3.jpg](https://i.loli.net/2020/02/19/yLJH5dbwpPmBIkj.jpg)

### 创建MySQL默认配置文件

新建一个文本文件，命名为`my.ini`，将以下内容复制保存到文件中，注意`basedir`和`datadir`对应为MySQL的解压路径。

```properties
[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8 
[mysqld]
#设置3306端口
port = 3306 
# 设置mysql的安装目录
basedir="F:\Software\MySQL57"
# 设置mysql数据库的数据的存放目录
datadir="F:\Software\MySQL57\data"
# 允许最大连接数
max_connections=200
# 服务端使用的字符集默认为8比特编码的latin1字符集
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
```

### 初始化MySQL

以管理员权限打开命令提示符，执行命令：`mysqld --initialize-insecure --user=mysql`，执行完这个命令后，MySQL会在安装目录下创建一个data文件夹，且创建好默认数据库，登录的用户名为`root`，密码为空。

![4936-4.jpg](https://i.loli.net/2020/02/19/JLCa3l5WB7MDuOT.jpg)

### 安装MySQL

以管理员权限打开命令提示符，执行命令：`mysqld install`，提示`Service successfully installed`即安装成功。

![4936-5.jpg](https://i.loli.net/2020/02/19/nBXAizgTYF2qp54.jpg)

*卸载MySQL的命令为：`mysqld remove`*

### 启动MySQL

以管理员权限打开命令提示符，执行命令：`net start mysql`，提示`MySQL服务已经启动成功`即表示MySQL已经正常启动。

![4936-6.jpg](https://i.loli.net/2020/02/19/Uo6P9rbqSpf5Tmk.jpg)

### 登录MySQL

打开命令提示符，执行命令：`mysql -u root -p`，密码默认为空，直接回车即可，表示以`root`用户登录MySQL。

![4936-7.jpg](https://i.loli.net/2020/02/19/VMKu49RId3HniOG.jpg)

### 修改用户密码

以命令提示符登录MySQL，执行命令：`set password for root@localhost = password("root");`结尾分号不能省略，表示修改`root`用户的密码为`root`，修改之后，下次登录则需键入新的密码。

![4936-8.jpg](https://i.loli.net/2020/02/19/jVdS3FTQlMt8UDz.jpg)

### 修改远程访问权限

以命令提示符登录MySQL，执行以下两个命令：`grant all privileges on *.* to 'root'@'%' identified by 'password';`和`flush privileges;`，第一个“\*”表示所有数据库，第二个“\*”表示所有数据表，root表示允许远程登录的用户名，%表示任意IP，password表示远程登录使用的密码，`flush privileges`是让权限立即生效。

![4936-9.jpg](https://i.loli.net/2020/02/19/QwpcgTktr9JPW5s.jpg)

### 总结

MySQL压缩版的安装及配置只是一个简单的开始，想要在开发中更好的运用MySQL，后期的学习和努力还需要更多。