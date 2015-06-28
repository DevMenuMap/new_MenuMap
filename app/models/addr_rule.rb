class AddrRule < ActiveRecord::Base
	### Associations
  belongs_to :user

	has_many :coordinates, as: :latlng

	# Associated attributes
	accepts_nested_attributes_for :coordinates


	### Validations
	validates :name, presence: true


	### Scopes
	default_scope { where(active: true) }
end
