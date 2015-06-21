class Picture < ActiveRecord::Base
	# Associations
	# Polymorphic associations to Restaurant, RestErr, RestRegister
  belongs_to :imageable, polymorphic: true

	# Paperclip interpoloations for custom save path
	Paperclip.interpolates :imageable_type do |attachment, style|
		attachment.instance.imageable_type.underscore + 's'
	end

	# Image attachment
	has_attached_file :img, 
										:styles	=> { :medium => "300x300>" },
										:path => '/:class/:imageable_type/:attachment/:id_partition/:style/:basename.:extension'

	# Validations
	validates_attachment	:img, 
												:presence			=> true,
												:content_type => { content_type: /\Aimage\/.*\Z/ },
												:size					=> { in: 0..15.megabyte }

	# Scopes
	default_scope { where active: true }
end
