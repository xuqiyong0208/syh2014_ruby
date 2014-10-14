
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

    #奖牌榜
    @jiangpais = DB.fetch("select TOP 4 * from dbo.系列赛总分榜 order by zjp + zyp + ztp DESC, zjp DESC, zyp DESC, ztp DESC")

    ttkeys = @jiangpais.map{|jiangpai| jiangpai[:ttkey] }

    #p ttkeys

    tmp_hsh = {}
    tmp_list = ShiYunHuiZF.where(ttkey: ttkeys)
    tmp_list.each do |jiangpai2|
      tmp_hsh[jiangpai2[:ttkey]] = jiangpai2
    end

    @jiangpais2 = []
    ttkeys.each do |ttkey|
      @jiangpais2 << tmp_hsh[ttkey]
    end

    #puts @jiangpais2

    #竞赛日程 本周
    @week = get_current_week
    @week_schedule = get_currnet_week_schedule(@week, 6)

    #p @week_schedule

    halt_page(:index_page)
  end

  #qing_data
  def qing_data_json
    qing_gonggao = fetch_qing_gonggao
    gonggao_html = render_to_string(partial: :_qing_list, locals: {news: qing_gonggao})

    qing_news = fetch_qing_news
    news_html = render_to_string(partial: :_qing_list, locals: {news: qing_news})

    halt_json({gonggao_html: gonggao_html, news_html: news_html})
  end

  #赛事交通
  def ssjt_page 

    halt_page(:ssjt_page)
  end

  #大会文件
  def dhwj_page
    @list = []
    dir = Settings.upload_root
    if File.directory?(dir)
      files = Dir.new(dir).to_a.sort[2..-1]
    else
      files = []
    end
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
    dir = Settings.upload_root
    if File.directory?(dir)
      files = Dir.new(dir).to_a.sort[2..-1]
    else
      files = []
    end
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
  def phb_page 

    @jiangpais = DB.fetch("select * from dbo.市运会单位总分 order by zdf desc")

    halt_page(:phb_page)
  end

  #竞赛规程
  def jsgc_page 

    @projects = WebProjectSchedule.where(zhkey: 3).all

    #puts @projects.size

    # @projects.each do |project|
    #   puts project.inspect
    # end

    halt_page(:jsgc_page)
  end

  #竞赛规程
  def jsgc_detail_page 
    dhkey = params[:id].to_i
    @project = WebProjectSchedule.where(zhkey: 3, dhkey: dhkey).first
    halt_404 if @project.nil?
    
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
    nid_news = params[:id].to_i
    @news = WebNews.where(nid: 26, nshenhe: 1, nid_news: nid_news).first
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
    nid_news = params[:id].to_i
    @news = WebNews.where(nid: 25, nshenhe: 1, nid_news: nid_news).first
    halt_404 if @news.nil?

    @content = db_content(@news.ccontent)

    halt_page(:tzgg_detail_page)
  end

  #组委会
  def zwh_page 

    halt_page(:zwh_page)
  end

  #单项成绩
  def dxcj_page

    @projects = WebProjectSchedule.where(zhkey: 3).all

    halt_page(:dxcj_page)
  end

  #单项成绩 - 比赛列表
  def dxcj_detail_page

    dhkey = params[:id].to_i
    @project = WebProjectSchedule.where(zhkey: 3, dhkey: dhkey).first
    halt_404 if @project.nil?

    @games = DB.fetch("select dbo.比赛项目清单.*,dbo.web_uploadhtml.* from dbo.比赛项目清单 left join dbo.web_uploadhtml on dbo.比赛项目清单.imkey = dbo.web_uploadhtml.nkey where dhkey = #{@project[:dhkey]} order by sex ASC, zubie ASC, itmc ASC ")

    # @games.each do |game|
    #   puts game.inspect
    #   break
    # end

    halt_page(:dxcj_detail_page)
  end

  #单项成绩 - 比赛成绩
  def dxcj_score_page

    dhkey = params[:id].to_i
    @project = WebProjectSchedule.where(zhkey: 3, dhkey: dhkey).first
    halt_404 if @project.nil?

    imkey = params[:imkey].to_i
    @game = DB.fetch("select dbo.比赛项目清单.*,dbo.web_uploadhtml.* from dbo.比赛项目清单 left join dbo.web_uploadhtml on dbo.比赛项目清单.imkey = dbo.web_uploadhtml.nkey where imkey = #{imkey} order by sex ASC, zubie ASC, itmc ASC ").first
    halt_404 if @game.nil?

    @records = DB.fetch("select * from dbo.比赛项目人员 where imkey = #{@game[:imkey]} and mingci > 0 order by mingci ASC, chengji DESC, dwjc ASC, tzmc ASC").to_a
    @records += DB.fetch("select * from dbo.比赛项目人员 where imkey = #{@game[:imkey]} and mingci = 0 order by  chengji DESC, dwjc ASC, tzmc ASC").to_a

    halt_page(:dxcj_score_page)
  end



end
