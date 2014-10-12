
module ApplicationHelper

  def requirejs_base_url
    @temp[:version_path] ||= Settings.static_version.presence && "/#{Settings.static_version}"
    "#{Settings.static_root}#{@temp[:version_path]}/js/lib"
  end

  #静态文件url
  def static_url(file)
    @temp[:version_path] ||= Settings.static_version.presence && "/#{Settings.static_version}"
    "#{Settings.static_root}#{@temp[:version_path]}#{file}"
  end

  #获取文件url
  def file_url(file_path)
    return file_path if file_path.nil? or file_path.empty?
    file_path.match(/^http/) ? file_path : File.join(Settings.oss_root, file_path)
  end


  #设置分页的默认值
  def paginate(sequel_pagination = nil, options = {})
    options[:previous_label] ||= '上一页'
    options[:next_label] ||= '下一页'
    options[:inner_window] ||= 3
    options[:outer_window] ||= 0
    options[:params] = params if request.post?
    temp = PaginateTemp.new(sequel_pagination)
    will_paginate(temp, options)
  end

end