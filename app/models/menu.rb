class Menu < ActiveRecord::Base
	### Associations
  	belongs_to :menu_title
  	belongs_to :user

  	### Validations
  	#validates :menu_title_id, presence: true
  	validates :name, presence: true
  	validates :price, presence: true

  	### Scopes
  	default_scope { where(active: true) }
end
