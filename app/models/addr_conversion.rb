class AddrConversion < ActiveRecord::Base
	### Associations
  belongs_to :address


	### Validations
	validates :address, 		 presence: true
	validates :convert_to, 	 presence: true
	validates :convert_from, presence: true
end
