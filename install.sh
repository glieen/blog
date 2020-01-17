#!/bin/bash
sudo npm install -g hexo-cli
echo 'Hexo install begin'
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
npm install hexo-deployer-git --save
npm install hexo-symbols-count-time --save
npm uninstall hexo-generator-index --save
npm install hexo-generator-index-pin-top --save
git clone https://github.com/theme-next/theme-next-canvas-nest themes/next/source/lib/canvas-nest
echo 'Hexo install complete'
