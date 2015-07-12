module Naver
  require 'open-uri'
  require 'nokogiri'

	### Constants
	# API keys
	MAP_KEY_JB1 = "e9259df9a4dead564ce9d22727f94934"
	SEARCH_KEY  = "813b2e5e653326da6ff7d7114acf8748"


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
end
