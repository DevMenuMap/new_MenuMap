class AddrTag < ActiveRecord::Base
	### Associations
  belongs_to :address
  belongs_to :restaurant


	### Validations
	validates :address, presence: true,
											uniquness: { scope: :restaurant_id }
	validates :restaurant, presence: true
end
