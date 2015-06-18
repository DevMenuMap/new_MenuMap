class MenuTitle < ActiveRecord::Base
	# Scope
	default_scope { where active: true }
	
	# Validations
	validates :restaurant_id, presence: true
	validates :title_name, presence: true

	# Associations
  belongs_to :restaurant
end
