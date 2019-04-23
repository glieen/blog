---
title: 配置Github公钥
tags: [Git]
comments: true
date: 2019-02-14 16:44:33
categories: Git
---

大多数 Git 服务器都会选择使用 SSH 公钥来进行授权,系统中的每个用户都必须提供一个公钥用于授权，没有的话就要生成一个。生成公钥的过程在所有操作系统上都差不多。

<!--more-->

### 公钥和私钥

SSH公钥默认储存在用户的家路径的`.ssh`目录下，Windows为`C:\Users\用户名\.ssh`目录，Linux为`~/.ssh`目录，下图为Windows下的文件列表。

![image](https://wx1.sinaimg.cn/large/005tkHc2gy1g06257oya9j30jy08p3yw.jpg)

`id_rsa`为私钥文件，`id_rsa.pub`为公钥文件。

### 生成公钥和私钥

1. 确保家路径下没有`.ssh`目录，有则先删除该文件夹；
2. 打开bash终端，运行`ssh-keygen`工具；
3. 会有三次提示操作，第一次是确认生成密钥的目录，默认是家路径下的 `.ssh`目录，第二次和第三次是提示输入密码和确认密码，可以为空；
4. 生成成功。

![image](https://ws1.sinaimg.cn/large/005tkHc2gy1g062genf7hj30sr0j5jvn.jpg)

生成后的公钥大概就是这个样子：

```markdown
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiupK6UEUhjsa/E7+lRx1WJpEE+arG6YiWJ5cdFCyHuXq3X+2anW7C68X6Wn41eivFmEcD4fXP8/ZM5x40spFfXsvE3qAAAZUxF9HDM0gj9zojaz9P1QtF1dqZKTiBszi9c0kPgb3iR24h6H+NzmX06dVp4PPv6Zlci7TEAf9gsFot1reEtT0Bp+jVivEutvz231A3pZcUBuYkGCXdfvw7gbT5NPFlVm8l+kY8xBbJ6sMXKWDO06Kx/aEpUbDHPsxlD4Vmu0A6NSjtxATjG9xEeaNHct2Ry6jpOWE28xIYYtS3b5FAx4k4XEULYWIMMersdwHA768LGnWibh9W9IUJ Glieen@Firefly
```

### 配置SSH到Github

1. 登录Github并打开SSH配置链接：[Github-Keys](https://github.com/settings/keys)；
2. 点击`New SSH Key`，Title可以随意命名，将公钥文件`id_rsa.pub`里的内容复制并粘贴到Key文本框中，点击`Add SSH Key`即可成功添加；
3. 打开bash终端，输入：`ssh git@github.com`可以测试是否配置成功。

![image](https://wx3.sinaimg.cn/large/005tkHc2gy1g062nognw0j30mo07e3yz.jpg)

![image](https://ws1.sinaimg.cn/large/005tkHc2gy1g062s45um3j30pp06omy7.jpg)

