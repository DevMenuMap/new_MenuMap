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
		where("id NOT IN ( SELECT DISTINCT menu_title_id FROM menus )")
	end
end
