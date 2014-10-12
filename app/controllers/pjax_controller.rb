
class PjaxController < ApplicationController

  set :views, ['pjax','application']

  def dispatch(action,options={})
    super(PjaxController,action)
    method(action).call
  end

  def index_page

    @page_title = '首页'

    #p WebNews.all.count

    #p WebPicdisplay.all.count

    @pics = WebPicdisplay.order(Sequel.desc(:nid)).limit(3).all

    @tongzhi = WebNews.where(nid: 25, nshenhe: 1).order(Sequel.desc(:ntop)).order_append(Sequel.desc(:nid_news)).limit(7)

    @news = WebNews.where(nid: 26, nshenhe: 1).order(Sequel.desc(:ntop)).order_append(Sequel.desc(:nid_news)).limit(7)

    @news.each do |news|
      puts "#{news.ctitle.inspect} | #{news.cauthor} | #{news.nid_news}"
      #nid_news ctitle cauthor content
      puts "----------------------------"
    end

    halt_page(:index_page)
  end

  #大会文件
  def dhwj_page 

    halt_page(:dhwj_page)
  end

  #赛事交通
  def ssjt_page 

    halt_page(:ssjt_page)
  end

  #下载中心
  def xzzx_page 

    halt_page(:xzzx_page)
  end

  #超创记录
  def ccjl_page 

    halt_page(:ccjl_page)
  end

  #带牌带分
  def dpdf_page 

    halt_page(:dpdf_page)
  end

  #竞赛规程
  def jsgc_page 

    halt_page(:jsgc_page)
  end

  #竞赛规程
  def jsgc_detail_page 

    halt_page(:jsgc_detail_page)
  end

  #竞赛日程
  def jsrc_page 

    halt_page(:jsrc_page)
  end

  #青训速递
  def qxsd_page 

    halt_page(:qxsd_page)
  end

  #赛事新闻
  def ssxw_page 

    halt_page(:ssxw_page)
  end

  #市运题外话
  def sstwh_page 

    halt_page(:sstwh_page)
  end

  #通知公告
  def tzgg_page 

    halt_page(:tzgg_page)
  end

  #组委会
  def zwh_page 

    halt_page(:zwh_page)
  end




end
