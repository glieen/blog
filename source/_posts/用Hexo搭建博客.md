---
title: 用Hexo搭建博客
tags:
  - Hexo
  - Blog
categories: Hexo
comments: true
abbrlink: 23632
date: 2018-08-21 15:43:27
---

作为一个开发者，拥有一个自己的博客来记录和分享自己的技术心得是非常有必要的，最近花了一些时间搭建了这个博客，做了一点简单的工作，在这篇文章中我会将博客的搭建过程完整的记录下来，算是一个总结，也可以帮助更多的人搭建属于自己的博客。

<!--more-->

### Hexo

Hexo是一款基于Node.js的静态博客框架，易于安装与部署，可以快速的搭建一个个人博客，并且可以托管在Github上，是搭建博客的不二之选。Hexo有自己的官方网站和文档 ([hexo.io](https://hexo.io))，可以了解到它的更多细节，同时它也是Github上的一个开源项目，参见：[Github/Hexo](https://github.com/hexojs/hexo)，Hexo同时拥有众多的主题和插件，博主可以为自己的博客定义非常多个性的元素。

![23632-1.jpg](https://i.loli.net/2020/02/19/YT2VnQdOgCkfWiI.jpg)

### Node.js

Hexo是基于Node.js的，所以需要安装Node.js，可以在官网下载到Node.js，下载地址：[Node.js](https://nodejs.org/zh-cn/download/)

![23632-2.jpg](https://i.loli.net/2020/02/19/nvxB8zcRZfhqV4G.jpg)

注意安装Node.js的时候要配置好环境变量以及NPM，安装完成之后在命令行输入： `node -v`和`npm -v`，能正确显示它们的版本号即成功了。

![23632-3.jpg](https://i.loli.net/2020/02/19/bMGxo1LvUYh5fgi.jpg)

### Git

因为会用到Github上的一些开源项目，博客系统也要托管到Github上，所以需要安装上Git用来做项目的同步，Git也可以去官网下载，下载地址：[Git](https://git-scm.com/download)

![23632-4.jpg](https://i.loli.net/2020/02/19/E9KWgyBZOPFlfXw.jpg)

Git安装完成之后，右键菜单会多出bash终端的选项

![23632-5.jpg](https://i.loli.net/2020/02/19/6JPHQLubjrcDA5O.jpg)

进入终端输入：`git --version`，正确显示git 的版本号即安装成功

![23632-6.jpg](https://i.loli.net/2020/02/19/EYivdTXLWz9VB5j.jpg)

### 安装Hexo

环境安装配置好之后，就可以开始安装Hexo了，安装过程非常简单。在资源管理器中右键，打开bash终端，创建文件夹，并定位到文件夹位置。

![23632-7.jpg](https://i.loli.net/2020/02/19/7HpVZcEukPNtfR5.jpg)



运行`npm install -g hexo-cli`安装Hexo脚手架

![23632-8.jpg](https://i.loli.net/2020/02/19/OIehiZsKpuCvWFL.jpg)

运行`hexo init`初始化Hexo框架

![23632-9.jpg](https://i.loli.net/2020/02/19/5hKSJlIcgj8EQPG.jpg)

到这里Hexo的安装已经完成了

### 启动Hexo

安装完成之后，接下来介绍几个简单的命令，用以编辑和启动Hexo。

```bash
#编译博客
hexo g
#启动Hexo(-i绑定IP，-p绑定端口)
hexo s [-i] [-p]
#清理编译文件
hexo clean
#新建文章
hexo new [post] "postName"
```

![23632-10.jpg](https://i.loli.net/2020/02/19/Etfq64ZGJL52OMX.jpg)

Hexo启动成功即可访问Hexo绑定的IP和端口查看博客了，默认的URL是：[http://localhost:4000](http://localhost:4000)

![23632-11.jpg](https://i.loli.net/2020/02/19/37iZ5BvLzbCmpqu.jpg)

访问到如图所示页面即表示Hexo已成功部署并启动了。

### Hexo文件结构

用资源管理器打开博客目录，查看文件结构

![23632-12.jpg](https://i.loli.net/2020/02/19/Dri4avWX5KQ92SY.jpg)



```bash
#简单介绍下目录构成
public：博客的发布文件，最终生成的文件
scaffolds：创建文章的模板，可以自定义创建格式
source：文章的源代码文件，markdown文件
themes：Hexo的主题目录
_config.yml：Hexo的主配置文件
#每个主题里面也有一个_config.yml，我们称之为主题配置文件，之后会讲到
```

### 发表文章

```bash
#发表新文章
hexo new [post] "postName"
```

![23632-13.jpg](https://i.loli.net/2020/02/19/rKdoOzIJGsjvWV7.jpg)

Hexo的文章编写是基于Markdown语法的，Markdown不过多介绍，想了解更多Markdown的知识，前往[维基百科-Markdown](https://zh.wikipedia.org/wiki/Markdown)。这里介绍一款非常好用的Markdown编辑器：[Typora](https://typora.io/)，可以前往官网下载，支持多平台运行，实时预览。用Typora打开刚刚新建的md文件，即可对文章进行编辑操作。

![23632-14.jpg](https://i.loli.net/2020/02/19/Amsjtzg83NvkZVf.jpg)

编辑完成之后重新编译并启动Hexo即可查看刚发布的文章了。

![23632-15.jpg](https://i.loli.net/2020/02/19/tIav4KzgyqjskLP.jpg)

### 部署到Github

安装 [hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)。

```bash
$ npm install hexo-deployer-git --save
```

修改配置。

```bash
deploy:
  type: git
  repo: <repository url>
  branch: [branch]
  message: [message]
```

| 参数      | 描述                                                         |
| --------- | ------------------------------------------------------------ |
| `repo`    | 库（Repository）地址                                         |
| `branch`  | 分支名称。如果您使用的是 GitHub 或 GitCafe 的话，程序会尝试自动检测。 |
| `message` | 自定义提交信息                                               |

配置完成之后运行命令`hexo d`即可进行部署。

### 更换主题

Hexo默认的主题并不美观，得益于Hexo庞大的主题库，我们可以使用自己喜欢的主题样式，并添加自定义的一些功能，这里我选用的是[NexT](https://theme-next.iissnan.com/)，这套主题简洁明了，非常不错。

**获取主题：**在终端窗口下，定位到 Hexo 站点目录下。使用 `Git` checkout 代码：

```bash
$ git clone https://github.com/iissnan/hexo-theme-next themes/next
```

**使用主题：**与所有 Hexo 主题启用的模式一样。 当 克隆/下载 完成后，打开 站点配置文件， 找到 `theme` 字段，并将其值更改为 `next`。

启用 NexT 主题

```xml
theme: next
```

到此，NexT 主题安装完成。下一步我们将验证主题是否正确启用。在切换主题之后、验证之前， 我们最好使用 `hexo clean` 来清除 Hexo 的缓存。编译并启动Hexo即可看到应用主题后的样式。

![23632-16.jpg](https://i.loli.net/2020/02/19/viMnT73XKdrA8OG.jpg)

更多详细的主题配置请参阅NexT的官方文档：[主题配置](https://theme-next.iissnan.com/theme-settings.html)

### 总结

Hexo的简单搭建部署就是这样，其他更多的一些设置会在之后的文章中补充。
