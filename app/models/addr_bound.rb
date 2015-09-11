class AddrBound < ActiveRecord::Base
	### Associations
  belongs_to :address


	### Validations
	validates :address, presence: true
	validates :addr_code, presence: true,
												numericality: { less_than: Addressable::ADDR_TAG }
	
	# Custom validators
	validate :only_addr_taggable_addresses


	### Instance methods
	def only_addr_taggable_addresses
		if address_id && address_id < 10**11	
			errors.add(:address_id, "this address is not address taggable")
		end
	end
end
