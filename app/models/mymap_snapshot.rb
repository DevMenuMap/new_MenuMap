class MymapSnapshot < ActiveRecord::Base
	### Associations
  belongs_to :user
	has_attached_file :snapshot,
										:processors => [:watermark],
										:styles => {
											:thumb => '150x150>',
											:original => { :geometry => '800>', :watermark_path => "#{Rails.root}/public/images/watermark.png" }
										},
										:url    => '/assets/attachment/:id/:style/:basename.:extension',
										:path   => ':rails_root/public/assets/attachment/:id/:style/:basename.:extension'

	### Validations
	validates_attachment_content_type :snapshot, :content_type => /\Aimage\/.*\Z/
end
