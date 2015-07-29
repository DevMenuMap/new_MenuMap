class Franchise < ActiveRecord::Base
	has_many :restaurants

	### Validation
	validates :name, presence: true

end
