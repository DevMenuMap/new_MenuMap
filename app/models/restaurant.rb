class Restaurant < ActiveRecord::Base
	# Associations
  belongs_to :category
  belongs_to :subcategory

	has_one 	 :rest_info

	has_many	 :rest_errs
	has_many	 :menu_titles
	has_many 	 :pictures, 		as: :imageable

	# Associated attributes
	accepts_nested_attributes_for :pictures

	# Validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id, presence: true
	validates :subcategory_id, presence: true

	# Scopes
	default_scope { where active: true }
end
