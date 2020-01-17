# 我的个人博客：[Glieen's Blog](https://glieen.cn)


### 拉取源文件

```bash
git clone -b source https://github.com/glieen/HexoBlog.git source
```
### 初始化Hexo

```bash
hexo init HexoBlog
# 删除默认文章
rm -f HexoBlog/source/_posts/hello-world.md
```

### 安装NexT主题

参考地址：[Github:hexo-theme-next](https://github.com/theme-next/hexo-theme-next)

```bash
git clone https://github.com/theme-next/hexo-theme-next HexoBlog/themes/next
# 覆盖配置文件
cp -rTf source HexoBlog
rm -rf source
cd HexoBlog
```
### 安装文章搜索插件

参考地址：[Github:hexo-generator-searchdb](https://github.com/theme-next/hexo-generator-searchdb)

```bash
npm install hexo-generator-searchdb --save
```

### 安装URL生成插件

参考地址：[Github:hexo-abbrlink](https://github.com/rozbo/hexo-abbrlink)

```bash
npm install hexo-abbrlink --save
```

### 安装Github自动部署插件

参考地址：[Github:hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)

```bash
npm install hexo-deployer-git --save
```

### 安装字数统计插件

参考地址：[Github:hexo-symbols-count-time](https://github.com/theme-next/hexo-symbols-count-time)

```bash
npm install hexo-symbols-count-time --save
```

### 文章置顶插件

参考地址：[Github:hexo-generator-index-pin-top](https://github.com/netcan/hexo-generator-index-pin-top)

```bash
npm uninstall hexo-generator-index --save
npm install hexo-generator-index-pin-top --save
```

### 导入背景变幻线依赖文件

参考地址：[Github:theme-next-canvas-nest](https://github.com/theme-next/theme-next-canvas-nest)

```bash
git clone https://github.com/theme-next/theme-next-canvas-nest themes/next/source/lib/canvas-nest
```
### 安装音乐播放器插件（可选）

参考地址：[Github:hexo-tag-aplayer](https://github.com/MoePlayer/hexo-tag-aplayer)

```bash
npm install hexo-tag-aplayer --save
```

### Hexo简单命令

|            命令            |             动作             |
| :------------------------: | :--------------------------: |
|      hexo init [path]      |        初始化hexo目录        |
| hexo new [post] "postName" |           新建文章           |
|           hexo g           |         编译markdown         |
|           hexo s           |  启动hexo，默认端口号为4000  |
|         hexo clean         |         清理编译文件         |
|           hexo d           | 部署编译后的静态文件到Github |

