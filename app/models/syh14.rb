
#首页轮播图
class WebPicdisplay < Sequel::Model
  set_dataset :web_picdisplay
end

#新闻
#nid  25:通知公告 26:网站新闻 青运会相关的新闻直接跳转到对应的链接
class WebNews < Sequel::Model
  set_dataset :web_news
end

#比赛列表 
#上海市第15届运动会 zhkey = 3
class WebProjectSchedule < Sequel::Model
  set_dataset "比赛列表".to_sym
end

#青少年单项总分(总奖牌)
class WebQingJP < Sequel::Model
  set_dataset "青少年单项总奖牌".to_sym
end

#十项系列赛比赛项目
class BiSaiXiangMu < Sequel::Model
  set_dataset :bisaixiangmu

  #获取十项赛总总分奖牌的项目列表
  #"select xmmc,bh1 from dbo.bisaixiangmu where bh1>0 order by bh1 ASC"
end

#十项系列赛总分榜
class XiLieSaiZF < Sequel::Model
  set_dataset "系列赛总分榜".to_sym

  #获取奖牌榜
  #"select * from dbo.系列赛总分榜 order by zjp + zyp + ztp DESC, zjp DESC, zyp DESC, ztp DESC, jp01 DESC, jp02 DESC, jp03 DESC"  

  #获取总分榜
  #"select * from dbo.系列赛总分榜 order by zdf - koufen DESC, zdf DESC, df01 DESC, df02 DESC, df03 DESC, df04 DESC"

end

class ShiYunHuiZF < Sequel::Model
  set_dataset "市运会单位总分".to_sym

  #获取奖牌榜
  #"select * from dbo.市运会单位总分 order by zjp + zyp + ztp DESC, zjp desc, zyp desc, ztp desc"

  #获取总分榜
  #"select * from dbo.市运会单位总分 order by zdf desc"

end

class ShiYunHuiJP < Sequel::Model
  set_dataset "市运会奖牌".to_sym
end

class BiSaiXiangMuQingDan < Sequel::Model
  set_dataset "比赛项目清单".to_sym

  #比赛项目清单
  #"select dbo.比赛项目清单.*,dbo.web_uploadhtml.* from dbo.比赛项目清单 left join dbo.web_uploadhtml on dbo.比赛项目清单.imkey = dbo.web_uploadhtml.nkey where dhkey =".intval($id)." order by sex ASC, zubie ASC, itmc ASC "
end


class ShiTeShuJP < Sequel::Model
  set_dataset "市特殊奖牌".to_sym
end


class ShiTeShuDF < Sequel::Model
  set_dataset "市特殊得分".to_sym
end







