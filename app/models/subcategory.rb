class Subcategory < ActiveRecord::Base
	validates :name, presence: true

	has_many :category_relationships, dependent: :destroy
	has_many :categories, through: :category_relationships

	# subcategory range with params[:category]
end
