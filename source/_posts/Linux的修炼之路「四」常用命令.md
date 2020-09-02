---
title: Linux的修炼之路「四」常用命令
tags:
  - Linux
  - Ubuntu
  - Shell
comments: true
categories: Linux
abbrlink: 64236
date: 2019-10-19 15:45:21
---

Linux是基于命令行的世界，想要熟练的使用，掌握和了解一些常用的命令是必不可少的，我简单记录下平时用到的一些命令或功能，方便拾遗，加强记忆。

<!--more-->

这里推荐一个网站和一个工具，对不了解的命令可以很快的找到它的快捷用法，相对于man文档来说要方便的多。
- [Linux-Command](https://wangchujiang.com/linux-command/)（可以很快捷的查询命令的用法，就不多做介绍了）
- [tldr](https://github.com/tldr-pages/tldr)
``` bash
# Ubuntu安装tldr
sudo apt install tldr
# 其他系统安装tldr
sudo npm install -g tldr
# 使用tldr xxx，xxx为具体要查询的命令
tldr tar
```

### 常用命令
#### more
以每次一屏的方式输出文本的内容。
快捷键：
	向下翻页：`Space`
	向上翻页：`b`
	退出：`q`
常用参数：

```bash
-<数字> # 每一屏的行数
```
示例：
```bash
# 以每屏10行的方式查看文件家目录下的a.txt
more -10 ~/a.txt
```
#### sudo
以管理员权限执行，配置位于`/etc/sudoers`，输入密码后有五分钟有效期。
示例：
``` bash
# 检查软件源更新
sudo apt update
```
#### su
用于切换当前用户身份到其他用户身份，需要输入切换用户的密码。
示例：
``` bash
# 切换到root用户
su root
```
#### cd
进入某目录，`/`表示根目录，`~`表示当前用户的家目录，`.`表示当前所在目录，`..`表示上级目录。
示例：
``` bash
# 进入家目录
cd ~
```
#### ls
列出目录下的文件，默认为当前文件夹，文件名以`.`开头的被视为隐藏文件（夹）。
常用参数：
```bash
-a # 列出所有文件
-l # 单列输出
-h # 转换成可读大小，文件大小默认是字节
-R # 递归子目录
```
示例：
``` bash
# 以单列输出列出家目录下的所有文件
ls -alh ~ 
```
#### mkdir
新建文件夹。
示例：

``` bash
# 在家目录下创建文件夹test
mkdir ~/test
```
#### cp
复制文件（夹），将源文件（夹）复制到目标位置。
常用参数：
```bash
-f # 强制复制，存在即覆盖
-R # 递归复制子文件夹
```
示例：
```bash
# 将家目录下的.bashrc文件复制到家目录下的test文件夹中
cp ~/.bashrc ~/test/
```
#### touch
创建新的空白文件。
示例：
```bash
# 在家目录下创建空白文件test.txt
touch ~/test.txt
```
#### mv
将源文件（夹）移动到目标位置，或者重命名文件（夹）。
常用参数：
```bash
-f # 如果存在同名文件直接覆盖
```
示例：
``` bash
# 将a.txt重命名为b.txt
mv a.txt b.txt
```
#### rm
删除文件（夹）。
常用参数：
``` bash
-r # 递归删除子目录下的文件
-f # 强制删除文件
```
示例：
``` bash
# 删除家目录下的a.txt
rm ~/a.txt
```
#### clear
清除屏幕上的信息
示例：
``` bash
clear
```
#### dpkg
Debian系Linux上的软件包管理工具，可以用来管理安装包，安装包后缀以`.deb`结尾，通常需要使用`root`权限执行。
常用参数：

```bash
-i # 安装软件包
-r # 删除软件包
-P # 删除软件包的同时删除其配置文件
-l # 显示已安装软件包列表
```
示例：
```bash
# 安装firefox
sudo dpkg -i firefox.deb
# 卸载firefox
sudo dpkg -r firefox
# 查找firefox安装包
sudo dpkg -l | grep firefox
```
#### alias
为命令设置别名，仅限当前会话（session）有效。
示例：
```bash
# 为ls设置别名l
alias l='ls'
```
#### grep
文本检索工具，查找满足表达式的所有行并打印到终端。
常用参数：
```bash
-n # 显示行号
-i # 忽略大小写
```
示例：
```bash
# 查找test.txt中包含字符test的所有行并列出行号
grep -n 'test' test.txt
```
#### nano
终端文本编辑器，比vim使用起来简单一些。
快捷键：
	搜索：`ctrl + w`
	保存：`ctrl + o`
	退出：`ctrl + x`
示例：

```bash
# 编辑家目录下的test.txt
nano ~/test.txt
```
#### echo
输出指定的字符串或者变量，变量以`$`开头引用
常用参数：

```bash
-e # 激活转义字符，如\n表示换行
```
示例：
```bash
# 输出当前的PATH环境变量
echo $PATH
# 打印Hello World
echo 'Hello World'
```
#### export
将SHELL变量导出到运行环境，在配置环境变量中尤为重要，多个环境变量的分隔符为`：`，引用其他环境变量使用`$`符号，通过终端设置的环境变量只对当前会话生效。
示例：
```bash
# 列出当前运行环境的所有环境变量
export
# 将/opt/jdk/bin添加到PATH变量中
export PATH=/opt/jdk/bin:$PATH
```
#### pwd
显示当前所在的工作目录。
示例：
```bash
# 显示当前所在的工作目录。
pwd
```
#### exit
退出当前的SHELL客户端。
示例：
```bash
# 退出当前的SHELL客户端
exit
```
#### bg
把当前执行的应用程序移动到后台执行，类似于在命令之后加`&`。
SHELL快捷键（在终端中通常以`^`符号指代`ctrl`）：
​	中断程序：`ctrl + c`	
​	挂起程序并暂停执行：`ctrl + z`
示例：
```bash
# 终端睡眠60秒钟
sleep 60
# 使用快捷键^ + z挂起当前进程
# 将当前挂起的进程移至到后台运行
bg
```
#### jobs
列出当前会话作业的状态。
示例：

```bash
# 列出当前会话作业的状态。
jobs
```
#### fg
将后台运行的进程切换到前台运行。
常用参数：

```bash
%n # 作业编号
```
示例：
```bash
# 将编号为1的作业切换到前台运行
fg %1
```
#### kill
发送信号到指定的进程。
常用参数：

```bash
-l # 列出所有信号量
-n # 指定发送的信号量
PID # 指定进程号（一个或多个）
%n # 指定作业号（一个或多个）
```
示例：
```bash
# 强制中止进程号为1的进程
kill -n 9 1
# 强制中止进程号为1的进程
kill -9 1
# 默认向进程号为1的进程发送终止信号
kill 1
```
#### find
在指定目录下查找满足条件的文件。
常用参数：

```bash
-name # 指定查找文件名（可以使用通配符）
-iname # 指定查找文件名，忽略大小写
-regex # 使用正则表达式匹配文件路径
```
示例：
```bash
# 列出当前目录及子目录下的所有文件
find .
# 在家目录下查找文件名为test的文件
find ~ -name 'test'
```
#### less
对指定的文件进行上下分页输出。
快捷键：
​	向上翻页：`PageUp`
​	向下翻页：`PageDown`
​	退出：`q`
常用参数：
```bash
-e # 文件内容显示完毕后，自动退出
-N # 行首显示行号
```
示例：
```bash
# 上下分页输出文件家目录下的a.txt
less -N ~/a.txt
```
#### wc
统计文件的字节数，字数，行数。
常用参数：

```bash
-c # 统计字节数
-w # 统计字符数
-l # 统计行数
```
示例：
```bash
# 统计a.txt的行数
wc -l a.txt
# 统计当前目录下文件的总行数
wc -l *
```
#### env/printenv
查看全局环境变量。
示例：
```bash
# 查看全局环境变量
printenv
# 查看HOME环境变量(查看单个环境变量时，只能使用printenv)
printenv HOME
```
#### uname
打印当前系统相关信息。
常用参数：
```bash
-a # 显示所有信息
-v # 显示操作系统版本
-s # 显示操作系统名称
```
示例：
```bash
# 显示系统所有信息
uname -a
```
#### netstat
显示各种网络相关信息，如网络连接，路由表，接口状态 ，多播成员等 。
常用参数：
```bash
-a # 显示所有选项，默认不显示LISTEN相关
-t # 显示tcp相关选项
-u # 显示udp相关选项
-n # 直接使用ip地址，而不通过域名服务器
-p # 显示正在使用Socket的程序识别码和程序名称；
-l # 列出所有处于监听状态的 Sockets
```
示例：
```bash
# 列出所有端口
netstat -a | more
# 列出所有监听的tcp端口
netstat -lt
```
#### man
查看Linux中的指令帮助、配置文件帮助和编程帮助等信息。
常用参数：
```bash
-a # 在所有的man帮助手册中搜索
-f # 等价于whatis指令，显示给定关键字的简短描述信息
-P # 指定内容时使用分页程序
```
示例：
```bash
# 查询ipconfig相关信息
man ipconfig
```
#### which
查找文件，在环境变量$PATH设置的目录里查找符合条件的文件。
示例：
```bash
# 查看指令"bash"的绝对路径
which bash
```
#### whereis
查找文件，只能用于查找二进制文件、源代码文件和man手册页。
示例：
```bash
# 查看指令"bash"的位置
whereis bash
```
#### whoami
显示自身用户名称。
示例：
```bash
# 显示自身的用户名称
whoami
```
#### ps
显示当前进程 (process) 的状态。
常用参数：
```bash
-A # 列出所有的进程
-f # 等价于whatis指令，显示给定关键字的简短描述信息
-u # 指定用户的所有进程
```
示例：
```bash
# 显示root进程用户信息
ps -u root
# 显示所有进程信息，连同命令行
ps -Af
```
#### top
显示当前系统正在执行的进程的相关信息，包括进程ID、内存占用率、CPU占用率等。
常用参数：
```bash
-u # 指定用户名
-p # 指定进程
```
示例：
```bash
# 显示root进程信息
top -u root
```
#### file
辨识文件类型。
示例：
```bash
# 查询文件pom.xml的类型
file pom.xml
```
#### ln
为某一个文件在另外一个位置建立一个同步的链接。当我们需要在不同的目录，用到相同的文件时，我们不需要在每一个需要的目录下都放一个必须相同的文件，我们只要在某个固定的目录，放上该文件，然后在其它的目录下用ln命令链接（link）它就可以，不必重复的占用磁盘空间。
链接又可分为两种 : 硬链接(hard link)与软链接(symbolic link)，硬链接的意思是一个档案可以有多个名称，而软链接的方式则是产生一个特殊的档案，该档案的内容是指向另一个档案的位置。硬链接是存在同一个文件系统中，而软链接却可以跨越不同的文件系统。
常用参数：
```bash
-s # 软链接(符号链接)
-b # 删除，覆盖以前建立的链接
-d # 允许超级用户制作目录的硬链接
-n # 把符号链接视为一般目录
```
示例：
```bash
# 给文件创建软链接，为log.log文件创建软链接link，如果log.log丢失，link将失效
ln -s log.log link
```
#### date
显示或设定系统的日期与时间。可以设定欲显示的格式，格式设定为一个加号后接数个标记
常用参数：
```bash
--help # 显示辅助讯息
%D # 直接显示日期 (mm/dd/yy)
%T # 直接显示时间 (24 小时制)
%k # 小时(0..23)
%M # 分钟(00..59)
```
示例：
```bash
# 显示时间
date '+%D %T'
```
#### apt
安装包管理工具，可以更新软件包列表索引、执行安装新软件包、升级现有软件包，还能够升级整个系统。(apt 是 Debian 系操作系统的包管理工具)
常用参数：
```bash
update  # 更新软件源中的所有软件列表
upgrade # 升级软件包
install <软件包名> # 安装指定软件。此命令需管理员权限
remove  <软件包名> # 用来卸载指定软件
show    <软件包名> # 显示软件包具体信息
autoremove  # 用来自动清理不再使用的依赖和库文件
purge # 卸载软件包并删除配置文件
```
示例：
```bash
# 修复依赖关系
sudo apt install -f
# 安装git
sudo apt install git
```
#### cat
连接文件并打印到标准输出设备上。
常用参数：
```bash
-n # 由1开始对所有输出的行数编号
-b # 和 -n 相似，只不过对于空白行不编号
-s # 当遇到有连续两行以上的空白行，就代换为一行的空白行
```
示例：
```bash
# 给log.txt加上行号后输出
cat -n log.txt
```
#### tar
用来打包，压缩和解压文件。tar本身不具有压缩功能，它是调用压缩功能实现的 。
打包和压缩：打包是指将一大堆文件或目录变成一个总的文件；压缩则是将一个大的文件通过一些压缩算法变成一个小文件。
常用参数：
```bash
-z # 支持gzip解压文件
-j # 支持bzip2解压文件
-c # 建立新的压缩文件
-x # 从压缩的文件中提取文件
-f # 指定压缩文件
-v # 显示操作过程
-t # 显示压缩文件的内容
```
示例：
```bash
# 将log.txt打包为log.tar
tar -cvf log.tar log.txt
# 将log.tar解包
tar -xvf log.tar
# 查看log.tar.gz内容
tar -ztvf log.tar.gz
```
#### chmod
Linux/Unix 的文件调用权限分为三级 : 文件拥有者、群组、其他。利用 chmod 可以藉以控制文件如何被他人所调用。
参数说明：

```bash
-u # 表示该文件的拥有者，g 表示与该文件的拥有者属于同一个群体(group)者，o 表示其他以外的人，a 表示这三者皆是
+ # 表示增加权限
- # 表示取消权限
= # 表示唯一设定权限
-r # 表示可读取
-w # 表示可写入
-x # 表示可执行
-X # 表示只有当该文件是个子目录或者该文件已经被设定过为可执行
```
补充：
chmod也可以用数字来表示权限如 :

```bash
chmod 777 file
```

分别表示User、Group、及Other的权限。r=4，w=2，x=1

- 若要rwx属性则4+2+1=7；
- 若要rw-属性则4+2=6；
- 若要r-x属性则4+1=5。

示例：
```bash
# 将文件file1.txt设为所有人皆可读取
chmod ugo+r file1.txt
# 将当前目录下的所有文件与子目录皆设为任何人可读取 
chmod -R a+r *
```
#### chown
将指定文件的拥有者改为指定的用户或组，用户可以是用户名或者用户ID；组可以是组名或者组ID；文件是以空格分开的要改变权限的文件列表，支持通配符。
示例：
```bash
# 将文件file1.txt的拥有者设为friend，群体的使用者friendGroup
chown friend:friendGroup file1.txt
```
#### df
显示目前在Linux系统上的文件系统的磁盘使用情况统计。
常用参数：
```bash
-h # 使用人类可读的格式
```
示例：
```bash
# 输出磁盘使用情况
df -h
```
#### tail
在终端上输出文件末尾的若干行内容，查看正在执行程序的日志输出很方便。
常用参数：

```bash
-n # 指定显示文件末尾的行数
-f # 动态监听文件末尾的内容变化
-s # 动态监听的秒数，和-f配合使用
```
示例：
```bash
# 查看mail.log的最后20行内容并执行动态监听
tail -n 20 -f mail.log 
```
#### logout
退出当前登录的SHELL。
示例：

```bash
# 退出当前登录的SHELL
logout
```
#### lsof
列出当前系统打开的文件列表，使用这个命令需要使用`root`权限。在Linux中，一切皆文件，如：进程、端口等，都被分配了文件标识符，可以通过`lsof`查看它们。
常用参数：

```bash
-i :port # 查看打开指定端口的进程 
-t # 只查看打开进程的PID
-u # 查看指定用户打开的文件
-c # 查看指定命令打开的文件
-p # 查看指定进程号打开的文件
-D # 查看某目录下被打开的文件
```
示例：
```bash
# 查看使用8080端口的进程
sudo lsof -i :80
# 查看用户glieen打开的文件
sudo lsof -u glieen
# 查看mysql打开的文件
sudo lsof -c mysql
# 查看进程号为555打开的文件
sudo lsof -p 555
```
#### mount
用于挂载Linux系统之外的文件，常用来挂载U盘，引导分区（EFi）等，通常需要使用`root`权限执行。
示例：

```bash
# 将磁盘的第一个分区/dev/sda1挂载到/mnt/glieen/f目录下
sudo mount /dev/sda1 /mnt/glieen/f
```
#### umount
用于卸载已经挂载的文件系统。
示例：
```bash
# 卸载磁盘的第一个分区/dev/sda1
sudo umount /dev/sda1
```
#### sftp
交互式的FTP文件传输程序，默认使用ssh协议连接，可以方便的上传和下载文件。
交互式命令：
```bash
# 可以远程执行程序命令，本地命令需要在命令前加l，表示local
put # 上传文件
get # 下载文件
```
示例：
```bash
# 以用户glieen的身份登录主机192.168.1.3的sftp交互客户端，需要输入用户glieen的密码
sftp glieen@192.168.1.3
# 获取mail.log文件并重命名为a.txt
> get mail.log a.txt
# 上传test.txt文件
> put test.txt
# 退出sftp交互程序
> exit
```
#### passwd
修改用户密码的工具，用户信息存放在`/etc/passwd`中。
常用参数：

```bash
-S # 查看当前登录用户的密码状态
-d # 清除密码
```
示例：
```bash
# 修改当前登录用户的密码为1234
passwd 1234
# 修改用户glieen的密码为1234
passwd glieen 1234
# 清除用户glieen的密码
passwd -d glieen
```
#### ping
测试主机网络连通性的工具。
常用参数：

```bash
-c # 指定测试连接的次数
```
示例：
```bash
# 发送10次测试连接到主机8.8.8.8
ping -n 10 8.8.8.8
```
#### poweroff
关闭当前的Linux系统。
常用参数：

```bash
-f # 强制关机
```
示例：
```bash
# 强制关机
sudo poweroff -f
```
#### shutdown
执行Linux系统的关机命令。
常用参数：

```bash
-t # 设定关机之前的延迟时间，单位为秒
-f # 强制关机
-r # 关机之后重启系统
```
示例：
```bash
# 立即关机
shutdown -t now
# 一分钟之后关机
shutdown -t 60
# 重启Linux操作系统，等价于reboot
shutdown -r
```
#### reboot
重启Linux系统。
常用参数：

```bash
-f # 强制重启
```
示例：
```bash
# 强制重启Linux操作系统
reboot -f
```
#### scp
在远程主机和本机之间进行文件复制，将源文件复制到目标位置。
常用参数：

```bash
-r # 递归复制子文件夹下的文件
```
示例：
```bash
# 将主机192.168.1.3上glieen用户家目录下的文件夹test复制到当前目录，需要输入glieen用户的密码
scp -r glieen@192.168.1.3:~/test/ .
```
#### ssh
SHELL客户端远程连接工具，可以远程登录Linux主机。
常用参数：

```bash
-p # 指定端口号
```
示例：
```bash
# 使用端口2333以用户glieen登录远程主机192.168.1.3，需要输入glieen用户的密码
ssh glieen@192.168.1.3 -p 2333
```
#### unzip
用于解压缩zip命令压缩的压缩文件。
常用参数：
```bash
-v # 执行时显示详细信息
-o # 覆盖已有文件
-d # 指定解压缩后的存放目录
-P # 解压缩密码
-l # 查看压缩包内的文件内容而不解压缩
```
示例：
```bash
# 解压缩test.zip压缩包到家目录下
unzip -v test.zip -d ~
# 查看test.zip压缩包内的文件
unzip -l test.zip
```
#### ifconfig
配置和查看Linux系统中的网络配置。
常用参数：
```bash
-a # 查看所有已配置的网络接口
```
示例：
```bash
# 查看所有已配置的网络接口
ifconfig -a
```
#### fdisk
查看磁盘的使用情况和磁盘分区。
常用参数：

```bash
-l # 查看所有磁盘及分区情况
```
示例：
```bash
# 查看所有磁盘及分区情况
fdisk -l
# 对磁盘/dev/sda进行交互式分区操作
fdisk /dev/sda
```