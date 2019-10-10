---
title: Windows10系统安装教程（UEFI+GPT）
tags: [Windows,系统]
comments: true
date: 2019-01-21 09:35:36
categories: 教程
---

作为一个程序员，修电脑和装系统是必须要会的（手动狗头），因为总会有朋友来问我怎么重装系统，所以准备写一个教程，以后要是还有人来问我怎么重装，直接把本文链接怼到他脸上（哼哼），本教程使用的是UEFI+GPT安装Windows10。

<!--more-->

### 准备

电脑一台

U盘一个（大小8G及以上）

### 下载镜像

去[官网](https://www.microsoft.com)或者[MSDN](https://msdn.itellyou.cn/)下载原版ISO镜像文件，以MSDN为例，打开链接，在左边导航栏【操作系统】列表中找到想要重装的系统版本，打开镜像列表，选择适合自己的镜像版本，2G以上内存推荐安装64位操作系统，复制ed2k链接，使用迅雷下载镜像文件即可，本教程使用的镜像文件如下：

```
文件名：cn_windows_10_consumer_editions_version_1809_updated_jan_2019_x64_dvd_34b4d4fb.iso
SHA1：61c07b037574454b88bcac7f5a571c042304c884
文件大小：4.89GB
发布时间：2019-01-16
ed2k://|file|cn_windows_10_consumer_editions_version_1809_updated_jan_2019_x64_dvd_34b4d4fb.iso|5246148608|D93F5C49291A0B7AA888537954785DC3|/
```

### 制作启动盘

1. 下载启动盘制作工具Rufus，官网地址：[Rufus](https://rufus.ie/)

2. 插入U盘

3. 打开Rufus，选择设备，通常会自动选定插入的U盘，选择镜像文件，分区类型选择GPT，目标系统类型选择UFEFI，其他设置默认，如图所示：

   ![image](https://ws2.sinaimg.cn/large/005tkHc2gy1fzf5ko8tg2j30bq0g6jrz.jpg)

4. 点击开始，工具即开始制作启动盘，**提醒：制作启动盘会清除U盘中的所有数据，请提前备份！**

5. 进度条跑完后，恭喜你，启动盘制作成功了！关闭Rufus，准备重装系统吧。

### 从启动盘启动

启动盘制作完毕后，不要拔出U盘，然后重启电脑，进入BIOS，各个品牌的主板（笔记本）进入BIOS的按键不一致，通常台式机是`Delete`，笔记本是`Esc`，`F2`，`F10`之类的，如果不对请查看主板（笔记本）说明书或者百度解决。

以下我以我手头的笔记本电脑**神舟战神K650D**举例，通常大多数电脑设置基本都是一致的，不会有很大的差别，具体的BIOS设置请百度自己的电脑主板或笔记本型号。

1. 关闭安全启动，进入BIOS，找到Secure Boot选项，将其设置为关闭；

   ![image](https://ws3.sinaimg.cn/large/005tkHc2gy1fzf5kojgmaj31770ku1iu.jpg)

2. 开启UEFI模式，在BIOS中找到Boot下的UEFI设置，将其设置为打开；

   ![image](https://wx1.sinaimg.cn/large/005tkHc2gy1fzf5koya3tj315x0jcb1f.jpg)

3. 将U盘设置为第一启动项，U盘是以UEFI开头的就对了，把它移动到第一的位置；

   ![image](https://ws3.sinaimg.cn/large/005tkHc2gy1fzf5kpbgu4j316s0ks4qp.jpg)

4. 保存设置并重启电脑。

### 系统安装

1. 如果上面的步骤都没有问题的话，那电脑重启应该可以进入到Win PE的安装界面了，像下面这样。

   ![image](https://ws1.sinaimg.cn/large/005tkHc2gy1fzf5kprckfj31530n64qp.jpg)

2. 点击下一步开始安装

   ![image](https://ws2.sinaimg.cn/large/005tkHc2gy1fzf5kq7sayj313w0mfb29.jpg)

3. 点击现在安装，进入到激活

   ![image](https://wx1.sinaimg.cn/large/005tkHc2gy1fzf5kqq9ppj312s0ma7wh.jpg)

4. 这里选择我没有产品密钥，装完系统之后再进行激活（KMS你懂的），进入操作系统版本选择

   ![image](https://ws2.sinaimg.cn/large/005tkHc2gy1fzf5kr5t7qj312e0lfkjl.jpg)

5. 这里我选择家庭版为例，然后单击下一步，进入许可条款

   ![image](https://ws1.sinaimg.cn/large/005tkHc2gy1fzf5krm6a1j31160k47wh.jpg)

6. 我接受许可条款打勾，单击下一步，进入安装选项

   ![image](https://ws1.sinaimg.cn/large/005tkHc2gy1fzf5ks27j4j30yp0js4qp.jpg)

7. 因为是安装全新的系统，所以这里选择自定义，进入安装磁盘选择

   ![image](https://ws2.sinaimg.cn/large/005tkHc2gy1fzf5kshan5j311h0l2x6p.jpg)

8. 到这里是最容易遇到问题的地方了，可能遇到所选磁盘不是GPT格式的分区，磁盘容量大小不足等等问题，只要你以上步骤都正确操作，硬盘是没有问题且大小合适的，那么接下来一系列步骤应该能解决大多数安装遇到的问题，按下键盘上的`Shift+F10`打开命令提示行

   ![image](https://ws4.sinaimg.cn/large/005tkHc2gy1fzf5ksy7npj31720mue81.jpg)

9. 根据提示输入以下的代码

   ```powershell
   # 打开磁盘工具
   diskpart
   # 列出硬盘
   list disk
   # 选择操作的硬盘，这里X是硬盘里的编号，你需要把系统装到哪个硬盘你就输入对应硬盘的编号
   select disk X
   # 清除硬盘，这个操作会将整个硬盘的内容全部清除，如果有重要数据请一定提前备份
   clean
   # 将硬盘装换成GPT分区格式
   convert gpt
   # 创建EFI分区，用来存放系统的引导文件，大小256M左右差不多够了
   create partition efi size = 256
   # 创建主分区，这是第一个主分区，我喜欢把系统装在这个分区里面，大小的话通常大于50G，因为我不喜欢在C盘放过多的文件和装软件，我这里分了50G
   create partition primary size = 51200
   # 创建主分区，这里省略了大小设置，就是默认将剩下的所有容量分到这个区，我喜欢把第二个分区用作D盘，装一些软件
   create partition primary
   ```

   下面是具体的操作过程截图，**慎重操作，注意备份数据**

   ![image](https://ws1.sinaimg.cn/large/005tkHc2gy1fzf5kmifgcj30xc0orhdt.jpg)

   操作完成之后右上角叉叉或者输入命令`exit`退出命令行

10. 再次回到安装磁盘选择，点击刷新，就可以看到重新分区后的磁盘列表了

    ![image](https://ws4.sinaimg.cn/large/005tkHc2gy1fzf5kmz9xlj314z0n84qq.jpg)

11. 选择为系统准备的分区，如图，我会选择`驱动器1分区2`然后单击下一步，系统开始安装，即将大功告成

    ![image](https://ws4.sinaimg.cn/large/005tkHc2gy1fzf5knjkswj31800oekjl.jpg)

12. 等待进度条读完，然后会提示重启系统完成安装，点击重启就可以了，**重启的时候记得把U盘给拔下来**，系统可能会重启多次，重启完成之后会进入系统的启动设置，这些都是一些基础的设置，设置完成后就能进入系统

    ![image](https://ws3.sinaimg.cn/large/005tkHc2gy1fzf5knxosxj31hc0u04qp.jpg)

13. 开始体验全新的Windows 10吧！！！

### 总结

遇到问题不要灰心，不要畏惧，善于利用百度/谷歌等搜索引擎！！！善于利用百度/谷歌等搜索引擎！！！善于利用百度/谷歌等搜索引擎！！！重要的事说三遍！！！
