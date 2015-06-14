class RestRegister < ActiveRecord::Base
	# validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :cat,  presence: true
	validates :subcat, presence: true

  belongs_to :user_id
end
