
require File.expand_path('../config/application',  __FILE__)

#学运会项目  #TODO 对应图片
#puts WebProject.all.count
# web_projects = []
# WebProject.all.each do |project|
#   # web_projects << project.inspect
#   web_projects << {xmmc: project.xmmc.to_s.strip, dhkey: project.dhkey}
# end
# web_projects.each do |project|
#   puts project.inspect
# end



require 'date'

#从星期一开始
def get_current_week
  list = []

  #t0 = Time.now
  t0 = Time.new(2014,5,24) #数据很少，模拟当天的数据

  support_year = 2014 #只处理2014年的数据,不支持跨年
  base_date = t0.to_date

  list << {month: base_date.month, day: base_date.day, yes: base_date.year==support_year}

  tmp = base_date
  offset = t0.strftime('%u').to_i - 1
  offset.times do
    tmp = tmp.prev_day
    list << {month: tmp.month, day: tmp.day, valid: tmp.year==support_year}
  end

  tmp = base_date
  (6-offset).times do
    tmp = tmp.next_day
    list << {month: tmp.month, day: tmp.day, valid: tmp.year==support_year}
  end

  list
end

#本周赛程 
def get_currnet_week_schedule(max=nil)
  week = get_current_week
  sql_parts = []
  week.each do |hsh|
    next unless hsh[:valid]
    #.where(ydhleixing:'S')  ##市运会要限制S
    sql_parts << "select * from lzj_sportsdata where yuefen = #{hsh[:month]} and rihao = #{hsh[:day]} and dhkey is not null"
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

# week_schedule = get_currnet_week_schedule(10)
# puts week_schedule


#全部赛程
#.where(ydhleixing:'S') ##市运会要限制S
# WebProjectSchedule.where('dhkey is not null').limit(10).each do |schedule|
#   puts schedule.inspect
# end

project_schedule = WebProjectSchedule.where(dhkey: 289).limit(10)

project_schedule.each do |schedule|
  puts schedule.inspect
end






