module Google
  require 'open-uri'
  require 'nokogiri'

	### Constants
	# API keys
	API_KEY = "AIzaSyB0s-wKE2YW_rreU6vcxkaR44MPzOa4JKg"


	### Instance methods
	# Return array of latitude, longitude from Google
  def get_latlng
    url = google_request_url
    xml_page = encode_and_open_xml(url)
    xml_finder(xml_page)
  end

  def google_request_url
    request_url = "https://maps.googleapis.com/maps/api/geocode/xml"
    request_url += "?address=" + self.restaurant.addr +
                   "&key="     + API_KEY
  end

  def encode_and_open_xml(url)
    Nokogiri::XML(open(URI::encode(url)))
  end

  def xml_finder(xml_page)
    lat = xml_page.xpath("///geometry/location/lat").text.to_f
    lng = xml_page.xpath("///geometry/location/lng").text.to_f
    [lat, lng]
  end

	# Check if coordinates are betweeen valid ranges.
	def valid_latlng?(latlng)
		lat_range = Coordinate::SEOUL_LAT_RANGE
		lng_range = Coordinate::SEOUL_LNG_RANGE
		latlng[0].between?(lat_range[:min], lat_range[:max]) && latlng[1].between?(lng_range[:min], lng_range[:max])
	end
end
