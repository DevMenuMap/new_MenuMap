class AdminAddr < ActiveRecord::Base
	### Validations
	validates :gu, 		presence: true
	validates :dong, 	presence: true


	### Associations
	has_many :legal_admins
	has_many :legal_addrs, through: :legal_admins
end
