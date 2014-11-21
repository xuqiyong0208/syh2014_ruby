
module ApplicationHelper

require 'date'

#从星期一开始
def get_current_week
  list = []

  t0 = Time.now
  #t0 = Time.new(2014,5,24) #数据很少，模拟当天的数据

  support_year = 2014 #只处理2014年的数据,不支持跨年
  base_date = t0.to_date

  tmp = base_date
  offset = t0.strftime('%u').to_i - 1
  offset.times do
    tmp = tmp.prev_day
    list << {month: tmp.month, day: tmp.day, valid: tmp.year==support_year}
  end

  list.reverse!

  list << {month: base_date.month, day: base_date.day, yes: base_date.year==support_year}

  tmp = base_date
  (6-offset).times do
    tmp = tmp.next_day
    list << {month: tmp.month, day: tmp.day, valid: tmp.year==support_year}
  end

  list
end

#本周赛程 
def get_currnet_week_schedule(week,max=nil)
  sql_parts = []
  week.each do |hsh|
    next unless hsh[:valid]
    #  ##市运会要限制S.where()
    sql_parts << "select * from lzj_sportsdata where ydhleixing = 'S' and yuefen = #{hsh[:month]} and rihao = #{hsh[:day]} and dhkey is not null"
  end
  sql = sql_parts.join(' union all ')
  week_schedule = DB.fetch(sql)

  tmp = {}
  week_schedule.each do |data|
    dh_key = data[:dhkey]
    ydhjc = data[:ydhjc].to_s.strip
    data[:ydhjc] = ydhjc
    tmp[dh_key] ||= {name: data[:ydhjc], dhkey: data[:dhkey], data: {}}
    tmp[dh_key][:data][data[:rihao]] = data
  end

  list = tmp.values
  list.sort! { |x,y| y[:data].size <=> x[:data].size }

  max ? list.first(max) : list
end


  def requirejs_base_url
    @temp[:version_path] ||= Settings.static_version.presence && "/#{Settings.static_version}"
    "#{Settings.static_root}#{@temp[:version_path]}/js/lib"
  end

  #静态文件url
  def static_url(file)
    @temp[:version_path] ||= Settings.static_version.presence && "/#{Settings.static_version}"
    "#{Settings.static_root}#{@temp[:version_path]}#{file}?v=4"
  end

  #获取文件url
  def file_url(file_path)
    return file_path if file_path.nil? or file_path.empty?
    file_path.match(/^http/) ? file_path : File.join(Settings.oss_root, file_path)
  end

  #数据库的数据需要先处理一下
  def db_content(str)
    CGI.unescape(str).force_encoding('GB2312').encode!('UTF-8').gsub("\\\"","\"").gsub("\\'","'")
  end

  def oj_dump(hash)
    Oj.dump(hash, mode: :compat)
  end

  def params_page
    @temp[:params_page] ||= (
      if params[:page].present?
        params[:page].to_i
      else
        1
      end
    )
  end

  #设置分页的默认值
  def paginate(sequel_pagination = nil, options = {})
    options[:previous_label] ||= '上一页'
    options[:next_label] ||= '下一页'
    options[:inner_window] ||= 3
    options[:outer_window] ||= 0
    options[:class] ||= "pageTurn"
    options[:params] = params if request.post?
    temp = PaginateTemp.new(sequel_pagination)
    will_paginate(temp, options)
  end

end