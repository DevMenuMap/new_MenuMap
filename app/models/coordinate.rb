class Coordinate < ActiveRecord::Base
	### Associations
	# belongs_to Address, AddrRule, Restaurant
  belongs_to :latlng, polymorphic: true


	### Validations
	# Max and min latlng constants for Seoul
	SEOUL_LAT_RANGE = { min:  37.42, max:	 37.71 }
	SEOUL_LNG_RANGE = { min: 126.76, max: 127.19 }

	validates :lat, presence:  true,
									inclusion: SEOUL_LAT_RANGE[:min]..SEOUL_LAT_RANGE[:max]
	validates :lng, presence:  true,
									inclusion: SEOUL_LNG_RANGE[:min]..SEOUL_LNG_RANGE[:max]
end
