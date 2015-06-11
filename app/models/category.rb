class Category < ActiveRecord::Base
	
	has_many :category_relationships, dependent: :destroy
	has_many :subcategories, through: :category_relationships
end
