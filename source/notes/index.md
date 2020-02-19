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

