class Slang < ActiveRecord::Base
	### Validations
	validates :name, presence: true

	
	### Scopes
	default_scope { where(active: true) }
end
