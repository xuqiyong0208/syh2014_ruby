# -*- coding:utf-8 -*-
module NokogiriHelper

  require 'nokogiri'
  require 'open-uri'
  require 'cgi'

  def fetch_qing_gonggao
    base_path = "http://shqx.shsports.gov.cn/WebSite/html/QX/"
    url = base_path + "qx_shhxsydh/List/list_0.htm"
    doc = Nokogiri::HTML(open(url))

    links = doc.css('body .left .left_box .list_box ul li a')

    arr = []
    links.each_with_index do |dom, i|
      break if i >= 7
      href =  base_path + dom.attributes['href'].to_s[6..-1]
      content = dom.content.to_s
      arr << {href: href, content: content}
    end

    arr
  end

  def fetch_qing_news
    base_path = "http://shqx.shsports.gov.cn/WebSite/html/QX/"
    url = base_path + "qx_shhxsydhgg/List/list_0.htm"
    doc = Nokogiri::HTML(open(url))

    links = doc.css('body .left .left_box .list_box ul li a')

    arr = []
    links.each_with_index do |dom, i|
      break if i >= 7
      href =  base_path + dom.attributes['href'].to_s[6..-1]
      content = dom.content.to_s
      arr << {href: href, content: content}
    end

    arr
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