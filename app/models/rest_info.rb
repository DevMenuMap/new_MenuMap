class RestInfo < ActiveRecord::Base
	### Associations
  belongs_to :restaurant


	### Validations
	validates :restaurant_id, presence: true


	### Scopes
	default_scope { where active: true }
end
