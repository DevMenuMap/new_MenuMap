class Subcategory < ActiveRecord::Base
	### Associations
	has_many :category_relationships, dependent: :destroy
	has_many :categories, through: :category_relationships

	# Restaurant related associations
	has_many :rest_registers


	### Validations
	validates :name, presence: true


	# subcategory range with params[:category]
end
