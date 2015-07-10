class LegalAddr < ActiveRecord::Base
	### Validations
	validates :gu, 		presence: true
	validates :dong, 	presence: true
	validates :jibun, presence: true


	### Associations
	has_many :legal_admins
	has_many :admin_addrs, through: :legal_admins
end
