class MymapSnapshot < ActiveRecord::Base
	### Associations
  belongs_to :user
	has_attached_file :snapshot


	### Validations
	validates_attachment_content_type :snapshot, :content_type => /\Aimage\/.*\Z/
end
