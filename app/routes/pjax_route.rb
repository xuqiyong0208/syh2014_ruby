
class PjaxRoute < PjaxController

  error do halt_500 end

  route :get, '/' do dispatch(:index_page) end    #首页

  route :get, '/api/get_qing_data_json' do dispatch(:qing_data_json) end #青训新闻 ajax

  route :get, '/dhwj' do dispatch(:dhwj_page) end   #大会文件

  route :get, '/ssjt' do dispatch(:ssjt_page) end   #赛事交通

  route :get, '/xzzx' do dispatch(:xzzx_page) end   #下载中心

  route :get, '/dxcj' do dispatch(:dxcj_page) end   #单项成绩-选择项目

  route :get, '/dxcj/:id' do dispatch(:dxcj_detail_page) end   #单项成绩-比赛列表

  route :get, '/dxcj/:id/:imkey' do dispatch(:dxcj_score_page) end   #单场比赛详细结果

  route :get, '/ccjl' do dispatch(:ccjl_page) end   #超创记录

  route :get, '/dpdf' do dispatch(:dpdf_page) end   #带牌带分

  route :get, '/phb' do dispatch(:phb_bsjp_page) end #排行榜-比赛奖牌

  route :get, '/phb/bsjp' do dispatch(:phb_bsjp_page) end #排行榜-比赛奖牌  

  route :get, '/phb/bsjp/sublist_json' do dispatch(:phb_bsjp_sublist_json) end #排行榜-比赛奖牌-各个项目细节

  route :get, '/phb/bszf' do dispatch(:phb_bszf_page) end #排行榜-比赛总分  

  route :get, '/phb/bszf/sublist_json' do dispatch(:phb_bszf_sublist_json) end #排行榜-比赛总分-各个项目细节 

  
  route :get, '/phb/dxjp' do dispatch(:phb_dxjp_page) end #排行榜-单项奖牌  

  route :get, '/phb/dxjp/:id' do dispatch(:phb_dxjp_detail_page) end #排行榜-单项奖牌-详情s

  route :get, '/phb/dxzf' do dispatch(:phb_dxzf_page) end #排行榜-单项总分    

  route :get, '/phb/dxzf/:id' do dispatch(:phb_dxzf_detail_page) end #排行榜-单项总分-详情

  route :get, '/phb/zdxmjp' do dispatch(:phb_zdxmjp_page) end #排行榜-重点项目奖牌

  route :get, '/phb/zdxmjp/sublist_json' do dispatch(:phb_zdxmjp_sublist_json) end #排行榜-重点项目奖牌-各个项目细节 

  route :get, '/phb/zdxmzf' do dispatch(:phb_zdxmzf_page) end #排行榜-重点项目总分  

  route :get, '/phb/zdxmzf/sublist_json' do dispatch(:phb_zdxmzf_sublist_json) end #排行榜-重点项目总分-各个项目细节 
  
  route :get, '/jsgc' do dispatch(:jsgc_page) end   #竞赛规程

  route :get, '/jsgc/:id' do dispatch(:jsgc_detail_page) end   #竞赛规程-详细

  route :get, '/jsrc' do dispatch(:jsrc_page) end   #竞赛日程

  route :get, '/qxsd' do dispatch(:qxsd_page) end   #青训速递

  route :get, '/ssxw' do dispatch(:ssxw_page) end   #赛事新闻

  route :get, '/ssxw/:id' do dispatch(:ssxw_detail_page) end   #赛事新闻-详细

  route :get, '/sstwh' do dispatch(:sstwh_page) end   #市运题外话

  route :get, '/tzgg' do dispatch(:tzgg_page) end   #通知公告

  route :get, '/tzgg/:id' do dispatch(:tzgg_detail_page) end   #通知公告-详细

  route :get, '/zwh' do dispatch(:zwh_page) end #组委会

end
