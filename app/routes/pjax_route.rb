
class PjaxRoute < PjaxController

  error do halt_500 end

  route :get, '/' do dispatch(:index_page) end    #首页

  route :get, '/dhwj' do dispatch(:dhwj_page) end   #大会文件

  route :get, '/ssjt' do dispatch(:ssjt_page) end   #赛事交通

  route :get, '/xzzx' do dispatch(:xzzx_page) end   #下载中心

  route :get, '/ccjl' do dispatch(:ccjl_page) end   #超创记录

  route :get, '/dpdf' do dispatch(:dpdf_page) end   #带牌带分

  route :get, '/jsgc' do dispatch(:jsgc_page) end   #竞赛规程

  route :get, '/jsgc/:id' do dispatch(:jsgc_detail_page) end   #竞赛规程-详细

  route :get, '/jsrc' do dispatch(:jsrc_page) end   #竞赛日程

  route :get, '/qxsd' do dispatch(:qxsd_page) end   #青训速递

  route :get, '/ssxw' do dispatch(:ssxw_page) end   #赛事新闻

  route :get, '/sstwh' do dispatch(:sstwh_page) end   #市运题外话

  route :get, '/tzgg' do dispatch(:tzgg_page) end   #通知公告

  route :get, '/zwh' do dispatch(:zwh_page) end #组委会

end
