module Daum
	require 'open-uri'
	require 'nokogiri'

	### Constants
	# API keys
	SEARCH_KEY  = "61a98e1ad6ddb530bcb93294019b80b8"
	# Filtering
	FILTER_RULES = ["철거", "용달", "공사", "시공", "경매", "고시원", "원룸", "투룸",
									"월세", "부동산", "급매", "최고가", "대리운전", "법인", "전세", "매매",
									"임대", "매물", "역세권", "건설", "미용실", "평형", "시세"]


	### Instance methods
	def daum_blog_search
		query = short_addrs + " " + name
		query = URI.encode("#{query}")

		daum_key = "?apikey=" + SEARCH_KEY 
		daum_options = "&q=#{query}&output=xml&result=5&sort=accu&advance=n" 
		daum_url = "http://apis.daum.net/search/blog#{daum_key}#{daum_options}"
																				 
		items = Nokogiri::XML(open(daum_url)).xpath("//item")
		
		daum_blogs = []
		items.each do |item|
			temp = Hash.new
			temp[:title] = item.xpath("title").text 
			temp[:link]  = item.xpath("link").text
			temp[:description]  = item.xpath("description").text
			temp[:blogger_name] = item.xpath("author").text
			temp[:blogger_link] = item.xpath("comment").text
			unless FILTER_RULES.any? {|word| temp[:title].include?(word) || 
																			 temp[:description].include?(word) ||
																			 temp[:blogger_name].include?(word)}
				daum_blogs << temp
			end
		end

		daum_blogs
	end
end