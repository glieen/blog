---
title: Linux的修炼之路（二）Ubuntu的安装
tags:
  - Linux
  - Ubuntu
comments: true
categories: Linux
abbrlink: 21868
date: 2019-10-09 23:31:13
---
发行版已经确定，接下来就是系统的安装工作，因为是准备安装Windows和Ubuntu双系统，所以很多操作可以先在Windows下完成，比如修改分区，制作启动盘等。

<!--more-->

### 制作启动盘

1. 下载系统镜像

   打开Ubuntu官网下载地址：[Download Ubuntu Desktop](https://ubuntu.com/download/desktop)，下载最新的桌面发行版镜像文件；

2. 下载启动盘制作软件

   打开Rufus官网：[Rufus](https://rufus.ie/)，下载最新版本的软件；

3. 制作启动盘


   准备一个容量大于4G的U盘，插入电脑，打开Rufus，在设备处会显示插入的U盘，然后点击选择，打开下载的Ubuntu镜像文件，分区类型建议设置为GPT，其他设置默认，然后单击开始，弹窗选择写入模式，默认即可，提示**会清除U盘所有数据，如有重要数据请先备份**，进度条跑完即制作完成。

   ![21868-1.jpg](https://i.loli.net/2020/02/19/IGXdjB8ROKLl2uC.jpg)

### 准备分区

在Windows10下右键开始，选择磁盘管理，打开磁盘管理工具。

![21868-2.jpg](https://i.loli.net/2020/02/19/28OUnSPe9BdDuwz.jpg)

这里我准备将F盘分50G出来用作安装Ubuntu，右键想分区的盘，选择压缩卷，输入分割的大小（注意单位是MB），点击压缩即可，即会多出一个大小为50G的未分配区块。

![21868-3.jpg](https://i.loli.net/2020/02/19/p4qbB8JVX6jG9vr.jpg)

![21868-4.jpg](https://i.loli.net/2020/02/19/Evd2kuWAUFyHfrh.jpg)

### 通过启动盘启动

把制作好的启动盘插入电脑，进入电脑的BIOS系统修改电脑的启动顺序，将启动盘设置成第一启动，以我的电脑（暗影精灵4）为例，开机按F9即可切换启动扇区，不同的品牌的电脑有不同的设置方法，详情可以通过搜索引擎查询自己的电脑型号查看具体的设置操作。

![21868-5.jpg](https://i.loli.net/2020/02/19/HTtdDhGnK21wlrz.jpg)

启动成功之后会有四个选项，第一个选项是试用Ubuntu，第二个选项是安装Ubuntu，剩下两个不用关注。

![21868-6.jpg](https://i.loli.net/2020/02/19/gdloXGZJ8C5yOwT.jpg)

这里我选择第一个试用Ubuntu，为了方便截图，当然直接安装也是可以的，稍等片刻后即进入Ubuntu的试用界面。

![21868-7.jpg](https://i.loli.net/2020/02/19/Ce85q6YGsL9gXpo.jpg)

进入Ubuntu的试用桌面基本表示启动盘引导启动成功了。

### 安装Ubuntu

1. 双击桌面上的`Install Ubuntu 18.04.3 LTS`图标就可以开始安装系统；

2. 选择语言，中文（简体），或者自己想要的语言；

   ![21868-8.jpg](https://i.loli.net/2020/02/19/Ec4OLnYaXiusqST.jpg)

3. 选择键盘布局，默认就可以了；

   ![21868-9.jpg](https://i.loli.net/2020/02/19/ubyG7Yjzx3J1QSs.jpg)

4. 设置网络连接，这里不建议在安装的时候连接网络，如果网速慢的话将会影响安装速度，如果是有线网络的话建议先把网线拔掉；

   ![21868-10.jpg](https://i.loli.net/2020/02/19/C35UzNx7LSnmJf9.jpg)

5. 选择安装的内容，使用最小安装就好了，没必要装那些多余的软件，以后需要用到再去安装；

   ![21868-11.jpg](https://i.loli.net/2020/02/19/dsmS6iucLlAT4Cj.jpg)

6. 选择安装方式，因为电脑已经安装了Windows10系统，如果要图简单的话，选择第一项，与Windows共存就好了，我喜欢自己调整分区，所以我使用的其他选项，**千万不要选择清除整个磁盘并安装Ubuntu**，那样会丢失所有硬盘里的数据；

   ![21868-12.jpg](https://i.loli.net/2020/02/19/JnFp1k5VYeyWd7G.jpg)

7. 硬盘的分区结构和大小预览，可以看到有一个大小50G左右空闲分区，这是在Windows下面预留出来的，这里我将它扩展成两个分区，一个4G大小的交换分区，用于Ubuntu系统休眠使用，剩下的分为一个EXT4主分区，挂在到`/`根目录下，关于分区，实在没有必要过于纠结挂载点，建议都挂载到根目录，**千万不要去修改其他非空闲的分区，格式化分区会丢失数据**，分区完成点击现在安装；

   ![21868-13.jpg](https://i.loli.net/2020/02/19/lGg1EKCzrn8fx6w.jpg)
   *分区方式：单击选择要修改的分区，点击左下角的“+”，然后设置分区大小和分区格式，点击确定即可。*
   ![21868-14.jpg](https://i.loli.net/2020/02/19/o2mrUuzHxkRMhas.jpg)
   
8. 选择时区，中国的话默认选择上海就可以了；

   ![21868-15.jpg](https://i.loli.net/2020/02/19/7puSkBtUgIzrWKd.jpg)

9. 设置电脑信息和用户信息，自行设置；

   ![21868-16.jpg](https://i.loli.net/2020/02/19/xgvZq7MmWhIH4Pe.jpg)

10. 开始安装系统，等待几分钟即可安装成功；

    ![21868-17.jpg](https://i.loli.net/2020/02/19/RdurE4XosJM5Pjz.jpg)

11. 安装成功，重启电脑；

    ![21868-18.jpg](https://i.loli.net/2020/02/19/MiwZEF8hyICTQJp.jpg)

12. 重启电脑时将U盘拔下，通常重启电脑之后，BIOS会默认启动Ubuntu的引导界面，如果没有启动到Ubuntu的引导界面，可以自行更改BIOS的启动设置，将Ubuntu设置成第一引导选项。引导界面有四个选项，第一个是正常启动Ubuntu系统，第二个是高级启动，第三个是启动Windows系统，第四个是进入电脑的BIOS设置。界面有10秒倒计时，如果没有更改启动选项则默认启动第一个，通过上下方向键可以更改启动选项，按回车键确定，通常默认启动第一个（正常启动Ubuntu）即可；

    ![21868-19.jpg](https://i.loli.net/2020/02/19/frlS4wkbWdpZE1q.jpg)

13. 稍等片刻就进入Ubuntu登录界面，选择安装系统时创建的用户，输入密码即可进入系统；

    ![21868-20.jpg](https://i.loli.net/2020/02/19/UVoPRxA6iuk4f2a.jpg)

14. 进入Ubuntu桌面，系统安装成功！

    ![21868-21.jpg](https://i.loli.net/2020/02/19/1Olj8xsBP6zUiNp.jpg)

### 总结

相对来说，Ubuntu桌面版的安装还是非常简单的，全程都是基于可视化操作，非常便捷，稍微仔细点，配合搜索引擎应该都可以安装成功。