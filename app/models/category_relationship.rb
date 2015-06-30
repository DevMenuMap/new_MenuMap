class CategoryRelationship < ActiveRecord::Base
	# Validations
	validates :category_id, presence: true
	validates :subcategory_id, presence: true

	# Associations
  belongs_to :category
  belongs_to :subcategory
end
