class RestInfo < ActiveRecord::Base
	# latitude and longitude's MAX, min constants
	LAT_MAX = 40 
	LAT_MIN = 32
	LNG_MAX = 131
	LNG_MIN = 125

	# Scope
	default_scope { where active: true }

	# Validations
	validates :restaurant_id, presence: true
	validates :naver_lat, numericality: { greater_than: LAT_MIN,
																				less_than:		LAT_MAX },
												# allow_blank includes not only nil, but "" string
												allow_nil: true		
	validates :naver_lng, numericality: { greater_than: LNG_MIN,
																				less_than:		LNG_MAX },
												allow_nil: true		

	# Associations
  belongs_to :restaurant
end
