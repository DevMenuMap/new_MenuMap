class RestRegister < ActiveRecord::Base
	# validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id,  presence: true
	validates :subcategory_id, presence: true

  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
end
