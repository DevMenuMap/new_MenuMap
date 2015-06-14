class Category < ActiveRecord::Base
	validates :name, presence: true
	
	has_many :category_relationships, dependent: :destroy
	has_many :subcategories, through: :category_relationships
end
