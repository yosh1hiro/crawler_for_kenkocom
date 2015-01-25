# -*- coding: utf-8 -*-

require 'anemone'
require 'mongo'
require 'nokogiri'
require 'kconv'
require 'bundler/setup'

options = {
  :user_agent => "AnemoneCrawler/0.0.1",
  :storage => Anemone::Storage.MongoDB,
  :delay => 1,
  :depth_limit => 0,
  :skip_query_strings => true
}


# クロールの起点となるURLを指定
# urls = ["http://www.kenko.com/ranking/01/"]
Anemone.crawl("http://www.kenko.com/product/item/itm_7721527072.html", options) do |anemone|

	# 巡回先の絞り込み
	anemone.focus_crawl do |page|
		page.links.keep_if { |link|
			link.to_s.match(/\/product\/item\//)
		}
	end

	# 取得したページに対する処理
	anemone.on_every_page do |page|


		name = page.doc.xpath('//*[@id="prodFeatures"]/h1').text

		price = page.doc.search('//*/li[@class="price"]/span[1]').text

		# 後で正規表現で数字だけ抽出する必要あり
		jan_code = page.doc.xpath('//*/div[@itemprop="identifier"]').text

		description = page.doc.xpath('//*/div[@class="description"]/p').text
		
 
		puts name
		puts price
		puts jan_code
		puts description


		puts page.url.to_s	
	end
end
