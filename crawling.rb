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
  :depth_limit => 1,
  :skip_query_strings => true
}


db = Mongo::Connection.new.db('anemone')
collections = db.collection('kenko_com')


# クロールの起点となるURLを指定
urls = ["http://www.kenko.com/product/seibun/sei_671070.html", "http://www.kenko.com/product/seibun/sei_755601.html", "http://www.kenko.com/product/seibun/sei_671070.html", "http://www.kenko.com/product/br/br_6810013.html", "http://www.kenko.com/product/seibun/sei_753163.html", "http://www.kenko.com/product/br/br_8250135.html", "http://www.kenko.com/product/seibun/sei_895003.html", "http://www.kenko.com/product/seibun/sei_822172.html", "http://www.kenko.com/product/br/br_6940076.html", "http://www.kenko.com/product/seibun/sei_724052.html", "http://www.kenko.com/product/item/itm_8803146072.html", "http://www.kenko.com/product/seibun/sei_722080.html", "http://www.kenko.com/product/seibun/sei_651164.html", "http://www.kenko.com/product/seibun/sei_725002.html", "http://www.kenko.com/product/seibun/sei_825006.html", "http://www.kenko.com/product/seibun/sei_655115.html", "http://www.kenko.com/product/seibun/sei_834320.html", "http://www.kenko.com/product/seibun/sei_803018.html", "http://www.kenko.com/product/br/br_7840003.html", "http://www.kenko.com/product/seibun/sei_754028.html", "http://www.kenko.com/product/seibun/sei_845002.html", "http://www.kenko.com/product/seibun/sei_651003.html", "http://www.kenko.com/product/seibun/sei_832012.html", "http://www.kenko.com/product/seibun/sei_824001.html", "http://www.kenko.com/product/seibun/sei_774004.html", "http://www.kenko.com/product/seibun/sei_845143.html", "http://www.kenko.com/product/seibun/sei_753003.html", "http://www.kenko.com/product/seibun/sei_662151.html", "http://www.kenko.com/product/seibun/sei_655193.html", "http://www.kenko.com/product/seibun/sei_681042.html", "http://www.kenko.com/product/seibun/sei_722167.html", "http://www.kenko.com/product/seibun/sei_803009.html", "http://www.kenko.com/product/seibun/sei_651046.html", "http://www.kenko.com/product/seibun/sei_902001.html", "http://www.kenko.com/product/seibun/sei_721024.html", "http://www.kenko.com/product/seibun/sei_803058.html", "http://www.kenko.com/product/seibun/sei_842006.html", "http://www.kenko.com/product/seibun/sei_752011.html", "http://www.kenko.com/product/seibun/sei_651040.html", "http://www.kenko.com/product/seibun/sei_755124.html", "http://www.kenko.com/product/seibun/sei_711001.html", "http://www.kenko.com/product/seibun/sei_803014.html", "http://www.kenko.com/product/seibun/sei_833146.html", "http://www.kenko.com/product/seibun/sei_651564.html", "http://www.kenko.com/product/seibun/sei_843014.html", "http://www.kenko.com/product/seibun/sei_755067.html", "http://www.kenko.com/product/seibun/sei_844022.html", "http://www.kenko.com/product/seibun/sei_831042.html", "http://www.kenko.com/product/seibun/sei_755087.html", "http://www.kenko.com/product/seibun/sei_831041.html", "http://www.kenko.com/product/seibun/sei_831039.html", "http://www.kenko.com/product/seibun/sei_831058.html", "http://www.kenko.com/product/seibun/sei_784022.html", "http://www.kenko.com/product/seibun/sei_752101.html", "http://www.kenko.com/product/seibun/sei_845024.html", "http://www.kenko.com/product/seibun/sei_753107.html", "http://www.kenko.com/product/seibun/sei_685076.html", "http://www.kenko.com/product/seibun/sei_711039.html", "http://www.kenko.com/product/seibun/sei_711038.html", "http://www.kenko.com/product/seibun/sei_782062.html", "http://www.kenko.com/product/seibun/sei_755057.html", "http://www.kenko.com/product/seibun/sei_753088.html", "http://www.kenko.com/product/seibun/sei_651888.html", "http://www.kenko.com/product/br/br_6550167.html", "http://www.kenko.com/product/seibun/sei_755001.html", "http://www.kenko.com/product/seibun/sei_713001.html", "http://www.kenko.com/product/seibun/sei_724018.html"]


Anemone.crawl(urls, options) do |anemone|

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

		jan_code = page.doc.xpath('//*/div[@itemprop="identifier"]').text.gsub(/[^0-9]/,"")	

		description = page.doc.xpath('//*/div[@class="description"]/p').text

		url = page.url.to_s
		
		puts name
		puts price
		puts jan_code
		puts description

		doc = { 'name' => "product", 'product_info' => { 'product_name' => "#{name}", 'price' => "#{price}", 'jan_code' => "#{jan_code}", 'description' => "#{description}", 'url' => "#{url}" } }

		collections.insert(doc)


		collections.find.each { |row| puts row.inspect }	

	end
end
