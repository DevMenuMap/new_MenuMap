class RestRegister < ActiveRecord::Base
	# Extensions
	extend S3Helper

	# Associations
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

	has_many :pictures, as: :imageable

	# Attach image on RestRegister
	has_attached_file :img, 
										# Default image for rest_register
										:default_url => s3_image_url("rest_register_default.jpg"),
										:styles 		 => { :medium => "300x300>" }

	# Validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id,  	 presence: true
	validates :subcategory_id, presence: true

	# Paperclip validation for image
	validates_attachment	:img, 
												:content_type => { content_type: /\Aimage\/.*\Z/ },
												:size					=> { in: 0..15.megabyte }
end
