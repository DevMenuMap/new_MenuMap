class Addrcomplete < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true
	
	### Scopes
	default_scope { order(priority: :desc) }

end
