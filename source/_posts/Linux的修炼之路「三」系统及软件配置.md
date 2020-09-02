---
title: Linux的修炼之路「三」系统及软件配置
tags:
  - Linux
  - Ubuntu
comments: true
categories: Linux
abbrlink: 59832
date: 2019-10-16 15:55:15
---

Ubuntu装好之后，折腾之路才刚刚开始，因为不是开箱即用，还需要做一定的配置，装一些软件和工具，才能用的顺手。

<!-- more -->

### 配置软件源

*简单介绍下Linux中的文本编辑器`nano`，`ctrl + o`是保存，`ctrl + x`是退出。*

``` bash
# 备份原软件源配置
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo nano /etc/apt/sources.list
```

将以下的网易软件源配置粘贴进编辑器并保存

``` text
deb http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse
```

``` bash
# 更新软件源
sudo apt update
sudo apt upgrade
```

### 常用软件

- Electron-SSR

  ``` bash
  sudo dpkg -i $(wget https://github.com/shadowsocksrr/electron-ssr/releases/download/v0.2.7/electron-ssr-0.2.7.deb) 
  ```

- Google Chrome

  ``` bash
  sudo dpkg -i $(wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb) 
  ```
  
- 谷歌拼音

  ``` bash
  sudo apt install fcitx googlepinyin
  ```

- 电源管理

  ``` bash
  sudo apt install tlp
  # 重启
  reboot
  ```

- 网络工具

  ``` bash
  sudo apt install net-tools
  ```

- 文本编辑器Kate

  ``` bash
  sudo apt install kate
  ```
  
- 网易云音乐

  打开网易云音乐客户端[下载页面](https://music.163.com/#/download)，下载适用于Ubuntu的版本。

  ``` bash
  # xxx为具体的版本号
  sudo dpkg -i netease-cloud-music_1.2.1_amd64_ubuntu_xxx.deb
  ```

- KeepassXC

  ``` bash
  sudo apt install keepassxc
  ```

- 坚果云

  ``` bash
  sudo dpkg -i $(wget https://www.jianguoyun.com/static/exe/installer/ubuntu/nautilus_nutstore_amd64.deb) 
  ```

- Git

  ``` bash
  sudo apt install git
  ```

- Axel（多线程下载工具）

  ``` bash
  sudo apt install axel
  ```

- Htop

  ``` bash
  sudo apt install htop
  ```

- Sublime Text

  ``` bash
  sudo apt install sublime-text
  ```

- NodeJS/npm/cnpm

  ``` bash
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
  sudo apt-get install -y nodejs
  sudo npm install -g cnpm --registry=https://registry.npm.taobao.org
  ```

- Curl

  ``` bash
  sudo apt install curl
  ```

- Yakuake（快捷下拉终端）

  ``` bash
  sudo apt install yakuake
  ```

- Zsh

  ``` bash
  sudo apt install zsh
  ```

- Tldr

  ``` bash
  sudo apt instal tldr
  ```

- OpenJDK

  ``` bash
  sudo apt install openjdk-8-jdk
  ```

- IntelliJ IDEA

  打开IntelliJ IDEA[下载页面](https://www.jetbrains.com/idea/download/#section=linux)，下载压缩包。

  ``` bash
  # xxx为具体的版本号
  tar zxvf ideaIU-xxx.tar.gz
  # 进入执行文件目录
  cd idea-IU-xxx/bin/
  # 执行启动脚本
  ./idea.sh
  ```

- Maven

  ``` bash
  sudo apt install maven
  ```

- MySQL

  ``` bash
  sudo apt install mysql-server mysql-client
  ```
  
- Nginx

  ``` bash
  sudo apt install nginx
  ```
  
### Deepin-Wine

电脑上免不了要装上QQ/微信等国民应用，但是却只有WIndows/MacOS的版本，Linux没能得到适配。在Deepin团队的努力下，做了Deepin-Wine的兼容层，让这些软件可以很好的运行在Deepin系统中，后在社区大牛的开源精神下，又把Deepin-Wine移植到了Ubuntu，所以Ubuntu也可以利用Deep-Wine运行QQ/微信/迅雷等软件了。

#### 安装Deepin-Wine

打开项目地址[deepin-wine-ubuntu](https://github.com/wszqkzqk/deepin-wine-ubuntu/releases)，下载最新的发行包。

``` bash
# xxx为具体的版本号
tar zxvf deepin-wine-ubuntu-2.18-12-3.tar.gz
# 执行安装脚本
./install.sh
```

#### 获取软件安装包

在[阿里云Deepin软件源](https://mirrors.aliyun.com/deepin/pool/non-free/d/)想要安装的软件的安装包，然后执行安装命令即可安装。

``` bash
# xxx为具体的安装包名
sudo dpkg -i xxx.deb
```

### 环境配置

#### 开机打开小键盘

``` bash
sudo -i
su gdm -s /bin/bash
gsettings set org.gnome.settings-daemon.peripherals.keyboard numlock-state 'on'
```

#### 将主目录中文名切换成英文

``` bash
export LANG=en_US
xdg-user-dirs-gtk-update
# 弹窗提示是否将目录转换成英文，同意
export LANG=zh_CN
reboot
# 弹窗提示是否将目录转换成中文，拒绝
```

#### 终端（tab）补全忽略大小写

```bash
# 家目录下执行
echo 'set completion-ignore-case on' >> .inputrc
```

#### oh-my-zsh

```bash
# 检查是否安装zsh，未安装则先安装
cat /etc/shells | grep zsh 
# 安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 修改zsh主题
nano ~/.zshrc
# 修改这个位置的主题名即可，默认主题是robbyrussell
# ZSH_THEME="robbyrussell"
# random是随机主题，推荐几套个人比较喜欢的主题：strug/ys/steeef/rkj-repos
```

#### git代理

```bash
# 访问github奇慢无比，所以根据需要加上代理
# 具体的代理端口号根据代理软件设置
git config --global http.https://github.com.proxy https://127.0.0.1:1080
git config --global https.https://github.com.proxy https://127.0.0.1:1080
```

#### 命令行查单词

``` bash
# word为具体要查的单词，支持中文/英文
curl v2en.co/word
sudo nano /usr/local/bin/fy
# 将以下查单词脚本复制保存
sudo chmod +x /usr/local/bin/fy
# 可以使用fy脚本查单词，word为要查的单词
fy word
```

``` bash
#!/bin/bash
# 查单词脚本
v2() 
	declare q="$*";
	curl --user-agent curl "https://v2en.co/${q// /%20}";
}
v2 $*
```

#### sudo免密

修改`/etc/sudoers`文件，修改`%sudo`这一行，这样所有的sudo命令都可以免密使用。

```bash
%sudo	ALL=(ALL:ALL) NOPASSWD: ALL
```

