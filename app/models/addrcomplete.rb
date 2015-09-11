class Addrcomplete < ActiveRecord::Base
	### Validations
	validates :name, uniqueness: true, presence: true

	
	### Scopes
	default_scope { where(active: true) }
	default_scope { order(priority: :desc) }
end
