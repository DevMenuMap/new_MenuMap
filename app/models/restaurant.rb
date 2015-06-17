class Restaurant < ActiveRecord::Base
	# Scope
	default_scope { where active: true }

	# Validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id, presence: true
	validates :subcategory_id, presence: true

	# Associations
  belongs_to :category
  belongs_to :subcategory
end
