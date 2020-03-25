#!/bin/bash
if !(command -v git >/dev/null 2>&1)
then
  echo 'git not exists,please install git'
  exit 0
fi
if !(command -v npm >/dev/null 2>&1)
then
  echo 'npm not exists,please install npm'
  exit 0
fi
echo 'Hexo install begin'
sudo npm install -g hexo-cli
rm -rf source HexoBlog
git clone -b source https://github.com/glieen/HexoBlog.git source
hexo init HexoBlog
rm -f HexoBlog/source/_posts/hello-world.md
git clone https://github.com/theme-next/hexo-theme-next HexoBlog/themes/next
cp -rTf source HexoBlog
rm -rf source
cd HexoBlog
npm install hexo-generator-searchdb --save
npm install hexo-abbrlink --save
npm install hexo-generator-feed --save
npm install hexo-deployer-git --save
npm install hexo-symbols-count-time --save
npm uninstall hexo-generator-index --save
npm install hexo-generator-index-pin-top --save
git clone https://github.com/theme-next/theme-next-canvas-nest themes/next/source/lib/canvas-nest
echo 'Hexo install complete'
