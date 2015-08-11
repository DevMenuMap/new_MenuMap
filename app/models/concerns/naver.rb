module Naver
  require 'open-uri'
  require 'nokogiri'

	### Constants
	# API keys
	MAP_KEY_JB1 = "e9259df9a4dead564ce9d22727f94934"
	SEARCH_KEY  = "813b2e5e653326da6ff7d7114acf8748"
	# Filtering
	FILTER_RULES = ["철거", "용달", "공사", "시공", "경매", "고시원", "원룸", "투룸",
									"월세", "부동산", "급매", "최고가", "대리운전", "법인", "전세", "매매",
									"임대", "매물", "역세권", "건설", "미용실", "평형", "시세"] 


	### Instance methods
	# Return array of latitude, longitude 
	def get_latlng
		url = naver_request_url
		xml_page = encode_and_open_xml(url)
		xml_page.remove_namespaces!			# Remove "xmlns:" part.
		xml_finder(xml_page)
	end

	def naver_request_url(options=["utf-8", "latlng"])
		# encoding = utf-8 | euc-kr
		# coord = latlng | tm128(default)

		request_url = "http://openapi.map.naver.com/api/geocode.php"
		request_url += "?key=" 			+ MAP_KEY_JB1 +
									 "&encoding=" + options[0] +
									 "&coord=" 		+ options[1] +
									 "&query=" 		+ self.addr
	end

	def encode_and_open_xml(url)
		Nokogiri::XML(open(URI::encode(url)))
	end

	# Find the "first" nodes for latitude and longitude on Naver xml file.
	def xml_finder(xml_page)
		# Longitude comes first in Naver.
		lng = xml_page.xpath("//item[1]//x").text.to_f
		lat = xml_page.xpath("//item[1]//y").text.to_f
		[lat, lng]
	end

	# Check if coordinates are betweeen valid ranges.
	def valid_latlng?(latlng)
		lat_range = Coordinate::SEOUL_LAT_RANGE
		lng_range = Coordinate::SEOUL_LNG_RANGE
		latlng[0].between?(lat_range[:min], lat_range[:max]) && latlng[1].between?(lng_range[:min], lng_range[:max])
	end

	# Return array of search result
	def naver_blog_search
		query = short_addrs + " " + short_name
		query = URI.encode("#{query}")

		naver_key = "key=" + SEARCH_KEY
		naver_options = "&query=#{query}&display=5&target=blog&sort=sim"
		naver_url = "http://openapi.naver.com/search?#{naver_key}#{naver_options}"

		items = Nokogiri::XML(open(naver_url)).xpath("//item")
		
		naver_blogs = []
		items.each do |item|
			temp = Hash.new
			temp[:title] = item.xpath("title").text 
			temp[:link]  = item.xpath("link").text
			temp[:description]  = item.xpath("description").text
			temp[:blogger_name] = item.xpath("bloggername").text
			temp[:blogger_link] = item.xpath("bloggerlink").text
			unless FILTER_RULES.any? {|word| temp[:title].include?(word) || 
																			 temp[:description].include?(word) ||
																			 temp[:blogger_name].include?(word)}
				naver_blogs << temp
			end
		end

		naver_blogs
	end
end