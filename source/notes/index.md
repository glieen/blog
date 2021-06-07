---
title: 笔记
comments: false
---

### 清除Windows Defender历史记录

删除`C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service`下的文件即可。

### Linux批量重命名

Ubuntu下安装rename工具

```bash
sudo apt install rename
```

使用正则表达式批量重命名文件，具体使用规则参照下方语句。

```bash
# 将当前目录下所有文件名中的a替换为b
rename 's/a/b/' *
# 将当前目录下所有以.log结尾的文件开头添加test
rename 's/^/test/' *.log
# 在当前目录下所有文件名后添加.txt
rename 's/$/.txt/' *
# 将当前目录下所有文件名中的test移除
rename 's/test//' *
```

### AUTO_INCREMENT

在MySQL中，AUTO_INCREMENT列只允许存在一列，且必须被索引（不一定是主键）。用UPDATE更新自增列时，修改值大于已有值，如果使用的是MyISAM，会改变自增的开始值，下次INSERT会从修改的最大值开始自增，如果使用的是InnoDB，不会改变自增的开始值，当插入到更改的该值时会出错。

### MyBatis/MyBatis Plus

使用MyBatis插入对象到数据库时，如果主键是由数据库生成，当插入完成时会将主键回写到对象中。

MyBatis查询时，如果是查询单个值为空，则返回null，如果是查询列表为空，则返回空集合。

MyBatis Plus分页查询，Mapper第一个入参为IPage，返回值为IPage，且SQL末尾不能加分号。

MyBatis Plus自定义查询条件时，入参传入Wrapper接口实现类，且在SQL末尾加上`${ew.customSqlSegment}`就可以实现。

MyBatis指定Mapper返回类型为Map时，添加泛型并不会生效，比如用`Map<String,String>`作为返回值，返回的数据中有Date时，类型依旧是时间类型，而不会转成String。

### Windows时间显示到秒

打开注册表编辑器，定位到

`计算机\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`

在右边新建一个DWORD(32位)值，命名为`ShowSecondsInSystemClock`，赋值为`1`，然后重启资源管理器就可以了。

### Windows Redis压缩版服务安装

定位到Redis解压文件目录下，打开Windows命令行，执行命令`redis-server.exe --service-install redis.windows.conf`就可以将Redis注册到Windows服务，同时可以在服务管理中配置服务开机自启动。

### 配置Git代理

因为国情因素，拉取Github的代码总是很慢，需要通过配置代理来提高下载速度，我使用的是SSR，可以用以下方式配置。

```bash
# 全局代理配置
git config --global http.proxy 'http://127.0.0.1:1080'
git config --global https.proxy 'http://127.0.0.1:1080'

# 仅代理Github
git config --global http.https://github.com.proxy http://127.0.0.1:1080
git config --global https.https://github.com.proxy http://127.0.0.1:1080

# 取消代理
git config --global --unset http.proxy
```

### Windows10更新失败修复

以管理员身份打开命令行，先后执行以下两行命令然后再进行系统更新。

```powershell
SFC -SCANNOW
DISM -Online -Cleanup-image -Restorehealth
```

#### Windows下Docker挂载目录

Docker挂载Windows下的目录要使用绝对路径，并且根目录要设置为`//`，如 ：`docker run -d -v //e/temp:/root/temp nginx`

