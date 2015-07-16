class AddrTag < ActiveRecord::Base
	### Associations
  belongs_to :address
  belongs_to :restaurant


	### Validations
	validates :address, presence: true,
											uniqueness: { scope: :restaurant_id }
	validates :restaurant, presence: true


	### Scopes
	default_scope { where(active: true) }
end
