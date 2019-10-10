---
title: Linux的修炼之路：（二）Ubuntu的安装
tags: [Linux,Ubuntu]
comments: true
date: 2019-10-09 23:31:13
categories: Linux
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

   ![image](https://tva3.sinaimg.cn/large/005tkHc2ly1g7t3f62rejj30bk0e7aat.jpg)

### 准备分区

在Windows10下右键开始，选择磁盘管理，打开磁盘管理工具。

![image](https://tvax4.sinaimg.cn/large/005tkHc2ly1g7t3nlitndj30pm0kqwg8.jpg)

这里我准备将F盘分50G出来用作安装Ubuntu，右键想分区的盘，选择压缩卷，输入分割的大小（注意单位是MB），点击压缩即可，即会多出一个大小为50G的未分配区块。

![image](https://tva3.sinaimg.cn/large/005tkHc2ly1g7t3qfsx3sj30pm0kqdi3.jpg)

![1570689962547](https://tva3.sinaimg.cn/large/005tkHc2ly1g7tjadaaeaj30pj037dft.jpg)

### 通过启动盘启动

把制作好的启动盘插入电脑，进入电脑的BIOS系统修改电脑的启动顺序，将启动盘设置成第一启动，以我的电脑（暗影精灵4）为例，开机按F9即可切换启动扇区，不同的品牌的电脑有不同的设置方法，详情可以通过搜索引擎查询自己的电脑型号查看具体的设置操作。

![C611F6C7181A1293C66AA4063BCEC07A](https://tvax3.sinaimg.cn/large/005tkHc2ly1g7thvll1xaj33402c0b2a.jpg)

启动成功之后会有四个选项，第一个选项是试用Ubuntu，第二个选项是安装Ubuntu，剩下两个不用关注。

![6566FC454645D20D48AE8F0848C83FD0](https://tva4.sinaimg.cn/large/005tkHc2ly1g7thwlk63pj32c0340kjm.jpg)

这里我选择第一个试用Ubuntu，为了方便截图，当然直接安装也是可以的，稍等片刻后即进入Ubuntu的试用界面。

![Screenshot from 2019-10-10 19-57-13](https://tva4.sinaimg.cn/large/005tkHc2ly1g7ti08ttjzj31hc0u0tk9.jpg)

进入Ubuntu的试用桌面基本表示启动盘引导启动成功了。

### 安装Ubuntu

1. 双击桌面上的`Install Ubuntu 18.04.3 LTS`图标就可以开始安装系统；

2. 选择语言，中文（简体），或者自己想要的语言；

   ![Screenshot from 2019-10-10 20-03-17](https://tvax1.sinaimg.cn/large/005tkHc2ly1g7ti42uwgzj30qu0ftjrw.jpg)

3. 选择键盘布局，默认就可以了；

   ![Screenshot from 2019-10-10 20-03-35](https://tva1.sinaimg.cn/large/005tkHc2ly1g7ti671nelj30o90h3q43.jpg)

4. 设置网络连接，这里不建议在安装的时候连接网络，如果网速慢的话将会影响安装速度，如果是有线网络的话建议先把网线拔掉；

   ![Screenshot from 2019-10-10 20-03-41](https://tva2.sinaimg.cn/large/005tkHc2ly1g7ti77xduoj30o90h375t.jpg)

5. 选择安装的内容，使用最小安装就好了，没必要装那些多余的软件，以后需要用到再去安装；

   ![Screenshot from 2019-10-10 20-03-48](https://tva2.sinaimg.cn/large/005tkHc2ly1g7tia3pqf8j30o90h3dhg.jpg)

6. 选择安装方式，因为电脑已经安装了Windows10系统，如果要图简单的话，选择第一项，与Windows共存就好了，我喜欢自己调整分区，所以我使用的其他选项，**千万不要选择清除整个磁盘并安装Ubuntu**，那样会丢失所有硬盘里的数据；

   ![Screenshot from 2019-10-10 20-04-27](https://tva1.sinaimg.cn/large/005tkHc2ly1g7ticc8k6qj30o90h376n.jpg)

7. 硬盘的分区结构和大小预览，可以看到有一个大小50G左右空闲分区，这是在Windows下面预留出来的，这里我将它扩展成两个分区，一个4G大小的交换分区，用于Ubuntu系统休眠使用，剩下的分为一个EXT4主分区，挂在到`/`根目录下，关于分区，实在没有必要过于纠结挂载点，建议都挂载到根目录，**千万不要去修改其他非空闲的分区，格式化分区会丢失数据**，分区完成点击现在安装；

   ![Screenshot from 2019-10-10 20-04-35](https://tva1.sinaimg.cn/large/005tkHc2ly1g7tif394w6j30nu0neace.jpg)
   *分区方式：单击选择要修改的分区，点击左下角的“+”，然后设置分区大小和分区格式，点击确定即可。*
   ![Screenshot from 2019-10-10 20-06-58](https://tvax2.sinaimg.cn/large/005tkHc2ly1g7timqck0bj30hw07mwfn.jpg)
   
8. 选择时区，中国的话默认选择上海就可以了；

   ![Screenshot from 2019-10-10 20-07-06](https://tva1.sinaimg.cn/large/005tkHc2ly1g7tiptajwrj30nu0ne79u.jpg)

9. 设置电脑信息和用户信息，自行设置；

   ![Screenshot from 2019-10-11 04-07-31](https://tvax2.sinaimg.cn/large/005tkHc2ly1g7tiqiqdumj30nu0nedh1.jpg)

10. 开始安装系统，等待几分钟即可安装成功；

    ![Screenshot from 2019-10-11 04-07-42](https://tva2.sinaimg.cn/large/005tkHc2ly1g7tirgiob5j30kw0ftn1f.jpg)

11. 安装成功，重启电脑；

    ![Screenshot from 2019-10-11 04-14-17](https://tvax1.sinaimg.cn/large/005tkHc2ly1g7tit5wdf5j30m004bdge.jpg)

12. 重启电脑时将U盘拔下，通常重启电脑之后，BIOS会默认启动Ubuntu的引导界面，如果没有启动到Ubuntu的引导界面，可以自行更改BIOS的启动设置，将Ubuntu设置成第一引导选项。引导界面有四个选项，第一个是正常启动Ubuntu系统，第二个是高级启动，第三个是启动Windows系统，第四个是进入电脑的BIOS设置。界面有10秒倒计时，如果没有更改启动选项则默认启动第一个，通过上下方向键可以更改启动选项，按回车键确定，通常默认启动第一个（正常启动Ubuntu）即可；

    ![9680080688BD30783DBB457347BDC21F](https://tvax1.sinaimg.cn/large/005tkHc2ly1g7tiueoiioj32c03407wi.jpg)

13. 稍等片刻就进入Ubuntu登录界面，选择安装系统时创建的用户，输入密码即可进入系统；

    ![A0F892F96AE3577616886671227AFAE1](https://tvax1.sinaimg.cn/large/005tkHc2ly1g7tj0g1qnlj32c03401ky.jpg)

14. 进入Ubuntu桌面，系统安装成功！

    ![2019-10-11 12-18-03 的屏幕截图](https://tvax1.sinaimg.cn/large/005tkHc2ly1g7tj2d7xb2j31hc0u07gh.jpg)

### 总结

相对来说，Ubuntu桌面版的安装还是非常简单的，全程都是基于可视化操作，非常便捷，稍微仔细点，配合搜索引擎应该都可以安装成功。