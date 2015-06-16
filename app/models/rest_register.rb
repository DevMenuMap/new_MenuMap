class RestRegister < ActiveRecord::Base
	# validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id,  	 presence: true
	validates :subcategory_id, presence: true

	# Associations
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

	### Image	
	# Attach image on RestRegister
	has_attached_file :img, 
										:styles => { :medium => "300x300>" },
										# Default image for rest_register
										:default_url => "download.jpg",
										:url 	=> "/assets/:class/:attachment/:id_partition/:style/:basename.:extension",
										:path => ":rails_root/app/assets/images/:class/:attachment/:id_partition/:style/:basename.:extension"
	
	# Validation check for images
	validates_attachment	:img, 
												:content_type => { content_type: /\Aimage\/.*\Z/ },
												:size					=> { in: 0..15.megabyte }

	def subcategory
		Subcategory.find(self.subcategory_id).name
	end
end
