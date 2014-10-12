comforthouse2
=========

*thin*
> puma -C puma.production.rb -d

> pumactl -F puma.production.rb restart

> pumactl -F puma.production.rb restart


*静态文件优化+部署*

在assets目录下:

> node r.js -o build.js

TODOLIST

1. cookies安全性 DONE

2. server client 分离 rest api + backbone requirejs

3. sequel timestamps 插件 实际运行效果不符合预期 已解决，加上了update_on_create:true

4. 用 window.postMessage 实现 oauth2_callback的效果,实现跨域效果 DONE










