class Picture < ActiveRecord::Base
	### Associations
	# Polymorphic associations to Restaurant, RestErr, RestRegister
  belongs_to :imageable, polymorphic: true


	# Paperclip interpoloations for custom save path
	Paperclip.interpolates :imageable_type do |attachment, style|
		attachment.instance.imageable_type.underscore + 's'
	end

  Paperclip.interpolates :imageable_id do |attachment, style|
    ("%09d" % attachment.instance.imageable_id).scan(/\d{3}/).join("/")
  end

	# Image attachment
	has_attached_file :img, 
										:styles	=> { small: "200x200>" },
										# :styles	=> { thumb: "120x120", medium: "400x400>" },
										# :convert_options => { thumb: "-quality 50 -strip" },
										:path => '/:class/:imageable_type/:attachment/:imageable_id/:style/:basename.:extension'


	### Validations
	validates_attachment	:img, 
												:presence			=> true,
												:content_type => { content_type: /\Aimage\/.*\Z/ },
												:size					=> { in: 0..15.megabyte }


	### Scopes
	default_scope { where(active: true) }
end
