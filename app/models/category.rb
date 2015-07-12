class Category < ActiveRecord::Base
	### Associations
	has_many :category_relationships, dependent: :destroy
	has_many :subcategories, through: :category_relationships

	has_many :restaurants
	has_many :rest_registers


	### Validations
	validates :name, presence: true
end
