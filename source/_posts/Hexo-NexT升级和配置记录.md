---
title: Hexo-NexT升级和配置记录
tags: 
  - Hexo
  - Blog
comments: true
abbrlink: 7905
date: 2020-01-19 15:48:14
categories: Hexo
---
我的博客是2018年建立的，使用的Hexo和NexT主题，如今已经2020年了，想着过了这么久了，是时候将它们的版本升级一下了，在升级的时候顺便对博客内容做了一些整理和优化，遇到一些问题，记录一下。
<!--more-->

### 备份源文件

将文章的源文件进行安全的备份，防止意外导致内容的丢失。

### 升级Hexo

```bash
# 升级hexo脚手架
npm install hexo-cli -g
# 切换到博客项目的目录下，升级博客hexo版本
npm install 
```

### 升级Next主题

```bash
# 切换到博客目录下，删除旧版本的next主题
rm -rf themes/next
# 拉取最新版本的主题文件
git clone https://github.com/theme-next/hexo-theme-next themes/next
```

### 图床

博客之前使用的是微博图床，免费、高速而且还没有流量限制，但是因为最近微博开始反盗链，图片挂的严重，很难去一一排查图片的失效连接，索性趁着这次升级的机会，将图床直接做了更换，我换了质量还不错的[SM.MS](https://sm.ms/)图床，注册之后有免费的5G空间可以使用，图片大小限制5M，每分钟限制20张上传，每小时限制100张，我这种小博客用免费版本应该是绰绰有余了。

Github上有图片上传工具：[PicGo](https://molunerfinn.com/PicGo/)，支持主流的几个图床，使用SM.MS图床上传图片需要配置一个插件：[picgo-plugin-smms-user](https://github.com/xlzy520/picgo-plugin-smms-user)，具体的配置可以参看插件的使用介绍。

### Hexo配置

Hexo的配置文件为`_config.yml`，在博客的根目录下。

#### 文章地址

默认的文章地址是文章发布的日期加文章标题，这样的地址显得太冗长而且不利于标记，我发现一个比较好的文章地址生成插件，以不重复的随机数来作为文章ID去标记地址：[Github:hexo-abbrlink](https://github.com/rozbo/hexo-abbrlink)，使用该插件之后，编译时会在每篇文章的头部自动添加`abbrlink`属性来作为文章的标记。

```bash
# 安装hexo-abbrlink
npm install hexo-abbrlink --save
```

修改 `_config.yml`

```yml
permalink: posts/:abbrlink.html
abbrlink:
  alg: crc16
  rep: dec
```

#### 自动部署

文章编译之后可以发布到Github，这些操作需要自己去完成，其实有工具可以实现自动部署：[hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)。

```bash
# 安装hexo-deployer-git
npm install hexo-deployer-git --save
```

修改`_config.yml`，部署的方式有多种，最常用的是git，我的博客仓库有两个分支，一个master分支用来发布文章，存放编译后的文件，还有一个source分支，存放markdown源文件、图片和一些配置文件。`ignore_pattern`属性是配置忽略文件的，我将图片和部分二进制文件都做了忽略。

```yml
deploy:
  type: git
  repository: https://github.com/glieen/HexoBlog.git
  branch: master
  ignore_pattern:
    public: post-image|about-image|files
```

```bash
# 自动部署
hexo d
```

#### 404页面

Github配置404文件非常简单，只需要在source目录下创建`404.html`文件即可，404页面只对绑定的域名生效，本地测试是无法看到的，我使用的是腾讯的404页面，内容如下。

```html
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8;"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="robots" content="all"/>
    <meta name="robots" content="index,follow"/>
    <link rel="stylesheet" type="text/css" href="https://qzone.qq.com/gy/404/style/404style.css">
</head>
<body>
<script type="text/plain" src="https://www.qq.com/404/search_children.js"
        charset="utf-8" homePageUrl="/"
        homePageName="返回博客首页">
</script>
<script src="https://qzone.qq.com/gy/404/data.js" charset="utf-8"></script>
<script src="https://qzone.qq.com/gy/404/page.js" charset="utf-8"></script>
</body>
</html>
```

#### 文章置顶

默认的文章排序是以时间倒叙排列的，如果想置顶某文章需要依赖其他的第三方工具：[hexo-generator-index-pin-top](https://github.com/netcan/hexo-generator-index-pin-top)。

```bash
npm uninstall hexo-generator-index --save
npm install hexo-generator-index-pin-top --save
```

使用置顶功能时，在文章的头部增加`top: true`即可。

#### 编译忽略

修改`_config.yml`中的`skip_render`属性，将需要忽略的文件添加到规则中。

```yml
skip_render: [README.md,'*.html',CNAME]
```

### Next配置

Next的配置文件为`_config.yml`，在主题的根目录下，主题的配置项繁多，我并未全部使用，更具体的可以查看官方文档：[Next](https://theme-next.iissnan.com/)，主题的配置主要是修改配置文件中的各个属性。

#### 布局

Next内置4种内容布局，属性是`scheme`，默认使用的是`Muse`，我选择使用的是`Gemini`，将想要使用的布局前面的`#`去掉即可启用。

```yml
# Schemes
# scheme: Muse
#scheme: Mist
#scheme: Pisces
scheme: Gemini
```

#### 导航

导航在`menu`属性下，主题内置了几个导航，去掉注释就可以启用，可以自定义导肮，配置好路由和图标即可，路由可以是博客内的任一页面，也可以是外网的地址，图标使用的是`Font Awesome icon`。

```yml
menu:
  home: / || home
  categories: /categories/ || th
  tags: /tags/ || tags
  archives: /archives/ || archive
  notes: /notes/ || book
  favorites: /favorites/ || star
  comment: https://leancloud.cn/dashboard/ || comment
  about: /about/ || user
  #schedule: /schedule/ || calendar
  #sitemap: /sitemap.xml || sitemap
  #commonweal: /404/ || heartbeat
```

其中`favorite`和`comment`是我自定义的导航，`favorite`是博客内部我自己建立的收藏页面，`comment`是指向[LeanCloud](https://leancloud.cn/)的评论管理页面，自定义的导航无法显示中文名，需要修改中文配置文件，文件位于`languages/zh-CN.yml`，将新增的导航添加进去即可。

```yml
menu:
  notes: 笔记
  favorites: 收藏
  comment: 评论
```

#### 头像

设置自己头像的URL即可。

```yml
avatar:
  url: /images/avatar.jpg
```

#### 社交

配置与导航类似，配置好地址和图标即可，内置了几个，去掉注释就可以启用。

```yml
social:
  GitHub: https://github.com/glieen || github
  E-Mail: mailto:glieen1995@gmail.com || envelope
  #Weibo: https://weibo.com/yourname || weibo
  #Google: https://plus.google.com/yourname || google
  #Twitter: https://twitter.com/yourname || twitter
  #FB Page: https://www.facebook.com/yourname || facebook
  #StackOverflow: https://stackoverflow.com/yourname || stack-overflow
  #YouTube: https://youtube.com/yourname || youtube
  #Instagram: https://instagram.com/yourname || instagram
  #Skype: skype:yourname?call|chat || skype
  #RSS: /atom.xml || rss
```

#### 友链

```yml
links_settings:
  icon: link
  title: 友链
  layout: block
links:
  前端小站：YmTonny : https://ymtonny.cn/
  Zalmon's Blog : https://zalmon.cn/
```

#### RSS订阅

生成订阅文件，用于RSS订阅更新获取最新的文章发布信息，需要安装插件启用该功能：[hexo-generator-feed](https://github.com/hexojs/hexo-generator-feed)。

```bash
npm install hexo-generator-feed --save
```

将以下的配置信息加入到主题的配置文件当中：

```yml
feed:
  type: atom
  path: atom.xml
  limit: 20
  order_by: -date
  icon: icon.png
  autodiscovery: true
  template:
```

#### 字数统计

字数统计可以统计整站的字符数，每篇文章的字符数以及阅读时间，需要配合插件启用该功能：[hexo-symbols-count-time](https://github.com/theme-next/hexo-symbols-count-time)。

```bash
npm install hexo-symbols-count-time --save
```

```yml
symbols_count_time:
  separated_meta: true
  item_text_post: true
  item_text_total: false
  awl: 4
  wpm: 275
```

#### 阅读进度

```yml
reading_progress:
  enable: true
  # Available values: top | bottom
  position: top
  color: "#37c6c0"
  height: 3px
```

#### 文章评论

我使用的是`valine`评论系统，它是依托于[LeanCloud](https://www.leancloud.cn/)的无后端评论系统，可以实现匿名评论，评论数统计和浏览量统计，可以前往[Valine](https://valine.js.org/)了解更多关于该评论系统的内容，使用时只需将它启用，并配置好自己的`appid`和`appkey`即可。

```yml
valine:
  enable: true
  appid: APPID
  appkey: APPKEY
  notify: false # Mail notifier
  verify: false # Verification code
  placeholder: 支持Markdown语法 # Comment box placeholder
  avatar: identicon # Gravatar style
  guest_info: nick,mail # Custom comment header
  pageSize: 10 # Pagination size
  language: # Language, available values: en, zh-cn
  visitor: false # Article reading statistic
  comment_count: false # If false, comment count will only be displayed in post page, not in home page
  recordIP: true # Whether to record the commenter IP
  serverURLs: # When the custom domain name is enabled, fill it in here (it will be detected automatically by default, no need to fill in)
  #post_meta_order: 0
```

因为在最新版本的Next中采用了多评论系统的设计，在使用`valine`时，出现了一些问题，比如标题下的评论数无法显示中文，且点击评论数的锚点无法定位到评论框，这里需要去修改next中的源文件才能修复，找到并打开主题目录下的`scripts/filters/comment/valine.js`文件，做以下的修改。

```javascript
// 原内容
${iconText('comment-o', 'valine')}
<a title="valine" href="{{ url_for(post.path) }}#comments" itemprop="discussionUrl">

// 修改后的内容
${iconText('comment-o', 'valine','评论数')}
<a title="valine" href="#valine-comments" itemprop="discussionUrl">
```

修改文章头部的`comments`属性可以开关文章评论功能，`true`开启，`false`关闭。

#### 访问计数

Next内置多种访问计数方式，我使用的是不蒜子，直接启用即可。

```yml
busuanzi_count:
  enable: true
  total_visitors: false
  total_visitors_icon: user
  total_views: false
  total_views_icon: eye
  post_views: true
  post_views_icon: eye
```

#### 文章搜索

可以在Next中启用文章搜索功能，启用该功能需要安装文章内容搜索插件：[hexo-generator-searchdb](https://github.com/theme-next/hexo-generator-searchdb)

```bash
npm install hexo-generator-searchdb --save
```

修改主题配置文件`_config.yml`：

```yml
local_search:
  enable: true
  # If auto, trigger search by changing input.
  # If manual, trigger search by pressing enter key or search button.
  trigger: auto
  # Show top n results per article, show all results by setting to -1
  top_n_per_article: 1
  # Unescape html strings to the readable one.
  unescape: false
  # Preload the search data when the page loads.
  preload: true
```

修改Hexo配置文件`_config.yml`：

```yml
# Search
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

#### 背景变幻线

添加依赖库：[theme-next-canvas-nest](https://github.com/theme-next/theme-next-canvas-nest)，启用功能即可。

```bash
git clone https://github.com/theme-next/theme-next-canvas-nest themes/next/source/lib/canvas-nest
```

```yml
canvas_nest:
  enable: true
  onmobile: true # Display on mobile or not
  color: "0,0,255" # RGB values, use `,` to separate
  opacity: 0.5 # The opacity of line: 0~1
  zIndex: -1 # z-index property of the background
  count: 150 # The number of lines
```