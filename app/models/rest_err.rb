class RestErr < ActiveRecord::Base
	# Associations
  belongs_to :restaurant
	belongs_to :user

	has_many :pictures, as: :imageable

	# Validations
	validates :restaurant_id, presence: true

	# Scopes
	default_scope { where(active: true) }
end
