class Picture < ActiveRecord::Base
	# Associations
	# Polymorphic associations to Restaurant, RestErr, RestRegister
  belongs_to :imageable, polymorphic: true

	# Scopes
	default_scope { where active: true }
end
