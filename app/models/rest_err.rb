class RestErr < ActiveRecord::Base
	# Scope
	default_scope { where active: true }

	# Validations
	validates :restaurant_id, presence: true

	# Associations
  belongs_to :restaurant
	belongs_to :user
end
