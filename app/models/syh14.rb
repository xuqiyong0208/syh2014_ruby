
#首页轮播图
class WebPicdisplay < Sequel::Model
  set_dataset :web_picdisplay
end

#新闻
#nid  25:通知公告 26:网站新闻 青运会相关的新闻直接跳转到对应的链接
class WebNews < Sequel::Model
  set_dataset :web_news
end




