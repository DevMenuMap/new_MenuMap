class Picture < ActiveRecord::Base
	# Associations
	# Polymorphic associations to Restaurant, RestErr, RestRegister
  belongs_to :imageable, polymorphic: true

	# Image attachment
	has_attached_file :img, 
										:styles	=> { :medium => "300x300>" }

	# Validations
	# validates :img, presence: true
	validates_attachment	:img, 
												:content_type => { content_type: /\Aimage\/.*\Z/ },
												:size					=> { in: 0..15.megabyte }

	# Scopes
	default_scope { where active: true }
end
