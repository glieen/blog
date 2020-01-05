# 我的个人博客:[Glieen's Blog](https://glieen.cn)

### 初始化Hexo

```bash
$ hexo init HexoBlog
```

### 拉取配置文件

```bash
$ git clone https://github.com/glieen/HexoBlog.git
```

### 安装NexT主题

参考地址：[Github:hexo-theme-next](https://github.com/theme-next/hexo-theme-next)

```bash
$ cd HexoBlog
$ git clone https://github.com/theme-next/hexo-theme-next themes/next
```

### 安装文章搜索插件

参考地址：[Github:hexo-generator-searchdb](https://github.com/theme-next/hexo-generator-searchdb)

```bash
$ npm install hexo-generator-searchdb --save
```

### 安装音乐播放器插件（可选）

参考地址：[Github:hexo-tag-aplayer](https://github.com/MoePlayer/hexo-tag-aplayer)

```bash
$ npm install --save hexo-tag-aplayer
```

### 安装Github自动部署插件

参考地址：[Github:hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)

```bash
$ npm install hexo-deployer-git --save
```

### 文章置顶插件

参考地址：[Github:hexo-generator-index-pin-top](https://github.com/netcan/hexo-generator-index-pin-top)

```bash
$ npm uninstall hexo-generator-index --save
$ npm install hexo-generator-index-pin-top --save
```

### 导入背景变幻线依赖文件

参考地址：[Github:theme-next-canvas-nest](https://github.com/theme-next/theme-next-canvas-nest)

```bash
$ cd themes/next
$ git clone https://github.com/theme-next/theme-next-canvas-nest source/lib/canvas-nest
```

### 博客搭建步骤

1. 新建文件夹，初始化Hexo博客
2. 根据以上方法安装主题及插件
3. 新建文件夹，拉取配置文件，将所有配置文件覆盖到步骤1的Hexo文件夹下
4. 编写文章并将文章编译部署到Github
5. 定期提交修改后的文件和源码

### Hexo简单命令

|            命令            |             动作             |
| :------------------------: | :--------------------------: |
|      hexo init [path]      |        初始化hexo目录        |
| hexo new [post] "postName" |           新建文章           |
|           hexo g           |         编译markdown         |
|           hexo s           |  启动hexo，默认端口号为4000  |
|         hexo clean         |         清理编译文件         |
|           hexo d           | 部署编译后的静态文件到Github |

