
class PjaxController < ApplicationController

  include NokogiriHelper

  set :views, ['pjax','application']

  def dispatch(action,options={})
    super(PjaxController,action)
    method(action).call
  end

  #首页
  def index_page

    @page_title = '首页'

    #p WebNews.all.count

    #p WebPicdisplay.all.count

    @pics = WebPicdisplay.order(Sequel.desc(:nid)).limit(3).all

    @tongzhi = WebNews.where(nid: 25, nshenhe: 1).order(Sequel.desc(:ntop)).order_append(Sequel.desc(:nid_news)).limit(7)

    @news = WebNews.where(nid: 26, nshenhe: 1).order(Sequel.desc(:ntop)).order_append(Sequel.desc(:nid_news)).limit(7)

    @qing_gonggao = fetch_qing_gonggao

    @qing_news = fetch_qing_news

    halt_page(:index_page)
  end

  #赛事交通
  def ssjt_page 

    halt_page(:ssjt_page)
  end

  #大会文件
  def dhwj_page
    @list = []
    dir = "#{Sinarey.root}/public/dahuiwenjian/"
    files = Dir.new(dir).to_a[2..-1]

    @count = files.size
    @page = (tmp = params[:page].to_i) > 0 ? tmp : 1
    @per_page = 50

    files = files[(@page-1)*@per_page,@per_page]
    files.each do |filename|
      atime = File.atime(dir+filename).strftime("%Y-%m-%d")
      @list << {filename: filename, atime:atime}
    end

    halt_page(:dhwj_page)
  end

  #下载中心
  def xzzx_page 

    @list = []
    dir = "#{Sinarey.root}/public/download/"
    files = Dir.new(dir).to_a[2..-1]

    @count = files.size
    @page = (tmp = params[:page].to_i) > 0 ? tmp : 1
    @per_page = 50

    files = files[(@page-1)*@per_page,@per_page]
    files.each do |filename|
      atime = File.atime(dir+filename).strftime("%Y-%m-%d")
      @list << {filename: filename, atime:atime}
    end

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

    @news_pagination = WebNews.where(nid: 26, nshenhe: 1).order(Sequel.desc(:ntop)).order_append(Sequel.desc(:nid_news)).paginate(params_page, 20)

    @news = @news_pagination.all

    halt_page(:ssxw_page)
  end

  #赛事新闻-详细
  def ssxw_detail_page

    @news = WebNews.where(nid: 26, nshenhe: 1, nid_news: params[:id]).first
    halt_404 if @news.nil?

    @content = db_content(@news.ccontent)

    halt_page(:ssxw_detail_page)
  end

  #市运题外话
  def sstwh_page 

    halt_page(:sstwh_page)
  end

  #通知公告
  def tzgg_page 

    @tongzhi_pagination = WebNews.where(nid: 25, nshenhe: 1).order(Sequel.desc(:ntop)).order_append(Sequel.desc(:nid_news)).paginate(params_page, 20)

    @tongzhi = @tongzhi_pagination.all

    halt_page(:tzgg_page)
  end

  #通知公告-详细
  def tzgg_detail_page
    @news = WebNews.where(nid: 25, nshenhe: 1, nid_news: params[:id]).first
    halt_404 if @news.nil?

    @content = db_content(@news.ccontent)

    halt_page(:tzgg_detail_page)
  end

  #组委会
  def zwh_page 

    halt_page(:zwh_page)
  end




end
