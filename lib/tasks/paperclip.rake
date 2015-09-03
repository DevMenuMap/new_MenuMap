namespace :paperclip do
  desc "Reprocess pictures"
  task reprocess: :environment do
		Picture.where("imageable_type = 'Restaurant'").each do |picture|
			picture.img.reprocess!
			# picture.img.reprocess! :medium
		end
  end
end
