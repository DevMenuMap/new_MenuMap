class MenuTitle < ActiveRecord::Base
	### Scope
	default_scope { where active: true }
	

	### Validations
	validates :restaurant_id, presence: true
	validates :title_name, presence: true


	### Associations
 	belongs_to :restaurant
 	has_many :menus


	### Class methods
	# Find menu_titles without menus
	def self.without_menus
		joins("LEFT JOIN menus ON menu_titles.id = menus.menu_title_id").where("menus.id IS NULL")
	end
end
