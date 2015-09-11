namespace :addresses do
  desc "Save addr_tags for each address"
  task save_addr_tags: :environment do
		Address.where("id > ?", Addressable::ADDR_TAG).find_each do |a|
			if a.coordinates.present? && a.addr_bounds.present?
				a.save_addr_tags
			end
		end
  end

	desc "Check if any address has coordinates without addr_bounds"
	task check_addr_bounds: :environment do
		Address.where("id > ?", Addressable::ADDR_TAG).find_each do |a|
			if a.coordinates.present? && !a.addr_bounds.present?
				puts [ a.id, a.name ]
			end
		end
	end
end
