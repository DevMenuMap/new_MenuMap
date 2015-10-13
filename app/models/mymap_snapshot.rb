class MymapSnapshot < ActiveRecord::Base
	### Associations
  belongs_to :user

  # Paperclip interpoloations for custom save path
  Paperclip.interpolates :user_id do |attachment, style|
    ("%09d" % attachment.instance.user_id).scan(/\d{3}/).join("/")
  end

	has_attached_file :snapshot,
										# :processors => [:watermark],
										# :styles => { 
										# 	original: { 
										# 		geometry: '800>', watermark_path: "#{Rails.root}/public/images/watermark.png" 
										# 	} 
										# },
										:path   => '/mymap_snapshot/snapshot/:user_id/:style/:basename.:extension'

	### Validations
	validates_attachment_content_type :snapshot, :content_type => /\Aimage\/.*\Z/
end
