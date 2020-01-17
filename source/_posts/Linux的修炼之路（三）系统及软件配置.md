---
title: Linux的修炼之路（三）系统及软件配置
tags:
  - Linux
comments: true
categories: Linux
abbrlink: 59832
date: 2020-01-16 15:55:15
---

Ubuntu装好之后，折腾之路才刚刚开始，因为不是开箱即用，还需要做一定的配置，装一些软件和工具，才能用的顺手。

<!-- more -->

### 切换软件源

``` bash

```



``` text
deb http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse  deb http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse 
```

