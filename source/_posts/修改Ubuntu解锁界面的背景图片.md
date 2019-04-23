---
title: 修改Ubuntu解锁界面的背景图片
tags: [Ubuntu,Linux]
comments: true
date: 2019-01-17 10:26:53
categories: Linux
---

因为学习Linux已经在Vmware装上Ubuntu有一段时间了，因为我装的是桌面版Ubuntu，所以是有GUI界面的，前几天逛知乎看到一篇修改Ubuntu解锁界面背景图片的文章，照着文章做了下，效果不错，所以在这里记录下来并分享给大家。

<!--more-->

默认的解锁界面简洁干净

![image](https://ws2.sinaimg.cn/large/005tkHc2gy1fzf5jnd1ysj30uo0h7102.jpg)

### 准备

Linux版本：Ubuntu 18.04

一张用来做背景的图片，png或者jpg格式的都可以，分辨率1080*1920比较合适，将图片命名为background.jpg，放置到家目录下

### 修改

打开终端，使用命令行把图片移动到/usr/share/backgrounds/目录下，如提示权限不足就用sudo命令。

```bash
$ sudo mv ~/background.jpg  /usr/share/backgrounds/
```

打开Ubuntu的样式文件

```bash
$ sudo nano /etc/alternatives/gdm3.css
```

使用`ctrl+w`搜索lockDialogGroup定位到解锁样式的位置，默认样式为

```css
#lockDialogGroup {
  background: #2c001e url(resource:///org/gnome/shell/theme/noise-texture.png);
  background-repeat: repeat; }
```

修改为以下样式

```css
#lockDialogGroup {
  background: #2c001e url(file:///usr/share/backgrounds/background.jpg);         
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center; 
}
```

`ctrl+o`保存文件，然后`ctrl+x`关闭文件。

### 生效

使用命令行重启系统

```bash
$ reboot
```

重启系统即可看到修改后的效果了，如果对css有更多的了解，还可以定制喜欢的样式。

![image](https://wx3.sinaimg.cn/large/005tkHc2gy1fzf5jmuo7rj31hc0u0hdu.jpg)

> 原文链接：[Ubuntu18.04 更改登录界面默认背景图](https://zhuanlan.zhihu.com/p/36470249)