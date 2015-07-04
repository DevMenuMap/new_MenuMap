class RestInfo < ActiveRecord::Base
	### Mixins
	include Google 


	### Associations
  belongs_to :restaurant

	has_one :coordinate, as: :latlng


	### Validations
	validates :restaurant_id, presence: true


	### Scopes
	default_scope { where(active: true) }

	# addr on restaurant issue
	scope :in_area, -> (area) { where("restaurant_id IN ( SELECT id FROM restaurants WHERE addr LIKE ?)", "%#{area}%") if area }


	### Class methods
	# Find RestInfo without one of the coordinates
	def self.without_latlng
		self.where("id NOT IN ( SELECT latlng_id FROM coordinates WHERE latlng_type = ? AND lat IS NOT NULL AND lng IS NOT NULL)", "RestInfo")
	end

	# Save Google's coordinates to rest_info's nested attributes(coordinate
	# model) based on that area.
	def self.save_latlngs(area = nil)
		puts "Get coordinates from Google and save them on rest_infos"
		self.in_area(area).without_latlng.each do |rest_info|
			latlng = rest_info.get_latlng
			puts "Get Google's latitude: #{latlng[0]} and longitude: #{latlng[1]}"

			rest_info.save_latlng(latlng)
		end
	end


	### Instance methods
	def lat
		coordinate ? coordinate.lat : nil
	end

	def lng 
		coordinate ? coordinate.lng : nil
	end

	def save_latlng(latlng)
		if valid_latlng?(latlng)
			create_coordinate(lat: latlng[0], lng: latlng[1])
			puts "Saved rest_info #{self.id}'s latlng(Google)"
		else
			puts "***** Fail rest_info #{self.id}"	
		end		
	end

	# Get Google's coordinate and save it into this instance instantly
	def get_and_save_latlng
		latlng = get_latlng
		create_coordinate(lat: latlng[0], lng: latlng[1])
	end
end
