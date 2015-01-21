# -*- coding: utf-8 -*-

require 'anemone'
require 'mongo'
require 'bundler/setup'

options = {
  :user_agent => "AnemoneCrawler/0.0.1",
  :storage => Anemone::Storage.MongoDB,
#  :delay => 1,
  :depth_limit => 1,
  :skip_query_strings => true
}


# クロールの起点となるURLを指定
urls = ["http://www.kenko.com/ranking/01/"]
Anemone.crawl(urls, options) do |anemone|

	# 巡回先の絞り込み
	anemone.focus_crawl do |page|
		page.links.keep_if { |link|
			link.to_s.match(/product/)
		}
	end

	# 取得したページに対する処理
	anemone.on_every_page do |page|
		 
		puts page.url.to_s
		puts page.doc.xpath("//head/title/text()").first.to_s if page.doc
	
	end
end
