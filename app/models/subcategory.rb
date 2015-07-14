class Subcategory < ActiveRecord::Base
	### Associations
	has_many :category_relationships, dependent: :destroy
	has_many :categories, through: :category_relationships

	has_many :restaurants
	has_many :rest_registers


	### Validations
	validates :name, presence: true


	### Class methods
	# Return range hash[:min, :max] for restaurants's subcategory.
	def self.range(n)
		n = n.to_i
		if n % 1000000 == 0
			{ min: n, max: n + 1000000 }
		elsif n % 10000 == 0
			{ min: n, max: n + 10000 }
		else
			{ min: n, max: n + 100 }
		end
	end
end
