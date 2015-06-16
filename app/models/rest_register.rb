class RestRegister < ActiveRecord::Base
	# validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id,  presence: true
	validates :subcategory_id, presence: true

	# Associations
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

	# Image	
	has_attached_file :img, 
										:styles => { :medium => "300x300>", :thumb => "100x100>" },
										:url 	=> "/:class/:attachment/:id/:style/:basename.:extension",
										:path => ":rails_root/public/:class/:attachment/:id/:style/:basename.:extension"
	validates_attachment_content_type :img, 
																		:content_type => /\Aimage\/.*\Z/
end
