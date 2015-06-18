class RestErr < ActiveRecord::Base
	# Validations
	validates :restaurant_id, presence: true

	# Associations
  belongs_to :restaurant
end
