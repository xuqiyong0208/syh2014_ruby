
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
    jp_hash = {}

    jiangpais = DB.fetch("select * from dbo.市运会单位总分 order by zjp + zyp + ztp DESC, zjp DESC, zyp DESC, ztp DESC").to_a

    jiangpais.each do |p|
      jp_hash[p[:ttkey]] = {dwjc: p[:dwjc].to_s.strip, jp1: p[:zjp] + p[:zyp] + p[:ztp], jpj1: p[:zjp].to_i, jpy1: p[:zyp].to_i, jpt1: p[:ztp].to_i, df1: p[:zdf]}
    end

    ttkeys = jiangpais.map{|p| p[:ttkey] }

    jp_list = ShiTeShuJP.where(ttkey: ttkeys).all
    jp_list.each do |p|
      jp_hash[p[:ttkey]][:jp2] = p[:hjj] + p[:hjy] + p[:hjt]
      jp_hash[p[:ttkey]][:jpj2] = p[:hjj]
      jp_hash[p[:ttkey]][:jpy2] = p[:hjy]
      jp_hash[p[:ttkey]][:jpt2] = p[:hjt]
    end

    zf_list = ShiTeShuDF.where(ttkey: ttkeys).all
    zf_list.each do |p|
      jp_hash[p[:ttkey]][:df2] = p[:hjf]
    end

    @jiangpaibang = jp_hash.values

    #puts @jiangpaibang


    #拼出所有比分的hash，为之后排序使用
    
    #@jiangpais = DB.fetch("select * from dbo.市运会单位总分 order by zjp + zyp + ztp DESC, zjp DESC, zyp DESC, ztp DESC").to_a


    # @sts_zf = []
    # ttkeys.each do |ttkey|
    #   @sts_zf << nil #tmp_hsh[ttkey]
    # end

    #竞赛日程 本周
    #@week = get_current_week
    #@week_schedule = get_currnet_week_schedule(@week, 6)
    @week_schedule = []

    #p @week_schedule

    halt_page(:index_page)
  end

  #qing_data
  def qing_data_json
    qing_gonggao = fetch_qing_gonggao
    gonggao_html = render_to_string(partial: :_qing_list, locals: {news: qing_gonggao})

    qing_news = fetch_qing_news
    news_html = render_to_string(partial: :_qing_list, locals: {news: qing_news})

    tiwaihua = fetch_tiwaihua
    tiwaihua_html = render_to_string(partial: :_qing_list, locals: {news: tiwaihua})

    halt_json({gonggao_html: gonggao_html, news_html: news_html, tiwaihua_html: tiwaihua_html})
  end

  #赛事交通
  def ssjt_page 

    #整理项目和坐标
    data = {
    "游泳" => {"浦东游泳馆 浦东南路3669号" => [121.511549,31.194376]},
    "跳水" => {"东方体育中心跳水池 浦东新区泳耀路701号" => [121.487226,31.160831]},
    "水球" => {"东方体育中心室内游泳馆 浦东新区泳耀路701号" => [121.487226,31.160831]},
    "花样游泳" => {"东方体育中心室内游泳馆  浦东新区泳耀路701号" => [121.487226,31.160831]},
    "射箭" => {"奉贤区体育中心 奉贤区南桥镇古华路100号" => [121.474836,30.910933]},
    "田径" => {"闵行区体育场 莘东路540号" => [121.379706,31.12106], "市二体校田径场 莘东路589号" => [121.37851,31.121709]},
    "羽毛球" => {"徐汇区青少年体育运动学校 华泾路1190号" => [121.450366,31.124406]},
    "棒球" => {"闵行四中 景谷路9号" => [121.409311,31.019343], "闵行中学 江川东路950号" => [121.432243,31.013285]},
    "男子篮球" => {"徐汇区青少年体育运动学校 华泾路1190号" => [121.450366,31.124406], "南洋模范中学 零陵路453号" => []},
    "女子篮球" => {"向明中学篮球馆 浦锦路138号" => [121.506567,31.078991], "卢湾少体校篮球馆 建国西路135号" => [121.470252,31.212962]},
    "拳击" => {"朱桥学校 嘉定区嘉朱公路1851号" => [121.20058,31.415989]},
    "皮划艇/赛艇/帆船/帆板" => {"市水上运动中心 盈朱路289号" => [121.01635,31.118664]},
    "自行车" => {"市第二体育运动学校（场地赛） 莘东路589号" => [121.37851,31.121709], "崇明县公路（公路赛） 崇明县陈家镇" => [121.839144,31.532304]},
    "马术" => {"上海乐派特马术俱乐部 奉贤区奉城镇头桥社区蔡建路东首（近大叶路）" => [121.668232,30.983723]},
    "击剑" => {"松江体育馆 松江区九峰路2号" => [121.237181,31.020774]},
    "男子足球" => {"杨浦区白洋淀足球场 周家嘴路4214弄22号" => [121.558596,31.288034], "平凉路第四小学 平凉路2767号5弄" => [121.563854,31.284802]},
    "女子足球" => {"桃浦体育公园 金通路158号" => [121.349509,31.289369], "金沙江路小学 怒江路60号" => [121.405112,31.234555]},
    "高尔夫球" => {"上海太阳岛国际俱乐部 青浦区沈太路2855号" => [121.080996,31.042559]},
    "体操" => {"上海国际体操中心 武夷路777号" => [121.42008,31.219633]},
    "艺术体操" => {"上海市体操运动中心 百色路1333号" => [121.437654,31.148539]},
    "蹦床" => {"上海市体操运动中心 百色路1333号" => [121.437654,31.148539]},
    "男子手球" => {"同洲模范学校 共康东路188号" => [121.463805,31.328251], "红星小学 泗塘三村39号" => [121.462857,31.340989]},
    "女子手球" => {"上师大附中 桂林路120号" => [121.425469,31.169506], "徐教院附中 上中路10号  " => [121.423097,31.141168]},
    "曲棍球" => {"闵行区曲棍球场 莘东路540号" => [121.379977,31.121176]},
    "女子柔道" => {"闵行区体育馆 莘东路540号" => [121.379706,31.12106]},
    "男子柔道" => {"崇明县体育馆 崇明县城桥镇北门路88号" => [121.406949,31.632672]},
    "现代五项" => {"市体育运动学校 水电路176号" => [121.479433,31.279779]},
    "射击" => {"市射击射箭中心 金都路3028号" => [121.403301,31.089298]},
    "垒球" => {"闵行四中 景谷路9号" => [121.409311,31.019343], "闵行中学 江川东路950号" => [121.432243,31.013285]},
    "乒乓球" => {"上海曹艳华乒乓球培训学校 杨鑫路388号" => [121.446448,31.373722]},
    "跆拳道" => {"黄浦区体育馆 山东中路311号" => [121.490717,31.241788]},
    "网球" => {"超越网球俱乐部 古华路100号" => [121.474334,30.910731]},
    "男子排球" => {"上海市进才中学 杨高中路2788号" => [121.552911,31.233343], "上海市进才实验中学 金松路191弄" => [121.562477,31.231506]},
    "女子排球" => {"黄埔学校 大吉路218号" => [121.489772,31.219239], "格致中学  广西北路66号" => [121.486029,31.236585]},
    "沙滩排球" => {"金山城市沙滩  新城路5号" => [121.352023,30.711082]},
    "举重" => {"松江体育馆 松江区九峰路2号" => [121.237181,31.020774]},
    "国际式摔跤" => {"杨浦体育馆 隆昌路640号" => [121.546397,31.285874]},
    "武术（套路）" => {"闸北区体育馆 中华新路475号" => [121.472521,31.26011]},
    "武术（散打）" => {"静安体育馆 南阳路123号" => [121.458193,31.234478]},
    "冰壶" => {"松江冰壶馆 松江文翔路2000号" => [121.218822,31.054671]},
    "花样滑冰" => {"松江大学生体育馆 松江文翔路2000号" => [121.218822,31.054671]}
    }

    @data = {}

    data.each do |name,hsh|
      @data[name] = hsh.to_a
    end

    halt_page(:ssjt_page)
  end

  #大会文件
  def dhwj_page
    @list = []
    dir = "#{Sinarey.root}/public/dahuiwenjian"
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
      atime = File.atime(File.join(dir,filename)).strftime("%Y-%m-%d")
      @list << {filename: filename, atime:atime}
    end

    halt_page(:dhwj_page)
  end

  #下载中心
  def xzzx_page 

    @list = []
    dir = begin Settings.upload_root rescue '' end
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
      atime = File.atime(File.join(dir,filename)).strftime("%Y-%m-%d")
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

    @jiangpais = DB.fetch("select * from dbo.市运会单位总分 order by zdf desc").to_a

    halt_page(:dpdf_page)
  end

  #排行榜-比赛奖牌
  def phb_bsjp_page

    feilds = ['dwjc','zjp','zyp','ztp']

    @projects = DB.fetch("select xmmc, bh2 from dbo.bisaixiangmu where bh2 > 0 order by bh2").to_a

    @jiangpais = DB.fetch("select #{feilds.join(',')} from dbo.市运会奖牌 order by zjp desc, zyp desc, ztp desc, dwjc").to_a

    halt_page(:phb_bsjp_page)
  end

  #排行榜-比赛奖牌-所有项目的细节
  def phb_bsjp_sublist_json

    cache = AppCache[:phb_bsjp_sublist_json]
    if cache and cache[:timestamp] == Time.now.strftime("%Y-%m-%d")
      halt_json(cache[:json])
    else
      feilds = ['dwjc']

      projects = []
      db_results = DB.fetch("select xmmc, bh2 from dbo.bisaixiangmu where bh2 > 0 order by bh2").to_a
      db_results.each do |project|
        projects << {xmmc: project[:xmmc].to_s.strip, bh2:project[:bh2]}
      end

      result = {}
      projects.each do |project|
        bh2 = project[:bh2]
        if bh2
          tail = bh2.to_s.rjust(2,'0')
          subfields = feilds + ["jp#{tail}","yp#{tail}","tp#{tail}"]
          jiangpais = DB.fetch("select #{subfields.join(',')} from dbo.市运会奖牌 order by zjp desc, zyp desc, ztp desc, dwjc").to_a
          jiangpais.each_with_index do |jiangpai,index|
            result["p#{bh2}r#{index}"] = {zjp:jiangpai["jp#{tail}".to_sym], zyp:jiangpai["yp#{tail}".to_sym], ztp:jiangpai["tp#{tail}".to_sym]}
          end
        end
      end
      AppCache[:phb_bsjp_sublist_json] = {timestamp: Time.now.strftime("%Y-%m-%d"), json: result}
      halt_json(result)
    end
  end

  #排行榜-比赛总分
  def phb_bszf_page

    feilds = ['dwjc','zdf']

    @projects = DB.fetch("select xmmc, bh2 from dbo.bisaixiangmu where bh2 > 0 order by bh2").to_a

    @jiangpais = DB.fetch("select #{feilds.join(',')} from dbo.市运会总分 order by zdf desc, dwjc").to_a

    halt_page(:phb_bszf_page)
  end

  #排行榜-比赛总分-所有项目的细节
  def phb_bszf_sublist_json

    cache = AppCache[:phb_bszf_sublist_json]
    if cache and cache[:timestamp] == Time.now.strftime("%Y-%m-%d")
      halt_json(cache[:json])
    else
      feilds = ['dwjc']

      projects = []
      db_results = DB.fetch("select xmmc, bh2 from dbo.bisaixiangmu where bh2 > 0 order by bh2").to_a
      db_results.each do |project|
        projects << {xmmc: project[:xmmc].to_s.strip, bh2:project[:bh2]}
      end

      result = {}
      projects.each do |project|
        xmmc,bh2 = project[:xmmc],project[:bh2]
        if xmmc && bh2
          tail = bh2.to_s.rjust(2,'0')
          subfields = feilds + ["df#{tail}"]
          jiangpais = DB.fetch("select #{subfields.join(',')} from dbo.市运会总分 order by zdf desc, dwjc").to_a
          jiangpais.each_with_index do |jiangpai,index|
            result["p#{bh2}r#{index}"] = {zdf:jiangpai["df#{tail}".to_sym]}
          end
        end
      end
      AppCache[:phb_bszf_sublist_json] = {timestamp: Time.now.strftime("%Y-%m-%d"), json: result}
      halt_json(result)
    end
  end

  #排行榜-单项奖牌
  def phb_dxjp_page

    @projects = WebProjectSchedule.where(zhkey: 3).all

    halt_page(:phb_dxjp_page)
  end

  #排行榜-单项奖牌-详情
  def phb_dxjp_detail_page

    dhkey = params[:id].to_i
    @project = WebProjectSchedule.where(zhkey: 3, dhkey: dhkey).first
    halt_404 if @project.nil?

    @zubie = params[:zubie].to_s
    if @zubie.present?
      case @zubie
      when '汇总'
        @score = DB.fetch("select sum(jpshu) hjjp, sum(ypshu) hjyp, sum(tpshu) hjtp, min(dwjc) dwjc FROM dbo.syh_danxingtongji where dhkey = #{@project[:dhkey]} group by dwjc order by hjjp desc, hjyp desc, hjtp desc").to_a
      else
        @score = DB.fetch("select sum(jpshu) hjjp, sum(ypshu) hjyp, sum(tpshu) hjtp, min(dwjc) dwjc FROM dbo.syh_danxingtongji where dhkey = #{@project[:dhkey]} and zubie = #{DB.literal(@zubie)} group by dwjc order by hjjp desc, hjyp desc, hjtp desc").to_a
      end
      halt_page(:phb_dxjp_detail_page)
    else
      #选择分组
      @zubies = DB.fetch("select zubie from syh_zubie where dhkey = #{@project[:dhkey]} order by zubie").to_a
      halt_page(:phb_dxjp_group_page)
    end
  end

  #排行榜-单项总分
  def phb_dxzf_page

    @projects = WebProjectSchedule.where(zhkey: 3).all

    halt_page(:phb_dxzf_page)
  end

  #排行榜-单项总分-详情
  def phb_dxzf_detail_page

    dhkey = params[:id].to_i
    @project = WebProjectSchedule.where(zhkey: 3, dhkey: dhkey).first
    halt_404 if @project.nil?

    @zubie = params[:zubie].to_s
    if @zubie.present?

      columns = ['dwjc', 'sum(hjdf) mcSum', 'min(dwjc) dwjc']
      (1..9).each do |i|
        columns << "sum(mc#{i}) mc#{i}"
      end

      case @zubie
      when '汇总'
        @score = DB.fetch("select #{columns.join(',')} FROM dbo.syh_danxingtongji where dhkey = #{@project[:dhkey]} group by dwjc order by mcSum desc, mc1 desc, mc2 desc").to_a
      else
        @score = DB.fetch("select #{columns.join(',')} FROM dbo.syh_danxingtongji where dhkey = #{@project[:dhkey]} and zubie = #{DB.literal(@zubie)} group by dwjc order by mcSum desc, mc1 desc, mc2 desc").to_a
      end

      #p @score

      halt_page(:phb_dxzf_detail_page)
    else
      #选择分组
      @zubies = DB.fetch("select zubie from syh_zubie where dhkey = #{@project[:dhkey]} order by zubie").to_a
      halt_page(:phb_dxzf_group_page)
    end
  end

  #排行榜-重点项目奖牌
  def phb_zdxmjp_page

    feilds = ['dwjc','hjj','hjy','hjt']

    @projects = DB.fetch("select bh3, tsmc from dbo.bisaixiangmu where bh3 > 0 order by bh3").to_a

    #p @projects

    @jiangpais = DB.fetch("select #{feilds.join(',')} from dbo.市特殊奖牌 order by hjj desc, hjy desc, hjt desc").to_a

    #p @jiangpais

    halt_page(:phb_zdxmjp_page)
  end

  #排行榜-重点项目奖牌-所有项目的细节
  def phb_zdxmjp_sublist_json

    cache = AppCache[:phb_zdxmjp_sublist_json]
    if cache and cache[:timestamp] == Time.now.strftime("%Y-%m-%d")
      halt_json(cache[:json])
    else
      feilds = ['dwjc']

      projects = []
      db_results = DB.fetch("select bh3, tsmc from dbo.bisaixiangmu where bh3 > 0 order by bh3").to_a
      db_results.each do |project|
        projects << {tsmc: project[:tsmc].to_s.strip, bh3:project[:bh3]}
      end

      result = {}
      projects.each do |project|
        bh3 = project[:bh3]
        if bh3
          subfields = feilds + ["p#{bh3}","j#{bh3}","y#{bh3}","t#{bh3}"]
          jiangpais = DB.fetch("select #{subfields.join(',')} from dbo.市特殊奖牌 order by hjj desc, hjy desc, hjt desc").to_a
          jiangpais.each_with_index do |jiangpai,index|
            result["p#{bh3}r#{index}"] = {zjp:jiangpai["j#{bh3}".to_sym], zyp:jiangpai["y#{bh3}".to_sym], ztp:jiangpai["t#{bh3}".to_sym]}
          end
        end
      end
      AppCache[:phb_zdxmjp_sublist_json] = {timestamp: Time.now.strftime("%Y-%m-%d"), json: result}
      halt_json(result)
    end
  end

  #排行榜-重点项目总分
  def phb_zdxmzf_page

    feilds = ['dwjc','hjf']

    @projects = DB.fetch("select bh3, tsmc from dbo.bisaixiangmu where bh3 > 0 order by bh3").to_a

    #p @projects

    @jiangpais = DB.fetch("select #{feilds.join(',')} from dbo.市特殊得分 order by hjf desc").to_a

    #p @jiangpais

    halt_page(:phb_zdxmzf_page)
  end

  #排行榜-重点项目总分-所有项目的细节
  def phb_zdxmzf_sublist_json

    cache = AppCache[:phb_zdxmzf_sublist_json]
    if cache and cache[:timestamp] == Time.now.strftime("%Y-%m-%d")
      halt_json(cache[:json])
    else
      feilds = ['dwjc']
      projects = []
      db_results = DB.fetch("select bh3, tsmc from dbo.bisaixiangmu where bh3 > 0 order by bh3").to_a
      db_results.each do |project|
        projects << {tsmc: project[:tsmc].to_s.strip, bh3:project[:bh3]}
      end
      puts projects
      result = {}
      projects.each do |project|
        bh3 = project[:bh3]
        if bh3
          subfields = feilds + ["p#{bh3}","f#{bh3}"]
          jiangpais = DB.fetch("select #{subfields.join(',')} from dbo.市特殊得分 order by hjf desc").to_a
          jiangpais.each_with_index do |jiangpai,index|
            result["p#{bh3}r#{index}"] = {zdf:jiangpai["f#{bh3}".to_sym], pid:jiangpai["p#{bh3}".to_sym].to_f }
          end
        end
      end
      #AppCache[:phb_zdxmzf_sublist_json] = {timestamp: Time.now.strftime("%Y-%m-%d"), json: result}
      halt_json(result)
    end
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

    @list = []
    dir = "#{Sinarey.root}/public/zuweihuiwenjian"
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
      atime = File.atime(File.join(dir,filename)).strftime("%Y-%m-%d")
      @list << {filename: filename, atime:atime}
    end

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

    @games = DB.fetch("select dbo.比赛项目清单.*,dbo.web_uploadhtml.* from dbo.比赛项目清单 left join dbo.web_uploadhtml on dbo.比赛项目清单.imkey = dbo.web_uploadhtml.nkey where dhkey = #{@project[:dhkey]} order by sex ASC, zubie ASC, itmc ASC ").to_a

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
