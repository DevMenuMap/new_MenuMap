class RestRegister < ActiveRecord::Base
	### Associations
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

	has_many :pictures, as: :imageable

	# Associated attributes
	accepts_nested_attributes_for :pictures


	### Validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id,  	 presence: true
	validates :subcategory_id, presence: true


	### Scopes
	default_scope { where(active: true) }
end
