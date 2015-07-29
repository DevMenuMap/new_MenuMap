class Franchise < ActiveRecord::Base

	### Validation
	validates :name, presence: true

end
