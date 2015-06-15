class Subcategory < ActiveRecord::Base
	validates :name, presence: true

	has_many :category_relationships, dependent: :destroy
	has_many :categories, through: :category_relationships

	# Restaurant related associations
	has_many :rest_registers

	# subcategory range with params[:category]
end
