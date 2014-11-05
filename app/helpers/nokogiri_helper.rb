# -*- coding:utf-8 -*-
module NokogiriHelper

  require 'nokogiri'
  require 'open-uri'
  require 'cgi'

  def fetch_qing_gonggao
    base_path = "http://shqx.shsports.gov.cn/WebSite/html/QX/"
    url = base_path + "qx_shhxsydh/List/list_0.htm"
    
    options = {
      "User-Agent" => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)",
      "Referer" => "http://syh.shsports.gov.cn/"
    }
    content = open(url,options).read

    doc = Nokogiri::HTML(content)

    links = doc.css('body .left .left_box .list_box ul li a')

    arr = []
    links.each_with_index do |dom, i|
      break if i >= 7
      href =  base_path + dom.attributes['href'].to_s[6..-1]
      content = dom.content.to_s
      arr << {href: href, content: content}
    end

    return arr
  rescue Exception => boom
    return []
  end

  def fetch_qing_news
    base_path = "http://shqx.shsports.gov.cn/WebSite/html/QX/"
    url = base_path + "qx_shhxsydhgg/List/list_0.htm"

    options = {
      "User-Agent" => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)",
      "Referer" => "http://syh.shsports.gov.cn/"
    }
    content = open(url,options).read

    doc = Nokogiri::HTML(content)

    links = doc.css('body .left .left_box .list_box ul li a')

    arr = []
    links.each_with_index do |dom, i|
      break if i >= 7
      href =  base_path + dom.attributes['href'].to_s[6..-1]
      content = dom.content.to_s
      arr << {href: href, content: content}
    end

    return arr
  rescue Exception => boom
    return []
  end

  #获取市运题外话
  def fetch_tiwaihua
    base_path = "http://syh.shsports.gov.cn/ShSportsWeb/html/shsports/"
    url = base_path + "15syh_mtgz/List/list_0.htm"

    options = {
      "User-Agent" => "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)",
      "Referer" => "http://syh.shsports.gov.cn/"
    }
    content = open(url,options).read.force_encoding('UTF-8')

    doc = Nokogiri::HTML(content)

    links = doc.css('body .center_box .c_left .list_right_box ul li a')

    arr = []
    links.each_with_index do |dom, i|
      break if i >= 7
      href =  base_path + dom.attributes['href'].to_s[6..-1]
      content = dom.content.to_s
      arr << {href: href, content: content}
    end

    return arr
  rescue Exception => boom
    return []
  end

  #数据库里的编码无法识别，直接从旧网站抓取
  def fetch_news_content(nid)
    url = "http://116.228.3.80/newsdetail/?nid=#{nid}"
    doc = Nokogiri::HTML(open(url))
    dom = doc.css('body #newsdetailbox #newscontent').first
 
    if dom
      value = dom.inner_html
    else
      value = ""
    end
    value
  end

end