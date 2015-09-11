class Foursquare
	### Constants
	CLIENT_ID = "JHL4AYTWC3NVEWA2LXA35NBYRYQIJCBZDOIRFAQISM4DUJRH"
	CLIENT_SECRET = "APFUDIQRTSEFAOM5F13RHUGH3BI3Q3PKB3PY1KVQMWPID55D"
	VERSION = "20150704"
	

  include ActiveModel::Validations
  # include ActiveModel::Conversion
  # extend ActiveModel::Naming
	extend HomeHelper

  attr_accessor :username
  attr_accessor :url

  validates :username, :presence => true
  validates :url,  :presence => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
	

	### Class methods
	# Get restaurant's venue_id in foursquare.
	def self.get_venue_id(name, lat, lng)
		name = remove_the_last_parenthesis_pair(name)
		url = foursquare_search_venue_url(name, lat, lng)
		json = JSON.load(open(url))

		if json["meta"]["code"] == 200 && !json["response"]["venues"][0].nil?
			json["response"]["venues"][0]["id"]
		else
			nil
		end
	end
	
	# Url for searching restaurant's venue_id.
	def self.foursquare_search_venue_url(name, lat, lng)
		query = URI.encode(name)
		url  = "https://api.foursquare.com/v2/venues/search"
		url += "?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}"
		url += "&ll=#{lat},#{lng}&query=#{query}&intent=match"
		url += "&v=#{VERSION}&m=foursquare"
	end

	# Get restaurant's photos with venue_id, size and # of images limit.
	def self.get_venue_images(venue_id, size = "500x500", limit = 10)
		url = foursquare_parse_images_url(venue_id, limit)

		images = []
		JSON.load(open(url))["response"]["photos"]["items"].each do |item|
			image_url = item["prefix"] + size + item["suffix"]
			username  = [item["user"]["firstName"], item["user"]["lastName"]].flatten.join(' ')
			images << Foursquare.new(username: username, url: image_url) 
		end
		images
	end

	# Url for parsing foursquare's images.
	def self.foursquare_parse_images_url(venue_id, limit)
		url  = "https://api.foursquare.com/v2/venues/#{venue_id}/photos"
		url += "?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}"
		url += "&limit=#{limit}&v=#{VERSION}&m=foursquare"
	end
end
