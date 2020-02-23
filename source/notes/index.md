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

MyBatis Plus分页查询，Mapper第一个入参为IPage，返回值为IPage，且SQL末尾不能加分号。

MyBatis Plus自定义查询条件时，入参传入Wrapper接口实现类，且在SQL末尾加上`${ew.customSqlSegment}`就可以实现。

MyBatis指定Mapper返回类型为Map时，添加泛型并不会生效，比如用Map<String,String>作为返回值，返回的数据中有Date时，类型依旧是时间类型，而不会转成String。