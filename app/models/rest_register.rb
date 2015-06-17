class RestRegister < ActiveRecord::Base
	# extensions
	extend S3Helper

	# validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id,  	 presence: true
	validates :subcategory_id, presence: true

	# Associations
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

	### Images
	# Attach image on RestRegister
	has_attached_file :img, 
										# Default image for rest_register
										:default_url => s3_image_url("rest_register_default.jpg"),
										:styles 		 => { :medium => "300x300>" }
	
	# Validation check for images
	validates_attachment	:img, 
												:content_type => { content_type: /\Aimage\/.*\Z/ },
												:size					=> { in: 0..15.megabyte }
end
