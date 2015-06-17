class Restaurant < ActiveRecord::Base
	# Validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id, presence: true
	validates :subcategory_id, presence: true

	# Associations
  belongs_to :category
  belongs_to :subcategory
end
