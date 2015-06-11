class Subcategory < ActiveRecord::Base

	has_many :category_relationships, dependent: :destroy
	has_many :categories, through: :category_relationships
end
